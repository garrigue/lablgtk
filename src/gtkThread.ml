(* $Id$ *)

open GtkMain

(* We check first whether there are some event pending, and run
   some iterations. We then need to delay, thus focing a thread switch. *)

let main () =
  try
    let loop = (Glib.Main.create true) in
    Main.loops := loop :: !Main.loops;
    while Glib.Main.is_running loop do
      let i = ref 0 in
      while !i < 100 && Glib.Main.pending () do
	Glib.Main.iteration true;
	incr i
      done;
      Thread.delay 0.001
    done;
    Main.loops := List.tl !Main.loops
  with exn ->
    Main.loops := List.tl !Main.loops;
    raise exn
      
let start = Thread.create main

let _ =
  let mutex = Mutex.create () in
  let depth = ref 0 in
  GtkSignal.enter_callback :=
    (fun () -> if !depth = 0 then Mutex.lock mutex; incr depth);
  GtkSignal.exit_callback :=
    (fun () -> decr depth; if !depth = 0 then Mutex.unlock mutex)
