(* $Id$ *)

open Common

val init : unit -> GWindow.window
val show : #tiwidget_base -> unit
val add : #tiwidget_base -> unit
val remove : string -> unit
(* val change_name : string -> string -> unit *)
val update : #tiwidget_base -> bool -> unit
