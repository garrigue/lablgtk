
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
    match dir with `VERTICAL -> "GMisc.vseparator"
    | `HORIZONTAL -> "GMisc.hseparator"
  initializer
    classe <-
    (match dir with `VERTICAL -> "vseparator" | `HORIZONTAL -> "hseparator")

end

let new_tihseparator ~name = new tiseparator ~dir: `HORIZONTAL ~name
    ~widget:(GMisc.separator `HORIZONTAL ())
let new_tivseparator ~name = new tiseparator ~dir: `VERTICAL ~name
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

let new_tistatusbar ~name = new tistatusbar ~widget:(GMisc.statusbar ()) ~name



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

  method private save_clean_proplist =
    List.remove_assoc "text" widget#save_clean_proplist

  method private emit_clean_proplist plist =
    List.remove_assoc "text" (widget#emit_clean_proplist plist)

  method private save_start formatter =
    Format.fprintf formatter "@\n@[<2><%s name=%s>" classe name;
    Format.fprintf formatter "@\ntext=\"%s\""
      (List.assoc "text" proplist)#get

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

let new_tilabel ~name = new tilabel ~widget:(GMisc.label ~text:name ()) ~name






class tinotebook ~(widget : GMisc.notebook) ~name ~parent_tree ~pos
    ?(insert_evbox=true) parent_window =
object(self)
  val notebook = widget
  inherit ticontainer ~name ~widget ~insert_evbox
      ~parent_tree ~pos parent_window as widget

  method private class_name = "GMisc.notebook"

  method private add child ~pos =
    children <- children @ [child, `START];
    notebook#insert_page child#base ~pos;
    child#add_to_proplist
      [ "tab_label",
	new prop_string ~name:"tab_label" ~init:""
	  ~set:(fun v -> notebook#set_page
	      ~tab_label:((GMisc.label ~text:v())#coerce) child#base; true)
      ]


  initializer
    classe <- "notebook";
    proplist <-  proplist @
      [ "tab_pos",
	new prop_position ~name:"tab_ pos" ~init:"TOP"
	  ~set:(ftrue notebook#set_tab_pos);
	"show_tabs",
	new prop_bool ~name:"show_tabs" ~init:"true"
	  ~set:(ftrue notebook#set_show_tabs);
	"homogeneous_tabs",
	new prop_bool ~name:"homogeneous_tabs" ~init:"true"
	  ~set:(ftrue notebook#set_homogeneous_tabs);
	"show_border",
	new prop_bool ~name:"show_border" ~init:"true"
	  ~set:(ftrue notebook#set_show_border);
	"scrollable",
	new prop_bool ~name:"scrollable" ~init:"false"
	  ~set:(ftrue notebook#set_scrollable);
	"tab_border",
	new prop_int ~name:"tab_border" ~init:"2"
	  ~set:(ftrue notebook#set_tab_border);
	"popup_enable",
	new prop_bool ~name:"popup_enable" ~init:"false"
	  ~set:(ftrue notebook#set_popup)
      ]
end

let new_tinotebook ~name = new tinotebook ~widget:(GMisc.notebook ()) ~name





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

let new_ticolor_selection ~name = new ticolor_selection
    ~widget:(GMisc.color_selection ()) ~name
