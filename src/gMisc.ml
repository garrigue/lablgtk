(* $Id$ *)

open Gaux
open Gtk
open GtkBase
open GtkMisc
open GObj

let separator dir ?(width = -2) ?(height = -2) ?packing ?show () =
  let w = Separator.create dir in
  if width <> -2 || height <> -2 then Widget.set_usize w ~width ~height;
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
    GtkMain.Timeout.add ~ms:delay ~callback:(fun () -> self#remove msg; false);
    ()
end

class statusbar obj = object
  inherit GContainer.container_full (obj : Gtk.statusbar obj)
  method new_context ~name =
    new statusbar_context obj (Statusbar.get_context obj name)
end

let statusbar ?border_width ?width ?height ?packing ?show () =
  let w = Statusbar.create () in
  Container.set w ?border_width ?width ?height;
  pack_return (new statusbar w) ~packing ~show

class calendar_signals obj = object
  inherit widget_signals obj
  method month_changed =
    GtkSignal.connect obj ~sgn:Calendar.Signals.month_changed ~after
  method day_selected =
    GtkSignal.connect obj ~sgn:Calendar.Signals.day_selected ~after
  method day_selected_double_click =
    GtkSignal.connect obj
      ~sgn:Calendar.Signals.day_selected_double_click ~after
  method prev_month =
    GtkSignal.connect obj ~sgn:Calendar.Signals.prev_month ~after
  method next_month =
    GtkSignal.connect obj ~sgn:Calendar.Signals.next_month ~after
  method prev_year =
    GtkSignal.connect obj ~sgn:Calendar.Signals.prev_year ~after
  method next_year =
    GtkSignal.connect obj ~sgn:Calendar.Signals.next_year ~after
end

class calendar obj = object
  inherit widget (obj : Gtk.calendar obj)
  method event = new GObj.event_ops obj
  method connect = new calendar_signals obj
  method select_month = Calendar.select_month obj
  method select_day = Calendar.select_day obj
  method mark_day = Calendar.mark_day obj
  method unmark_day = Calendar.unmark_day obj
  method clear_marks = Calendar.clear_marks obj
  method display_options = Calendar.display_options obj
  method date = Calendar.get_date obj
  method freeze () = Calendar.freeze obj
  method thaw () = Calendar.thaw obj
end

let calendar ?options ?(width = -2) ?(height = -2) ?packing ?show () =
  let w = Calendar.create () in
  if width <> -2 || height <> -2 then Widget.set_usize w ~width ~height;
  may options ~f:(Calendar.display_options w);
  pack_return (new calendar w) ~packing ~show

class drawing_area obj = object
  inherit widget_full (obj : Gtk.drawing_area obj)
  method event = new GObj.event_ops obj
  method set_size = DrawingArea.size obj
end

let drawing_area ?(width=0) ?(height=0) ?packing ?show () =
  let w = DrawingArea.create () in
  if width <> 0 || height <> 0 then DrawingArea.size w ~width ~height;
  pack_return (new drawing_area w) ~packing ~show

class misc obj = object
  inherit widget obj
  method set_alignment = Misc.set_alignment obj
  method set_padding = Misc.set_padding obj
end

class arrow obj = object
  inherit misc obj
  method set_arrow kind ~shadow = Arrow.set obj ~kind ~shadow
end

let arrow ~kind ~shadow
    ?xalign ?yalign ?xpad ?ypad ?width ?height ?packing ?show () =
  let w = Arrow.create ~kind ~shadow in
  Misc.set w ?xalign ?yalign ?xpad ?ypad ?width ?height;
  pack_return (new arrow w) ~packing ~show

class image obj = object
  inherit misc obj
  method set_image ?mask image = Image.set obj image ?mask
end

let image image ?mask
    ?xalign ?yalign ?xpad ?ypad ?width ?height ?packing ?show () =
  let w = Image.create image ?mask in
  Misc.set w ?xalign ?yalign ?xpad ?ypad ?width ?height;
  pack_return (new image w) ~packing ~show

class label_skel obj = object
  inherit misc obj
  method set_text = Label.set_text obj
  method set_justify = Label.set_justify obj
  method set_pattern = Label.set_pattern obj
  method set_line_wrap = Label.set_line_wrap obj
  method text = Label.get_text obj
end

class label obj = object
  inherit label_skel (Label.coerce obj)
  method connect = new widget_signals obj
end

let label ?(text="") ?justify ?line_wrap ?pattern
    ?xalign ?yalign ?xpad ?ypad ?width ?height ?packing ?show () =
  let w = Label.create text in
  Label.set w ?justify ?line_wrap ?pattern;
  Misc.set w ?xalign ?yalign ?xpad ?ypad ?width ?height;
  pack_return (new label w) ~packing ~show

let label_cast w = new label (Label.cast w#as_widget)

class tips_query_signals obj = object
  inherit widget_signals obj
  method widget_entered ~callback = 
    GtkSignal.connect ~sgn:TipsQuery.Signals.widget_entered obj ~after
      ~callback:(function None -> callback None
	| Some w -> callback (Some (new widget w)))
  method widget_selected ~callback = 
    GtkSignal.connect ~sgn:TipsQuery.Signals.widget_selected obj ~after
      ~callback:(function None -> callback None
	| Some w -> callback (Some (new widget w)))
end

class tips_query obj = object
  inherit label_skel (obj : Gtk.tips_query obj)
  method start () = TipsQuery.start obj
  method stop () = TipsQuery.stop obj
  method set_caller (w : widget) = TipsQuery.set_caller obj w#as_widget
  method set_emit_always = TipsQuery.set_emit_always obj
  method set_label_inactive inactive = TipsQuery.set_labels obj ~inactive
  method set_label_no_tip no_tip = TipsQuery.set_labels obj ~no_tip
  method connect = new tips_query_signals obj
end

let tips_query ?caller ?emit_always ?label_inactive ?label_no_tip
    ?xalign ?yalign ?xpad ?ypad ?width ?height ?packing ?show () =
  let w = TipsQuery.create () in
  let caller = may_map caller ~f:(fun (w : #widget) -> w#as_widget) in
  TipsQuery.set w ?caller ?emit_always ?label_inactive ?label_no_tip;
  Misc.set w ?xalign ?yalign ?xpad ?ypad ?width ?height;
  pack_return (new tips_query w) ~packing ~show

class color_selection obj = object
  inherit GObj.widget_full (obj : Gtk.color_selection obj)
  method set_update_policy = ColorSelection.set_update_policy obj
  method set_opacity = ColorSelection.set_opacity obj
  method set_color = ColorSelection.set_color obj
  method get_color = ColorSelection.get_color obj
end

let color_selection ?border_width ?width ?height ?packing ?show () =
  let w = ColorSelection.create () in
  Container.set w ?border_width ?width ?height;
  pack_return (new color_selection w) ~packing ~show

class pixmap obj = object
  inherit misc (obj : Gtk.pixmap obj)
  method connect = new widget_signals obj
  method set_pixmap (pm : GDraw.pixmap) =
    Pixmap.set obj ~pixmap:pm#pixmap ?mask:pm#mask
  method pixmap =
    new GDraw.pixmap (Pixmap.pixmap obj)
      ?mask:(try Some(Pixmap.mask obj) with Gpointer.Null -> None)
end

let pixmap (pm : #GDraw.pixmap) ?xalign ?yalign ?xpad ?ypad
    ?(width = -2) ?(height = -2) ?packing ?show () =
  let w = Pixmap.create pm#pixmap ?mask:pm#mask in
  Misc.set w ?xalign ?yalign ?xpad ?ypad;
  if width <> -2 || height <> -2 then Widget.set_usize w ~width ~height;
  pack_return (new pixmap w) ~packing ~show

class font_selection obj = object
  inherit widget_full (obj : Gtk.font_selection obj)
  method notebook = new GPack.notebook obj
  method event = new event_ops obj
  method font = FontSelection.get_font obj
  method font_name = FontSelection.get_font_name obj
  method set_font_name = FontSelection.set_font_name obj
  method preview_text = FontSelection.get_preview_text obj
  method set_preview_text = FontSelection.set_preview_text obj
  method set_filter = FontSelection.set_filter obj
end
