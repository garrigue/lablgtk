(*
 * $Id$

    Copyright (c) 1999 Christian Lindig <lindig@ips.cs.tu-bs.de>. All
    rights reserved. See COPYING for details.
 * 
 * Scanning XML files is context dependend. The parser controlls
 * the context of the scanner.
 *)


type context =      | ElementContext 
                    | DataContext
                    | DeclContext
                    | PiContext

(* [contextAsString] is only for debuging.
 *)

let contextAsString = function
    | ElementContext    -> "element"
    | DataContext       -> "pc"
    | DeclContext       -> "xml"
    | PiContext         -> "pi"

(* [context] holds the current scanning context used 
 * by parser and scanner. Don't access directy.
 *)
let context	    = ref DataContext

(* get and set context *)
 
let setContext c    = context := c (* ; print_endline (contextAsString c) *)
let getContext ()   = !context


