open Unix
open Printf
open Wav
open Xafile
open Xaadpcm

open Gtk
open GMain

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
  let oc = 
    try
      open_out file: conf_path 
    with
      e -> prerr_endline ("Failed to open to write a track connfiguratoin file "^conf_path); raise e
  in

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

let create_xpm_button parent: (parent : GPack.hbox) :file :label =
(*
  if not (Sys.file_exists file) then 
*)
    new GButton.button :label
(*
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
*)

class time_scale (time : GMisc.label) (scale : GRange.scale) length = 
  let adjustment = 
    new GData.adjustment value: 0.0
	                 lower: 0.0
                         upper: (float (length - 1))
                         step_incr: 1.0
                         page_incr: 1.0
                         page_size: 0.0 
  in
  let _ = scale#set_adjustment adjustment;
  in
  object

  method set_time =
    let v = adjustment#value in
    let sec = Pervasives.truncate (v *. 0.0533333333) in
    let min = sec / 60 in
    let hour = min / 60 in
    let min = min mod 60 in
    let sec = sec mod 60 in
    time#set_text (Printf.sprintf "%02d:%02d:%02d" hour min sec);
    Pervasives.truncate v

  method destroy =
    adjustment#destroy ()

  method adjustment = adjustment
end
 
class player :fd :start :length :interleave :report :finish = 
  let _ = Xaadpcm.init_decoder () in
  object (self)
  val dsp = new Dsp.dspplay "/dev/dsp"
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

  method init = 
    Xaadpcm.init_decoder ();
    dsp#open_dsp;
    dsp#set_sample_size 16;
    dsp#set_stereo true;
    dsp#set_speed 37800

  method play =
    prerr_endline "play";
    dsp#open_dsp;
    dsp#set_sample_size 16;
    dsp#set_stereo true;
    dsp#set_speed 37800;
    report true current;
    if job = None then
      let magic = 40 in
      (* 40 is good for my computer *)
      (* if < 35, gtk does not update the text (too busy) *) 
      (* if > 35, noise *)
      job <- Some (Timeout.add magic callback: (fun () -> 
	let _,fdok,_ = Unix.select read:[] write:[fd] exn:[] timeout:(-1.0) in
	if fdok <> [] then begin 
	  self#send; 
	  true
	end else begin
	  true
	end))

  method pause =
    match job with
      Some j -> 
	prerr_endline "pause";
	report true current;
	Timeout.remove j; job <- None;
	dsp#flush;
	dsp#close
    | None -> ()

  method stop =
    match job with
      Some j -> 
	self#pause;
	prerr_endline "stop";
	self#jump 0;
	dsp#flush;
	dsp#close
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

  let window = new GWindow.window in
  window#connect#destroy callback:Main.quit;

  let bar_and_other = new GPack.vbox homogeneous: false spacing: 0 
  packing: window#add
  in

(*
  let menubar = MenuBar.create () in
  (* pack_start, pack, pack_end are unified *)
  Box.pack bar_and_other menubar expand: false fill: false padding: 0;
  Widget.show menubar;

  let menuitem = MenuItem.create label: "File" in
  MenuShell.append menubar menuitem;
*)

  let vbox = new GPack.vbox  homogeneous: false spacing: 2 border_width: 5 packing: bar_and_other#add in

  let cdtitle = new GMisc.label text: "unknown disk" packing: (vbox#pack padding: 1) in

  let tracktitle = new GMisc.label text: "unknown track" packing: (vbox#pack padding: 1) in

  let trackselecter = new GPack.hbox homogeneous: false spacing: 0 packing: (vbox#pack expand: false fill: false padding: 1) in
  
  let timebar = new GPack.vbox  homogeneous: false spacing: 2 packing: (vbox#pack padding: 1) in

  let buttons = new GPack.hbox  homogeneous: false spacing: 0 packing: (vbox#pack from: `END padding: 1) in

  let b_rewind = create_xpm_button parent: buttons 
      file: "rewind.xpm" label: "<<" in
  buttons#pack b_rewind expand: false fill: false;
  let b_play = create_xpm_button parent: buttons 
      file: "play.xpm" label: "=>" in
  buttons#pack b_play expand: false fill: false;
  let b_forward = create_xpm_button parent: buttons
      file: "forward.xpm" label: ">>" in
  buttons#pack b_forward expand: false fill: false;
  let b_pause = create_xpm_button parent: buttons
      file: "pause.xpm" label: "||" in
  buttons#pack b_pause expand: false fill: false;
  let b_stop = create_xpm_button parent: buttons
      file: "stop.xpm" label: "[]" in
  buttons#pack b_stop expand: false fill: false;
  let b_eject = create_xpm_button parent: buttons
      file: "eject.xpm" label: "/\\" in
  buttons#pack b_eject expand: false fill: false;

  let time = new GMisc.label text: "00:00:00" packing: (timebar#pack expand: false fill: false padding: 1) in
  let time_scale = new GRange.scale `HORIZONTAL packing: vbox#add in
  time_scale#set_display draw_value: false;

  let scale = ref (new time_scale time time_scale 1) in

  let recreate_time_scale length =
    (!scale)#destroy;
    scale := new time_scale time time_scale length
  in

  window#show ();

  let fd = Unix.openfile !device flags: [O_RDONLY] perm: 0o644 in

  let current_player = ref None in
  let player_send f =
    match !current_player with
      None -> ()
    | Some p -> f p
  in

  let set_cd_title s =
    cdtitle#set_text s
  in
  
  let current_track = ref 0 in

  let finish = ref (fun () -> ()) in
  let tracks = ref [] in

  let trackbox = ref (None : GPack.table option) in

  let prepare_track finish onplay x =
    try
      let name, track = List.nth !tracks pos: x in
      tracktitle#set_text (sprintf "%d: %s" (x+1) name);
  
      recreate_time_scale track.tlength;
  
      let cur_frame = ref 0 in
      let player = new player :fd start: track.tstart length: track.tlength 
  			      interleave: track.tinterleave :finish
  	  report: (fun sw cur ->
  	    if (sw && !cur_frame <> cur) || 
  	       abs(!cur_frame - cur) > 18  (* more than 1 sec *) then begin
  		 !scale#adjustment#set_value (float cur);
  	      cur_frame := cur
  	    end)
      in
      
      current_player := Some player;
  
(* does not work ? *)
      (!scale)#adjustment#connect#changed callback: (fun _ -> 
  	  let v = (!scale)#set_time in
  	  player_send (fun x -> x#jump v) );
      (!scale)#adjustment#connect#value_changed callback: (fun _-> 
	  (!scale)#set_time; ());
      if onplay then player#play;
      ()
    with
      Failure("nth") ->
	tracktitle#set_text "No XA" 
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
      Some t -> 
	prerr_endline "trackbox destroy";
	t#destroy ()
    | None -> ()
    end;
    let num_tracks = List.length tracks in
    if num_tracks <> 0 then begin
      let table = new GPack.table rows: 5 
	  columns: (num_tracks / 5 + (if num_tracks mod 5 <> 0 then 1 else 0))
      in
      for i = 0 to num_tracks - 1 do
	let button = new GButton.button label: (sprintf "%d" (i + 1)) in
	button#connect#clicked callback:(fun () ->
	  current_track := i;
	  player_send (fun x -> x#destroy);
	  prepare_track !finish true i);
	table#attach button left: (i mod 5) top: (i / 5);
      done;
      trackselecter#pack table expand: true fill: false padding: 1;
      (* Widget.show table; *)
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

  b_play#connect#clicked callback:(fun () ->
    player_send (fun x -> x#play));
  b_stop#connect#clicked callback:(fun () ->
    player_send (fun x -> x#stop));
  b_pause#connect#clicked callback:(fun () ->
    player_send (fun x -> x#pause));
  b_eject#connect#clicked callback:(fun () ->
    tracks := check_cdrom ());

  b_rewind#connect#clicked callback: (fun () ->
    prev_track false);

  b_forward#connect#clicked callback: (fun () ->
    next_track false);

  Main.main ()

let _ = Printexc.print main ()
