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

class data_signals obj = object
  inherit gtkobj_signals obj
  method disconnect = Signal.connect sig:Data.Signals.disconnect obj
end

class adjustment_signals obj = object
  inherit data_signals obj
  method changed = Signal.connect sig:Adjustment.Signals.changed obj
  method value_changed =
    Signal.connect sig:Adjustment.Signals.value_changed obj
end

class adjustment obj = object
  inherit gtkobj obj
  method as_adjustment : Adjustment.t obj = obj
  method connect = new adjustment_signals obj
  method set_value = Adjustment.set_value obj
  method clamp_page = Adjustment.clamp_page obj
  method value = Adjustment.get_value obj
end

let new_adjustment :value :lower :upper :step_incr :page_incr :page_size =
  new adjustment
    (Adjustment.create :value :lower :upper :step_incr :page_incr :page_size)

class type has_frame = object method frame : Widget.t obj end
class type is_widget = object method as_widget : Widget.t obj end

class tooltips obj = object
  inherit gtkobj obj
  method connect = new data_signals obj
  method enable () = Tooltips.enable obj
  method disable () = Tooltips.disable obj
  method set_tip : 'b . (#is_widget as 'b) -> _ =
    fun w -> Tooltips.set_tip ?obj ?w#as_widget
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
  method draw = Widget.draw obj
  method event : 'a. 'a Gdk.event -> unit = Widget.event obj
  method activate () = Widget.activate obj
  method reparent : 'a. (#is_widget as 'a) -> unit =
    fun w -> Widget.reparent obj w#as_widget
  method popup = Widget.popup obj
  method intersect = Widget.intersect obj
  method grab_focus () = Widget.grab_focus obj
  method grab_default () = Widget.grab_default obj
  method is_ancestor : 'a. (#is_widget as 'a) -> bool =
    fun w -> Widget.is_ancestor obj w#as_widget
  method add_accelerator = Widget.add_accelerator obj
  method remove_accelerator = Widget.remove_accelerator obj
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

class widget obj = object (self)
  inherit gtkobj obj
  method frame = Widget.coerce obj
  method as_widget = Widget.coerce obj
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
  method add : 'b . (#has_frame as 'b) -> unit =
    fun w -> Container.add obj w#frame
  method remove : 'b. (#has_frame as 'b) -> unit =
    fun w -> Container.remove obj w#frame
  method children = List.map fun:(new widget) (Container.children obj)
  method set_size ?:border = Container.set ?obj ?border_width:border
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

let pack_return wrapper w ?:packing =
  let w = wrapper w in
  may packing fun:(fun f -> (f w : unit));
  w

class event_box = container_full

let new_event_box () =
  Container.setter ?(EventBox.create ()) ?cont:(pack_return (new event_box))

class frame obj = object
  inherit container_full obj
  method set_label ?label ?:xalign ?:yalign =
    Frame.setter obj ?:label ?label_xalign:xalign ?label_yalign:yalign
      cont:null_cont
  method set_shadow_type = Frame.set_shadow_type obj
end

class frame_create ?:label ?opt = frame (Frame.create ?:label ?opt) 

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

class type ['a] is_item = object
  method as_item : 'a obj
end

class item_signals obj = object
  inherit container_signals obj
  method select = Signal.connect sig:Item.Signals.select obj
  method deselect = Signal.connect sig:Item.Signals.deselect obj
  method toggle = Signal.connect sig:Item.Signals.toggle obj
end

class list_item obj = object
  inherit container obj
  method as_item : ListItem.t obj = obj
  method select () = Item.select obj
  method deselect () = Item.deselect obj
  method toggle () = Item.toggle obj
  method connect = new item_signals obj
end

let new_list_item ?opt ?:label =
  Container.setter ?(ListItem.create ?opt ?:label)
    ?cont:(pack_return (new list_item))

class type is_menu = object
  method as_menu : Menu.t obj
end

class menu_item_skel obj = object
  inherit container obj
  method as_item = MenuItem.coerce obj
  method set_submenu : 'a. (#is_menu as 'a) -> unit =
    fun w -> MenuItem.set_submenu obj w#as_menu
  method remove_submenu () = MenuItem.remove_submenu obj
  method configure = MenuItem.configure obj
  method activate () = MenuItem.activate obj
  method right_justify () = MenuItem.right_justify obj
  method add_accelerator =
    Widget.add_accelerator obj sig:MenuItem.Signals.activate
end

class menu_item_signals obj = object
  inherit item_signals obj
  method activate = Signal.connect sig:MenuItem.Signals.activate obj
end

class menu_item obj = object
  inherit menu_item_skel obj
  method connect = new menu_item_signals obj
end

let new_menu_item ?opt ?:label =
  Container.setter ?(MenuItem.create ?opt ?:label)
    ?cont:(pack_return (new menu_item))

class check_menu_item_signals obj = object
  inherit menu_item_signals obj
  method toggled = Signal.connect sig:CheckMenuItem.Signals.toggled obj
end

class check_menu_item obj = object
  inherit menu_item_skel obj
  method set_active = CheckMenuItem.set_active obj
  method set_show_toggle = CheckMenuItem.set_show_toggle obj
  method active = CheckMenuItem.get_active obj
  method toggled () = CheckMenuItem.toggled obj
  method connect = new check_menu_item_signals obj
end

let new_check_menu_item ?opt ?:label =
  CheckMenuItem.setter ?(CheckMenuItem.create ?opt ?:label)
    ?cont:(Container.setter ?cont:(pack_return (new check_menu_item)))

class radio_menu_item obj = object
  inherit check_menu_item obj
  method group = RadioMenuItem.group obj
  method set_group = RadioMenuItem.set_group obj
end

let new_radio_menu_item ?opt ?:group ?:label =
  CheckMenuItem.setter ?(RadioMenuItem.create ?opt ?:group ?:label)
    ?cont:(Container.setter ?cont:(pack_return (new radio_menu_item)))

class tree_item_signals obj = object
  inherit item_signals obj
  method expand = Signal.connect obj sig:TreeItem.Signals.expand
  method collapse = Signal.connect obj sig:TreeItem.Signals.collapse
end

class type is_tree = object
  method as_tree : Tree.t obj
end

class tree_item obj = object
  inherit container obj
  method as_item : TreeItem.t obj = obj
  method connect = new tree_item_signals obj
  method set_subtree : 'a. (#is_tree as 'a) -> unit =
    fun w -> TreeItem.set_subtree obj w#as_tree
  method remove_subtree () = TreeItem.remove_subtree obj
  method expand () = TreeItem.expand obj
  method collapse () = TreeItem.collapse obj
end

let new_tree_item ?opt ?:label =
  Container.setter ?(TreeItem.create ?opt ?:label)
    ?cont:(pack_return (new tree_item))

class box obj = object
  inherit container_full obj
  method pack : 'b . (#has_frame as 'b) -> _ =
    fun w ->  Box.pack ?obj ?w#frame
  method set_packing = Box.setter ?obj ?cont:null_cont
  method set_child_packing : 'b . (#has_frame as 'b) -> _ =
    fun w -> Box.set_child_packing ?obj ?w#frame
end

class box_create dir ?:homogeneous ?:spacing =
  box (Box.create dir ?:homogeneous ?:spacing)

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
  method add_accel_group = Window.add_accel_group obj
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
  method clicked () = Button.clicked obj
  method grab_default () =
    Widget.set_can_default obj true;
    Widget.grab_default obj
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
  method active = ToggleButton.get_active obj
  method set_active = ToggleButton.set_active obj
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
  method set_group = RadioButton.set_group obj
  method group = RadioButton.group obj
end
  
let new_radio_button ?opt ?:group ?:label =
  RadioButton.setter ?(RadioButton.create ?:group ?:label ?opt)
    ?cont:(ToggleButton.setter
	     ?cont:(Container.setter ?cont:(pack_return (new radio_button))))

class file_selection obj = object
  inherit window obj
  method set_filename = FileSelection.set_filename obj
  method get_filename = FileSelection.get_filename obj
  method show_fileop_buttons () = FileSelection.show_fileop_buttons obj
  method hide_fileop_buttons () = FileSelection.hide_fileop_buttons obj
  method ok_button = new button (FileSelection.get_ok_button obj)
  method cancel_button = new button (FileSelection.get_cancel_button obj)
  method help_button = new button (FileSelection.get_help_button obj)
end

let new_file_selection :title =
  FileSelection.setter ?(FileSelection.create title)
    ?cont:(Window.setter
	     ?cont:(Container.setter ?cont:(new file_selection)))

class fixed obj = object
  inherit container obj
  method connect = new container_signals obj
  method put : 'a. (#has_frame as 'a) -> _ = fun w -> Fixed.put obj w#frame
  method move : 'a. (#has_frame as 'a) -> _ = fun w -> Fixed.move obj w#frame
end

let new_fixed  ?(_ : unit option) =
  Container.setter ?(Fixed.create ()) ?cont:(pack_return (new fixed))

class menu_shell_signals obj = object
  inherit container_signals obj
  method deactivate = Signal.connect sig:MenuShell.Signals.deactivate obj
end

class menu_shell obj = object
  inherit widget obj
  method remove : 'b. (MenuItem.t #is_item as 'b) -> unit =
    fun w -> Container.remove obj w#as_item
  method children =
    List.map (Container.children obj)
      fun:(fun w -> new widget (MenuItem.cast w))
  method set_size ?:border = Container.set ?obj ?border_width:border
  method append : 'a. (MenuItem.t #is_item as 'a) -> unit =
    fun w -> MenuShell.append obj w#as_item
  method prepend : 'a. (MenuItem.t #is_item as 'a) -> unit =
    fun w -> MenuShell.prepend obj w#as_item
  method insert : 'a. (MenuItem.t #is_item as 'a) -> _ =
    fun w -> MenuShell.insert obj w#as_item
  method deactivate () = MenuShell.deactivate obj
  method connect = new menu_shell_signals obj
end

class menu obj = object
  inherit menu_shell obj
  method popup = Menu.popup obj
  method popdown () = Menu.popdown obj
  method as_menu : Menu.t obj = obj
end

let new_menu ?(_ : unit option) =
  Container.setter ?(Menu.create ()) ?cont:(pack_return (new menu))

class option_menu obj = object
  inherit button obj
  method set_menu (menu : menu) = OptionMenu.set_menu obj menu#as_menu
  method get_menu = new menu (OptionMenu.get_menu obj)
  method remove_menu () = OptionMenu.remove_menu obj
  method set_history = OptionMenu.set_history obj
end

let new_option_menu ?(_ : unit option) =
  Container.setter ?(OptionMenu.create ())
    ?cont:(pack_return (new option_menu))

class menu_bar = menu_shell

let new_menu_bar ?(_ : unit option) =
  Container.setter ?(MenuBar.create ()) ?cont:(pack_return (new menu_bar))

class scrolled_window obj = object
  inherit container_full obj
  method hadjustment = new adjustment (ScrolledWindow.get_hadjustment obj)
  method vadjustment = new adjustment (ScrolledWindow.get_vadjustment obj)
  method set_policy ?:horizontal ?:vertical =
    ScrolledWindow.setter obj cont:null_cont
      ?hscrollbar_policy:horizontal ?vscrollbar_policy:vertical
  method add_with_viewport : 'a. (#has_frame as 'a) -> _ =
    fun w -> ScrolledWindow.add_with_viewport obj w#frame
end

let new_scrolled_window () =
  ScrolledWindow.setter ?(ScrolledWindow.create ())
    ?cont:(Container.setter ?cont:(pack_return (new scrolled_window)))

class table obj = object
  inherit container_full obj
  method attach : 'a. (#has_frame as 'a) -> _ =
    fun w -> Table.attach obj w#frame
  method set_packing = Table.setter ?obj ?cont:null_cont
end

let new_table :rows :columns ?:homogeneous =
  Table.setter ?(Table.create :rows :columns ?:homogeneous) ?homogeneous:None
    ?cont:(Container.setter ?cont:(pack_return (new table)))

class drawing_area obj = object
  inherit widget_full obj
  method set_size = DrawingArea.size obj
end

let new_drawing_area ?(_ : unit option) ?:width [< 0 >] ?:height [< 0 >] =
  let w = DrawingArea.create () in
  if width <> 0 || height <> 0 then DrawingArea.size w :width :height;
  pack_return ?(new drawing_area) ?w

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
  method cut_clipboard () = Editable.cut_clipboard obj
  method copy_clipboard () = Editable.copy_clipboard obj
  method paste_clipboard () = Editable.paste_clipboard obj
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

class combo obj = object
  val combo = obj
  inherit entry (Combo.entry obj)
  method frame = Widget.coerce combo
  method set_value_in_list = Combo.set_value_in_list combo
  method set_use_arrows = Combo.set_use_arrows combo
  method set_use_arrows_always = Combo.set_use_arrows_always combo
  method set_case_sensitive = Combo.set_case_sensitive combo
  method set_popdown_strings = Combo.set_popdown_strings combo
  method disable_activate () = Combo.disable_activate combo
end

let new_combo ?(_ : unit option) =
  Combo.setter ?(Combo.create ())
    ?cont:(Container.setter ?cont:(pack_return (new combo)))

class text obj = object
  inherit editable obj
  method set_editable = Text.set_editable obj
  method set_point = Text.set_point obj
  method set_word_wrap = Text.set_word_wrap obj
  method set_adjustment ?:horizontal ?:vertical =
    Text.set_adjustment obj
      ?horizontal:(may_map horizontal
		     fun:(fun (x : adjustment) -> x#as_adjustment))
      ?vertical:(may_map vertical
		     fun:(fun (x : adjustment) -> x#as_adjustment))
  method point = Text.get_point obj
  method length = Text.get_length obj
  method freeze () = Text.freeze obj
  method thaw () = Text.thaw obj
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
  method set_text = Label.set_text obj
  method set_justify = Label.set_justify obj
  method text = Label.get_text obj
end

let new_label ?:text [< "" >] =
  Label.setter ?(Label.create text) ?text:None
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
  method percentage = Progress.get_percentage obj
end

let new_progress_bar ?(_ : unit option) =
  pack_return ?(new progress_bar) ?(ProgressBar.create ())

class range obj = object
  inherit widget_full obj
  method adjustment = new adjustment (Range.get_adjustment obj)
  method set_adjustment (adj : adjustment) =
    Range.set_adjustment obj adj#as_adjustment
  method set_update_policy = Range.set_update_policy obj
end

class scrollbar = range

let new_scrollbar dir ?:adjustment ?:update_policy =
  let w = Scrollbar.create dir ?:adjustment in
  may update_policy fun:(Range.set_update_policy w);
  pack_return ?(new scrollbar) ?w

class separator = widget_full

let new_separator dir =
  pack_return ?(new separator) ?(Separator.create dir)

module Main : sig
  val locale : string
  val argv : string array
  val main : unit -> unit
  val quit : unit -> unit
  val version : int * int * int
end = Main

module Grab = struct
  open Grab
  let add (w : #is_widget) = add w#as_widget
  let remove (w : #is_widget) = remove w#as_widget
  let get_current () = new widget_full (get_current ())
end

module Timeout : sig
  type id
  val add : int -> callback:(unit -> bool) -> id
  val remove : id -> unit
end = Timeout
