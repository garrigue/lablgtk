(* $Id$ *)

(* Basic functions *)

(** The main loop to use with threads. [GMain.main] does not work!
    This changes [GMain.main] to call [threaded_main] rather than
    [GtkMain.Main.default_main], so subsequent calls will work.
    The first call sets the GUI thread, and subsequent calls
    to [main] will be automatically routed through [sync] *)
val main : unit -> unit
(** Start the main loop in a new GUI thread. Do not use recursively. *)
val start : unit -> Thread.t
(** The real main function *)
val thread_main : unit -> unit
(** Forget the current GUI thread. The next call to [main]
    will register its caller as GUI thread. *)
val reset : unit -> unit

(* Jobs are needed for windows, as you cannot do GTK work from
   another thread.
   Even under Unix some calls need to come from the main thread.
   The basic idea is to either use async (if you don't need a result)
   or sync whenever you call a GTK related function from another thread
   (for instance with the threaded toplevel).
   With sync, beware of deadlocks!
*)

(** Add an asynchronous job (to do in the main thread) *)
val async : ('a -> unit) -> 'a -> unit
(** Add a synchronous job (to do in the main thread) *)
val sync : ('a -> 'b) -> 'a -> 'b
(** Whether it is safe to call most GTK functions directly from
    the current thread *)
val gui_safe : unit -> bool
