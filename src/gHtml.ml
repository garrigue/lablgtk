(* $Id$ *)

open Gaux
open Gtk
open GtkBase
open GObj
open GtkXmHTML

class xmhtml obj = object (self)
  inherit widget_full (obj : GtkXmHTML.xmhtml obj)
  method event = new GObj.event_ops obj
  method freeze = freeze obj
  method thaw = thaw obj
  method source = source obj
  method set_fonts = set_font_familty obj
  method set_fonts_fixed = set_font_familty_fixed obj
  method set_anchor_buttons = set_anchor_buttons obj
  method set_anchor_cursor = set_anchor_cursor obj
  method set_anchor_underline = set_anchor_underline_type obj
  method set_anchor_visited_underline = set_anchor_visited_underline_type obj
  method set_anchor_target_underline = set_anchor_target_underline_type obj
  method set_topline = set_topline obj
  method topline = get_topline obj
  method set_strict_checking = set_strict_checking obj
  method set_bad_html_warnings = set_bad_html_warnings obj
  method set_imagemap_draw = set_imagemap_draw obj
end

let xmhtml ?source ?border_width ?width ?height ?packing ?show () =
  let w = create () in
  Container.set w ?border_width ?width ?height;
  may source ~f:(GtkXmHTML.source w);
  pack_return (new xmhtml w) ~packing ~show
