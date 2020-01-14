(**************************************************************************)
(*                Lablgtk                                                 *)
(*                                                                        *)
(*    This program is free software; you can redistribute it              *)
(*    and/or modify it under the terms of the GNU Library General         *)
(*    Public License as published by the Free Software Foundation         *)
(*    version 2, with the exception described in file COPYING which       *)
(*    comes with the library.                                             *)
(*                                                                        *)
(*    This program is distributed in the hope that it will be useful,     *)
(*    but WITHOUT ANY WARRANTY; without even the implied warranty of      *)
(*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the       *)
(*    GNU Library General Public License for more details.                *)
(*                                                                        *)
(*    You should have received a copy of the GNU Library General          *)
(*    Public License along with this program; if not, write to the        *)
(*    Free Software Foundation, Inc., 59 Temple Place, Suite 330,         *)
(*    Boston, MA 02111-1307  USA                                          *)
(*                                                                        *)
(*                                                                        *)
(**************************************************************************)

(* $Id$ *)

open Gtk
open GObj
open GContainer

(** Several container widgets *)

(** {3 Boxes} *)

(** @gtkdoc gtk GtkBox *)
class box_skel : ([> box] as 'a) obj ->
  object
    inherit GContainer.container
    val obj : 'a obj
    method pack :
      ?from:Tags.pack_type ->
      ?expand:bool -> ?fill:bool -> ?padding:int -> widget -> unit
   (** @param from default value is [`START]
       @param expand default value is [false]
       @param fill default value is [true], ignored if [expand] is [false] *)
    method reorder_child : widget -> pos:int -> unit
    method set_child_packing :
      ?from:Tags.pack_type ->
      ?expand:bool -> ?fill:bool -> ?padding:int -> widget -> unit
    method set_homogeneous : bool -> unit
    method homogeneous : bool
    method set_orientation : Gtk.Tags.orientation -> unit
    method orientation : Gtk.Tags.orientation
    method set_spacing : int -> unit
    method spacing : int
  end

(** A base class for box containers
   @gtkdoc gtk GtkBox *)
class size_group : ([> `sizegroup ] as 'a) Gtk.obj ->
  object
    val obj : 'a obj
    method get_oid : int
    method add_widget : #widget -> unit
    method remove_widget : #widget -> unit
  end


(** A base class for box containers
   @gtkdoc gtk GtkBox *)
class box : ([> Gtk.box] as 'a) obj ->
  object
    inherit box_skel
    val obj : 'a obj
    method connect : GContainer.container_signals
  end

(** @gtkdoc gtk GtkBox 
    @param homogeneous default value is [false] *)
val box :
  Tags.orientation ->
  ?homogeneous:bool ->
  ?spacing:int ->
  ?border_width:int ->
  ?width:int ->
  ?height:int -> ?packing:(widget -> unit) -> ?show:bool -> unit -> box

(** @gtkdoc gtk GtkVBox
    @param homogeneous default value is [false] *)
val vbox :
  ?homogeneous:bool ->
  ?spacing:int ->
  ?border_width:int ->
  ?width:int ->
  ?height:int -> ?packing:(widget -> unit) -> ?show:bool -> unit -> box

(** @gtkdoc gtk GtkHVBox
    @param homogeneous default value is [false] *)
val hbox :
  ?homogeneous:bool ->
  ?spacing:int ->
  ?border_width:int ->
  ?width:int ->
  ?height:int -> ?packing:(widget -> unit) -> ?show:bool -> unit -> box

(** @gtkdoc gtk GtkButtonBox *)
class button_box : ([> Gtk.button_box] as 'a) obj ->
  object
    inherit box
    val obj : 'a obj
    method set_layout : Gtk.Tags.button_box_style -> unit
    method layout : Gtk.Tags.button_box_style
    method get_child_secondary : widget -> bool (** @since GTK 2.4 *)
    method set_child_secondary : widget -> bool -> unit (** @since GTK 2.4 *)
  end

(** @gtkdoc gtk GtkButtonBox *)
val button_box :
  Tags.orientation ->
  ?spacing:int ->
  ?layout:Gtk.Tags.button_box_style ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> button_box

(** {3 GtkTable} *)

(** Pack widgets in regular patterns
   @gtkdoc gtk GtkTable *)
class table :
  Gtk.table obj ->
  object
    inherit GContainer.container_full
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
    (** @param left column number to attach the left side of the widget to
        @param top  row number to attach the top of the widget to
        @param right default value is [left+1]
        @param bottom default value is [top+1]
        @param expand default value is [`NONE]
        @param fill default value is [`BOTH]
        @param shrink default value is [`NONE] *)
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

(** @gtkdoc gtk GtkTable *)
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

(** {3 GtkGrid} *)

(** Pack widgets in regular patterns
   @gtkdoc gtk GtkGrid *)
class grid :
  Gtk.grid obj ->
  object
    inherit GContainer.container_full
    val obj : Gtk.grid obj
    method attach :
      left:int ->
      top:int ->
      ?width:int ->
      ?height:int ->
      GObj.widget -> unit
    (** @param left column number to attach the left side of the widget to
        @param top  row number to attach the top of the widget to
        @param width default value is [1]
        @param height default value is [1] *)
    method set_baseline_row : int -> unit
    method set_col_homogeneous : bool -> unit
    method set_col_spacings : int -> unit
    method set_row_homogeneous : bool -> unit
    method set_row_spacings : int -> unit
    method baseline_row : int
    method col_homogeneous : bool
    method col_spacings : int
    method row_homogeneous : bool
    method row_spacings : int
end

(** @gtkdoc gtk GtkGrid *)
val grid :
  ?baseline_row:int ->
  ?row_homogeneous:bool ->
  ?col_homogeneous:bool ->
  ?row_spacings:int ->
  ?col_spacings:int ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> grid

(** {3 GtkFixed} *)

(** A container which allows you to position widgets at fixed coordinates
   @gtkdoc gtk GtkFixed *)
class fixed :
  Gtk.fixed obj ->
  object
    inherit GContainer.container_full
    val obj : Gtk.fixed obj
    method event : event_ops
    method move : widget -> x:int -> y:int -> unit
    method put : widget -> x:int -> y:int -> unit
  end

(** @gtkdoc gtk GtkFixed *)
val fixed :
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> fixed

(** {3 GtkLayout} *)

(** Infinite scrollable area containing child widgets and/or custom drawing
   @gtkdoc gtk GtkLayout *)
class layout :
  'a obj ->
  object
    inherit GContainer.container_full
    constraint 'a = [> Gtk.layout]
    val obj : 'a obj
    method event : event_ops
    method bin_window : Gdk.window
    method hadjustment : GData.adjustment
    method height : int
    method move : widget -> x:int -> y:int -> unit
    method put : widget -> x:int -> y:int -> unit
    method set_hadjustment : GData.adjustment -> unit
    method set_height : int -> unit
    method set_vadjustment : GData.adjustment -> unit
    method set_width : int -> unit
    method vadjustment : GData.adjustment
    method width : int
  end

(** @gtkdoc gtk GtkLayout *)
val layout :
  ?hadjustment:GData.adjustment ->
  ?vadjustment:GData.adjustment ->
  ?layout_width:int ->
  ?layout_height:int ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> layout

(** {3 GtkNotebook} *)

(** @gtkdoc gtk GtkNotebook *)
class notebook_signals : [> Gtk.notebook] obj ->
  object
    inherit GContainer.container_signals
    method change_current_page : callback:(int -> unit) -> GtkSignal.id
    method create_window : callback:(page:GObj.widget -> x:int -> y:int -> unit) -> GtkSignal.id
    method move_focus_out : callback:(GtkEnums.direction_type -> unit) -> GtkSignal.id
    method notify_enable_popup : callback:(bool -> unit) -> GtkSignal.id
    method notify_scrollable : callback:(bool -> unit) -> GtkSignal.id
    method notify_show_border : callback:(bool -> unit) -> GtkSignal.id
    method notify_show_tabs : callback:(bool -> unit) -> GtkSignal.id
    method notify_tab_pos : callback:(GtkEnums.position_type -> unit) -> GtkSignal.id
    method notify_group_name : callback:(string -> unit) -> GtkSignal.id
    method page_added : callback:(GObj.widget -> int -> unit) -> GtkSignal.id
    method page_removed : callback:(GObj.widget -> int -> unit) -> GtkSignal.id
    method page_reordered : callback:(GObj.widget -> int -> unit) -> GtkSignal.id
    method reorder_tab : callback:(GtkEnums.direction_type -> bool -> unit) -> GtkSignal.id
    method select_page : callback:(bool -> unit) -> GtkSignal.id
    method switch_page : callback:(int -> unit) -> GtkSignal.id
  end

(** A tabbed notebook container
   @gtkdoc gtk GtkNotebook *)
class notebook : Gtk.notebook obj ->
  object
    inherit GContainer.container
    val obj : Gtk.notebook obj
    method as_notebook : Gtk.notebook Gtk.obj
    method event : event_ops
    method append_page :
      ?tab_label:widget -> ?menu_label:widget -> widget -> int
    method connect : notebook_signals
    method current_page : int
    method get_menu_label : widget -> widget
    method get_nth_page : int -> widget
    method get_tab_label : widget -> widget
    method get_tab_reorderable : widget -> bool
    method goto_page : int -> unit
    method insert_page :
      ?tab_label:widget -> ?menu_label:widget -> ?pos:int -> widget -> int
    method next_page : unit -> unit
    method page_num : widget -> int
    method prepend_page :
      ?tab_label:widget -> ?menu_label:widget -> widget -> int
    method previous_page : unit -> unit
    method remove_page : int -> unit
    method reorder_child : widget -> int -> unit
    method set_enable_popup : bool -> unit
    method set_group_name : string -> unit
    method set_page :
      ?tab_label:widget -> ?menu_label:widget -> widget -> unit
    method set_scrollable : bool -> unit
    method set_show_border : bool -> unit
    method set_show_tabs : bool -> unit
    method set_tab_reorderable : widget -> bool -> unit
    method set_tab_pos : Tags.position_type -> unit
    method group_name : string
    method enable_popup : bool
    method scrollable : bool
    method show_border : bool
    method show_tabs : bool
    method tab_pos : Tags.position_type
  end

(** @gtkdoc gtk GtkNotebook *)
val notebook :
  ?enable_popup:bool ->
  ?group_name:string ->
  ?scrollable:bool ->
  ?show_border:bool ->
  ?show_tabs:bool ->
  ?tab_pos:Tags.position_type ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> notebook

(** {3 GtkPaned} *)

(** Base class for widgets with two adjustable panes
   @gtkdoc gtk GtkPaned *)
class paned :
  Gtk.paned obj ->
  object
    inherit GContainer.container_full
    val obj : Gtk.paned obj
    method event : event_ops
    method add1 : widget -> unit
    method add2 : widget -> unit
    method pack1 : ?resize:bool -> ?shrink:bool -> widget -> unit
    (** @param resize default value is [false]
        @param shrink default value is [false] *)
    method pack2 : ?resize:bool -> ?shrink:bool -> widget -> unit
    (** @param resize default value is [false]
        @param shrink default value is [false] *)
    method child1 : widget
    method child2 : widget
    method set_orientation : Gtk.Tags.orientation -> unit
    method orientation : Gtk.Tags.orientation
    method set_position : int -> unit
    method position : int
    method max_position : int (** @since GTK 2.4 *)
    method min_position : int (** @since GTK 2.4 *)
  end

(** @gtkdoc gtk GtkPaned *)
val paned :
  Tags.orientation ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> paned
