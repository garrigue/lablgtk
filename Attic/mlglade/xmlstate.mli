(*
 * $Id$
 * 
 * Scanning XML files is context dependend. The parser controlls
 * the context of the scanner.
 *)

(* the differnt contexts -- see [xmlscan] module *)

type context = ElementContext | DataContext | DeclContext | PiContext

(* functions to get and set the context *)

val setContext : context -> unit
val getContext : unit -> context

