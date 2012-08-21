(**************************************************************************)
(*                Lablgtk                                                 *)
(*                                                                        *)
(*    This program is free software; you can redistribute it              *)
(*    and/or modify it under the terms of the GNU Library General         *)
(*    Public License as published by the Free Software Foundation         *)
(*    version 2, with the exception described in file COPYING which       *)
(*    comes with the library.                                             *)
(*                                                                        *)
(*    This program is distributed in the hope that it will be useful,     *)
(*    but WITHOUT ANY WARRANTY; without even the implied warranty of      *)
(*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the       *)
(*    GNU Library General Public License for more details.                *)
(*                                                                        *)
(*    You should have received a copy of the GNU Library General          *)
(*    Public License along with this program; if not, write to the        *)
(*    Free Software Foundation, Inc., 59 Temple Place, Suite 330,         *)
(*    Boston, MA 02111-1307  USA                                          *)
(*                                                                        *)
(*                                                                        *)
(**************************************************************************)

(* $Id$ *)

(* Basic functions *)

(** The main loop to use with threads. [GMain.main] does not work!
    This changes [GMain.main] to call [threaded_main] rather than
    [GtkMain.Main.default_main], so subsequent calls will work.
    The first call sets the GUI thread, and subsequent calls
    to [main] will be automatically routed through [sync].
    With system threads, the ocaml giant lock is now released on
    polling, so that other ocaml threads can run without busy wait. *)
val main : unit -> unit
(** Setting [busy_waiting] to [true] forces the main loop to be
    non-blocking. This is required with VM threads.
    The default value is set to [true] at startup if the environment
    variable [LABLGTK_BUSY_WAIT] is set to something other than [0]. *)
val busy_waiting : bool ref
(** Start the main loop in a new GUI thread. Do not use recursively.
    Do not use with the Quartz backend, as the GUI must imperatively
    run in the main thread. *)
val start : unit -> Thread.t
(** The real main function *)
val thread_main : unit -> unit
(** Forget the current GUI thread. The next call to [main]
    will register its caller as GUI thread. *)
val reset : unit -> unit

(* Jobs are needed for windows and quartz, as you cannot do GTK work from
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
(** Allow other threads to run, and process the message queue.
    The following ensures that messages will be processed even
    if another main loop is running:
      [Glib.Timeout.add ~ms:100 ~callback:GtkThread.do_jobs] *)
val do_jobs : unit -> bool

(** Set the delay used in the main loop when [busy_waiting] is [true].
  Higher value will make the application less CPU-consuming,
  but (relatively) less reactive.
  Default value is [0.013] .*)
val set_do_jobs_delay : float -> unit


