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

class pre_entry_wrapper obj = object
  inherit editable obj
  method add_events = Widget.add_events obj
  method set_text = Entry.set_text obj
  method set_position = Entry.set_position obj
  method append_text = Entry.append_text obj
  method prepend_text = Entry.prepend_text obj
  method set_entry = Entry.setter ?obj ?cont:null_cont ?text:None
  method text = Entry.get_text obj
  method text_length = Entry.text_length obj
end

class entry_wrapper obj = pre_entry_wrapper (Entry.coerce obj)

class entry ?:max_length ?:text ?:visibility ?:editable
    ?:width ?:height ?:packing ?:show =
  let w = Entry.create ?:max_length ?None in
  let () =
    Entry.setter w cont:null_cont ?:text ?:visibility ?:editable;
    Widget.set_size w ?:width ?:height
  in
  object (self)
    inherit entry_wrapper w
    initializer pack_return :packing ?:show (self :> entry_wrapper)
  end

class spin_button_wrapper obj = object
  inherit pre_entry_wrapper (obj : spin_button obj)
  method adjustment =
    new GData.adjustment_wrapper (SpinButton.get_adjustment obj)
  method value = SpinButton.get_value obj
  method value_as_int = SpinButton.get_value_as_int obj
  method spin = SpinButton.spin obj
  method update = SpinButton.update obj
  method set_spin ?:adjustment =
    SpinButton.setter ?obj ?cont:null_cont ?value:None
      ?adjustment:(GData.adjustment_option adjustment)
  method set_value = SpinButton.set_value obj
end

class spin_button :rate :digits ?:adjustment ?:value ?:update_policy
    ?:numeric ?:wrap ?:shadow_type ?:snap_to_ticks
    ?:width ?:height ?:packing ?:show =
  let w = SpinButton.create :rate :digits
      ?adjustment:(GData.adjustment_option adjustment)
  in
  let () =
    SpinButton.setter w cont:null_cont ?:value ?:update_policy
      ?:numeric ?:wrap ?:shadow_type ?:snap_to_ticks;
    Widget.set_size w ?:width ?:height
  in
  object (self)
    inherit spin_button_wrapper w
    initializer pack_return :packing ?:show (self :> spin_button_wrapper)
  end

class combo_wrapper obj = object
  inherit GContainer.container_wrapper (obj : Gtk.combo obj)
  method entry = new entry_wrapper (Combo.entry obj)
  method set_combo = Combo.setter ?obj ?cont:null_cont
  method disable_activate () = Combo.disable_activate obj
end

class combo ?:popdown_strings ?:use_arrows ?:use_arrows_always
    ?:case_sensitive ?:value_in_list ?:ok_if_empty
    ?:border_width ?:width ?:height ?:packing ?:show =
  let w = Combo.create () in
  let () =
    Combo.setter w cont:null_cont ?:popdown_strings ?:use_arrows
      ?:use_arrows_always ?:case_sensitive ?:value_in_list ?:ok_if_empty;
    Container.set w ?:border_width ?:width ?:height
  in
  object (self)
    inherit combo_wrapper w
    initializer pack_return :packing ?:show (self :> combo_wrapper)
  end

class text_wrapper obj = object
  inherit editable (obj : Gtk.text obj)
  method add_events = Widget.add_events obj
  method set_point = Text.set_point obj
  method set_text ?:hadjustment ?:vadjustment =
    Text.setter ?obj ?cont:null_cont
      ?hadjustment:(GData.adjustment_option hadjustment)
      ?vadjustment:(GData.adjustment_option vadjustment)
  method hadjustment = new GData.adjustment_wrapper (Text.get_hadjustment obj)
  method vadjustment = new GData.adjustment_wrapper (Text.get_vadjustment obj)
  method point = Text.get_point obj
  method length = Text.get_length obj
  method freeze () = Text.freeze obj
  method thaw () = Text.thaw obj
  method insert = Text.insert ?obj
end

class text ?:hadjustment ?:vadjustment ?:editable
    ?:word_wrap ?:width ?:height ?:packing ?:show =
  let w = Text.create ?None
      ?hadjustment:(GData.adjustment_option hadjustment)
      ?vadjustment:(GData.adjustment_option vadjustment) in
  let () =
    Text.setter w cont:null_cont ?:editable ?:word_wrap;
    Widget.set_size w ?:width ?:height
  in
  object (self)
    inherit text_wrapper w
    initializer pack_return :packing ?:show (self :> text_wrapper)
  end
