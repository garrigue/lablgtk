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


module Rectangle : sig
  type t
  external create : x:int -> y:int -> width:int -> height:int -> t
      = "ml_GdkRectangle"
  external x : t -> int = "ml_GdkRectangle_x"
  external y : t -> int = "ml_GdkRectangle_y"
  external width : t -> int = "ml_GdkRectangle_width"
  external height : t -> int = "ml_GdkRectangle_height"
end

module Event : sig
  type t
end
