(* $Id$ *)

open Misc
open Gdk

type color = [
  | `COLOR of Color.t
  | `WHITE
  | `BLACK
  | `NAME of string
  | `RGB of int * int * int
]

let default_colormap = GtkBase.Widget.get_default_colormap

let color ?(colormap = default_colormap ()) (c : color) =
  match c with
  | `COLOR col -> col
  | `WHITE|`BLACK|`NAME _|`RGB _ as def -> Color.alloc ~colormap def

class ['a] drawable ?(colormap = default_colormap ()) w =
object (self)
  val colormap = colormap
  val gc = GC.create w
  val w : 'a Gdk.drawable = w
  method color = color ~colormap
  method set_foreground col = GC.set_foreground gc (self#color col)
  method set_background col = GC.set_background gc (self#color col)
  method gc_values = GC.get_values gc
  method set_line_attributes ?width ?style ?cap ?join () =
    let v = GC.get_values gc in
    GC.set_line_attributes gc
      ~width:(default v.GC.line_width width)
      ~style:(default v.GC.line_style style)
      ~cap:(default v.GC.cap_style cap)
      ~join:(default v.GC.join_style join)
  method point = Draw.point w gc
  method line = Draw.line w gc
  method rectangle = Draw.rectangle w gc
  method arc = Draw.arc w gc
  method polygon ?filled l = Draw.polygon w gc ?filled l
  method string s = Draw.string w gc ~string:s
  method image ~width ~height ?(xsrc=0) ?(ysrc=0) ?(xdest=0) ?(ydest=0) image =
    Draw.image w gc ~image ~width ~height ~xsrc ~ysrc ~xdest ~ydest
end

class pixmap ?colormap ?mask pm = object
  inherit [[`pixmap]] drawable ?colormap pm as pixmap
  val bitmap = may_map mask ~f:
      begin fun x ->
        let mask = new drawable x in
        mask#set_foreground `WHITE;
        mask
      end
  val mask : Gdk.bitmap option = mask
  method pixmap = w
  method mask = mask
  method set_line_attributes ?width ?style ?cap ?join () =
    pixmap#set_line_attributes ?width ?style ?cap ?join ();
    may bitmap ~f:(fun m -> m#set_line_attributes ?width ?style ?cap ?join ())
  method point ~x ~y =
    pixmap#point ~x ~y;
    may bitmap ~f:(fun m -> m#point ~x ~y)
  method line ~x ~y ~x:x' ~y:y' =
    pixmap#line ~x ~y ~x:x' ~y:y';
    may bitmap ~f:(fun m -> m#line ~x ~y ~x:x' ~y:y')
  method rectangle ~x ~y ~width ~height ?filled () =
    pixmap#rectangle ~x ~y ~width ~height ?filled ();
    may bitmap ~f:(fun m -> m#rectangle ~x ~y ~width ~height ?filled ())
  method arc ~x ~y ~width ~height ?filled ?start ?angle () =
    pixmap#arc ~x ~y ~width ~height ?filled ?start ?angle ();
    may bitmap
      ~f:(fun m -> m#arc ~x ~y ~width ~height ?filled ?start ?angle ());
  method polygon ?filled l =
    pixmap#polygon ?filled l;
    may bitmap ~f:(fun m -> m#polygon ?filled l)
  method string s ~font ~x ~y =
    pixmap#string s ~font ~x ~y;
    may bitmap ~f:(fun m -> m#string s ~font ~x ~y)
end

class type widget_draw = object
  method allocation : Gtk.rectangle
  method colormap : colormap
  method draw : Rectangle.t option -> unit
  method event : Tags.event_type event -> bool
  method hide : unit -> unit
  method hide_all : unit -> unit
  method intersect : Rectangle.t -> Rectangle.t option
  method pointer : int * int
  method realize : unit -> unit
  method set_app_paintable : bool -> unit
  method set_uposition : x:int -> y:int -> unit
  method set_usize : width:int -> height:int -> unit
  method show : unit -> unit
  method unmap : unit -> unit
  method unparent : unit -> unit
  method unrealize : unit -> unit
  method visible : bool
  method visual : visual
  method visual_depth : int
  method window : window
end

let pixmap ~(window : < misc : #widget_draw; .. >)
    ~width ~height ?(mask=false) () =
  window#misc#realize ();
  let depth = window#misc#visual_depth
  and window = window#misc#window
  and colormap = window#misc#colormap in
  let mask =
    if not mask then None else
    let bm = Bitmap.create window ~width ~height in
    let mask = new drawable bm in
    mask#set_foreground `BLACK;
    mask#rectangle ~x:0 ~y:0 ~width ~height ~filled:true ();
    Some bm
  in
  new pixmap (Pixmap.create window ~width ~height ~depth) ~colormap ?mask

let pixmap_from_xpm ~window ~file ?colormap ?transparent () =
  let pm, mask =
    try Pixmap.create_from_xpm window ~file ?colormap
	?transparent:(may_map transparent ~f:(fun c -> color c))
    with Null_pointer -> invalid_arg ("GDraw.pixmap_from_xpm : " ^ file) in
  new pixmap pm ?colormap ~mask

let pixmap_from_xpm_d ~window ~data ?colormap ?transparent () =
  let pm, mask =
    Pixmap.create_from_xpm_d window ~data ?colormap
      ?transparent:(may_map transparent ~f:(fun c -> color c)) in
  new pixmap pm ?colormap ~mask

class drag_context context = object
  val context = context
  method status ?(time=0) act = DnD.drag_status context act ~time
  method suggested_action = DnD.drag_context_suggested_action context
  method targets = DnD.drag_context_targets context
end
