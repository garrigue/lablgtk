
open Utils
open Property

open TiBase
open TiContainer


class tiseparator ~(dir : Gtk.Tags.orientation) ~(widget : GObj.widget_full)
    ~name ~parent_tree ~pos ?(insert_evbox=true) parent_window =
object
  val separator = widget
  inherit tiwidget ~name ~widget ~parent_tree ~pos parent_window ~insert_evbox

  method private class_name =
    match dir with `VERTICAL -> "GMisc.separator `VERTICAL"
    | `HORIZONTAL -> "GMisc.hseparator `HORIZONTAL"
  initializer
    classe <-
    (match dir with `VERTICAL -> "vseparator" | `HORIZONTAL -> "hseparator")

end

let new_tihseparator ~name ?(listprop = []) =
  new tiseparator ~dir: `HORIZONTAL ~name
    ~widget:(GMisc.separator `HORIZONTAL ())
let new_tivseparator ~name ?(listprop = []) = 
  new tiseparator ~dir: `VERTICAL ~name
    ~widget:(GMisc.separator `VERTICAL ())




class tistatusbar ~(widget : GMisc.statusbar) ~name ~parent_tree ~pos
    ?(insert_evbox=true) parent_window =
object(self)
  val statusbar = widget
  inherit ticontainer ~name ~widget ~insert_evbox
      ~parent_tree ~pos parent_window as widget

  method private class_name = "GMisc.statusbar"

  initializer
    classe <- "statusbar"
end

let new_tistatusbar ~name ?(listprop = []) =
  new tistatusbar ~widget:(GMisc.statusbar ()) ~name



class timisc ~(widget : GMisc.misc) ~name ~parent_tree ~pos
    ?(insert_evbox=true) parent_window =
object(self)
  val misc = widget
  inherit tiwidget ~name ~widget ~insert_evbox
      ~parent_tree ~pos parent_window as widget

  method private class_name = failwith "timisc::class_name"

  initializer
    proplist <- proplist @
      [ "x_alignment",
	new prop_float ~name:"x alignment" ~init:"0.5" ~min:0. ~max:1.
	  ~set:(fun v -> misc#set_alignment ~x:v (); true);
	"y_alignment",
	new prop_float ~name:"y alignment" ~init:"0.5" ~min:0. ~max:1.
	  ~set:(fun v -> misc#set_alignment ~y:v (); true);
	"x_padding",
	new prop_int ~name:"x padding" ~init:"0.5"
	  ~set:(fun v -> misc#set_padding ~x:v (); true);
	"y_padding",
	new prop_int ~name:"y padding" ~init:"0.5"
	  ~set:(fun v -> misc#set_padding ~y:v (); true)

      ]
end


class tiarrow ~(widget : GMisc.arrow) ~name ~parent_tree ~pos
    ?(insert_evbox=true) parent_window =
object(self)
  val arrow = widget
  inherit timisc ~name ~widget:(widget :> GMisc.misc) ~insert_evbox
      ~parent_tree ~pos parent_window as widget

  method private class_name = "GMisc.arrow"
  initializer
    classe <- "arrow";
end


(* TODO   fenetre demandant kind et shadow 
let new_tiarrow ~name = new tiarrow ~widget:(GMisc.arrow ()) ~name
*)


class tilabel ~(widget : GMisc.label) ~name ~parent_tree ~pos
    ?(insert_evbox=true) parent_window =
object(self)
  val labelw = widget
  inherit timisc ~name ~widget:(widget :> GMisc.misc) ~insert_evbox
      ~parent_tree ~pos parent_window as widget

  method private class_name = "GMisc.label"

  method private get_mandatory_props = [ "text" ]

  initializer
    classe <- "label";
    proplist <-  proplist @
      [ "text",
	new prop_string ~name:"text" ~init:name ~set:(ftrue labelw#set_text);
	"line_wrap",
	new prop_bool ~name:"line_wrap" ~init:"true"
	  ~set:(ftrue labelw#set_line_wrap)
      ]
end

let new_tilabel ~name ?(listprop = []) =
  new tilabel ~widget:(GMisc.label ~text:name ()) ~name





class ticolor_selection ~(widget : GMisc.color_selection) ~name ~parent_tree ~pos
    ?(insert_evbox=true) parent_window =
object(self)
  val color_selection = widget
  inherit tiwidget ~name ~widget ~insert_evbox
      ~parent_tree ~pos parent_window as widget

  method private class_name = "GMisc.color_selection"

  initializer
    classe <- "color_selection";
    proplist <-  proplist @
      [ "use_opacity",
	new prop_bool ~name:"use_opacity" ~init:"false"
	  ~set:(ftrue color_selection#set_opacity);
	"update_policy",
	new prop_update_type ~name:"update_policy" ~init:"CONTINUOUS"
	  ~set:(ftrue color_selection#set_update_policy)
      ]
end

let new_ticolor_selection ~name ?(listprop = []) =
  new ticolor_selection ~widget:(GMisc.color_selection ()) ~name


class tipixmap ~(widget : GMisc.pixmap) ~name ~parent_tree ~pos
    ?(insert_evbox=true) parent_window =
object(self)
  val pixmap = widget
  inherit timisc ~name ~widget:(widget :> GMisc.misc) ~insert_evbox
      ~parent_tree ~pos parent_window as widget

  method private class_name = "GMisc.pixmap"
  initializer
    classe <- "pixmap";
    proplist <- proplist @
      [ "file",
	new prop_file ~name:"file" ~init:""
	  ~set:(fun v ->
	    pixmap#set_pixmap
	      (GDraw.pixmap_from_xpm ~window:parent_window#tiwin#widget
		 ~file:v ());
	    true)
      ]
end

let new_tipixmap ~name ?(listprop = []) ~parent_tree ~pos ?(insert_evbox=true) (parent_window : window_and_tree0) =
  new tipixmap ~widget:(GMisc.pixmap (GDraw.pixmap_from_xpm 
   ~window:parent_window#tiwin#widget ~file:"pixmap.xpm" ()) ()) ~name
    ~parent_tree ~pos ~insert_evbox parent_window
