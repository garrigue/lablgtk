(* $Id$ *)

(* Basic functions *)

(** The main loop to use with threads. GMain.main does not work! *)
val main : unit -> unit
(** Start the main loop in another thread. *)
val start : unit -> Thread.t

(* Jobs are needed for windows, as you cannot do GTK work from
   another thread.
   The basic idea is to either use async (if you don't need a result)
   or sync whenever you call a GTK related function from another thread
   (for instance with the threaded toplevel).
   With sync, beware of deadlocks!
*)

(** Add an asynchronous job (to do in the main loop) *)
val async : ('a -> unit) -> 'a -> unit
(** Add a synchronous job (to do in the main loop) *)
val sync : ('a -> 'b) -> 'a -> 'b
(** Whether it is safe to call GTK functions directly from
    the current thread *)
val gui_safe : unit -> bool
