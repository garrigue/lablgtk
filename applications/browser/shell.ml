(* $Id$ *)

open GdkKeysyms
open Printf

(* Nice history class. May reuse *)

class ['a] history () = object
  val mutable history = ([] : 'a list)
  val mutable count = 0
  method empty = history = []
  method add s = count <- 0; history <- s :: history
  method previous =
    let s = List.nth pos:count history in
    count <- (count + 1) mod List.length history;
    s
  method next =
    let l = List.length history in
    count <- (l + count - 1) mod l;
    List.nth history pos:((l + count - 1) mod l)
end

(* The shell class. Now encapsulated *)

let protect f x = try f x with _ -> ()

class shell :prog :args :env ?:packing ?:show =
  let (in2,out1) = Unix.pipe ()
  and (in1,out2) = Unix.pipe ()
  and (err1,err2) = Unix.pipe () in
  let _ = List.iter fun:Unix.set_nonblock [out1;in1;err1] in
object (self)
  val textw = new GEdit.text editable:true ?:packing ?:show
  val pid = Unix.create_process_env :prog :args :env in:in2 out:out2 err:err2
  val out = Unix.out_channel_of_descr out1
  val h = new history ()
  val mutable alive = true
  val mutable reading = false
  val mutable input_start = 0
  val mutex = Mutex.create ()
  method private lock =
    Mutex.lock mutex; textw#set_editable false
  method private unlock =
    Mutex.unlock mutex; textw#set_editable alive
  method text = textw
  method alive = alive
  method kill () =
    textw#set_editable false;
    if alive then begin
      alive <- false;
      protect close_out out;
      List.iter fun:(protect Unix.close) [in2; out2; err2];
      try
	Unix.kill :pid signal:Sys.sigkill;
	Thread.create Thread.wait_pid pid; ()
      with _ -> ()
    end
  method interrupt () =
    if alive then try
      reading <- false;
      Unix.kill :pid signal:Sys.sigint
    with Unix.Unix_error _ -> ()
  method send s =
    if alive then try
      output_string s to:out;
      flush out
    with Sys_error _ -> ()
  method private read :fd :len =
    try
      let buffer = String.create :len in
      let len = ThreadUnix.read fd :buffer pos:0 :len in
      if len > 0 then begin
	self#lock;
	self#insert (String.sub buffer pos:0 :len);
	input_start <- textw#point;
	self#unlock
      end
    with Unix.Unix_error _ -> ()
  method history (dir : [next previous]) =
    if not h#empty then begin
      self#lock;
      if reading then begin
	textw#delete_text start:input_start end:textw#point;
      end else begin
	reading <- true;
	input_start <- textw#point
      end;
      self#insert (if dir = `previous then h#previous else h#next);
      self#unlock
    end
  method private lex ?:start [< Text.line_start textw >]
      ?end:e [< Text.line_end textw >] =
    if start < e then Lexical.tag textw :start end:e
  method insert text =
    let start = Text.line_start textw in
    textw#insert text;
    self#lex :start
  method private keypress c =
    self#lock;
    if not reading & c > " " then begin
      reading <- true;
      input_start <- textw#point
    end;
    self#unlock
  method private keyrelease c =
    self#lock;
    if c <> "" then self#lex;
    self#unlock
  method private return () =
    self#lock;
    if reading then reading <- false
    else input_start <- Text.line_start textw;
    self#lex start:(Text.line_start textw pos:input_start);
    let s = textw#get_chars start:input_start end:textw#point in
    h#add s;
    self#send s;
    self#send "\n";
    self#unlock
  method private paste () =
    if not reading then begin
      self#lock;
      reading <- true;
      input_start <- textw#position;
      self#unlock
    end
  initializer
    textw#connect#event#key_press callback:
      begin fun ev ->
	if GdkEvent.Key.keyval ev = _Return &&
	  GdkEvent.Key.state ev = 0
	then self#return ()
	else self#keypress (GdkEvent.Key.string ev);
	false
      end;
    textw#connect#event#key_release
      callback:(fun ev -> self#keyrelease (GdkEvent.Key.string ev); false);
    textw#connect#event#button_press after:true callback:
      begin fun ev ->
	if GdkEvent.Button.button ev = 2 then self#paste ();
	false
      end;
    textw#connect#destroy callback:self#kill;
    let make_thread fd =
      while alive do self#read :fd len:1024 done;
      Unix.close fd
    in
    ignore (List.map [in1;err1] fun:(Thread.create make_thread))
end

(* Specific use of shell, for LablBrowser *)

let shells : (string * shell) list ref = ref []

(* Called before exiting *)
let kill_all () =
  List.iter !shells fun:(fun (_,sh) -> if sh#alive then sh#kill ());
  shells := []

let get_all () =
  let all = List.filter !shells pred:(fun (_,sh) -> sh#alive) in
  shells := all;
  all

let may_exec prog =
  try
    let stats = Unix.stat prog in
    stats.st_kind = Unix.S_REG &&
    (stats.st_perm land 1 <> 0 or
     stats.st_perm land 8 <> 0
       & List.mem stats.st_gid in:(Array.to_list (Unix.getgroups ())) or
     stats.st_perm land 64 <> 0 & stats.st_uid = Unix.getuid ())
  with Unix.Unix_error _ -> false

let f :prog :title =
  let progargs =
    List.filter pred:((<>) "") (Str.split sep:(Str.regexp " ") prog) in
  if progargs = [] then () else
  let prog = List.hd progargs in
  let path = try Sys.getenv "PATH" with Not_found -> "/bin:/usr/bin" in
  let exec_path = Str.split sep:(Str.regexp":") path in
  let prog =
    if not (Filename.is_implicit prog) then
      if may_exec prog then prog else ""
    else
      List.fold_left exec_path acc:"" fun:
	begin fun :acc dir ->
	  if acc <> "" then acc else
	  let prog = Filename.concat :dir file:prog in
	  if may_exec prog then prog else acc
	end
  in
  if prog = "" then () else
  let reg = Str.regexp "TERM=" in
  let env = Array.map (Unix.environment ()) fun:
      begin fun s ->
 	if Str.string_match reg in:s pos:0 then "TERM=dumb" else s
      end in
  let load_path =
    List.flatten (List.map !Config.load_path fun:(fun dir -> ["-I"; dir])) in
  let args = Array.of_list (progargs @ load_path) in
  let current_dir = ref (Unix.getcwd ()) in

  let tl = new GWindow.window :title width:500 height:300 in
  let vbox = new GPack.vbox packing:tl#add in
  let menus = new GMenu.menu_bar packing:(vbox#pack expand:false) in
  let f = new GMenu.factory menus in
  let accel_group = f#accel_group in
  tl#add_accel_group accel_group;
  let file_menu = f#add_submenu label:"File"
  and history_menu = f#add_submenu label:"History"
  and signal_menu = f#add_submenu label:"Signal" in

  let hbox = new GPack.hbox packing:vbox#add in
  let sh = new shell :prog :env :args packing:hbox#add in
  let sb =
    new GRange.scrollbar `VERTICAL adjustment:sh#text#vadjustment
      packing:(hbox#pack expand:false)
  in

  let f = new GMenu.factory file_menu :accel_group in
  f#add_item label:"Use..." callback:
    begin fun () ->
      File.dialog title:"Use File" filename:(!current_dir ^ "/") callback:
	begin fun name ->
	  current_dir := Filename.dirname name;
	  if Filename.check_suffix name suffix:".ml" then
	    let cmd = "#use \"" ^ name ^ "\";;\n" in
	    sh#insert cmd;
	    sh#send cmd
	end
    end;
  f#add_item label:"Load..." callback:
    begin fun () ->
      File.dialog title:"Load File" filename:(!current_dir ^ "/") callback:
	begin fun name ->
	  current_dir := Filename.dirname name;
	  if Filename.check_suffix name suffix:".cmo" or
	    Filename.check_suffix name suffix:".cma"
	  then
	    let cmd = Printf.sprintf "#load \"%s\";;\n" name in
	    sh#insert cmd;
	    sh#send cmd
	end
    end;
  f#add_item label:"Import path" callback:
    begin fun () ->
      List.iter (List.rev !Config.load_path)
	fun:(fun dir -> sh#send (sprintf "#directory \"%s\";;\n" dir))
    end;
  f#add_item label:"Close" callback:tl#destroy;

  let h = new GMenu.factory history_menu :accel_group in
  h#add_item label:"Previous" key:_P callback:(fun () -> sh#history `previous);
  h#add_item label:"Next" key:_N callback:(fun () -> sh#history `next);
  let s = new GMenu.factory signal_menu :accel_group in
  s#add_item label:"Interrupt" key:_C callback:sh#interrupt;
  s#add_item label:"Kill" callback:sh#kill;
  shells := (title, sh) :: !shells;
  tl#show ()
