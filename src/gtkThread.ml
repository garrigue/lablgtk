(* $Id$ *)

open GtkRaw

(* We add a timer to interrupt the main iteration when it does nothing.
   We then need to delay, thus focing a thread switch. *)

let main () =
  let timer = Timeout.add 50 callback:(fun () -> true) in
  try
    let loop = (Glib.Main.create true) in
    Main.loops := loop :: !Main.loops;
    while Glib.Main.is_running loop do 
      Glib.Main.iteration true; Thread.delay 0.001
    done;
    Main.loops := List.tl !Main.loops;
    Timeout.remove timer
  with exn ->
    Main.loops := List.tl !Main.loops;
    Timeout.remove timer;
    raise exn
      
let start = Thread.create main
