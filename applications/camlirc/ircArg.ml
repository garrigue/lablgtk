(* $Id$ *)
open Str

type arg = string list

let sep = regexp " :"
and spl = regexp "[ \t]+"

let process_arg s =
  let
      (rest, taillist) = 
    try
      let s1 = " "^s
      in  
      let n = search_forward sep s1 0
      in 
      (string_before s1 n, [string_after s1 (n+2)])
    with Not_found -> (s,[])
  in
  try
    (split spl rest)@taillist 
  with Not_found -> taillist

let to_string sl = 
  List.fold_left (fun s r -> (s^" "^r))  "" sl
