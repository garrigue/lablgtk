open Unix
open Printf
open Wav
open Xafile
open Xaadpcm

open Gtk

let track_conf_path app volume = 
  Filename.concat
    dir: (Filename.concat 
	    dir: (Filename.concat dir: (Sys.getenv "HOME") file: ".xxaplay")
	    file: app)
    file: volume

let create_track_conf fd app volume =
  let dumb_reporter () =
    let start_time = ref (-1.0) in
    let prevper = ref (-1) in
    fun all cur ->
      let now = Unix.time () in
      if !start_time < 0.0 then start_time := now
      else if all = cur then begin
	let used = Pervasives.truncate (now -. !start_time) in  
	prerr_endline (sprintf "Finished (%d secs)" used)
      end else begin
	let per = cur * 100 / all in
	if per <> !prevper then begin
	  prerr_string (sprintf "%d%% is done" (cur * 100 / all));
	  if cur <> 0 then begin
	    let est = 
	      Pervasives.truncate ((now -. !start_time) /. (float cur) *. (float (all - cur)))
	    in
	    prerr_endline (sprintf " (estimated more %d secs)" est)
	  end else
	    prerr_endline "";
	  prevper := per
	end
      end
  in

  let conf_path = track_conf_path app volume in
  let oc = open_out file: conf_path in

  let xa_files = Xafile.list_xa_files_of_disk fd in

  List.iter fun: (fun target ->
    prerr_endline (target.name);
    let i = ref 1 in
    let tracks = Xafile.get_tracks fd (dumb_reporter ()) target in
    List.iter fun: (fun track ->
      eprintf "%s#%d\n%d\n%d\n%d\n\n" target.name !i track.tstart track.tlength track.tinterleave;
      fprintf to:oc "%s#%d\n%d\n%d\n%d\n\n" target.name !i track.tstart track.tlength track.tinterleave;
      incr i) tracks) xa_files;
  close_out oc

exception NoConf

let read_track_conf app volume =
  let conf_path = track_conf_path app volume in
  let tracks = ref [] in
  begin try
    let ic = open_in file: conf_path in
    begin try while true do
      let name = input_line ic in
      let start = int_of_string (input_line ic) in
      let length = int_of_string (input_line ic) in
      let inter = int_of_string (input_line ic) in
      let _ = input_line ic in
      let track = name, { tstart= start; tlength= length; tinterleave= inter }
      in
      tracks := track :: !tracks
    done; [] with _ -> 
      close_in ic;
      List.rev !tracks
    end
  with
    _ -> raise NoConf
  end

let create_xpm_button :parent :file :label =
  if not (Sys.file_exists file) then 
    Button.create :label
  else begin
    Widget.realize parent;
    let style = Widget.get_style parent in
    let pixmap, mask = Gdk.Pixmap.create_from_xpm (Widget.window parent)
        transparent:(Style.get_bg style) :file
    in
    let w = Pixmap.create pixmap :mask in
    Widget.show w; 
    let button = Button.create () in
    Container.add button w;
    button
  end

class time_scale parent time length = 
  let time_scale_adjustment = 
    Adjustment.create value: 0.0
	                lower: 0.0
                        upper: (float (length - 1))
                        step_incr: 1.0
                        page_incr: 1.0
                        page_size: 0.0 in
  let  time_scale = 
    Scale.create `HORIZONTAL adjustment: time_scale_adjustment
  in
  let _ = 
    Scale.set time_scale draw_value: false;
    Box.pack parent time_scale padding: 1;
    Widget.show time_scale
  in
  object

  method set_time =
    let v = Adjustment.get_value time_scale_adjustment in
    let sec = Pervasives.truncate (v *. 0.0533333333) in
    let min = sec / 60 in
    let hour = min / 60 in
    let min = min mod 60 in
    let sec = sec mod 60 in
    Label.set time label: (Printf.sprintf "%02d:%02d:%02d" hour min sec);
    Pervasives.truncate v

  method destroy =
    Object.destroy time_scale_adjustment;
    Object.destroy time_scale

  method adjustment = time_scale_adjustment
end
 
class player :fd :start :length :interleave :report :finish = 
  let _ = Xaadpcm.init_decoder () in
  object (self)
  val dsp = 
    let dsp = new Dsp.dspplay "/dev/dsp" in
    dsp#set_sample_size 16;
    dsp#set_stereo true;
    dsp#set_speed 37800;
    dsp
  val mutable current = 0
  val mutable current_sector = start
  val mutable job = None

  method next =
    current_sector <- current_sector + interleave;
    current <- current + 1;
    report false current

  method jump x =
    self#init;
    current_sector <- start + x  * interleave;
    current <- x;
    report true current

  method send =
    let s = read_raw_frame fd current_sector in
    let track = track_info s in
    if track = -1 then begin (* end *)
      prerr_endline (sprintf "end at %d" current_sector); 
      self#stop;
      finish ()
    end else begin
      dsp#write (Xaadpcm.decodeSector s);
      report false current;
      self#next
    end

  method init = Xaadpcm.init_decoder ()

  method play =
    prerr_endline "play";
    report true current;
    if job = None then
      job <- Some (Timeout.add 10 callback: (fun () -> 
	let _,fdok,_ = Unix.select read:[] write:[fd] exn:[] timeout:(-1.0) in
	if fdok <> [] then self#send; 
	true))

  method pause =
    match job with
      Some j -> 
	prerr_endline "pause";
	report true current;
	Timeout.remove j; job <- None
    | None -> ()

  method stop =
    match job with
      Some j -> 
	self#pause;
	prerr_endline "stop";
	self#jump 0
    | None -> ()

  method destroy =
    prerr_endline "destroy";
    self#stop;
    dsp#flush;
    dsp#close
end

let main () =
  let device = ref "/dev/cdrom" in
  Arg.parse keywords: [
    "-device", Arg.String (fun s -> device := s), "\t: device(=/dev/cdrom)";
  ] others: (fun _ -> ()) errmsg: "xxaplay";

  let window = Window.create `TOPLEVEL in
  Signal.connect sig:Object.Signals.destroy window callback:Main.quit;

  let bar_and_other = Box.vbox_new homogeneous: false spacing: 0 in
  Container.add window bar_and_other;
  Widget.show bar_and_other;

(*
  let menubar = MenuBar.create () in
  (* pack_start, pack, pack_end are unified *)
  Box.pack bar_and_other menubar expand: false fill: false padding: 0;
  Widget.show menubar;

  let menuitem = MenuItem.create label: "File" in
  MenuShell.append menubar menuitem;
*)

  let vbox = Box.vbox_new homogeneous: false spacing: 2 in
  Container.border_width vbox 5;
  Container.add bar_and_other vbox; 

  let cdtitle = Label.create "unknown disk" in
  Box.pack vbox cdtitle padding: 1;

  let tracktitle = Label.create "unknown track" in
  Box.pack vbox tracktitle padding: 1;

  let trackselecter = Box.hbox_new homogeneous: false spacing: 0 in
  Box.pack vbox trackselecter expand: false fill: false padding: 1;
  
  let timebar = Box.vbox_new homogeneous: false spacing: 2 in
  Box.pack vbox timebar padding: 1;

  let buttons = Box.hbox_new homogeneous: false spacing: 0 in
  Box.pack vbox buttons from: `END padding: 1;

  let b_rewind = create_xpm_button parent: buttons 
      file: "rewind.xpm" label: "<<" in
  Box.pack buttons b_rewind expand: false fill: false;
  let b_play = create_xpm_button parent: buttons 
      file: "play.xpm" label: "=>" in
  Box.pack buttons b_play expand: false fill: false;
  let b_forward = create_xpm_button parent: buttons
      file: "forward.xpm" label: ">>" in
  Box.pack buttons b_forward expand: false fill: false;
  let b_pause = create_xpm_button parent: buttons
      file: "pause.xpm" label: "||" in
  Box.pack buttons b_pause expand: false fill: false;
  let b_stop = create_xpm_button parent: buttons
      file: "stop.xpm" label: "[]" in
  Box.pack buttons b_stop expand: false fill: false;
  let b_eject = create_xpm_button parent: buttons
      file: "eject.xpm" label: "/\\" in
  Box.pack buttons b_eject expand: false fill: false;

  let time = Label.create "00:00:00" in
  Label.set time label: "00:00:00";
  Box.pack timebar time expand: false fill: false padding: 1;

  let scale = ref (new time_scale vbox time 1) in

  let recreate_time_scale length =
    (!scale)#destroy;
    scale := new time_scale timebar time length
  in

  Widget.show_all window;
  
  let fd = Unix.openfile !device flags: [O_RDONLY] perm: 0o644 in

  let current_player = ref None in
  let player_send f =
    match !current_player with
      None -> ()
    | Some p -> f p
  in

  let set_cd_title s =
    Label.set cdtitle label:s
  in
  
  let current_track = ref 0 in

  let finish = ref (fun () -> ()) in
  let tracks = ref [] in

  let trackbox = ref None in

  let prepare_track finish onplay x =
    try
      let name, track = List.nth !tracks pos: x in
      Label.set tracktitle label: (sprintf "%d: %s" (x+1) name);
  
      recreate_time_scale track.tlength;
  
      let cur_frame = ref 0 in
      let player = new player :fd start: track.tstart length: track.tlength 
  			      interleave: track.tinterleave :finish
  	  report: (fun sw cur ->
  	    if (sw && !cur_frame <> cur) || 
  	       abs(!cur_frame - cur) > 18  (* more than 1 sec *) then begin
  	      Adjustment.set_value (!scale#adjustment) (float cur);
  	      cur_frame := cur
  	    end)
      in
      
      current_player := Some player;
  
      Signal.connect sig:Adjustment.Signals.value_changed (!scale)#adjustment
  	callback: (fun _ -> 
  	  let v = (!scale)#set_time in
  	  player_send (fun x -> x#jump v) );
      Signal.connect sig:Adjustment.Signals.changed (!scale)#adjustment
  	callback: (fun _ -> (!scale)#set_time; ());
      if onplay then player#play;
      ()
    with
      Failure("nth") ->
	Label.set tracktitle label: "No XA" 
  in

  let check_cdrom () =
    current_track := 0;
    player_send (fun x -> x#stop);
    prerr_endline "checking cd";
    let app, volume = read_cdrom_info fd in
    if volume <> "" then set_cd_title volume
    else set_cd_title "Unknown CD";
    let app = "PLAYSTATION" in
    let tracks =
      try
	read_track_conf app volume
      with
	NoConf ->
	  create_track_conf fd app volume;
	  read_track_conf app volume
    in
    begin match !trackbox with
      Some t -> Object.destroy t
    | None -> ()
    end;
    let num_tracks = List.length tracks in
    if num_tracks <> 0 then begin
      let table = Table.create rows: 5 
	  columns: (num_tracks / 5 + (if num_tracks mod 5 <> 0 then 1 else 0))
      in
      for i = 0 to num_tracks - 1 do
	let button = Button.create label: (sprintf "%d" (i + 1)) in
	Signal.connect sig:Button.Signals.clicked button callback:(fun () ->
	  current_track := i;
	  player_send (fun x -> x#destroy);
	  prepare_track !finish true i);
	Table.attach table button left: (i mod 5) top: (i / 5);
	Widget.show button
      done;
      Box.pack trackselecter table expand: true fill: false padding: 1;
      Widget.show table;
      trackbox := Some table
    end else trackbox := None;
    tracks
  in

  tracks := check_cdrom ();

  let next_track onplay =
    if !current_track <> List.length !tracks - 1 then begin
      player_send (fun x -> x#destroy);
      incr current_track;
      prepare_track !finish onplay !current_track
    end
  in
  
  let prev_track onplay =
    if !current_track <> 0 then begin
      player_send (fun x -> x#destroy);
      decr current_track;
      prepare_track !finish onplay !current_track
    end
  in
  
  finish := (fun () -> next_track true);

  prepare_track !finish false !current_track;

  Signal.connect sig:Button.Signals.clicked b_play callback:(fun () ->
    player_send (fun x -> x#play));
  Signal.connect sig:Button.Signals.clicked b_stop callback:(fun () ->
    player_send (fun x -> x#stop));
  Signal.connect sig:Button.Signals.clicked b_pause callback:(fun () ->
    player_send (fun x -> x#pause));
  Signal.connect sig:Button.Signals.clicked b_eject callback:(fun () ->
    tracks := check_cdrom ());

  Signal.connect sig:Button.Signals.clicked b_rewind callback: (fun () ->
    prev_track false);

  Signal.connect sig:Button.Signals.clicked b_forward callback: (fun () ->
    next_track false);

  Main.main ()

let _ = Printexc.print main ()
