(* $Id$ *)

open Gtk

class ['a] gtkobj obj = object
  val obj : 'a obj = obj
  method raw = obj
  method destroy () = Object.destroy obj
end

class widget_ops obj = object
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
  method window = Widget.window obj
  method basic = Widget.basic obj
  method set = Widget.set ?obj
  method disconnect = Signal.disconnect obj
end

class type widgeter = object
  method widget : [widget] obj
end

class ['a] widget_skel obj = object
  inherit ['a] gtkobj obj
  method widget = Widget.coerce obj
  method widget_ops = new widget_ops obj
  method show () = Widget.show obj
end

class event_signal obj = object
  val obj = Widget.coerce obj
  method any = Signal.connect obj sig:Signal.Event.any
  method delete = Signal.connect obj sig:Signal.Event.delete
  method expose = Signal.connect obj sig:Signal.Event.expose
end

class ['a] widget_signals obj = object
  val obj : 'a obj = obj
  method destroy = Signal.connect obj sig:Object.Sig.destroy
  method draw = Signal.connect obj sig:Widget.Sig.draw
  method show = Signal.connect obj sig:Widget.Sig.show
  method event = new event_signal obj
end

class widget obj = object
  inherit [Widget.t] widget_skel obj
  method connect = new widget_signals obj
end

class tooltips obj = object
  inherit [Tooltips.t] gtkobj obj
  method enable () = Tooltips.enable obj
  method disable () = Tooltips.disable obj
  method set_tip : 'b . (#widgeter as 'b) -> _ =
    fun w -> Tooltips.set_tip ?obj ?w#widget
  method set = Tooltips.set ?obj
end

let new_tooltips () = new tooltips (Tooltips.create ())

class ['a] container obj = object
  inherit ['a] widget_skel obj
  method border_width = Container.border_width obj
  method add : 'b . (#widgeter as 'b) -> unit =
    fun w -> Container.add obj w#widget
  method remove : 'b. (#widgeter as 'b) -> unit =
    fun w -> Container.remove obj w#widget
end

class ['a] container_signals obj = object
  inherit ['a] widget_signals obj
  method add = Signal.connect obj sig:Container.Sig.add
  method remove = Signal.connect obj sig:Container.Sig.remove
end

class ['a] box_skel obj = object
  inherit ['a] container obj
  method pack : 'b . (#widgeter as 'b) -> _ = fun w ->  Box.pack obj w#widget
  method set = Box.set ?obj
end

class box obj = object
  inherit [Box.t] box_skel obj
  method connect = new container_signals obj
end

let new_box dir = new box (Box.create dir)

class window obj = object
  inherit [Window.t] container obj
  method connect = new container_signals obj
  method show_all () = Widget.show_all obj
  method set_title = Window.set_title obj
  method set_wmclass = Window.set_wmclass obj
  method set_focus : 'a. (#widgeter as 'a) -> unit =
    fun w -> Window.set_focus obj w#widget
  method set_default : 'a. (#widgeter as 'a) -> unit =
    fun w -> Window.set_default obj w#widget
  method set_policy = Window.set_policy obj
  method activate_focus () = Window.activate_focus obj
  method activate_default () = Window.activate_default obj
end

let new_window dir = new window (Window.create dir)

class ['a] button_signals obj = object
  inherit ['a] widget_signals obj
  method clicked = Signal.connect obj sig:Button.Sig.clicked
end

class ['a] button_skel obj = object
  inherit ['a] container obj
  method clicked = Button.clicked obj
end


class button obj = object
  inherit [Button.t] button_skel obj
  method connect = new button_signals obj
end

let new_button ?:label ?x = new button (Button.create ?:label ?x)

class table obj = object
  inherit [Table.t] container obj
  method connect = new widget_signals obj
  method attach : 'a. (#widgeter as 'a) -> _ =
    fun w -> Table.attach obj w#widget
end

let new_table r c ?:homogeneous =
  new table (Table.create r c ?:homogeneous)

class ['a] editable obj = object
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
  method activate = Signal.connect obj sig:Editable.Sig.activate
  method changed = Signal.connect obj sig:Editable.Sig.changed
end

class entry obj = object
  inherit [Entry.t] editable obj
  method connect = new editable_signals obj
  method append_text = Entry.append_text obj
  method prepend_text = Entry.prepend_text obj
  method set = Entry.set ?obj
  method text = Entry.get_text obj
  method text_length = Entry.text_length obj
end

let new_entry ?:max_length ?unit =
  new entry (Entry.create ?:max_length ?unit)

class ['a] misc obj = object
  inherit ['a] widget_skel obj
  method set_alignment = Misc.set_alignment obj
  method set_padding = Misc.set_padding obj
end

class label obj = object
  inherit [Label.t] misc obj
  method connect = new widget_signals obj
  method set = Label.set ?obj
  method text = Label.text obj
end

let new_label text = new label (Label.create text)

class progress_bar obj = object
  inherit [ProgressBar.t] widget_skel obj
  method connect = new widget_signals obj
  method update percent = ProgressBar.update obj :percent
  method percent = ProgressBar.percent obj
end

let new_progress_bar () = new progress_bar (ProgressBar.create ())
