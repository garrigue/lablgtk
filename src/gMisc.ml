(* $Id$ *)

open Misc
open Gtk
open GtkBase
open GtkMisc
open GObj

class separator_wrapper w = widget_wrapper (w : separator obj)

class separator dir ?:width ?:height ?:packing ?:show =
  let w = Separator.create dir in
  let () = Widget.set_size w ?:width ?:height in
  object (self)
    inherit separator_wrapper w
    initializer pack_return :packing ?:show (self :> separator_wrapper)
  end

class statusbar_context obj ctx = object (self)
  val obj : statusbar obj = obj
  val context : Gtk.statusbar_context = ctx
  method context = context
  method push text = Statusbar.push obj context :text
  method pop () = Statusbar.pop obj context
  method remove = Statusbar.remove obj context
  method flash text ?:delay [< 1000 >] =
    let msg = self#push text in
    GtkMain.Timeout.add delay callback:(fun () -> self#remove msg; false);
    ()
end

class statusbar_wrapper obj = object
  inherit GContainer.container_wrapper (obj : Gtk.statusbar obj)
  method new_context :name =
    new statusbar_context obj (Statusbar.get_context obj name)
end

class statusbar ?:border_width ?:width ?:height ?:packing ?:show =
  let w = Statusbar.create () in
  let () = Container.set w ?:border_width ?:width ?:height in
  object (self)
    inherit statusbar_wrapper w
    initializer pack_return :packing ?:show (self :> statusbar_wrapper)
  end

class calendar_signals obj ?:after = object
  inherit widget_signals obj ?:after
  method month_changed =
    GtkSignal.connect obj sig:Calendar.Signals.month_changed ?:after
  method day_selected =
    GtkSignal.connect obj sig:Calendar.Signals.day_selected ?:after
  method day_selected_double_click =
    GtkSignal.connect obj
      sig:Calendar.Signals.day_selected_double_click ?:after
  method prev_month =
    GtkSignal.connect obj sig:Calendar.Signals.prev_month ?:after
  method next_month =
    GtkSignal.connect obj sig:Calendar.Signals.next_month ?:after
  method prev_year =
    GtkSignal.connect obj sig:Calendar.Signals.prev_year ?:after
  method next_year =
    GtkSignal.connect obj sig:Calendar.Signals.next_year ?:after
end

class calendar_wrapper obj = object
  inherit widget (obj : Gtk.calendar obj)
  method add_events = Widget.add_events obj
  method connect = new calendar_signals ?obj
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

class calendar ?:options ?:width ?:height ?:packing ?:show =
  let w = Calendar.create () in
  let () =
    Widget.set_size w ?:width ?:height;
    may options fun:(Calendar.display_options w) in
  object (self)
    inherit calendar_wrapper w
    initializer pack_return :packing ?:show (self :> calendar_wrapper)
  end

class drawing_area_wrapper obj = object
  inherit widget_wrapper (obj : Gtk.drawing_area obj)
  method add_events = Widget.add_events obj
  method set_size = DrawingArea.size obj
end

class drawing_area  ?:width [< 0 >] ?:height [< 0 >] ?:packing ?:show =
  let w = DrawingArea.create () in
  let () =
    if width <> 0 || height <> 0 then DrawingArea.size w :width :height in
  object (self)
    inherit drawing_area_wrapper w
    initializer pack_return :packing ?:show (self :> drawing_area_wrapper)
  end

class misc obj = object
  inherit widget obj
  method set_misc = Misc.setter ?obj ?cont:null_cont
end

class label_skel obj = object
  inherit misc obj
  method set_text = Label.set_text obj
  method set_justify = Label.set_justify obj
  method text = Label.get_text obj
end

class label_wrapper obj = object
  inherit label_skel (Label.coerce obj)
  method connect = new widget_signals ?obj
end

class label ?:text [< "" >] ?:justify ?:line_wrap ?:pattern
    ?:xalign ?:yalign ?:xpad ?:ypad ?:width ?:height ?:packing ?:show =
  let w = Label.create text in
  let () =
    Label.setter w cont:null_cont ?:justify ?:line_wrap ?:pattern;
    Misc.set w ?:xalign ?:yalign ?:xpad ?:ypad ?:width ?:height
  in
  object (self)
    inherit label_wrapper w
    initializer pack_return :packing ?:show (self :> label_wrapper)
  end

class tips_query_signals obj ?:after = object
  inherit widget_signals obj ?:after
  method widget_entered :callback = 
    GtkSignal.connect sig:TipsQuery.Signals.widget_entered obj ?:after
      callback:(function None -> callback None
	| Some w -> callback (Some (new widget_wrapper w)))
  method widget_selected :callback = 
    GtkSignal.connect sig:TipsQuery.Signals.widget_selected obj ?:after
      callback:(function None -> callback None
	| Some w -> callback (Some (new widget_wrapper w)))
end

class tips_query_wrapper obj = object
  inherit label_skel (obj : Gtk.tips_query obj)
  method start () = TipsQuery.start obj
  method stop () = TipsQuery.stop obj
  method set_caller : 'a . (#is_widget as 'a) -> unit =
    fun w -> TipsQuery.set_caller obj (w #as_widget)
  method set_tips = TipsQuery.setter ?obj ?cont:null_cont ?caller:None
  method connect = new tips_query_signals ?obj
end

class tips_query ?:caller ?:emit_always ?:label_inactive ?:label_no_tip
    ?:width ?:height ?:packing ?:show =
  let w = TipsQuery.create () in
  let () =
    let caller = may_map (caller : #is_widget option) fun:(#as_widget) in
    TipsQuery.setter w cont:null_cont ?:caller ?:emit_always
      ?:label_inactive ?:label_no_tip;
    Widget.set_size w ?:width ?:height
  in
  object (self)
    inherit tips_query_wrapper w
    initializer pack_return :packing ?:show (self :> tips_query_wrapper)
  end

class notebook_signals obj ?:after = object
  inherit GContainer.container_signals obj ?:after
  method switch_page =
    GtkSignal.connect obj sig:Notebook.Signals.switch_page ?:after
end

class notebook_wrapper obj = object (self)
  inherit GContainer.container (obj : notebook obj)
  method add_events = Widget.add_events obj
  method connect = new notebook_signals ?obj
  method insert_page : 'a 'b 'c. (#is_widget as 'a) ->
    ?tab_label:(#is_widget as 'b) -> ?menu_label:(#is_widget as 'c) -> _ =
    fun child ?:tab_label ?:menu_label ->
      Notebook.insert_page obj child#as_widget
	tab_label:(may_box tab_label fun:(#as_widget))
	menu_label:(may_box menu_label fun:(#as_widget))
  method append_page : 'a 'b 'c. (#is_widget as 'a) ->
    ?tab_label:(#is_widget as 'b) -> ?menu_label:(#is_widget as 'c) -> _ =
    self#insert_page pos:(-1)
  method prepend_page : 'a 'b 'c. (#is_widget as 'a) ->
    ?tab_label:(#is_widget as 'b) -> ?menu_label:(#is_widget as 'c) -> _ =
    self#insert_page pos:0
  method remove_page = Notebook.remove_page obj
  method current_page = Notebook.get_current_page obj
  method goto_page = Notebook.set_page obj
  method previous_page () = Notebook.prev_page obj
  method next_page () = Notebook.next_page obj
  method set_notebook = Notebook.setter ?obj ?cont:null_cont ?page:None
  method page_num : 'a. (#is_widget as 'a) -> _ =
    fun w -> Notebook.page_num obj w#as_widget
  method nth_page n = new widget (Notebook.get_nth_page obj n)
  method set_page : 'a 'b 'c. (#is_widget as 'a) ->
    ?tab_label:(#is_widget as 'b) -> ?menu_label:(#is_widget as 'c) -> _ =
    fun page ?:tab_label ?:menu_label ->
      let child = page#as_widget in
      may tab_label
	fun:(fun lbl -> Notebook.set_tab_label obj child lbl#as_widget);
      may menu_label
	fun:(fun lbl -> Notebook.set_menu_label obj child lbl#as_widget)
end

class notebook ?:tab_pos ?:tab_border ?:show_tabs ?:homogeneous_tabs
    ?:show_border ?:scrollable ?:popup
    ?:border_width ?:width ?:height ?:packing ?:show =
  let w = Notebook.create () in
  let () =
    Notebook.setter w cont:null_cont ?:tab_pos ?:tab_border ?:show_tabs
      ?:homogeneous_tabs ?:show_border ?:scrollable ?:popup;
    Container.set w ?:border_width ?:width ?:height in
  object (self)
    inherit notebook_wrapper w
    initializer pack_return :packing ?:show (self :> notebook_wrapper)
  end

class color_selection_wrapper obj = object
  inherit GPack.box_skel (obj : Gtk.color_selection obj)
  method connect = new GContainer.container_signals ?obj
  method set_update_policy = ColorSelection.set_update_policy obj
  method set_opacity = ColorSelection.set_opacity obj
  method set_color = ColorSelection.set_color obj
  method get_color = ColorSelection.get_color obj
end

class color_selection ?:border_width ?:width ?:height ?:packing ?:show =
  let w = ColorSelection.create () in
  let () = Container.set w ?:border_width ?:width ?:height in
  object (self)
    inherit color_selection_wrapper w
    initializer pack_return :packing ?:show (self :> color_selection_wrapper)
  end
