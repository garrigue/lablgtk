(**************************************************************************)
(*     Lablgtk - Applications                                             *)
(*                                                                        *)
(*    * You are free to do anything you want with this code as long       *)
(*      as it is for personal use.                                        *)
(*                                                                        *)
(*    * Redistribution can only be "as is".  Binary distribution          *)
(*      and bug fixes are allowed, but you cannot extensively             *)
(*      modify the code without asking the authors.                       *)
(*                                                                        *)
(*    The authors may choose to remove any of the above                   *)
(*    restrictions on a per request basis.                                *)
(*                                                                        *)
(*    Authors:                                                            *)
(*      Jacques Garrigue <garrigue@kurims.kyoto-u.ac.jp>                  *)
(*      Benjamin Monate  <Benjamin.Monate@free.fr>                        *)
(*      Olivier Andrieu  <oandrieu@nerim.net>                             *)
(*      Jun Furuse       <Jun.Furuse@inria.fr>                            *)
(*      Hubert Fauque    <hubert.fauque@wanadoo.fr>                       *)
(*      Koji Kagawa      <kagawa@eng.kagawa-u.ac.jp>                      *)
(*                                                                        *)
(**************************************************************************)

(* $Id$ *)

type error =
  | Illegal_character of char
  | Bad_entity of string
  | Unterminated of string
  | Tag_expected
  | Other of string
exception Error of error * int
val error_string : error -> string

type token =
  | Tag of string * (string * string) list * bool
        (* [Tag (name, attributes, closed)] denotes an opening tag with
           the specified [name] and [attributes]. If [closed], then the tag
           ended in "/>", meaning that it has no sub-elements. *)
  | Chars of string
        (* Some text between the tags, cut by line *)
  | Endtag of string
        (* A closing tag *)
  | EOF
        (* End of input *)
val token : Lexing.lexbuf -> token
val token_start : unit -> int

val base64 : Lexing.lexbuf -> int
    (* Decode base 64 data to 6-bit ints, skipping blanks *)
