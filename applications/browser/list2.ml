(* $Id$ *)

let rec cut l :len =
  if len <= 0 then [], l else
  match l with
    a::l ->
      let l1, l2 = cut l len:(len-1) in
      a::l1, l2
  | [] ->
      invalid_arg "cut_list"

let rec chop l :len =
  if l = [] then [] else
  let l1, l2 =
    try cut_list l :len
    with Invalid_argument _ -> l, []
  in
  l1 :: chop l2 :len


let rec iteri_aux fun:f :i = function
    [] -> ()
  | a::l -> f :i a; iteri_aux fun:f i:(i+1) l

let iteri = iteri_aux i:0
