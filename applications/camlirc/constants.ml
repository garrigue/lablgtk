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

let config_file = (getpwnam (getlogin ())).pw_dir^"/.camlirc.xml"
