(* $Id$ *)

open GEdit

let line_start (text : text) ?:pos [< text#position >] =
  if pos = 0 then 0 else
  let start = max 0 (pos-256) in
  let buffer = text#get_chars :start end:pos in
  try start + String.rindex buffer char:'\n' with Not_found -> 0

let line_end (text : text) ?:pos [< text#position >] =
  if pos = text#length then text#length else
  let buffer = text#get_chars start:pos end:(min text#length (pos+256)) in
  try pos + String.index buffer char:'\n' with Not_found -> text#length
