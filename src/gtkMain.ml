(* $Id$ *)

open StdLabels
open Gtk

let _ = Callback.register_exception "gtkerror" (Error"")

let critical_warnings =
  ref [ "Invalid text buffer iterator" ]

module Main = struct
  external init : string array -> string array = "ml_gtk_init"
  (* external exit : int -> unit = "ml_gtk_exit" *)
  external set_locale : unit -> string = "ml_gtk_set_locale"
  external disable_setlocale : unit -> unit = "ml_gtk_disable_setlocale"
  (* external main : unit -> unit = "ml_gtk_main" *)
  let init ?(setlocale=true) () =
    let locale =
      if try Sys.getenv "GTK_SETLOCALE" <> "0" with Not_found -> setlocale
      then set_locale ()
      else (disable_setlocale (); "")
    in
    let argv =
      try
	init Sys.argv
      with Error err ->
        raise (Error ("GtkMain.init: initialization failed\n" ^ err))
    in
    Glib.Main.setlocale `NUMERIC "C";
    let is_critical s =
      List.exists !critical_warnings ~f:
        (fun w ->
          let len = String.length w in
          String.length s >= len && w = String.sub s ~pos:0 ~len)
    in
    Glib.Message.set_log_handler ~domain:"Gtk" ~levels:[`WARNING;`CRITICAL]
      (fun ~level msg ->
        let crit = level land (Glib.Message.log_level `CRITICAL) <> 0 in
        if crit || is_critical msg then
          raise (Gtk.Error ("Gtk-CRITICAL ***: " ^ msg))
        else prerr_endline ("Gtk-WARNING **: " ^ msg));
    Array.blit ~src:argv ~dst:Sys.argv ~len:(Array.length argv)
      ~src_pos:0 ~dst_pos:0;
    Obj.truncate (Obj.repr Sys.argv) (Array.length argv);
    locale
  open Glib
  let loops = ref [] 
  let main () =
    let loop = (Main.create true) in
    loops := loop :: !loops;
    while Main.is_running loop do Main.iteration true done;
    if !loops <> [] then loops := List.tl !loops
  and quit () = if !loops <> [] then Main.quit (List.hd !loops)
  external get_version : unit -> int * int * int = "ml_gtk_get_version"
  let version = get_version ()
end

module Grab = struct
  external add : [>`widget] obj -> unit = "ml_gtk_grab_add"
  external remove : [>`widget] obj -> unit = "ml_gtk_grab_remove"
  external get_current : unit -> widget obj= "ml_gtk_grab_get_current"
end

module Rc = struct
  external add_default_file : string -> unit = "ml_gtk_rc_add_default_file"
end

let _ =
  Glib.Message.set_print_handler (fun msg -> print_string msg)

