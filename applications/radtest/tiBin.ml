open Gtk

open Utils
open Property

open TiContainer

class tiframe ~(widget : GBin.frame) ~name ~parent_tree ~pos
    ?(insert_evbox=true) parent_window =
object
  val frame = widget
  inherit ticontainer ~name ~widget ~parent_tree ~pos
      ~insert_evbox parent_window

  method private class_name = "GBin.frame"

  initializer
    classe <- "frame";
    frame#set_label name;
    proplist <- proplist @
      [ "label",
	new prop_string ~name:"label" ~init:name ~set:(ftrue frame#set_label);
       "label_xalign",
	new prop_float ~name:"label_xalign" ~init:"0.0" ~min:0. ~max:1.
            ~set:(fun x -> frame#set_label_align ~x (); true);
       "shadow_type",
	new prop_shadow ~name:"shadow_type" ~init:"ETCHED_IN"
	  ~set:(ftrue frame#set_shadow_type) ]
end

let new_tiframe ~name = new tiframe ~widget:(GBin.frame ()) ~name




class tiaspect_frame ~(widget : GBin.aspect_frame) ~name ~parent_tree ~pos
    ?(insert_evbox=true) parent_window =
object
  val aspect_frame = widget
  inherit tiframe ~name ~widget:(widget :> GBin.frame) ~parent_tree ~pos
      ~insert_evbox parent_window

  method private class_name = "GBin.aspect_frame"

  initializer
    classe <- "aspect_frame";
    frame#set_label name;
    proplist <- proplist @
      [ "obey_child",
	new prop_bool ~name:"obey child" ~init:"true"
	  ~set:(ftrue aspect_frame#set_obey_child);
       "ratio",
	new prop_float ~name:"ratio" ~init:"1.0" ~min:0. ~max:1.
            ~set:(ftrue aspect_frame#set_ratio)
      ]	
end

let new_tiaspect_frame ~name =
  new tiaspect_frame ~widget:(GBin.aspect_frame ()) ~name




class tievent_box ~(widget : GBin.event_box) ~name ~parent_tree ~pos
    ?(insert_evbox=true) parent_window =
object
  val event_box = widget
  inherit ticontainer ~name ~widget ~parent_tree ~pos
      ~insert_evbox parent_window

  method private class_name = "GBin.event_box"
  initializer
    classe <- "event_box"
end

let new_event_box ~name = new tievent_box ~widget:(GBin.event_box ()) ~name




class tihandle_box ~(widget : GBin.handle_box) ~name ~parent_tree ~pos
    ?(insert_evbox=true) parent_window =
object
  val handle_box = widget
  inherit ticontainer ~name ~widget ~parent_tree ~pos
      ~insert_evbox parent_window

  method private class_name = "GBin.handle_box"

  initializer
    classe <- "handle_box";
    proplist <- proplist @
      [ "shadow type",
	new prop_shadow ~name:"shadow_type" ~init:"OUT"
	  ~set:(ftrue handle_box#set_shadow_type);
	"handle position",
	new prop_position ~name:"handle_position" ~init:"LEFT"
	  ~set:(ftrue handle_box#set_handle_position);
	"snap edge",
	new prop_position ~name:"snap_edge" ~init:"TOP"
	  ~set:(ftrue handle_box#set_snap_edge)
      ]
end

let new_handle_box ~name = new tihandle_box ~widget:(GBin.handle_box ())
    ~name





class tiviewport ~(widget : GBin.handle_box) ~name ~parent_tree ~pos
    ?(insert_evbox=true) parent_window =
object
  val viewport = widget
  inherit ticontainer ~name ~widget ~parent_tree ~pos
      ~insert_evbox parent_window

  method private class_name = "GBin.viewport"

  initializer
    classe <- "viewport";
    proplist <- proplist @
      [ "shadow type",
	new prop_shadow ~name:"shadow_type" ~init:"OUT"
	  ~set:(ftrue viewport#set_shadow_type)
      ]
end

let new_viewport ~name = new tiviewport ~widget:(GBin.handle_box ())
    ~name





class tiscrolled_window ~(widget : GBin.scrolled_window)
    ~name ~parent_tree ~pos ?(insert_evbox=true) parent_window =
  object(self)
    val scrolled_window = widget
    inherit ticontainer ~name ~insert_evbox
	~parent_tree ~pos ~widget parent_window

    method private class_name = "GBin.scrolled_window"
    method private name_of_add_method = "#add_with_viewport"

    method private add rw ~pos =
      scrolled_window#add_with_viewport (rw#base);
      children <- [ rw, `START];
      self#set_full_menu false;
      tree_item#drag#dest_unset ()

(* we must remove the child from the viewport,
   not from the scrolled_window;
   it is not mandatory to remove the viewport
   from the scrolled_window *)
    method remove child =
      let viewport = (new GContainer.container (GtkBase.Container.cast (List.hd scrolled_window#children)#as_widget)) in
      viewport#remove child#base;
(*      scrolled_window#remove (List.hd scrolled_window#children); *)
      children <- [ ];
      self#set_full_menu true;
      tree_item#drag#dest_set ~actions:[`COPY]
	[ { target = "STRING"; flags = []; info = 0} ]


    initializer
      classe <- "scrolled_window";
      proplist <- proplist @
	[ "hscrollbar policy",
	  new prop_policy ~name:"hscrollbar_policy" ~init:"ALWAYS"
	    ~set:(ftrue scrolled_window#set_hpolicy);
	  "vscrollbar policy",
	  new prop_policy ~name:"vscrollbar_policy" ~init:"ALWAYS"
	    ~set:(ftrue scrolled_window#set_vpolicy) ]
end

let new_tiscrolled_window ~name =
  new tiscrolled_window ~widget:(GBin.scrolled_window ()) ~name


