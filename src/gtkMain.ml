(* $Id$ *)

open StdLabels
open Gtk

let () = Callback.register_exception "gtkerror" (Error"")
let () = Gc.set {(Gc.get()) with Gc.max_overhead = 1000000}

module Main = struct
  external init : string array -> string array = "ml_gtk_init"
  (* external set_locale : unit -> string = "ml_gtk_set_locale" *)
  external disable_setlocale : unit -> unit = "ml_gtk_disable_setlocale"
  (* external main : unit -> unit = "ml_gtk_main" *)
  let init ?(setlocale=true) () =
    let setlocale =
      try Sys.getenv "GTK_SETLOCALE" <> "0" with Not_found -> setlocale in
    if not setlocale then disable_setlocale ();
    let argv =
      try
	init Sys.argv
      with Error err ->
        raise (Error ("GtkMain.init: initialization failed\n" ^ err))
    in
    if setlocale then ignore (Glib.Main.setlocale `NUMERIC (Some "C"));
    Array.blit ~src:argv ~dst:Sys.argv ~len:(Array.length argv)
      ~src_pos:0 ~dst_pos:0;
    Obj.truncate (Obj.repr Sys.argv) (Array.length argv);
    if setlocale then Glib.Main.setlocale `ALL None else ""
  open Glib
  let loops = ref []
  let default_main () =
    let loop = (Main.create true) in
    loops := loop :: !loops;
    while Main.is_running loop do Main.iteration true done;
    if !loops <> [] then loops := List.tl !loops
  let main_func = ref default_main
  let main () = !main_func ()
  let quit () = if !loops <> [] then Main.quit (List.hd !loops)
  external get_version : unit -> int * int * int = "ml_gtk_get_version"
  let version = get_version ()
  external get_current_event_time : unit -> int32
    = "ml_gtk_get_current_event_time"
end

module Grab = struct
  external add : [>`widget] obj -> unit = "ml_gtk_grab_add"
  external remove : [>`widget] obj -> unit = "ml_gtk_grab_remove"
  external get_current : unit -> widget obj= "ml_gtk_grab_get_current"
end

module Rc = struct
  external add_default_file : string -> unit = "ml_gtk_rc_add_default_file"
end

module Message = struct
  (* Use normal caml printing function *)
  let _ =
    Glib.Message.set_print_handler (fun msg -> print_string msg)

  (* A list of strings used as prefix to determine whether a warning
     should cause an exception or not *)
  let critical_warnings =
    ref [ "Invalid text buffer iterator" ]

  let is_critical_warning s =
    List.exists !critical_warnings ~f:
      (fun w ->
        let len = String.length w in
        String.length s >= len && w = String.sub s ~pos:0 ~len)

  let () =
    (* Cause exceptions for critical messages in the Gtk domain,
       including "critical" warnings *)
    Glib.Message.set_log_handler ~domain:"Gtk" ~levels:[`WARNING;`CRITICAL]
      (fun ~level msg ->
        let crit = level land (Glib.Message.log_level `CRITICAL) <> 0 in
        if crit || is_critical_warning msg then
          raise (Glib.Critical ("Gtk", msg))
        else prerr_endline ("Gtk-WARNING **: " ^ msg));
    ()
end
