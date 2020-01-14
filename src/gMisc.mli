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

(** Miscellaneous widgets *)

(** @gtkdoc gtk GtkSeparator
    @gtkdoc gtk GtkHSeparator
    @gtkdoc gtk GtkVSeparator *)
val separator :
  Tags.orientation ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> widget_full

(** {3 Statusbar} *)

class statusbar_context :
  Gtk.statusbar obj -> Gtk.statusbar_context ->
  object
    val context : Gtk.statusbar_context
    val obj : Gtk.statusbar obj
    method context : Gtk.statusbar_context
    method flash : ?delay:int -> string -> unit
    (** @param delay default value is [1000] ms *)
    method pop : unit -> unit
    method push : string -> statusbar_message
    method remove : statusbar_message -> unit
  end

(** Report messages of minor importance to the user
    @gtkdoc gtk GtkStatusbar *)
class statusbar : Gtk.statusbar obj ->
  object
    inherit GPack.box
    val obj : Gtk.statusbar obj
    method new_context : name:string -> statusbar_context
  end

(** @gtkdoc gtk GtkStatusbar *)
val statusbar :
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> statusbar

(** {3 Status icon} *)

(** @gtkdoc gtk GtkStatusIcon *)
class status_icon_signals : Gtk.status_icon Gobject.obj ->
  object
    method activate : callback:(unit -> unit) -> GtkSignal.id
    method popup_menu : callback:(int -> int -> unit) -> GtkSignal.id
    method size_changed : callback:(int -> unit) -> GtkSignal.id
    method notify_screen : callback:(Gdk.screen -> unit) -> GtkSignal.id
    method notify_visible : callback:(bool -> unit) -> GtkSignal.id
    method notify_tooltip_markup : callback:(string -> unit) -> GtkSignal.id
    method notify_tooltip_text : callback:(string -> unit) -> GtkSignal.id
  end

(** Display an icon in the system tray.
  @gtkdoc gtk GtkStatusIcon *)
class status_icon : Gtk.gtk_status_icon ->
  object
    val obj : Gtk.status_icon Gobject.obj
    method connect : status_icon_signals
    method get_icon_name : string
    method get_pixbuf : GdkPixbuf.pixbuf
    method screen : Gdk.screen
    method get_size : int
    method get_stock : string
    method visible : bool
    method is_embedded : bool
    method set_from_file : string -> unit
    method set_from_icon_name : string -> unit
    method set_from_pixbuf : GdkPixbuf.pixbuf -> unit
    method set_from_stock : string -> unit
    method set_screen : Gdk.screen -> unit
    method set_tooltip_markup : string -> unit
    method set_tooltip_text : string -> unit
    method set_visible : bool -> unit
    method tooltip_markup : string
    method tooltip_text : string
  end

val status_icon :
  ?screen:Gdk.screen -> ?visible:bool ->
  ?tooltip_markup:string -> ?tooltip_text:string -> unit -> status_icon
val status_icon_from_pixbuf :
  ?screen:Gdk.screen -> ?visible:bool -> ?tooltip_markup:string ->
  ?tooltip_text:string -> GdkPixbuf.pixbuf -> status_icon
val status_icon_from_file :
  ?screen:Gdk.screen -> ?visible:bool ->
  ?tooltip_markup:string -> ?tooltip_text:string -> string -> status_icon
val status_icon_from_stock :
  ?screen:Gdk.screen -> ?visible:bool ->
  ?tooltip_markup:string -> ?tooltip_text:string -> string -> status_icon
val status_icon_from_icon_name :
  ?screen:Gdk.screen -> ?visible:bool ->
  ?tooltip_markup:string -> ?tooltip_text:string -> string -> status_icon


(** {3 Calendar} *)

(** @gtkdoc gtk GtkCalendar *)
class calendar_signals : 'a obj ->
  object
    inherit GObj.widget_signals
    constraint 'a = [> calendar]
    val obj : 'a obj
    method day_selected : callback:(unit -> unit) -> GtkSignal.id
    method day_selected_double_click :
      callback:(unit -> unit) -> GtkSignal.id
    method month_changed : callback:(unit -> unit) -> GtkSignal.id
    method next_month : callback:(unit -> unit) -> GtkSignal.id
    method next_year : callback:(unit -> unit) -> GtkSignal.id
    method prev_month : callback:(unit -> unit) -> GtkSignal.id
    method prev_year : callback:(unit -> unit) -> GtkSignal.id
    method notify_day : callback:(int -> unit) -> GtkSignal.id
    method notify_month : callback:(int -> unit) -> GtkSignal.id
    method notify_year : callback:(int -> unit) -> GtkSignal.id
  end

(** Display a calendar and/or allow the user to select a date
    @gtkdoc gtk GtkCalendar *)
class calendar : Gtk.calendar obj ->
  object
    inherit GObj.widget
    val obj : Gtk.calendar obj
    method day : int
    method month : int
    method year : int
    method set_day : int -> unit
    method set_month : int -> unit
    method set_year : int -> unit
    method event : event_ops
    method clear_marks : unit
    method connect : calendar_signals
    method date : int * int * int
    method mark_day : int -> unit
    method select_day : int -> unit
    method select_month : month:int -> year:int -> unit
    method unmark_day : int -> unit
    method set_display_options : Tags.calendar_display_options list -> unit
  end

(** @gtkdoc gtk GtkCalendar *)
val calendar :
  ?options:Tags.calendar_display_options list ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> calendar

(** {3 Drawing Area} *)

(** A widget for custom user interface elements
    @gtkdoc gtk GtkDrawingArea *)
class drawing_area : ([> Gtk.drawing_area] as 'a) obj ->
  object
    inherit GObj.widget_full
    val obj : 'a obj
    method event : event_ops
  end

(** @gtkdoc gtk GtkDrawingArea *)
val drawing_area :
  ?packing:(widget -> unit) -> ?show:bool -> unit -> drawing_area

(** {3 Misc. Widgets} *)

(** A base class for widgets with alignments and padding
    @gtkdoc gtk GtkMisc *)
class misc : ([> Gtk.misc] as 'a) obj ->
  object
    inherit GObj.widget
    val obj : 'a obj
    method set_xalign : float -> unit
    method set_yalign : float -> unit
    method set_xpad : int -> unit
    method set_ypad : int -> unit
    method xalign : float
    method yalign : float
    method xpad : int
    method ypad : int
  end

(** Produces an arrow pointing in one of the four cardinal directions
    @gtkdoc gtk GtkArrow *)
class arrow : ([> Gtk.arrow] as 'a) obj ->
  object
    inherit misc
    val obj : 'a obj
    method set_kind : Tags.arrow_type -> unit
    method set_shadow : Tags.shadow_type -> unit
    method kind : Tags.arrow_type
    method shadow : Tags.shadow_type
  end

(** @gtkdoc gtk GtkArrow
    @param kind default value is [`RIGHT]
    @param shadow default value is [`OUT] *)
val arrow :
  ?kind:Tags.arrow_type ->
  ?shadow:Tags.shadow_type ->
  ?xalign:float ->
  ?yalign:float ->
  ?xpad:int ->
  ?ypad:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> arrow

type image_type =
  [ `EMPTY | `PIXBUF | `STOCK | `ICON_SET | `ANIMATION | `ICON_NAME | `GICON
  | `SURFACE ]

(** A widget displaying an image
    @gtkdoc gtk GtkImage *)
class image : 'a obj ->
  object
    inherit misc
    constraint 'a = [> Gtk.image]
    val obj : 'a obj
    method clear : unit -> unit (** since Gtk 2.8 *)
    method storage_type : image_type
    method set_file : string -> unit
    method set_pixbuf : GdkPixbuf.pixbuf -> unit
    method set_stock : GtkStock.id -> unit
    method set_icon_name : string -> unit
    method set_icon_set : icon_set -> unit
    method set_icon_size : Tags.icon_size -> unit
    method set_pixel_size : int -> unit
    method set_resource : string -> unit
    method set_use_fallback : bool -> unit
    method pixbuf : GdkPixbuf.pixbuf
    method pixel_size : int
    method stock : GtkStock.id
    method icon_name : string
    method icon_set : icon_set
    method icon_size : Tags.icon_size
    method resource : string
    method use_fallback : bool
  end

(** @gtkdoc gtk GtkImage *)
val image :
  ?file:string ->
  ?icon_name:string ->
  ?icon_set:icon_set ->
  ?icon_size:Tags.icon_size ->
  ?pixbuf:GdkPixbuf.pixbuf ->
  ?pixel_size:int ->
  ?resource:string ->
  ?stock:GtkStock.id ->
  ?use_fallback:bool ->
  ?xalign:float ->
  ?yalign:float ->
  ?xpad:int ->
  ?ypad:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> image

(** {4 Labels} *)

(** @gtkdoc gtk GtkLabel *)
class label_skel : 'a obj ->
  object
    inherit misc
    constraint 'a = [> Gtk.label]
    val obj : 'a obj
    method cursor_position : int
    method selection_bound : int
    method selection_bounds : (int * int) option
    method select_region : int -> int -> unit
    method set_justify : Tags.justification -> unit
    method set_label : string -> unit
    method set_line_wrap : bool -> unit
    method set_mnemonic_widget : widget option -> unit
    method set_pattern : string -> unit
    method set_selectable : bool -> unit
    method set_text : string -> unit
    method set_use_markup : bool -> unit
    method set_use_underline : bool -> unit
    method justify : Tags.justification
    method label : string
    method line_wrap : bool
    method mnemonic_keyval : int
    method mnemonic_widget : widget option
    method selectable : bool
    method text : string
    method use_markup : bool
    method use_underline : bool

    method angle : float (** @since GTK 2.6 *)
    method set_angle : float -> unit (** @since GTK 2.6 *)
    method max_width_chars : int (** @since GTK 2.6 *)
    method set_max_width_chars : int -> unit (** @since GTK 2.6 *)
    method single_line_mode : bool (** @since GTK 2.6 *)
    method set_single_line_mode : bool -> unit (** @since GTK 2.6 *)
    method width_chars : int (** @since GTK 2.6 *)
    method set_width_chars : int -> unit (** @since GTK 2.6 *)
    method ellipsize : PangoEnums.ellipsize_mode (** @since GTK 2.6 *)
    method set_ellipsize : PangoEnums.ellipsize_mode -> unit (** @since GTK 2.6 *)
    method get_layout : Pango.layout
  end

(** A widget that displays a small to medium amount of text
   @gtkdoc gtk GtkLabel *)
class label : Gtk.label obj ->
  object
    inherit label_skel
    val obj : Gtk.label obj
    method connect : widget_signals
  end

(** @gtkdoc gtk GtkLabel
    @param markup overrides [text] if both are present
    @param use_underline default value is [false]
    @param justify default value is [`LEFT]
    @param selectable default value is [false]
    @param line_wrap default values is [false] *)
val label :
  ?text:string ->
  ?markup:string ->     (* overrides ~text if present *)
  ?use_underline:bool ->
  ?mnemonic_widget:#widget ->
  ?justify:Tags.justification ->
  ?line_wrap:bool ->
  ?pattern:string ->
  ?selectable:bool ->
  ?ellipsize:PangoEnums.ellipsize_mode ->
  ?xalign:float ->
  ?yalign:float ->
  ?xpad:int ->
  ?ypad:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> label
val label_cast : < as_widget : 'a obj ; .. > -> label

(** {3 Color and font selection} *)

(** Deprecated since 3.0 *)

(** A widget used to select a color
    @gtkdoc gtk GtkColorSelection *)
class color_selection : Gtk.color_selection obj ->
  object
    inherit GObj.widget_full
    val obj : Gtk.color_selection obj
    method alpha : int
    method color : Gdk.color
    method set_alpha : int -> unit
    method set_border_width : int -> unit
    method set_color : Gdk.color -> unit
    method set_has_opacity_control : bool -> unit
    method set_has_palette : bool -> unit
    method has_opacity_control : bool
    method has_palette : bool
  end

(** @gtkdoc gtk GtkColorSelection *)
val color_selection :
  ?alpha:int ->
  ?color:Gdk.color ->
  ?has_opacity_control:bool ->
  ?has_palette:bool ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> color_selection

(** A widget for selecting fonts.
    @gtkdoc gtk GtkFontSelection *)
class font_selection : Gtk.font_selection obj ->
  object
    inherit GObj.widget_full
    val obj : Gtk.font_selection obj
    method event : event_ops
    method font_name : string
    method preview_text : string
    method set_border_width : int -> unit
    method set_font_name : string -> unit
    method set_preview_text : string -> unit
  end

(** @gtkdoc gtk GtkFontSelection *)
val font_selection :
  ?font_name:string ->
  ?preview_text:string ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> font_selection
