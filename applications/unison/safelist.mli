(* $I1: Unison file synchronizer: src/safelist.mli $ *)
(* $I2: Last modified by vouillon on Wed, 16 Feb 2000 15:30:55 -0500 $ *)
(* $I3: Copyright 1999-2000 (see COPYING for details) $ *)

(* All functions here are tail recursive and will work for arbitrary
   sized lists (unlike some of the standard ones).  The intention is that
   the built-in List module should not be referred to outside this module. *)

(* Functions from built-in List module *)
val map : f:('a -> 'b) -> 'a list -> 'b list
val append : 'a list -> 'a list -> 'a list
val rev_append : 'a list -> 'a list -> 'a list
val concat : 'a list list -> 'a list       
val combine : 'a list -> 'b list -> ('a * 'b) list 
val iter : f:('a -> unit) -> 'a list -> unit
val rev : 'a list -> 'a list
val fold_right : f:('a -> 'b -> 'b) -> 'a list -> init:'b -> 'b
val hd : 'a list -> 'a
val tl : 'a list -> 'a list
val nth : 'a list -> int -> 'a
val length : 'a list -> int
val mem : 'a -> 'a list -> bool
val flatten : 'a list list -> 'a list
val assoc : 'a -> ('a * 'b) list -> 'b
val for_all : f:('a -> bool) -> 'a list -> bool
val exists : f:('a -> bool) -> 'a list -> bool
val split : ('a * 'b) list -> 'a list * 'b list
val filter : f:('a -> bool) -> 'a list -> 'a list
val remove_assoc : 'a -> ('a * 'b) list -> ('a * 'b) list
val fold_left: f:('a -> 'b -> 'a) -> init:'a -> 'b list -> 'a
val map2 : f:('a -> 'b -> 'c) -> 'a list -> 'b list -> 'c list
val iter2 : f:('a -> 'b -> unit) -> 'a list -> 'b list -> unit

(* Other useful list-processing functions *)
val filterMap : f:('a -> 'b option) -> 'a list -> 'b list
val filterMap2 :
    f:('a -> 'b option * 'c option) -> 'a list -> 'b list * 'c list
val transpose : 'a list list -> 'a list list
val filterBoth : f:('a -> bool) -> 'a list -> ('a list * 'a list)
val allElementsEqual : 'a list -> bool
