(* $Id$ *)

open Gtk
open GObj
open GContainer

class box_skel : ([> box] as 'a) obj ->
  object
    inherit container
    val obj : 'a obj
    method pack :
      ?from:Tags.pack_type ->
      ?expand:bool -> ?fill:bool -> ?padding:int -> widget -> unit
    method reorder_child : widget -> pos:int -> unit
    method set_child_packing :
      ?from:Tags.pack_type ->
      ?expand:bool -> ?fill:bool -> ?padding:int -> widget -> unit
    method set_homogeneous : bool -> unit
    method set_spacing : int -> unit
  end
class box : ([> Gtk.box] as 'a) obj ->
  object
    inherit box_skel
    val obj : 'a obj
    method connect : GContainer.container_signals
  end

val box :
  Tags.orientation ->
  ?homogeneous:bool ->
  ?spacing:int ->
  ?border_width:int ->
  ?width:int ->
  ?height:int -> ?packing:(widget -> unit) -> ?show:bool -> unit -> box
val vbox :
  ?homogeneous:bool ->
  ?spacing:int ->
  ?border_width:int ->
  ?width:int ->
  ?height:int -> ?packing:(widget -> unit) -> ?show:bool -> unit -> box
val hbox :
  ?homogeneous:bool ->
  ?spacing:int ->
  ?border_width:int ->
  ?width:int ->
  ?height:int -> ?packing:(widget -> unit) -> ?show:bool -> unit -> box

class button_box : ([> Gtk.button_box] as 'a) obj ->
  object
    inherit container_full
    val obj : 'a obj
    method pack :
      ?from:Tags.pack_type ->
      ?expand:bool -> ?fill:bool -> ?padding:int -> widget -> unit
    method reorder_child : widget -> pos:int -> unit
    method set_child_ipadding : ?x:int -> ?y:int -> unit -> unit
    method set_child_packing :
      ?from:Tags.pack_type ->
      ?expand:bool -> ?fill:bool -> ?padding:int -> widget -> unit
    method set_child_size : ?width:int -> ?height:int -> unit -> unit
    method set_homogeneous : bool -> unit
    method set_layout : GtkPack.BBox.bbox_style -> unit
    method layout : GtkPack.BBox.bbox_style
    method set_spacing : int -> unit
  end
val button_box :
  Tags.orientation ->
  ?spacing:int ->
  ?child_width:int ->
  ?child_height:int ->
  ?child_ipadx:int ->
  ?child_ipady:int ->
  ?layout:GtkPack.BBox.bbox_style ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> button_box

class table :
  Gtk.table obj ->
  object
    inherit container_full
    val obj : Gtk.table obj
    method attach :
      left:int ->
      top:int ->
      ?right:int ->
      ?bottom:int ->
      ?expand:Tags.expand_type ->
      ?fill:Tags.expand_type ->
      ?shrink:Tags.expand_type ->
      ?xpadding:int -> ?ypadding:int -> widget -> unit
    method col_spacings : int
    method columns : int
    method homogeneous : bool
    method row_spacings : int
    method rows : int
    method set_col_spacing : int -> int -> unit
    method set_col_spacings : int -> unit
    method set_columns : int -> unit
    method set_homogeneous : bool -> unit
    method set_row_spacing : int -> int -> unit
    method set_row_spacings : int -> unit
    method set_rows : int -> unit
  end
val table :
  ?columns:int ->
  ?rows:int ->
  ?homogeneous:bool ->
  ?row_spacings:int ->
  ?col_spacings:int ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> table

class fixed :
  Gtk.fixed obj ->
  object
    inherit container_full
    val obj : Gtk.fixed obj
    method event : event_ops
    method move : widget -> x:int -> y:int -> unit
    method put : widget -> x:int -> y:int -> unit
    method set_has_window : bool -> unit
    method has_window : bool
  end
val fixed :
  ?has_window: bool ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> fixed

class layout :
  'a obj ->
  object
    inherit container_full
    constraint 'a = [> Gtk.layout]
    val obj : 'a obj
    method event : event_ops
    method freeze : unit -> unit
    method hadjustment : GData.adjustment
    method height : int
    method move : widget -> x:int -> y:int -> unit
    method put : widget -> x:int -> y:int -> unit
    method set_hadjustment : GData.adjustment -> unit
    method set_height : int -> unit
    method set_vadjustment : GData.adjustment -> unit
    method set_width : int -> unit
    method thaw : unit -> unit
    method vadjustment : GData.adjustment
    method width : int
  end
val layout :
  ?hadjustment:GData.adjustment ->
  ?vadjustment:GData.adjustment ->
  ?layout_width:int ->
  ?layout_height:int ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> layout

class notebook_signals : [> Gtk.notebook] obj ->
  object
    inherit container_signals
    method change_current_page : callback:(int -> unit) -> GtkSignal.id
  end

class notebook : Gtk.notebook obj ->
  object
    inherit container
    val obj : Gtk.notebook obj
    method event : event_ops
    method append_page :
      ?tab_label:widget -> ?menu_label:widget -> widget -> unit
    method connect : notebook_signals
    method current_page : int
    method get_menu_label : widget -> widget
    method get_nth_page : int -> widget
    method get_tab_label : widget -> widget
    method goto_page : int -> unit
    method insert_page :
      ?tab_label:widget -> ?menu_label:widget -> pos:int -> widget -> unit
    method next_page : unit -> unit
    method page_num : widget -> int
    method prepend_page :
      ?tab_label:widget -> ?menu_label:widget -> widget -> unit
    method previous_page : unit -> unit
    method remove_page : int -> unit
    method set_enable_popup : bool -> unit
    method set_homogeneous_tabs : bool -> unit
    method set_page :
      ?tab_label:widget -> ?menu_label:widget -> widget -> unit
    method set_scrollable : bool -> unit
    method set_show_border : bool -> unit
    method set_show_tabs : bool -> unit
    method set_tab_border : int -> unit
    method set_tab_hborder : int -> unit
    method set_tab_vborder : int -> unit
    method set_tab_pos : Tags.position -> unit
    method enable_popup : bool
    method homogeneous_tabs : bool
    method scrollable : bool
    method show_border : bool
    method show_tabs : bool
    method tab_hborder : int
    method tab_pos : GtkEnums.position_type
    method tab_vborder : int
  end
val notebook :
  ?enable_popup:bool ->
  ?homogeneous_tabs:bool ->
  ?scrollable:bool ->
  ?show_border:bool ->
  ?show_tabs:bool ->
  ?tab_border:int ->
  ?tab_pos:Tags.position ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> notebook

class paned :
  Gtk.paned obj ->
  object
    inherit container_full
    val obj : Gtk.paned obj
    method event : event_ops
    method add1 : widget -> unit
    method add2 : widget -> unit
    method pack1 : ?resize:bool -> ?shrink:bool -> widget -> unit
    method pack2 : ?resize:bool -> ?shrink:bool -> widget -> unit
    method child1 : widget
    method child2 : widget
    method set_position : int -> unit
  end
val paned :
  Tags.orientation ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> paned
