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
