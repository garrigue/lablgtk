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

open Gaux
open Gobject
open Gtk
open GtkBase
open GtkMisc
open OgtkMiscProps
open GObj

let separator dir ?packing ?show () =
  let w = Separator.create dir [] in
  pack_return (new widget_full w) ~packing ~show

class statusbar_context obj ctx = object (self)
  val obj : statusbar obj = obj
  val context : Gtk.statusbar_context = ctx
  method context = context
  method push text = Statusbar.push obj context ~text
  method pop () = Statusbar.pop obj context
  method remove = Statusbar.remove obj context
  method flash ?(delay=1000) text =
    let msg = self#push text in
    Glib.Timeout.add delay (fun () -> self#remove msg; false);
    ()
end

class statusbar obj = object
  inherit GPack.box (obj : Gtk.statusbar obj)
  method new_context ~name =
    new statusbar_context obj (Statusbar.get_context_id obj name)
end

let statusbar =
  GContainer.pack_container [] ~create:
    (fun p -> new statusbar (Statusbar.create p))

class status_icon_signals (obj : Gtk.status_icon Gobject.obj) = object
(*    inherit [Gtk.status_icon] gobject_signals obj*)
    inherit gtk_status_icon_sigs
    method private connect sgn ~callback =
      GtkSignal.connect ~sgn ~callback ~after: true obj
    method private notify prop ~callback =
      GtkSignal.connect_property obj ~prop ~callback
end

class status_icon obj = object
  val obj : Gtk.status_icon Gobject.obj = obj
  inherit gtk_status_icon_props
  method connect = new status_icon_signals obj
  method set_from_pixbuf = StatusIcon.set_from_pixbuf obj
  method set_from_file = StatusIcon.set_from_file obj
  method set_from_stock = StatusIcon.set_from_stock obj
  method set_from_icon_name = StatusIcon.set_from_icon_name obj
  method get_pixbuf = StatusIcon.get_pixbuf obj
  method get_stock = StatusIcon.get_stock obj
  method get_icon_name = StatusIcon.get_icon_name obj
  method get_size = StatusIcon.get_size obj
  method is_embedded= StatusIcon.is_embedded obj
end

let status_icon =
  StatusIcon.make_params [] ~cont:
    (fun p () -> new status_icon (StatusIcon.create p))

let status_icon_from_pixbuf =
  StatusIcon.make_params [] ~cont:
    (fun p pb ->
       let o = new status_icon (StatusIcon.create p) in
       o#set_from_pixbuf pb;
       o
    )
let status_icon_from_file =
  StatusIcon.make_params [] ~cont:
    (fun p file ->
       let o = new status_icon (StatusIcon.create p) in
       o#set_from_file file;
       o
    )
let status_icon_from_stock =
  StatusIcon.make_params [] ~cont:
    (fun p s ->
       let o = new status_icon (StatusIcon.create p) in
       o#set_from_stock s;
       o
    )
let status_icon_from_icon_name =
  StatusIcon.make_params [] ~cont:
    (fun p s ->
       let o = new status_icon (StatusIcon.create p) in
       o#set_from_icon_name s;
       o
    )


class calendar_signals obj = object
  inherit widget_signals_impl obj
  inherit calendar_sigs
end

class calendar obj = object
  inherit ['a] widget_impl (obj : Gtk.calendar obj)
  inherit calendar_props
  method event = new GObj.event_ops obj
  method connect = new calendar_signals obj
  method select_month = Calendar.select_month obj
  method select_day = Calendar.select_day obj
  method mark_day = Calendar.mark_day obj
  method unmark_day = Calendar.unmark_day obj
  method clear_marks = Calendar.clear_marks obj
  method date = Calendar.get_date obj
  method set_display_options = Calendar.set_display_options obj
 end

let calendar ?options ?packing ?show () =
  let w = Calendar.create [] in
  may options ~f:(Calendar.set_display_options w);
  pack_return (new calendar w) ~packing ~show

class drawing_area obj = object
  inherit widget_full (obj : [> Gtk.drawing_area] obj)
  method event = new GObj.event_ops obj
end

let drawing_area ?packing ?show () =
  let w = DrawingArea.create [] in
  pack_return (new drawing_area w) ~packing ~show

class misc obj = object
  inherit ['a] widget_impl obj
  inherit misc_props
end

class arrow obj = object
  inherit misc obj
  inherit arrow_props
end

let arrow =
  Arrow.make_params [] ~cont:(
  Misc.all_params ~cont:(fun p ?packing ?show () ->
    pack_return (new arrow (Arrow.create p)) ~packing ~show))

class image obj = object (self)
  inherit misc obj
  inherit image_props
  method clear () = Image.clear obj
end

type image_type =
  [ `EMPTY | `PIXBUF | `STOCK | `ICON_SET | `ANIMATION | `ICON_NAME | `GICON
  | `SURFACE ]

let image =
  Image.make_params [] ~cont:(
  Misc.all_params ~cont:(fun p ?packing ?show () ->
    pack_return (new image (Image.create p)) ~packing ~show))

class label_skel obj = object(self)
  inherit misc obj
  inherit label_props
  method text = GtkMiscProps.Label.get_text obj
  method set_text = GtkMiscProps.Label.set_text obj
  method get_layout = GtkMiscProps.Label.get_layout obj
  method selection_bounds = GtkMiscProps.Label.get_selection_bounds obj
  method select_region = GtkMiscProps.Label.select_region obj
end

class label obj = object
  inherit label_skel (obj : Gtk.label obj)
  method connect = new widget_signals_impl obj
end

let label ?text ?markup ?use_underline ?mnemonic_widget =
  let label, use_markup =
    if markup = None then text, None else markup, Some true in
  let mnemonic_widget = may_map (fun w -> w#as_widget) mnemonic_widget in
  Label.make_params [] ?label ?use_markup ?use_underline ?mnemonic_widget
    ~cont:(
  Misc.all_params ~cont:(fun p ?packing ?show () ->
    pack_return (new label (Label.create p)) ~packing ~show))

let label_cast w = new label (Label.cast w#as_widget)

class color_selection obj = object
  inherit [Gtk.color_selection] GObj.widget_impl obj
  method connect = new GObj.widget_signals_impl obj
  method set_border_width = set Container.P.border_width obj
  inherit color_selection_props
end

let color_selection =
  ColorSelection.make_params [] ~cont:(
  GContainer.pack_container ~create:
    (fun p -> new color_selection (ColorSelection.create p)))

class font_selection obj = object
  inherit [Gtk.font_selection] widget_impl obj
  inherit font_selection_props
  method event = new event_ops obj
  method connect = new GObj.widget_signals_impl obj
  method set_border_width = set Container.P.border_width obj
end

let font_selection =
  FontSelection.make_params [] ~cont:(
  GContainer.pack_container ~create:
    (fun p -> new font_selection (FontSelection.create p)))
