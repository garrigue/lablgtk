(* $Id$ *)

type colormap
type color
type pixel = int

exception Error of string
let _ = Callback.register_exception "gdkerror" (Error"")

external color_white : colormap -> color = "ml_gdk_color_white"
external color_black : colormap -> color = "ml_gdk_color_black"
external color_parse : string -> color = "ml_gdk_color_parse"
external color_alloc : colormap -> color -> bool = "ml_gdk_color_alloc"
external color_create : red:int -> green:int -> blue:int -> color
    = "ml_GdkColor"

module Color = struct
  type spec = [Black Name(string) RGB(int * int * int) White]
  let alloc color in:colormap =
    match color with
      `White -> color_white colormap
    | `Black -> color_black colormap
    | `Name _|`RGB _ as c ->
	let color =
	  match c with `Name s -> color_parse s
	  | `RGB (red,green,blue) -> color_create :red :green :blue
	in
	if not (color_alloc colormap color) then raise (Error"color_alloc");
	color

  external red : color -> int = "ml_GdkColor_red"
  external blue : color -> int = "ml_GdkColor_green"
  external green : color -> int = "ml_GdkColor_blue"
  external pixel : color -> pixel = "ml_GdkColor_pixel"
end
