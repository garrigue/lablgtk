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

(** Base classes for objects and widgets *)

(** {3 GObject} *)

class gobject_ops : 'a obj ->
  object
    val obj : 'a obj
    method get_oid : int
    method get_type : string
    method disconnect : GtkSignal.id -> unit
    method handler_block : GtkSignal.id -> unit
    method handler_unblock : GtkSignal.id -> unit
    method set_property : 'a. string -> 'a Gobject.data_set -> unit
    method get_property : string -> Gobject.data_get
    method freeze_notify : unit -> unit
    method thaw_notify : unit -> unit
  end

class ['a] gobject_signals : 'a obj ->
  object ('b)
    val obj : 'a obj
    val after : bool
    method after : 'b
    method private connect :
      'c. ('a,'c) GtkSignal.t -> callback:'c -> GtkSignal.id
    method private notify :
      'b. ('a, 'b) Gobject.property -> callback:('b -> unit) -> GtkSignal.id
  end

(** {3 GtkObject} *)

class type ['a] objvar = object
  val obj : 'a obj
  (* needed for pre 3.10
  method private obj : 'a obj
  *)
end

class gtkobj : 'a obj ->
  object
    val obj : 'a obj
    method get_oid : int
  end

class type gtkobj_signals =
  object ('a) method after : 'a end

(** {3 GtkWidget} *)

class event_signals : [> widget] obj ->
  object ('a)
    method after : 'a
    method any :
	callback:(Gdk.Tags.event_type Gdk.event -> bool) -> GtkSignal.id
    method after_any :
	callback:(Gdk.Tags.event_type Gdk.event -> unit) -> GtkSignal.id
    method button_press : callback:(GdkEvent.Button.t -> bool) -> GtkSignal.id
    method button_release :
	callback:(GdkEvent.Button.t -> bool) -> GtkSignal.id
    method configure : callback:(GdkEvent.Configure.t -> bool) -> GtkSignal.id
    method delete : callback:([`DELETE] Gdk.event -> bool) -> GtkSignal.id
    method destroy : callback:([`DESTROY] Gdk.event -> bool) -> GtkSignal.id
    method enter_notify :
	callback:(GdkEvent.Crossing.t -> bool) -> GtkSignal.id
    method expose : callback:(GdkEvent.Expose.t -> bool) -> GtkSignal.id
    method focus_in : callback:(GdkEvent.Focus.t -> bool) -> GtkSignal.id
    method focus_out : callback:(GdkEvent.Focus.t -> bool) -> GtkSignal.id
    method key_press : callback:(GdkEvent.Key.t -> bool) -> GtkSignal.id
    method key_release : callback:(GdkEvent.Key.t -> bool) -> GtkSignal.id
    method leave_notify :
	callback:(GdkEvent.Crossing.t -> bool) -> GtkSignal.id
    method map : callback:([`MAP] Gdk.event -> bool) -> GtkSignal.id
    method motion_notify :
	callback:(GdkEvent.Motion.t -> bool) -> GtkSignal.id
    method property_notify :
	callback:(GdkEvent.Property.t -> bool) -> GtkSignal.id
    method proximity_in :
	callback:(GdkEvent.Proximity.t -> bool) -> GtkSignal.id
    method proximity_out :
	callback:(GdkEvent.Proximity.t -> bool) -> GtkSignal.id
    method scroll :
	callback:(GdkEvent.Scroll.t -> bool) -> GtkSignal.id
    method selection_clear :
	callback:(GdkEvent.Selection.t -> bool) -> GtkSignal.id
    method selection_notify :
	callback:(GdkEvent.Selection.t -> bool) -> GtkSignal.id
    method selection_request :
	callback:(GdkEvent.Selection.t -> bool) -> GtkSignal.id
    method unmap : callback:([`UNMAP] Gdk.event -> bool) -> GtkSignal.id
    method visibility_notify :
	callback:(GdkEvent.Visibility.t -> bool) -> GtkSignal.id
    method window_state :
	callback:(GdkEvent.WindowState.t -> bool) -> GtkSignal.id
  end

class event_ops : [> widget] obj ->
  object
    method add : Gdk.Tags.event_mask list -> unit
    method connect : event_signals
    method send : GdkEvent.any -> bool
  end

(** @gtkdoc gtk GtkStyle *)
class style : Gtk.style ->
  object ('a)
    val style : Gtk.style
    method as_style : Gtk.style
    method base : Gtk.Tags.state_type -> Gdk.color
    method bg : Gtk.Tags.state_type -> Gdk.color
(*
    method colormap : Gdk.colormap
*)
    method copy : 'a
    method dark : Gtk.Tags.state_type -> Gdk.color
    method fg : Gtk.Tags.state_type -> Gdk.color
(*
    method font : Gdk.font
*)
    method light : Gtk.Tags.state_type -> Gdk.color
    method mid : Gtk.Tags.state_type -> Gdk.color
    method set_bg : (Gtk.Tags.state_type * GDraw.color) list -> unit
    method set_base : (Gtk.Tags.state_type * GDraw.color) list -> unit
    method set_dark : (Gtk.Tags.state_type * GDraw.color) list -> unit
    method set_fg : (Gtk.Tags.state_type * GDraw.color) list -> unit
(*
    method set_font : Gdk.font -> unit
*)
    method set_light : (Gtk.Tags.state_type * GDraw.color) list -> unit
    method set_mid : (Gtk.Tags.state_type * GDraw.color) list -> unit
    method set_text : (Gtk.Tags.state_type * GDraw.color) list -> unit
    method text : Gtk.Tags.state_type -> Gdk.color
  end

(** @gtkdoc gtk GtkCssProvider *)

class css_provider: Gtk.css_provider ->
  object
    val prov : Gtk.css_provider
    method as_css_provider : Gtk.css_provider
    method load_from_data: string -> unit
  end

val css_provider: unit -> css_provider

(** @gtkdoc gtk GtkStyleContext *)
class style_context: Gtk.style_context ->
  object
    val ctxt : Gtk.style_context
    method add_provider: css_provider -> int -> unit
  end

(** @gtkdoc gtk gtk-Selections *)
class selection_data :
  Gtk.selection_data ->
  object
    val sel : Gtk.selection_data
    method data : string	(* May raise Gpointer.Null *)
    method format : int
    method selection : Gdk.atom
    method typ : string
    method target : string
  end

(** @gtkdoc gtk gtk-Selections *)
class selection_context :
  Gtk.selection_data ->
  object
    val sel : Gtk.selection_data
    method selection : Gdk.atom
    method target : string
    method return : ?typ:string -> ?format:int -> string -> unit
  end

(** @gtkdoc gtk gtk-Drag-and-Drop *)

class drag_ops : Gtk.widget obj ->
  object
    method connect : drag_signals
    method dest_set :
      ?flags:Tags.dest_defaults list ->
      ?actions:Gdk.Tags.drag_action list -> target_entry list -> unit
    method dest_unset : unit -> unit
    method get_data : target:string -> ?time:int32 -> drag_context ->unit
    method highlight : unit -> unit
    method source_set :
      ?modi:Gdk.Tags.modifier list ->
      ?actions:Gdk.Tags.drag_action list -> target_entry list -> unit
    method source_unset : unit -> unit
    method unhighlight : unit -> unit
  end

(** @gtkdoc gtk GtkWidget *)
and misc_ops : Gtk.widget obj ->
  object
    inherit gobject_ops
    val obj : Gtk.widget obj
    method activate : unit -> bool
    method add_accelerator : 'a.
      sgn:('a, unit -> unit) GtkSignal.t ->
      group:accel_group -> ?modi:Gdk.Tags.modifier list ->
      ?flags:Tags.accel_flag list -> Gdk.keysym -> unit
    method add_selection_target :
      target:string -> ?info:int -> Gdk.atom -> unit
    method allocation : rectangle
    method clear_selection_targets : Gdk.atom -> unit
    method connect : misc_signals
    method convert_selection : target:string -> ?time:int32 -> Gdk.atom -> bool
    method create_pango_context : GPango.context
    method draw : Gdk.cairo -> unit
    method grab_default : unit -> unit
    method grab_focus : unit -> unit
    method grab_selection : ?time:int32 -> Gdk.atom -> bool
    method has_tooltip : bool
    method hide : unit -> unit
    method intersect : Gdk.Rectangle.t -> Gdk.Rectangle.t option
    method is_ancestor : widget -> bool
    method map : unit -> unit
    (* Deprecated since 3.0 *)
    method modify_bg : (Gtk.Tags.state_type * GDraw.color) list -> unit
    method modify_base : (Gtk.Tags.state_type * GDraw.color) list -> unit
    method modify_fg : (Gtk.Tags.state_type * GDraw.color) list -> unit
    method modify_text : (Gtk.Tags.state_type * GDraw.color) list -> unit
    method modify_font : GPango.font_description -> unit
    method modify_font_by_name : string -> unit
    (* End deprecated since 3.0 *)
    method style_context: style_context
    method name : string
    method parent : widget option
    method pango_context : GPango.context
    method pointer : int * int
    method queue_draw : unit -> unit
    method queue_draw_area : int -> int -> int -> int -> unit
    method realize : unit -> unit
    method remove_accelerator :
      group:accel_group -> ?modi:Gdk.Tags.modifier list -> Gdk.keysym -> unit
    method render_icon :
       size:Gtk.Tags.icon_size -> GtkStock.id -> GdkPixbuf.pixbuf
    method reparent : widget -> unit
    method sensitive : bool
    method set_app_paintable : bool -> unit
    method set_can_default : bool -> unit
    method set_can_focus : bool -> unit
    method set_double_buffered : bool -> unit
    method set_has_tooltip : bool -> unit
    method set_name : string -> unit
    method set_sensitive : bool -> unit
    method set_size_chars :
      ?desc:GPango.font_description ->
      ?lang:string -> ?width:int -> ?height:int -> unit -> unit
    method set_style : style -> unit
    method set_size_request : ?width:int -> ?height:int -> unit -> unit
    method set_tooltip_markup : string -> unit
    method set_tooltip_text : string -> unit
    method show : unit -> unit
    method show_all : unit -> unit
    method style : style
    method tooltip_markup : string
    method tooltip_text : string
    method toplevel : widget
    method unmap : unit -> unit
    method unparent : unit -> unit
    method unrealize : unit -> unit
    method visible : bool
    method visual : Gdk.visual
    method visual_depth : int
    method window : Gdk.window
  end

(** @gtkdoc gtk GtkWidget *)
and widget : ([> Gtk.widget] as 'a) obj ->
  object
    inherit gtkobj
    val obj : 'a obj
    method app_paintable : bool
    method as_widget : Gtk.widget obj
    method can_default : bool
    method can_focus : bool
    method coerce : widget
    method composite_child : bool
    method destroy : unit -> unit
    method drag : drag_ops
    method events : GdkEnums.event_mask list
    method expand : bool
    method focus_on_click : bool
    method halign : GtkEnums.align
    method has_default : bool
    method has_focus : bool
    method has_tooltip : bool
    method height_request : int
    method hexpand : bool
    method hexpand_set : bool
    method is_focus : bool
    method margin : int
    method margin_bottom : int
    method margin_end : int
    method margin_left : int
    method margin_right : int
    method margin_start : int
    method margin_top : int
    method misc : misc_ops
    method destroy : unit -> unit
    method name : string
    method no_show_all : bool
    method opacity : float
    method parent : Gtk.container Gtk.obj option
    method receives_default : bool
    method scale_factor : int
    method sensitive : bool
    method set_app_paintable : bool -> unit
    method set_can_default : bool -> unit
    method set_can_focus : bool -> unit
    method set_events : GdkEnums.event_mask list -> unit
    method set_expand : bool -> unit
    method set_focus_on_click : bool -> unit
    method set_halign : GtkEnums.align -> unit
    method set_has_default : bool -> unit
    method set_has_focus : bool -> unit
    method set_has_tooltip : bool -> unit
    method set_height_request : int -> unit
    method set_hexpand : bool -> unit
    method set_hexpand_set : bool -> unit
    method set_is_focus : bool -> unit
    method set_margin : int -> unit
    method set_margin_bottom : int -> unit
    method set_margin_end : int -> unit
    method set_margin_left : int -> unit
    method set_margin_right : int -> unit
    method set_margin_start : int -> unit
    method set_margin_top : int -> unit
    method set_name : string -> unit
    method set_no_show_all : bool -> unit
    method set_opacity : float -> unit
    method set_parent : Gtk.container Gtk.obj option -> unit
    method set_receives_default : bool -> unit
    method set_sensitive : bool -> unit
    method set_style : Gtk.style -> unit
    method set_tooltip_markup : string -> unit
    method set_tooltip_text : string -> unit
    method set_valign : GtkEnums.align -> unit
    method set_vexpand : bool -> unit
    method set_vexpand_set : bool -> unit
    method set_visible : bool -> unit
    method set_width_request : int -> unit
    method style : Gtk.style
    method tooltip_markup : string
    method tooltip_text : string
    method valign : GtkEnums.align
    method vexpand : bool
    method vexpand_set : bool
    method visible : bool
    method width_request : int
  end

(** @gtkdoc gtk GtkWidget *)
and misc_signals : Gtk.widget obj ->
  object ('b)
    inherit gtkobj_signals
    method destroy : callback:(unit -> unit) -> GtkSignal.id
    method hide : callback:(unit -> unit) -> GtkSignal.id
    method map : callback:(unit -> unit) -> GtkSignal.id
    method parent_set : callback:(widget option -> unit) -> GtkSignal.id
    method draw : callback:(Gdk.cairo -> bool) -> GtkSignal.id
    method query_tooltip :
      callback:(x:int -> y:int -> kbd:bool -> tooltip -> bool) -> GtkSignal.id
    method realize : callback:(unit -> unit) -> GtkSignal.id
    method unrealize : callback:(unit -> unit) -> GtkSignal.id
    method selection_get :
      callback:(selection_context -> info:int -> time:int32 -> unit) ->
      GtkSignal.id
    method selection_received :
      callback:(selection_data -> time:int32 -> unit) -> GtkSignal.id
    method show : callback:(unit -> unit) -> GtkSignal.id
    method size_allocate : callback:(Gtk.rectangle -> unit) -> GtkSignal.id
    method state_changed :
      callback:(Gtk.Tags.state_type -> unit) -> GtkSignal.id
    method style_set : callback:(unit -> unit) -> GtkSignal.id
    method unmap : callback:(unit -> unit) -> GtkSignal.id
  end

(** @gtkdoc gtk gtk-Drag-and-Drop *)
and drag_context :
  Gdk.drag_context ->
  object
    val context : Gdk.drag_context
    method context : Gdk.drag_context
    method finish : success:bool -> del:bool -> time:int32 -> unit
    method source_widget : widget 
    method set_icon_widget : widget -> hot_x:int -> hot_y:int -> unit
    method status : ?time:int32 -> Gdk.Tags.drag_action option -> unit
    method suggested_action : Gdk.Tags.drag_action
    method targets : string list
  end

(** @gtkdoc gtk gtk-Drag-and-Drop *)
and drag_signals :
  Gtk.widget obj ->
  object ('a)
    method after : 'a
    method beginning :
      callback:(drag_context -> unit) -> GtkSignal.id
    method data_delete :
      callback:(drag_context -> unit) -> GtkSignal.id
    method data_get :
      callback:
      (drag_context -> selection_context -> info:int -> time:int32 -> unit) ->
      GtkSignal.id
    method data_received :
      callback:(drag_context -> x:int -> y:int ->
	        selection_data -> info:int -> time:int32 -> unit) -> GtkSignal.id
    method drop :
      callback:(drag_context -> x:int -> y:int -> time:int32 -> bool) ->
      GtkSignal.id
    method ending :
      callback:(drag_context -> unit) -> GtkSignal.id
    method leave :
      callback:(drag_context -> time:int32 -> unit) -> GtkSignal.id
    method motion :
      callback:(drag_context -> x:int -> y:int -> time:int32 -> bool) ->
      GtkSignal.id
  end

(** @gtkdoc gtk GtkWidget *)
class ['a] widget_impl : ([> Gtk.widget] as 'a) obj ->
  object
    inherit widget
    inherit ['a] objvar
  end

(** @gtkdoc gtk GtkWidget *)
class type widget_signals =
  object
    inherit gtkobj_signals
    method destroy : callback:(unit -> unit) -> GtkSignal.id
  end

(** @gtkdoc gtk GtkWidget *)
class widget_signals_impl : ([> Gtk.widget] as 'a) obj ->
  object
    inherit ['a] gobject_signals
    inherit widget_signals
  end

(** @gtkdoc gtk GtkWidget *)
class widget_full : ([> Gtk.widget] as 'a) obj ->
  object
    inherit widget
    val obj : 'a obj
    method connect : widget_signals
  end

(** @gtkdoc gtk GtkWidget *)
val as_widget : widget -> Gtk.widget obj

val pack_return :
    (#widget as 'a) ->
    packing:(widget -> unit) option -> show:bool option -> 'a
    (* To use in initializers to provide a ?packing: option *)

val conv_widget : widget Gobject.data_conv
val conv_widget_option : widget option Gobject.data_conv
