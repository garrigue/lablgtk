(* $Id$ *)

open Gtk

let _ = Callback.register_exception "gtkerror" (Error"")

module Timeout = struct
  type id
  external add : int -> callback:(GtkArgv.t -> unit) -> id
      = "ml_gtk_timeout_add"
  let add inter :callback =
    add inter callback:(fun arg -> GtkArgv.set_result_bool arg (callback ()))
  external remove : id -> unit = "ml_gtk_timeout_remove"
end

module Main = struct
  external init : string array -> string array = "ml_gtk_init"
  (* external exit : int -> unit = "ml_gtk_exit" *)
  external set_locale : unit -> string = "ml_gtk_set_locale"
  (* external main : unit -> unit = "ml_gtk_main" *)
  let locale = set_locale ()
  let init () =
    let argv = init Sys.argv in
    Array.blit argv to:Sys.argv len:(Array.length argv) pos:0 to_pos:0;
    Obj.truncate (Obj.repr Sys.argv) len:(Array.length argv)
  open Glib
  let loops = ref [] 
  let main () =
    let loop = (Main.create true) in
    loops := loop :: !loops;
    while Main.is_running loop do Main.iteration true done;
    loops := List.tl !loops
  and quit () = Main.quit (List.hd !loops)
  external get_version : unit -> int * int * int = "ml_gtk_get_version"
  let version = get_version ()

  let flush = Gdk.X.flush
end

module Grab = struct
  external add : [>`widget] obj -> unit = "ml_gtk_grab_add"
  external remove : [>`widget] obj -> unit = "ml_gtk_grab_remove"
  external get_current : unit -> widget obj= "ml_gtk_grab_get_current"
end

let _ = Glib.set_warning_handler (fun msg -> raise (Warning msg))
let _ = Glib.set_print_handler (fun msg -> print_string msg)
