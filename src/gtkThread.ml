(* $Id$ *)

open GtkMain

(* Job handling for Windows *)

let jobs : (unit -> unit) Queue.t = Queue.create ()
let m = Mutex.create ()
let with_jobs f =
  Mutex.lock m; let y = f jobs in Mutex.unlock m; y

let loop_id = ref None
let cannot_sync () =
  match !loop_id with None -> true
  | Some id -> Thread.id (Thread.self ()) = id

let gui_safe () =
  not (Sys.os_type = "Win32") || !loop_id = Some(Thread.id (Thread.self ()))

let has_jobs () = not (with_jobs Queue.is_empty)
let n_jobs () = with_jobs Queue.length
let do_next_job () = with_jobs Queue.take ()
let async j x = with_jobs (Queue.add (fun () -> j x))
let sync f x =
  if cannot_sync () then f x else
  let m = Mutex.create () in
  let res = ref None in
  Mutex.lock m;
  let c = Condition.create () in
  let j x =
    let y = f x in Mutex.lock m; res := Some y; Mutex.unlock m;
    Condition.signal c
  in
  async j x;
  Condition.wait c m;
  match !res with Some y -> y | None -> assert false

(* We check first whether there are some event pending, and run
   some iterations. We then need to delay, thus focing a thread switch. *)

let thread_main () =
  let old_id = !loop_id in
  try
    let loop = (Glib.Main.create true) in
    Main.loops := loop :: !Main.loops;
    loop_id := Some (Thread.id (Thread.self ()));
    while Glib.Main.is_running loop do
      let i = ref 0 in
      while !i < 100 && Glib.Main.pending () do
	Glib.Main.iteration true;
	incr i
      done;
      Thread.delay 0.001;
      for i = 1 to n_jobs () do do_next_job () done
    done;
    Main.loops := List.tl !Main.loops;
    loop_id := old_id
  with exn ->
    Main.loops := List.tl !Main.loops;
    loop_id := old_id;
    raise exn

let main () =
  GtkMain.Main.main_func := thread_main;
  thread_main ()
      
let start = Thread.create main

let _ =
  let mutex = Mutex.create () in
  let depth = ref 0 in
  GtkSignal.enter_callback :=
    (fun () -> if !depth = 0 then Mutex.lock mutex; incr depth);
  GtkSignal.exit_callback :=
    (fun () -> decr depth; if !depth = 0 then Mutex.unlock mutex)
