(* $Id$ *)

open Gtk

(* We add a timer to interrupt the main iteration when it does nothing.
   We then need to delay, thus focing a thread switch. *)

let main () =
  let timer = Timeout.add 50 cb:(fun () -> true) in
  try
    while not (Main.iteration_do true) do Thread.delay 0.001 done;
    Timeout.remove timer
  with exn ->
    Timeout.remove timer;
    raise exn
