(* $I1: Unison file synchronizer: src/safelist.mli $ *)
(* $I2: Last modified by bcpierce on Mon, 24 Jan 2000 17:48:01 -0500 $ *)
(* $I3: Copyright 1999-2000 (see COPYING for details) $ *)

(* All functions here are tail recursive and will work for arbitrary
   sized lists (unlike some of the standard ones).  The intention is that
   the built-in List module should not be referred to outside this module. *)

(* Functions from built-in List module *)
val map : fun:('a -> 'b) -> 'a list -> 'b list
val append : 'a list -> 'a list -> 'a list
val concat : 'a list list -> 'a list       
val combine : 'a list -> 'b list -> ('a * 'b) list 
val iter : fun:('a -> unit) -> 'a list -> unit
val rev : 'a list -> 'a list
val fold_right : fun:('a -> acc:'b -> 'b) -> 'a list -> acc:'b -> 'b
val hd : 'a list -> 'a
val tl : 'a list -> 'a list
val nth : 'a list -> pos:int -> 'a
val length : 'a list -> int
val mem : item:'a -> 'a list -> bool
val flatten : 'a list list -> 'a list
val assoc : key:'a -> ('a * 'b) list -> 'b
val for_all : pred:('a -> bool) -> 'a list -> bool
val exists : pred:('a -> bool) -> 'a list -> bool
val split : ('a * 'b) list -> 'a list * 'b list
val filter : pred:('a -> bool) -> 'a list -> 'a list
val remove_assoc : key:'a -> ('a * 'b) list -> ('a * 'b) list
val fold_left: fun:(acc:'a -> 'b -> 'a) -> acc:'a -> 'b list -> 'a
val map2 : fun:('a -> 'b -> 'c) -> 'a list -> 'b list -> 'c list

(* Other useful list-processing functions *)
val filterMap : fun:('a -> 'b option) -> 'a list -> 'b list
val splitN : 'a list list -> pos:int -> 'a list list
val filterBoth : pred:('a -> bool) -> 'a list -> ('a list * 'a list)
val allElementsEqual : 'a list -> bool

