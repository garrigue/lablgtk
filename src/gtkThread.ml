(* $Id$ *)

open Gtk
open Glib

(* We add a timer to interrupt the main iteration when it does nothing.
   We then need to delay, thus focing a thread switch. *)

let main () =
  let timer = Timeout.add 50 callback:(fun () -> true) in
  try
    while Main.is_running Gtk.Main.loop do
      Main.iteration true; Thread.delay 0.001
    done;
    Timeout.remove timer
  with exn ->
    Timeout.remove timer;
    raise exn

let start = Thread.create main
