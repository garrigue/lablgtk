(* $Id$ *)

open Gtk
open GtkMain
open GObj

module Main : sig
  val locale : string
  val argv : string array
  val main : unit -> unit
  val quit : unit -> unit
  val version : int * int * int
end = Main

module Grab = struct
  open Grab
  let add (w : #is_widget) = add w#as_widget
  let remove (w : #is_widget) = remove w#as_widget
  let get_current () = new widget_wrapper (get_current ())
end

module Timeout : sig
  type id
  val add : int -> callback:(unit -> bool) -> id
  val remove : id -> unit
end = Timeout
