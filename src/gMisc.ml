(* $Id$ *)

open Misc
open Gtk
open GtkBase
open GtkMisc
open GObj

let separator dir ?(:width = -2) ?(:height = -2) ?:packing ?:show () =
  let w = Separator.create dir in
  if width <> -2 || height <> -2 then Widget.set_usize w :width :height;
  pack_return (new widget_full w) :packing :show

class statusbar_context obj ctx = object (self)
  val obj : statusbar obj = obj
  val context : Gtk.statusbar_context = ctx
  method context = context
  method push text = Statusbar.push obj context :text
  method pop () = Statusbar.pop obj context
  method remove = Statusbar.remove obj context
  method flash ?(:delay=1000) text =
    let msg = self#push text in
    GtkMain.Timeout.add delay callback:(fun () -> self#remove msg; false);
    ()
end

class statusbar obj = object
  inherit GContainer.container_full (obj : Gtk.statusbar obj)
  method new_context :name =
    new statusbar_context obj (Statusbar.get_context obj name)
end

let statusbar ?:border_width ?:width ?:height ?:packing ?:show () =
  let w = Statusbar.create () in
  Container.set w ?:border_width ?:width ?:height;
  pack_return (new statusbar w) :packing :show

class calendar_signals obj = object
  inherit widget_signals obj
  method month_changed =
    GtkSignal.connect obj sig:Calendar.Signals.month_changed :after
  method day_selected =
    GtkSignal.connect obj sig:Calendar.Signals.day_selected :after
  method day_selected_double_click =
    GtkSignal.connect obj
      sig:Calendar.Signals.day_selected_double_click :after
  method prev_month =
    GtkSignal.connect obj sig:Calendar.Signals.prev_month :after
  method next_month =
    GtkSignal.connect obj sig:Calendar.Signals.next_month :after
  method prev_year =
    GtkSignal.connect obj sig:Calendar.Signals.prev_year :after
  method next_year =
    GtkSignal.connect obj sig:Calendar.Signals.next_year :after
end

class calendar obj = object
  inherit widget (obj : Gtk.calendar obj)
  method add_events = Widget.add_events obj
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

let calendar ?:options ?(:width = -2) ?(:height = -2) ?:packing ?:show () =
  let w = Calendar.create () in
  if width <> -2 || height <> -2 then Widget.set_usize w :width :height;
  may options fun:(Calendar.display_options w);
  pack_return (new calendar w) :packing :show

class drawing_area obj = object
  inherit widget_full (obj : Gtk.drawing_area obj)
  method add_events = Widget.add_events obj
  method set_size = DrawingArea.size obj
end

let drawing_area ?(:width=0) ?(:height=0) ?:packing ?:show () =
  let w = DrawingArea.create () in
  if width <> 0 || height <> 0 then DrawingArea.size w :width :height;
  pack_return (new drawing_area w) :packing :show

class misc obj = object
  inherit widget obj
  method set_alignment = Misc.set_alignment obj
  method set_padding = Misc.set_padding obj
end

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

let label ?(:text="") ?:justify ?:line_wrap ?:pattern
    ?:xalign ?:yalign ?:xpad ?:ypad ?:width ?:height ?:packing ?:show () =
  let w = Label.create text in
  Label.set w ?:justify ?:line_wrap ?:pattern;
  Misc.set w ?:xalign ?:yalign ?:xpad ?:ypad ?:width ?:height;
  pack_return (new label w) :packing :show

class tips_query_signals obj = object
  inherit widget_signals obj
  method widget_entered :callback = 
    GtkSignal.connect sig:TipsQuery.Signals.widget_entered obj :after
      callback:(function None -> callback None
	| Some w -> callback (Some (new widget w)))
  method widget_selected :callback = 
    GtkSignal.connect sig:TipsQuery.Signals.widget_selected obj :after
      callback:(function None -> callback None
	| Some w -> callback (Some (new widget w)))
end

class tips_query obj = object
  inherit label_skel (obj : Gtk.tips_query obj)
  method start () = TipsQuery.start obj
  method stop () = TipsQuery.stop obj
  method set_caller (w : widget) = TipsQuery.set_caller obj w#as_widget
  method set_emit_always = TipsQuery.set_emit_always obj
  method set_label_inactive inactive = TipsQuery.set_labels obj :inactive
  method set_label_no_tip no_tip = TipsQuery.set_labels obj :no_tip
  method connect = new tips_query_signals obj
end

let tips_query ?:caller ?:emit_always ?:label_inactive ?:label_no_tip
    ?:xalign ?:yalign ?:xpad ?:ypad ?:width ?:height ?:packing ?:show () =
  let w = TipsQuery.create () in
  let caller = may_map caller fun:(fun (w : #widget) -> w#as_widget) in
  TipsQuery.set w ?:caller ?:emit_always ?:label_inactive ?:label_no_tip;
  Misc.set w ?:xalign ?:yalign ?:xpad ?:ypad ?:width ?:height;
  pack_return (new tips_query w) :packing :show

class notebook_signals obj = object
  inherit GContainer.container_signals obj
  method switch_page =
    GtkSignal.connect obj sig:Notebook.Signals.switch_page :after
end

class notebook obj = object (self)
  inherit GContainer.container (obj : Gtk.notebook obj)
  method add_events = Widget.add_events obj
  method connect = new notebook_signals obj
  method insert_page ?:tab_label ?:menu_label :pos child =
      Notebook.insert_page obj (as_widget child) :pos
	tab_label:(may_box tab_label fun:as_widget)
	menu_label:(may_box menu_label fun:as_widget)
  method append_page = self#insert_page pos:(-1)
  method prepend_page = self#insert_page pos:0
  method remove_page = Notebook.remove_page obj
  method current_page = Notebook.get_current_page obj
  method goto_page = Notebook.set_page obj
  method previous_page () = Notebook.prev_page obj
  method next_page () = Notebook.next_page obj
  method set_tab_pos = Notebook.set_tab_pos obj
  method set_show_tabs = Notebook.set_show_tabs obj
  method set_homogeneous_tabs = Notebook.set_homogeneous_tabs obj
  method set_show_border = Notebook.set_show_border obj
  method set_scrollable = Notebook.set_scrollable obj
  method set_tab_border = Notebook.set_tab_border obj
  method set_popup = Notebook.set_popup obj
  method page_num w = Notebook.page_num obj (as_widget w)
  method nth_page n = new widget (Notebook.get_nth_page obj n)
  method set_page ?:tab_label ?:menu_label page =
    let child = as_widget page in
    may tab_label
      fun:(fun lbl -> Notebook.set_tab_label obj child (as_widget lbl));
    may menu_label
      fun:(fun lbl -> Notebook.set_menu_label obj child (as_widget lbl))
end

let notebook ?:tab_pos ?:tab_border ?:show_tabs ?:homogeneous_tabs
    ?:show_border ?:scrollable ?:popup
    ?:border_width ?:width ?:height ?:packing ?:show () =
  let w = Notebook.create () in
  Notebook.set w ?:tab_pos ?:tab_border ?:show_tabs
    ?:homogeneous_tabs ?:show_border ?:scrollable ?:popup;
  Container.set w ?:border_width ?:width ?:height;
  pack_return (new notebook w) :packing :show

class color_selection obj = object
  inherit GObj.widget_full (obj : Gtk.color_selection obj)
  method set_update_policy = ColorSelection.set_update_policy obj
  method set_opacity = ColorSelection.set_opacity obj
  method set_color = ColorSelection.set_color obj
  method get_color = ColorSelection.get_color obj
end

let color_selection ?:border_width ?:width ?:height ?:packing ?:show () =
  let w = ColorSelection.create () in
  Container.set w ?:border_width ?:width ?:height;
  pack_return (new color_selection w) :packing :show
