(* $Id$
   
   This module provides small but useful functions which are not provided
   by the OCaml standard library.
 *)


val (<<) : ('a -> 'b) -> ('c -> 'a) -> ('c -> 'b)
(* [f << g] function composition: [(f << g) x = f (g x)] and [f << g << h] 
   equals [(f << g) << h] 
 *)

val (>>) : ('a -> 'b) -> ('b -> 'c) -> ('a -> 'c)
(* [f >> g] function composition: [(f >> g) x = g (f x)]. This operator is
   left associative: [f >> g >> h] equals [(f >> g) >> h].
 *)

