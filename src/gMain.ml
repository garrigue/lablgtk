(* $Id$ *)

open Gtk
open GtkMain
open GObj

module Main : sig
  val locale : string
  val init : unit -> unit
  val main : unit -> unit
  val quit : unit -> unit
  val version : int * int * int
  val flush : unit -> unit
end = Main

module Grab = struct
  open Grab
  let add (w : #widget) = add w#as_widget
  let remove (w : #widget) = remove w#as_widget
  let get_current () = new widget (get_current ())
end

module Timeout : sig
  type id
  val add : int -> callback:(unit -> bool) -> id
  val remove : id -> unit
end = Timeout
