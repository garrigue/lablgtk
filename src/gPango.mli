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

val to_pixels : Pango.units -> int
val from_pixels : int -> Pango.units

class metrics :
  Pango.font_metrics ->
  object
    method approx_char_width : Pango.units
    method approx_digit_width : Pango.units
    method ascent : Pango.units
    method descent : Pango.units
  end

class font_description :
  Pango.font_description ->
  object
    method copy : font_description
    method family : string
    method fd : Pango.font_description
    method modify :
      ?family:string ->
      ?style:Pango.Tags.style ->
      ?variant:Pango.Tags.variant ->
      ?weight:Pango.Tags.weight ->
      ?stretch:Pango.Tags.stretch -> ?size:int -> unit -> unit
    method size : int
    method stretch : Pango.Tags.stretch
    method style : Pango.Tags.style
    method to_string : string
    method variant : Pango.Tags.variant
    method weight : int
  end

val font_description_from_string : string -> font_description

class layout :
  Pango.layout ->
  object
    val obj : Pango.layout
    method as_layout : Pango.layout
    method context_changed : unit
    method copy : layout
    method get_context : context
    method get_ellipsize : Pango.Tags.ellipsize_mode
    method get_extent : Pango.rectangle
    method get_font_description : font_description
    method get_indent : int
    method get_justify : bool
    method get_pixel_extent : Pango.rectangle
    method get_pixel_size : int * int
    method get_single_paragraph_mode : bool
    method get_size : Pango.units * Pango.units
    method get_spacing : int
    method get_text : string
    method get_width : int
    method get_wrap : Pango.Tags.wrap_mode
    method index_to_pos : int -> Pango.rectangle
    method set_ellipsize : Pango.Tags.ellipsize_mode -> unit
    method set_font_description : font_description -> unit
    method set_indent : int -> unit
    method set_justify : bool -> unit
    method set_markup : string -> unit
    method set_markup_with_accel : string -> Glib.unichar -> unit
    method set_single_paragraph_mode : bool -> unit
    method set_spacing : int -> unit
    method set_text : string -> unit
    method set_width : int -> unit
    method set_wrap : Pango.Tags.wrap_mode -> unit
    method xy_to_index : x:int -> y:int -> int * int * bool
  end

and context :
  Pango.context ->
  object
    val obj : Pango.context
    method as_context : Pango.context
    method create_layout : layout
    method font_description : font_description
    method font_name : string
    method get_metrics :
      ?desc:font_description -> ?lang:string -> unit -> metrics
    method language : string
    method load_font : string -> Pango.font
    method load_fontset :
      ?desc:font_description -> ?lang:string -> unit -> Pango.font
    method set_font_by_name : string -> unit
    method set_font_description : font_description -> unit
    method set_language : string -> unit
  end
