(*************************************************************************)
(*                                                                       *)
(*                Objective Caml LablTk library                          *)
(*                                                                       *)
(*            Jacques Garrigue, Kyoto University RIMS                    *)
(*                                                                       *)
(*   Copyright 1999 Institut National de Recherche en Informatique et    *)
(*   en Automatique and Kyoto University.  All rights reserved.          *)
(*   This file is distributed under the terms of the GNU Library         *)
(*   General Public License, with the special exception on linking       *)
(*   described in file ../../../LICENSE.                                 *)
(*                                                                       *)
(*************************************************************************)

(* $Id$ *)

val formatted :
  title:string ->
  ?on:#GContainer.container ->
  ?ppf:Format.formatter ->
  ?width:int ->
  ?maxheight:int ->
  ?minheight:int ->
  unit -> GText.view * (unit -> unit)

val ask :
    title:string -> ?master:#GWindow.window_skel ->
    ?no:bool -> ?cancel:bool -> string -> [`Cancel|`No|`Yes]

val info :
    title:string -> ?master:#GWindow.window_skel -> string -> unit
