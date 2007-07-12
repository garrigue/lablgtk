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
open Str
open Unix

let doctype = Printf.sprintf "Caml IRC client %d.%d" 1 1
let software = "CamlIRC"
let version = "0.01"
let datestring = 
  match split (regexp " ") "$Date$" with
  | [_;date;time;_] ->
      date^"-"^(global_replace (regexp ":") "-" time) 
  | _ -> "" 

(* *)

let id = software^" "^version^"("^datestring^")"
and author = ""

(* getlogin doesn't work all the time.  I observe it to raise an
   exception when I log in via xdm on my Debian system, March 21, 2002.
   Using getpwuid instead.  tim@fungible.com. *)

let user_entry = getpwuid (getuid ());;

let config_file = user_entry.pw_dir^"/.camlirc.xml";;
