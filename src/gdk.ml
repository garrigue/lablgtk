(* $Id$ *)

type colormap
type visual
type window
type pixmap
type bitmap
type font

exception Error of string
let _ = Callback.register_exception "gdkerror" (Error"")

module Color = struct
  type t

  external color_white : colormap -> t = "ml_gdk_color_white"
  external color_black : colormap -> t = "ml_gdk_color_black"
  external color_parse : string -> t = "ml_gdk_color_parse"
  external color_alloc : colormap -> t -> bool = "ml_gdk_color_alloc"
  external color_create : red:int -> green:int -> blue:int -> t
      = "ml_GdkColor"

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

  external red : t -> int = "ml_GdkColor_red"
  external blue : t -> int = "ml_GdkColor_green"
  external green : t -> int = "ml_GdkColor_blue"
  external pixel : t -> int = "ml_GdkColor_pixel"
end

module Rectangle = struct
  type t
  external create : x:int -> y:int -> width:int -> height:int -> t
      = "ml_GdkRectangle"
  external x : t -> int = "ml_GdkRectangle_x"
  external y : t -> int = "ml_GdkRectangle_y"
  external width : t -> int = "ml_GdkRectangle_width"
  external height : t -> int = "ml_GdkRectangle_height"
end

module Event = struct
  type t
end

module Pixmap = struct
  external create : window -> width:int -> height:int -> depth:int -> pixmap
      = "ml_gdk_pixmap_new"
  external create_from_data :
      window -> string -> width:int -> height:int -> depth:int ->
      fg:Color.t -> bg:Color.t -> pixmap
      = "ml_gdk_pixmap_create_from_data_bc" "ml_gk_pixmap_create_from_data"
  external create_from_xpm :
      window -> ?:colormap -> ?transparent:Color.t ->
      file:string -> pixmap * bitmap
      = "ml_gdk_pixmap_colormap_create_from_xpm"
  external create_from_xpm_d :
      window -> ?:colormap -> ?transparent:Color.t ->
      data:string array -> pixmap * bitmap
      = "ml_gdk_pixmap_colormap_create_from_xpm_d"
end

module Bitmap = struct
  external create_from_data :
      window -> string -> width:int -> height:int -> bitmap
      = "ml_gdk_bitmap_create_from_data"
end

module Font = struct
  external load : string -> font = "ml_gdk_font_load"
  external load_fontset : string -> font = "ml_gdk_fontset_load"
  external string_width : font -> string -> int = "ml_gdk_string_width"
  external char_width : font -> char -> int = "ml_gdk_char_width"
  external string_measure : font -> string -> int = "ml_gdk_string_measure"
  external char_measure : font -> char -> int = "ml_gdk_char_measure"
end
