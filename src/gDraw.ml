(* $Id$ *)

open Gaux
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
  | #Gdk.Color.spec as def -> Color.alloc ~colormap def

type optcolor = [
  | `COLOR of Color.t
  | `WHITE
  | `BLACK
  | `NAME of string
  | `RGB of int * int * int
  | `DEFAULT
]

let optcolor ?colormap (c : optcolor) =
  match c with
  | `DEFAULT -> None
  | #color as c -> Some (color ?colormap c)

class drawable ?(colormap = default_colormap ()) w =
object (self)
  val colormap = colormap
  val gc = GC.create w
  val w = w
  method color = color ~colormap
  method set_foreground col = GC.set_foreground gc (self#color col)
  method set_background col = GC.set_background gc (self#color col)
  method size = Drawable.get_size w
  method depth = Drawable.get_depth w
  method gc_values = GC.get_values gc
  method set_clip_region = GC.set_clip_region gc
  method set_clip_origin = GC.set_clip_origin gc
  method set_clip_mask = GC.set_clip_mask gc
  method set_clip_rectangle = GC.set_clip_rectangle gc
  method set_line_attributes ?width ?style ?cap ?join () =
    let v = GC.get_values gc in
    GC.set_line_attributes gc
      ~width:(default v.GC.line_width ~opt:width)
      ~style:(default v.GC.line_style ~opt:style)
      ~cap:(default v.GC.cap_style ~opt:cap)
      ~join:(default v.GC.join_style ~opt:join)
  method point = Draw.point w gc
  method line = Draw.line w gc
  method rectangle = Draw.rectangle w gc
  method arc = Draw.arc w gc
  method polygon = Draw.polygon w gc
  method string s = Draw.string w gc s
  method put_image ~x ~y = Draw.image w gc ~xdest:x ~ydest:y
  method put_pixmap ~x ~y = Draw.pixmap w gc ~xdest:x ~ydest:y
  method put_rgb_data = Rgb.draw_image w gc
  method points = Draw.points w gc
  method lines = Draw.lines w gc
  method segments = Draw.segments w gc
end

class pixmap ?colormap ?mask pm = object
  inherit drawable ?colormap pm as pixmap
  val bitmap = may_map mask ~f:
      begin fun x ->
        let mask = new drawable x in
        mask#set_foreground `WHITE;
        mask
      end
  val mask : Gdk.bitmap option = mask
  method pixmap : Gdk.pixmap = w
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
  method points pts = pixmap#points pts; may bitmap ~f:(fun m -> m#points pts)
  method lines pts = pixmap#lines pts; may bitmap ~f:(fun m -> m#lines pts)
  method segments lns = pixmap#segments lns; may bitmap ~f:(fun m -> m#segments lns)
end

class type misc_ops = object
  method allocation : Gtk.rectangle
  method colormap : colormap
  method draw : Rectangle.t option -> unit
  method hide : unit -> unit
  method hide_all : unit -> unit
  method intersect : Rectangle.t -> Rectangle.t option
  method pointer : int * int
  method realize : unit -> unit
  method set_app_paintable : bool -> unit
  method set_geometry :
    ?x:int -> ?y:int -> ?width:int -> ?height:int -> unit -> unit
  method show : unit -> unit
  method unmap : unit -> unit
  method unparent : unit -> unit
  method unrealize : unit -> unit
  method visible : bool
  method visual : visual
  method visual_depth : int
  method window : window
end

let pixmap ~width ~height ?(mask=false)
    ?(window : < misc : #misc_ops; .. > option) ?colormap () =
  let window, depth, colormap =
    match window with
      Some w ->
        begin try
          w#misc#realize ();
          Some w#misc#window, w#misc#visual_depth,
          match colormap with Some c -> c | None -> w#misc#colormap
        with Gpointer.Null -> failwith "GDraw.pixmap : window"
        end
    | None ->
        let colormap =
          match colormap with Some c -> c | None -> default_colormap () in
        None, (Gdk.Visual.depth (Gdk.Color.get_visual colormap)), colormap
  in
  let mask =
    if not mask then None else
    let bm = Bitmap.create ?window ~width ~height () in
    let mask = new drawable bm in
    mask#set_foreground `BLACK;
    mask#rectangle ~x:0 ~y:0 ~width ~height ~filled:true ();
    Some bm
  in
  new pixmap (Pixmap.create ?window ~width ~height ~depth ()) ~colormap ?mask

let pixmap_from_xpm ~file ?window ?colormap ?transparent () =
  let window =
    try may_map window ~f:(fun w -> w#misc#realize (); w#misc#window)
    with Gpointer.Null -> invalid_arg "GDraw.pixmap_from_xpm : window"
  in
  let colormap =
    if colormap <> None || window <> None then colormap
    else Some (default_colormap ())
  in
  let pm, mask =
    try Pixmap.create_from_xpm  ~file ?window ?colormap
	?transparent:(may_map transparent ~f:(fun c -> color c)) ()
    with _ -> invalid_arg ("GDraw.pixmap_from_xpm : " ^ file) in
  new pixmap pm ?colormap ~mask

let pixmap_from_xpm_d ~data ?window ?colormap ?transparent () =
  let window =
    try may_map window ~f:(fun w -> w#misc#realize (); w#misc#window)
    with Gpointer.Null -> failwith "GDraw.pixmap_from_xpm_d : no window" in
  let pm, mask =
    Pixmap.create_from_xpm_d ~data ?colormap ?window
      ?transparent:(may_map transparent ~f:(fun c -> color c)) () in
  new pixmap pm ?colormap ~mask

class drag_context context = object
  val context = context
  method status ?(time=Int32.zero) act = DnD.drag_status context act ~time
  method suggested_action = DnD.drag_context_suggested_action context
  method targets = List.map Gdk.Atom.name (DnD.drag_context_targets context)
end
