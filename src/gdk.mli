(* $Id$ *)

exception Error of string

type colormap
type color
type pixel = int

module Color :
  sig
    type spec = [Black Name(string) RGB(int * int * int) White]
    val alloc : spec -> in:colormap -> color
    external red : color -> int = "ml_GdkColor_red"
    external blue : color -> int = "ml_GdkColor_green"
    external green : color -> int = "ml_GdkColor_blue"
    external pixel : color -> pixel = "ml_GdkColor_pixel"
  end


