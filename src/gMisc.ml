(* $Id$ *)

open Misc
open Gtk
open GtkBase
open GtkMisc
open GObj

class separator_wrapper w = widget_wrapper (w : separator obj)

class separator dir ?:packing ?:show =
  object (self)
    inherit separator_wrapper (Separator.create dir)
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
  let () = Container.setter w ?:border_width ?:width ?:height cont:null_cont in
  object (self)
    inherit statusbar_wrapper w
    initializer pack_return :packing ?:show (self :> statusbar_wrapper)
  end

class drawing_area_wrapper obj = object
  inherit widget_wrapper (obj : Gtk.drawing_area obj)
  method event = new event_ops obj
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
  method set_alignment = Misc.set_alignment obj
  method set_padding = Misc.set_padding obj
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
    ?:xalign ?:yalign ?:xpad ?:ypad ?:packing ?:show =
  let w = Label.create text in
  let () =
    Label.setter w cont:null_cont ?:justify ?:line_wrap ?:pattern;
    Misc.setter w cont:null_cont ?:xalign ?:yalign ?:xpad ?:ypad
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
  method set_labels = TipsQuery.set_labels obj
  method connect = new tips_query_signals ?obj
end

class tips_query ?:caller ?:emit_always ?:label_inactive ?:label_no_tip
    ?:packing ?:show =
  let w = TipsQuery.create () in
  let () =
    let caller = may_map (caller : #is_widget option) fun:(#as_widget) in
    TipsQuery.setter w cont:null_cont ?:caller ?:emit_always
      ?:label_inactive ?:label_no_tip
  in
  object (self)
    inherit tips_query_wrapper w
    initializer pack_return :packing ?:show (self :> tips_query_wrapper)
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
  let () = Container.setter w cont:null_cont ?:border_width ?:width ?:height in
  object (self)
    inherit color_selection_wrapper w
    initializer pack_return :packing ?:show (self :> color_selection_wrapper)
  end
