(* $Id$ *)

open Gtk
open Glib

(* We add a timer to interrupt the main iteration when it does nothing.
   We then need to delay, thus focing a thread switch. *)

let main () =
  let timer = Timeout.add 50 callback:(fun () -> true) in
  try
    let loop = (Main.create true) in
    Gtk.Main.loops := loop :: !Gtk.Main.loops;
    while Main.is_running loop do 
      Main.iteration true; Thread.delay 0.001
    done;
    Gtk.Main.loops := List.tl !Gtk.Main.loops;
    Timeout.remove timer
  with exn ->
    Gtk.Main.loops := List.tl !Gtk.Main.loops;
    Timeout.remove timer;
    raise exn
      
let start = Thread.create main
