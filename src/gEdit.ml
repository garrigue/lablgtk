(* $Id$ *)

open Misc
open Gtk
open GtkBase
open GtkEdit
open GObj

class editable_signals obj ?:after = object
  inherit widget_signals obj ?:after
  method activate = GtkSignal.connect sig:Editable.Signals.activate obj ?:after
  method changed = GtkSignal.connect sig:Editable.Signals.changed obj ?:after
end

class editable obj = object
  inherit widget obj
  method connect = new editable_signals ?obj
  method select_region = Editable.select_region obj
  method insert_text = Editable.insert_text obj
  method delete_text = Editable.delete_text obj
  method get_chars = Editable.get_chars obj
  method cut_clipboard () = Editable.cut_clipboard obj
  method copy_clipboard () = Editable.copy_clipboard obj
  method paste_clipboard () = Editable.paste_clipboard obj
end

class entry_wrapper obj = object
  inherit editable (Entry.coerce obj) 
  method add_events = Widget.add_events obj
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

class entry ?:max_length ?:text ?:position
    ?:visibility ?:editable ?:packing ?:show =
  let w = Entry.create ?:max_length ?None in
  let () =
    Entry.setter w cont:null_cont ?:text ?:position ?:visibility ?:editable in
  object (self)
    inherit entry_wrapper w
    initializer pack_return :packing ?:show (self :> entry_wrapper)
  end

class spin_button_wrapper myobj = object
  inherit entry_wrapper myobj
  val obj : Gtk.spin_button obj = myobj
  method get_adjustment =
    new GData.adjustment_wrapper (SpinButton.get_adjustment obj)
  method get_value = SpinButton.get_value obj
  method get_value_as_int = SpinButton.get_value_as_int obj
  method spin = SpinButton.spin obj
  method update = SpinButton.update obj
  method set ?:adjustment =
    SpinButton.setter ?obj ?cont:null_cont
      ?adjustment:(may_map adjustment fun:GData.adjustment_obj)
end

class spin_button :rate :digits ?:adjustment ?:value ?:update_policy
    ?:numeric ?:wrap ?:shadow_type ?:snap_to_ticks ?:packing ?:show =
  let w = SpinButton.create :rate :digits ?adjustment:
      (may_map adjustment fun:GData.adjustment_obj)
  in
  let () =
    SpinButton.setter w cont:null_cont ?:value ?:update_policy
      ?:numeric ?:wrap ?:shadow_type ?:snap_to_ticks
  in
  object (self)
    inherit spin_button_wrapper w
    initializer pack_return :packing ?:show (self :> spin_button_wrapper)
  end

class combo_wrapper obj = object
  inherit GPack.box_skel (obj : Gtk.combo obj)
  method connect = new GContainer.container_signals ?obj
  method entry = new entry_wrapper (Combo.entry obj)
  method set_value_in_list = Combo.set_value_in_list obj
  method set_use_arrows = Combo.set_use_arrows obj
  method set_use_arrows_always = Combo.set_use_arrows_always obj
  method set_case_sensitive = Combo.set_case_sensitive obj
  method set_popdown_strings = Combo.set_popdown_strings obj
  method disable_activate () = Combo.disable_activate obj
end

class combo ?:popdown_strings ?:use_arrows ?:use_arrows_always
    ?:case_sensitive ?:border_width ?:width ?:height ?:packing ?:show =
  let w = Combo.create () in
  let () =
    Combo.setter w cont:null_cont ?:popdown_strings ?:use_arrows
      ?:use_arrows_always ?:case_sensitive;
    Container.setter w cont:null_cont ?:border_width ?:width ?:height
  in
  object (self)
    inherit combo_wrapper w
    initializer pack_return :packing ?:show (self :> combo_wrapper)
  end

class text_wrapper obj = object
  inherit editable (obj : Gtk.text obj)
  method add_events = Widget.add_events obj
  method set_editable = Text.set_editable obj
  method set_point = Text.set_point obj
  method set_word_wrap = Text.set_word_wrap obj
  method set_adjustment ?:horizontal ?:vertical =
    Text.set_adjustment obj
      ?horizontal:(may_map horizontal fun:GData.adjustment_obj)
      ?vertical:(may_map vertical fun:GData.adjustment_obj)
  method hadjustment = new GData.adjustment_wrapper (Text.get_hadjustment obj)
  method vadjustment = new GData.adjustment_wrapper (Text.get_vadjustment obj)
  method point = Text.get_point obj
  method length = Text.get_length obj
  method freeze () = Text.freeze obj
  method thaw () = Text.thaw obj
  method insert = Text.insert ?obj
end

class text ?:hadjustment ?:vadjustment ?:editable
    ?:word_wrap ?:point ?:packing ?:show =
  let w = Text.create ?None
      ?hadjustment:(may_map hadjustment fun:GData.adjustment_obj)
      ?vadjustment:(may_map vadjustment fun:GData.adjustment_obj) in
  let () = Text.setter w cont:null_cont ?:editable ?:word_wrap ?:point in
  object (self)
    inherit text_wrapper w
    initializer pack_return :packing ?:show (self :> text_wrapper)
  end
