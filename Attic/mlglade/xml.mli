(*
    $Id$

    Copyright (c) 1999 Christian Lindig <lindig@ips.cs.tu-bs.de>. All
    rights reserved. See COPYING for details.
 *)

open Pp         (* defines doc type and pretty printing functions *)

(*
 * xml abstract syntax
 *) 

type name	= string
type attribute	= name * name           (* name="value" *)
type pi         = name * string list    (* processing instruction *)

type element	= Eelement  of	    name * attribute list * element list
		| Eempty    of	    name * attribute list
		| Echunk    of	    string              (* character data *)
                | Epi       of      pi 

type dtd_id     = DTDsys    of      string
                | DTDpub    of      string * string
               
(* 
 * dtd is incomplete - no markup type provided 
 *)
  
type dtd        = DTD       of      name * dtd_id option 

type xmldecl    = XMLDecl   of string            (* version *)
                             * bool option       (* standalone *)
                             * string option     (* encoding *) 

type prolog     = Prolog    of xmldecl option 
                             * dtd option 
                             * pi list 

type document   = XML       of prolog * element * pi list                

(*
 * pretty printing for XML documents
 *)
 
val ppDoc : document -> doc
