(* $Id$ *)

open Gtk
open GtkMain
open GObj

module Main = Main

module Grab = struct
  open Grab
  let add (w : #widget) = add w#as_widget
  let remove (w : #widget) = remove w#as_widget
  let get_current () = new widget (get_current ())
end

module Rc = Rc

module Timeout = Timeout

module Io = Glib.Io

open Main
let main = main
let quit = quit
