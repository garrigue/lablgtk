(* $Id$ *)

open Misc
open Gtk

class ['a] gtkobj_skel obj = object
  val obj : 'a obj = obj
  method raw = obj
  method destroy () = Object.destroy obj
  method disconnect = Signal.disconnect obj
end

class ['a] gtkobj_signals obj = object
  val obj : 'a obj = obj
  method destroy = Signal.connect sig:Object.Signals.destroy obj
end

class gtkobj obj = object
  inherit [unit] gtkobj_skel obj
  method connect = new gtkobj_signals obj
end

class type widgeter = object
  method widget : [widget] obj
end

let widgeter w = (w : #widgeter :> widgeter)

class tooltips obj = object
  inherit [Tooltips.t] gtkobj_skel obj
  method enable () = Tooltips.enable obj
  method disable () = Tooltips.disable obj
  method set_tip : 'b . (#widgeter as 'b) -> _ =
    fun w -> Tooltips.set_tip ?obj ?w#widget
  method set = Tooltips.set ?obj
  method connect = new gtkobj_signals obj
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
  method reparent : 'a. (#widgeter as 'a) -> unit =
    fun w -> Widget.reparent obj w#widget
  method popup = Widget.popup obj
  method intersect = Widget.intersect obj
  method basic = Widget.basic obj
  method grab_focus () = Widget.grab_focus obj
  method grab_default () = Widget.grab_default obj
  method is_ancestor : 'a. (#widgeter as 'a) -> bool =
    fun w -> Widget.is_ancestor obj w#widget
  method is_child : 'a. (#widgeter as 'a) -> bool =
    fun w -> Widget.is_child obj w#widget
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

class ['a] widget_skel obj = object
  inherit ['a] gtkobj_skel obj
  method widget = Widget.coerce obj
  method misc = new widget_misc obj
  method show () = Widget.show obj
end

class event_signal obj = object
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

class ['a] widget_signals obj = object
  inherit ['a] gtkobj_signals obj
  method draw = Signal.connect sig:Widget.Signals.draw obj
  method show = Signal.connect sig:Widget.Signals.show obj
  method event = new event_signal obj
end

class widget obj = object
  inherit [Widget.t] widget_skel obj
  method connect = new widget_signals obj
end

class ['a] container_skel obj = object
  inherit ['a] widget_skel obj
  method add : 'b . (#widgeter as 'b) -> unit =
    fun w -> Container.add obj w#widget
  method remove : 'b. (#widgeter as 'b) -> unit =
    fun w -> Container.remove obj w#widget
  method foreach fun:f = Container.foreach obj fun:(fun x -> f (new widget x))
  method children = List.map fun:(new widget) (Container.children obj)
end

class ['a] container_signals obj = object
  inherit ['a] widget_signals obj
  method add = Signal.connect sig:Container.Signals.add obj
  method remove = Signal.connect sig:Container.Signals.remove obj
end

class container obj = object
  inherit [Container.t] container_skel obj
  method connect = new container_signals obj
  method set = Container.set ?obj
end

class event_box obj = object
  inherit [EventBox.t] container_skel obj
  method connect = new container_signals obj
  method set = Container.set ?obj
end

let new_event_box () = new event_box (EventBox.create ())

class frame obj = object
  inherit [Frame.t] container_skel obj
  method connect = new container_signals obj
  method set = Frame.set ?obj
end

let new_frame :label = new frame (Frame.create :label)

class aspect_frame obj = object
  inherit [AspectFrame.t] container_skel obj
  method connect = new container_signals obj
  method set = AspectFrame.set ?obj
end

let new_aspect_frame :label ?:xalign ?:yalign ?:ratio ?:obey =
  new aspect_frame (AspectFrame.create :label ?:xalign ?:yalign ?:ratio ?:obey)

class ['a] box_skel obj = object
  inherit ['a] container_skel obj
  method pack : 'b . (#widgeter as 'b) -> _ = fun w ->  Box.pack ?obj ?w#widget
  method set = Box.set ?obj
end

class box obj = object
  inherit [Box.t] box_skel obj
  method connect = new container_signals obj
end

let new_box dir ?:homogeneous ?:spacing =
  new box (Box.create dir ?:homogeneous ?:spacing)

class ['a] window_skel obj = object
  inherit ['a] container_skel obj
  method show_all () = Widget.show_all obj
  method activate_focus () = Window.activate_focus obj
  method activate_default () = Window.activate_default obj
end

class window obj = object
  inherit [Window.t] window_skel obj
  method connect = new container_signals obj
  method set = Window.set ?obj
end

let new_window dir = new window (Window.create dir)

class ['a] dialog_skel obj = object
  inherit ['a] window_skel obj
  method action_area = new box (Dialog.action_area obj)
  method vbox = new box (Dialog.vbox obj)
end

class dialog obj = object
  inherit [Dialog.t] dialog_skel obj
  method connect = new container_signals obj
  method set = Window.set ?obj
end

let new_dialog () = new dialog (Dialog.create ())

class ['a] button_signals obj = object
  inherit ['a] widget_signals obj
  method clicked = Signal.connect sig:Button.Signals.clicked obj
  method pressed = Signal.connect sig:Button.Signals.pressed obj
  method released = Signal.connect sig:Button.Signals.released obj
  method enter = Signal.connect sig:Button.Signals.enter obj
  method leave = Signal.connect sig:Button.Signals.leave obj
end

class ['a] button_skel obj = object
  inherit ['a] container_skel obj
  method clicked = Button.clicked obj
end


class button obj = object
  inherit [Button.t] button_skel obj
  method connect = new button_signals obj
  method set ?:can_default =
    may can_default fun:(Widget.set_can_default obj);
    Container.set ?obj
  method grab_default () = Widget.grab_default obj
end

let new_button ?:label ?x = new button (Button.create ?:label ?x)

class ['a] toggle_button_skel obj = object
  inherit ['a] button_skel obj
  method active = ToggleButton.active obj
end

class ['a] toggle_button_signals obj = object
  inherit ['a] button_signals obj
  method toggled = Signal.connect sig:ToggleButton.Signals.toggled obj
end

class toggle_button obj = object
  inherit [ToggleButton.t] toggle_button_skel obj
  method connect = new toggle_button_signals obj
  method set = ToggleButton.set ?obj
end

let new_toggle_button ?:label ?opt =
  new toggle_button (ToggleButton.create_toggle ?:label ?opt)

let new_check_button ?:label ?opt =
  new toggle_button (ToggleButton.create_check ?:label ?opt)

class radio_button obj = object
  inherit [RadioButton.t] toggle_button_skel obj
  method connect = new toggle_button_signals obj
  method set = RadioButton.set ?obj
  method group = RadioButton.group obj
end
  
let new_radio_button ?:group ?:label ?opt =
  new radio_button (RadioButton.create ?:group ?:label ?opt)

class scrolled_window obj = object
  inherit [ScrolledWindow.t] container_skel obj
  method connect = new container_signals obj
  method hadjustment = ScrolledWindow.get_hadjustment obj
  method vadjustment = ScrolledWindow.get_vadjustment obj
  method set = ScrolledWindow.set ?obj
end

let new_scrolled_window () = new scrolled_window (ScrolledWindow.create ())

class table obj = object
  inherit [Table.t] container_skel obj
  method connect = new widget_signals obj
  method attach : 'a. (#widgeter as 'a) -> _ =
    fun w -> Table.attach obj w#widget
  method set = Table.set ?obj
end

let new_table :rows :columns ?:homogeneous =
  new table (Table.create :rows :columns ?:homogeneous)

class ['a] editable_skel obj = object
  inherit ['a] widget_skel obj
  method select_region = Editable.select_region obj
  method insert_text = Editable.insert_text obj
  method delete_text = Editable.delete_text obj
  method get_chars = Editable.get_chars obj
  method cut_clipboard = Editable.cut_clipboard obj
  method copy_clipboard = Editable.copy_clipboard obj
  method paste_clipboard = Editable.paste_clipboard obj
end

class ['a] editable_signals obj = object
  inherit ['a] widget_signals obj
  method activate = Signal.connect sig:Editable.Signals.activate obj
  method changed = Signal.connect sig:Editable.Signals.changed obj
end

class entry obj = object
  inherit [Entry.t] editable_skel obj
  method connect = new editable_signals obj
  method set_text = Entry.set_text obj
  method append_text = Entry.append_text obj
  method prepend_text = Entry.prepend_text obj
  method set = Entry.set ?obj
  method text = Entry.get_text obj
  method text_length = Entry.text_length obj
end

let new_entry ?:max_length ?unit =
  new entry (Entry.create ?:max_length ?unit)

class text obj = object
  inherit [Text.t] editable_skel obj
  method connect = new editable_signals obj
  method set = Text.set ?obj
  method point = Text.get_point obj
  method length = Text.get_length obj
  method freeze = Text.freeze obj
  method thaw = Text.thaw obj
  method insert = Text.insert ?obj
end

let new_text ?:hadjustment ?:vadjustment ?opt =
  new text (Text.create ?:hadjustment ?:vadjustment ?opt)

class ['a] misc obj = object
  inherit ['a] widget_skel obj
  method set_alignment = Misc.set_alignment obj
  method set_padding = Misc.set_padding obj
end

class label obj = object
  inherit [Label.t] misc obj
  method connect = new widget_signals obj
  method set = Label.set ?obj
  method label = Label.get_label obj
end

let new_label :label = new label (Label.create label)

class pixmap obj = object
  inherit [Pixmap.t] misc obj
  method connect = new widget_signals obj
  method set = Pixmap.set ?obj
  method pixmap = Pixmap.pixmap obj
  method mask = Pixmap.mask obj
end

let new_pixmap pix ?:mask = new pixmap (Pixmap.create pix ?:mask)

class progress_bar obj = object
  inherit [ProgressBar.t] widget_skel obj
  method connect = new widget_signals obj
  method update percent = ProgressBar.update obj :percent
  method percent = ProgressBar.percent obj
end

let new_progress_bar () = new progress_bar (ProgressBar.create ())

class separator obj = object
  inherit [Separator.t] widget_skel obj
  method connect = new widget_signals obj
end

let new_separator dir = new separator (Separator.create dir)
