(* $Id$ *)

open Misc
open Gtk

class gtkobj obj = object
  val obj = obj
  method destroy () = Object.destroy obj
  method disconnect = Signal.disconnect obj
end

class gtkobj_signals obj = object
  val obj = obj
  method destroy = Signal.connect sig:Object.Signals.destroy obj
end

class gtkobj_full obj = object
  inherit gtkobj obj
  method connect = new gtkobj_signals obj
end

class type framed = object method frame : Widget.t obj end

class tooltips obj = object
  inherit gtkobj_full obj
  method enable () = Tooltips.enable obj
  method disable () = Tooltips.disable obj
  method set_tip : 'b . (#framed as 'b) -> _ =
    fun w -> Tooltips.set_tip ?obj ?w#frame
  method set = Tooltips.set ?obj
end

let new_tooltips () = new tooltips (Tooltips.create ())

class widget_misc obj = object
  val obj = Widget.coerce obj
  method show () = Widget.show obj
  method show_now () = Widget.show_now obj
  method show_all () = Widget.show_all obj
  method hide () = Widget.hide obj
  method hide_all () = Widget.hide_all obj
  method map () = Widget.map obj
  method unmap () = Widget.unmap obj
  method realize () = Widget.realize obj
  method unrealize () = Widget.realize obj
  method event : 'a. 'a Gdk.event -> unit = Widget.event obj
  method activate () = Widget.activate obj
  method reparent : 'a. (#framed as 'a) -> unit =
    fun w -> Widget.reparent obj w#frame
  method popup = Widget.popup obj
  method intersect = Widget.intersect obj
  method basic = Widget.basic obj
  method grab_focus () = Widget.grab_focus obj
  method grab_default () = Widget.grab_default obj
  method is_ancestor : 'a. (#framed as 'a) -> bool =
    fun w -> Widget.is_ancestor obj w#frame
  method is_child : 'a. (#framed as 'a) -> bool =
    fun w -> Widget.is_child obj w#frame
  method install_accelerator : 'a. _ -> sig:('a[> widget],_) Signal.t -> _ =
    Widget.install_accelerator obj
  method remove_accelerator : 'a. _ -> sig:('a[> widget],_) Signal.t -> _ =
    Widget.remove_accelerator obj
  method set = Widget.set ?obj
  (* get functions *)
  method name = Widget.get_name obj
  method toplevel = Widget.get_toplevel obj
  method window = Widget.window obj
  method colormap = Widget.get_colormap obj
  method visual = Widget.get_visual obj
  method pointer = Widget.get_pointer obj
  method style = Widget.get_style obj
end

class event_signals obj = object
  val obj = Widget.coerce obj
  method any = Signal.connect sig:Event.Signals.any obj
  method button_press = Signal.connect sig:Event.Signals.button_press obj
  method button_release = Signal.connect sig:Event.Signals.button_release obj
  method configure = Signal.connect sig:Event.Signals.configure obj
  method delete = Signal.connect sig:Event.Signals.delete obj
  method destroy = Signal.connect sig:Event.Signals.destroy obj
  method enter_notify = Signal.connect sig:Event.Signals.enter_notify obj
  method expose = Signal.connect sig:Event.Signals.expose obj
  method focus_in = Signal.connect sig:Event.Signals.focus_in obj
  method focus_out = Signal.connect sig:Event.Signals.focus_out obj
  method key_press = Signal.connect sig:Event.Signals.key_press obj
  method key_release = Signal.connect sig:Event.Signals.key_release obj
  method leave_notify = Signal.connect sig:Event.Signals.leave_notify obj
  method map = Signal.connect sig:Event.Signals.map obj
  method motion_notify = Signal.connect sig:Event.Signals.motion_notify obj
  method property_notify = Signal.connect sig:Event.Signals.property_notify obj
  method proximity_in = Signal.connect sig:Event.Signals.proximity_in obj
  method proximity_out = Signal.connect sig:Event.Signals.proximity_out obj
  method selection_clear = Signal.connect sig:Event.Signals.selection_clear obj
  method selection_notify =
    Signal.connect sig:Event.Signals.selection_notify obj
  method selection_request =
    Signal.connect sig:Event.Signals.selection_request obj
  method unmap = Signal.connect sig:Event.Signals.unmap obj
end

class widget obj = object
  inherit gtkobj obj
  method frame = Widget.coerce obj
  method misc = new widget_misc obj
  method show () = Widget.show obj
end

class widget_signals obj = object
  inherit gtkobj_signals obj
  method show = Signal.connect sig:Widget.Signals.show obj
  method draw = Signal.connect sig:Widget.Signals.draw obj
  method event = new event_signals obj
end

class widget_full obj = object
  inherit widget obj
  method connect = new widget_signals obj
end

class container obj = object
  inherit widget obj
  method add : 'b . (#framed as 'b) -> unit =
    fun w -> Container.add obj w#frame
  method remove : 'b. (#framed as 'b) -> unit =
    fun w -> Container.remove obj w#frame
  method children = List.map fun:(new widget) (Container.children obj)
  method set_size = Container.set ?obj
end

class container_signals obj = object
  inherit widget_signals obj
  method add = Signal.connect sig:Container.Signals.add obj
  method remove = Signal.connect sig:Container.Signals.remove obj
end

class container_full obj = object
  inherit container obj
  method connect = new container_signals obj
end

class event_box = container_full

let new_event_box () = new event_box (EventBox.create ())

class frame obj = object
  inherit container_full obj
  method set_label ?label ?:xalign ?:yalign =
    Frame.setter obj ?:label ?label_xalign:xalign ?label_yalign:yalign
      cont:null_cont
  method set_shadow_type = Frame.set_shadow_type obj
end

class frame_create ?:label ?opt = frame (Frame.create ?:label ?opt) 

let pack_return wrapper w ?:packing =
  let w = wrapper w in
  may packing fun:(fun f -> f w);
  w

let new_frame ?opt ?:label =
  Frame.setter ?(Frame.create ?:label ?opt) ?label:None
    ?cont:(Container.setter ?cont:(pack_return (new frame)))

class aspect_frame obj = object
  inherit frame obj
  method set_aspect = AspectFrame.setter ?obj ?cont:null_cont
end

class aspect_frame_create ?:label ?:xalign ?:yalign ?:ratio ?:obey_child ?opt =
  aspect_frame
    (AspectFrame.create ?:label ?:xalign ?:yalign ?:ratio ?:obey_child ?opt)

let new_aspect_frame ?opt ?:label ?:xalign ?:yalign ?:ratio ?:obey_child =
  let w =
    AspectFrame.create ?opt ?:label ?:xalign ?:yalign ?:ratio ?:obey_child in
  Frame.setter ?w ?label:None
    ?cont:(Container.setter ?cont:(pack_return (new aspect_frame)))

class box obj = object
  inherit container_full obj
  method pack : 'b . (#framed as 'b) -> _ = fun w ->  Box.pack ?obj ?w#frame
  method set_packing = Box.setter ?obj ?cont:null_cont
  method set_child_packing : 'b . (#framed as 'b) -> _ =
    fun w -> Box.set_child_packing ?obj ?w#frame
end

let new_box dir ?:homogeneous ?:spacing =
  let w = Box.create dir ?:homogeneous ?:spacing in
  Container.setter ?w ?cont:(pack_return (new box))

class statusbar_context obj ctx = object (self)
  val obj : Statusbar.t obj = obj
  val context : Statusbar.context = ctx
  method context = context
  method push text = Statusbar.push obj context :text
  method pop () = Statusbar.pop obj context
  method remove = Statusbar.remove obj context
  method flash text ?:delay [< 1000 >] =
    let msg = self#push text in
    Timeout.add delay callback:(fun () -> self#remove msg; false);
    ()
end

class statusbar obj = object
  inherit container_full obj
  method new_context :name =
    new statusbar_context obj (Statusbar.get_context obj name)
end

let new_statusbar ?(_ : unit option) =
  let w = Statusbar.create () in
  Container.setter ?w ?cont:(pack_return (new statusbar))

class window obj = object
  inherit container_full obj
  method show_all () = Widget.show_all obj
  method activate_focus () = Window.activate_focus obj
  method activate_default () = Window.activate_default obj
  method set_wm ?:title ?:name ?class:c =
    Window.setter obj cont:null_cont
      ?:title ?wmclass_name:name ?wmclass_class:c
  method set_policy ?:allow_shrink ?:allow_grow ?:auto_shrink =
    Window.setter obj cont:null_cont ?:allow_shrink ?:allow_grow ?:auto_shrink
end

let new_window dir =
  Window.setter ?(Window.create dir)
    ?cont:(Container.setter ?cont:(new window))

class dialog obj = object
  inherit window obj
  method action_area = new box (Dialog.action_area obj)
  method vbox = new box (Dialog.vbox obj)
end

let new_dialog ?(_ : unit option) =
  Window.setter ?(Dialog.create ())
    ?cont:(Container.setter ?cont:(new dialog))

class button_skel obj = object (self)
  inherit container obj
  method clicked = Button.clicked obj
  method grab_default () =
    Widget.set_can_default (self#frame) true;
    Widget.grab_default (self#frame)
end

class button_signals obj = object
  inherit container_signals obj
  method clicked = Signal.connect sig:Button.Signals.clicked obj
  method pressed = Signal.connect sig:Button.Signals.pressed obj
  method released = Signal.connect sig:Button.Signals.released obj
  method enter = Signal.connect sig:Button.Signals.enter obj
  method leave = Signal.connect sig:Button.Signals.leave obj
end

class button obj = object
  inherit button_skel obj
  method connect = new button_signals obj
end

class button_create ?:label ?opt = button (Button.create ?:label ?opt)

let new_button ?opt ?:label =
  Container.setter ?(Button.create ?:label ?opt)
    ?cont:(pack_return (new button))

class toggle_button_signals obj = object
  inherit button_signals obj
  method toggled = Signal.connect sig:ToggleButton.Signals.toggled obj
end

class toggle_button obj = object
  inherit button_skel obj
  method connect = new toggle_button_signals obj
  method active = ToggleButton.active obj
  method set_state = ToggleButton.set_state obj
  method draw_indicator = ToggleButton.set_mode obj
end

let new_toggle_button ?opt ?:label =
  ToggleButton.setter ?(ToggleButton.create_toggle ?:label ?opt)
    ?cont:(Container.setter ?cont:(pack_return (new toggle_button)))

let new_check_button ?opt ?:label =
  ToggleButton.setter ?(ToggleButton.create_check ?:label ?opt)
    ?cont:(Container.setter ?cont:(pack_return (new toggle_button)))

class radio_button obj = object
  inherit toggle_button obj
  method set_group = RadioButton.set ?obj
  method group = RadioButton.group obj
end
  
let new_radio_button ?opt ?:group ?:label =
  RadioButton.setter ?(RadioButton.create ?:group ?:label ?opt)
    ?cont:(ToggleButton.setter
	     ?cont:(Container.setter ?cont:(pack_return (new radio_button))))

class scrolled_window obj = object
  inherit container_full obj
  method hadjustment = ScrolledWindow.get_hadjustment obj
  method vadjustment = ScrolledWindow.get_vadjustment obj
  method set_policy ?:horizontal ?:vertical =
    ScrolledWindow.setter obj cont:null_cont
      ?hscrollbar_policy:horizontal ?vscrollbar_policy:vertical
end

let new_scrolled_window () =
  ScrolledWindow.setter ?(ScrolledWindow.create ())
    ?cont:(Container.setter ?cont:(pack_return (new scrolled_window)))

class table obj = object
  inherit container_full obj
  method attach : 'a. (#framed as 'a) -> _ =
    fun w -> Table.attach obj w#frame
  method set_packing = Table.setter ?obj ?cont:null_cont
end

let new_table :rows :columns ?:homogeneous =
  Table.setter ?(Table.create :rows :columns ?:homogeneous) ?homogeneous:None
    ?cont:(Container.setter ?cont:(pack_return (new table)))

class editable_signals obj = object
  inherit widget_signals obj
  method activate = Signal.connect sig:Editable.Signals.activate obj
  method changed = Signal.connect sig:Editable.Signals.changed obj
end

class editable obj = object
  inherit widget obj
  method connect = new editable_signals obj
  method select_region = Editable.select_region obj
  method insert_text = Editable.insert_text obj
  method delete_text = Editable.delete_text obj
  method get_chars = Editable.get_chars obj
  method cut_clipboard = Editable.cut_clipboard obj
  method copy_clipboard = Editable.copy_clipboard obj
  method paste_clipboard = Editable.paste_clipboard obj
end

class entry obj = object
  inherit editable obj
  method set_text = Entry.set_text obj
  method append_text = Entry.append_text obj
  method prepend_text = Entry.prepend_text obj
  method set_position = Entry.set_position obj
  method set_visibility = Entry.set_visibility obj
  method set_editable = Entry.set_editable obj
  method set_max_length = Entry.set_max_length obj
  method text = Entry.get_text obj
  method text_length = Entry.text_length obj
end

let new_entry ?:max_length ?unit =
  Entry.setter ?(Entry.create ?:max_length ?unit) ?max_length:None
    ?cont:(pack_return (new entry))

class text obj = object
  inherit editable obj
  method set_editable = Text.set_editable obj
  method set_point = Text.set_point obj
  method set_word_wrap = Text.set_word_wrap obj
  method point = Text.get_point obj
  method length = Text.get_length obj
  method freeze = Text.freeze obj
  method thaw = Text.thaw obj
  method insert = Text.insert ?obj
end

let new_text ?opt ?:hadjustment ?:vadjustment =
  Text.setter ?(Text.create ?:hadjustment ?:vadjustment ?opt) ?point:None
    ?cont:(pack_return (new text))

class misc obj = object
  inherit widget_full obj
  method set_alignment = Misc.set_alignment obj
  method set_padding = Misc.set_padding obj
end

class label obj = object
  inherit misc obj
  method set_label = Label.set_label obj
  method set_justify = Label.set_justify obj
  method label = Label.get_label obj
end

let new_label ?:label [< "" >] =
  Label.setter ?(Label.create label) ?label:None
    ?cont:(Misc.setter ?cont:(pack_return (new label)))

class pixmap obj = object
  inherit misc obj
  method set = Pixmap.setter ?obj ?cont:null_cont
  method pixmap = Pixmap.pixmap obj
  method mask = Pixmap.mask obj
end

let new_pixmap pix ?:mask =
  Misc.setter ?(Pixmap.create pix ?:mask) ?cont:(pack_return (new pixmap))

class progress_bar obj = object
  inherit widget_full obj
  method update percent = ProgressBar.update obj :percent
  method percent = ProgressBar.percent obj
end

let new_progress_bar ?(_ : unit option) =
  pack_return ?(new progress_bar) ?(ProgressBar.create ())

class separator = widget_full

let new_separator dir =
  pack_return ?(new separator) ?(Separator.create dir)
