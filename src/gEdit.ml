(* $Id$ *)

open Misc
open Gtk
open GtkBase
open GtkEdit
open GObj

class editable_signals obj = object
  inherit widget_signals obj
  method activate = GtkSignal.connect sig:Editable.Signals.activate obj
  method changed = GtkSignal.connect sig:Editable.Signals.changed obj
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
  method delete_selection () = Editable.delete_selection obj
  method set_position = Editable.set_position obj
  method position = Editable.get_position obj
  method set_editable = Editable.set_editable obj
  method selection =
    if Editable.has_selection obj then
      Some (Editable.selection_start_pos obj, Editable.selection_end_pos obj)
    else None
end

class pre_entry_wrapper obj = object
  inherit editable obj
  method add_events = Widget.add_events obj
  method set_text = Entry.set_text obj
  method append_text = Entry.append_text obj
  method prepend_text = Entry.prepend_text obj
  method set_visibility = Entry.set_visibility obj
  method set_max_length = Entry.set_max_length obj
  method text = Entry.get_text obj
  method text_length = Entry.text_length obj
end

class entry_wrapper obj = pre_entry_wrapper (Entry.coerce obj)

let set_editable w ?:editable ?:width ?:height =
  may editable fun:(Editable.set_editable w);
  if width <> None || height <> None then Widget.set_size w ?:width ?:height

class entry ?:max_length ?:text ?:visibility ?:editable
    ?:width ?:height ?:packing ?:show =
  let w = Entry.create ?:max_length ?None in
  let () =
    Entry.set w ?:text ?:visibility;
    set_editable w ?:editable ?:width ?:height
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
  method set_adjustment (adj : GData.adjustment) =
    SpinButton.set_adjustment obj adj#as_adjustment
  method set_digits = SpinButton.set_digits obj
  method set_value = SpinButton.set_value obj
  method set_update_policy = SpinButton.set_update_policy obj
  method set_numeric = SpinButton.set_numeric obj
  method set_wrap = SpinButton.set_wrap obj
  method set_shadow_type = SpinButton.set_shadow_type obj
  method set_snap_to_ticks = SpinButton.set_snap_to_ticks obj
end

class spin_button :rate :digits ?:adjustment ?:value ?:update_policy
    ?:numeric ?:wrap ?:shadow_type ?:snap_to_ticks
    ?:width ?:height ?:packing ?:show =
  let w = SpinButton.create :rate :digits
      ?adjustment:(GData.adjustment_option adjustment)
  in
  let () =
    SpinButton.set w ?:value ?:update_policy
      ?:numeric ?:wrap ?:shadow_type ?:snap_to_ticks;
    set_editable w ?:width ?:height
  in
  object (self)
    inherit spin_button_wrapper w
    initializer pack_return :packing ?:show (self :> spin_button_wrapper)
  end

class combo_wrapper obj = object
  inherit GObj.widget_wrapper (obj : Gtk.combo obj)
  method entry = new entry_wrapper (Combo.entry obj)
  method set_popdown_strings = Combo.set_popdown_strings obj
  method set_use_arrows = Combo.set_use_arrows' obj
  method set_case_sensitive = Combo.set_case_sensitive obj
  method set_value_in_list = Combo.set_value_in_list ?obj
  method disable_activate () = Combo.disable_activate obj
end

class combo ?:popdown_strings ?:use_arrows
    ?:case_sensitive ?:value_in_list ?:ok_if_empty
    ?:border_width ?:width ?:height ?:packing ?:show =
  let w = Combo.create () in
  let () =
    Combo.set w ?:popdown_strings ?:use_arrows
      ?:case_sensitive ?:value_in_list ?:ok_if_empty;
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
  method set_hadjustment (adj : GData.adjustment) =
    Text.set_adjustment obj horizontal:(adj#as_adjustment)
  method set_vadjustment (adj : GData.adjustment) =
    Text.set_adjustment obj vertical:(adj#as_adjustment)
  method set_word_wrap = Text.set_word_wrap obj
  method hadjustment = new GData.adjustment_wrapper (Text.get_hadjustment obj)
  method vadjustment = new GData.adjustment_wrapper (Text.get_vadjustment obj)
  method point = Text.get_point obj
  method length = Text.get_length obj
  method freeze () = Text.freeze obj
  method thaw () = Text.thaw obj
  method insert text ?:font ?:foreground ?:background =
    Text.insert obj text ?:font
      ?foreground:(may_map foreground fun:GdkObj.color)
      ?background:(may_map background fun:GdkObj.color)
end

class text ?:hadjustment ?:vadjustment ?:editable
    ?:word_wrap ?:width ?:height ?:packing ?:show =
  let w = Text.create ?None
      ?hadjustment:(GData.adjustment_option hadjustment)
      ?vadjustment:(GData.adjustment_option vadjustment) in
  let () =
    may word_wrap fun:(Text.set_word_wrap w);
    set_editable w ?:editable ?:width ?:height
  in
  object (self)
    inherit text_wrapper w
    initializer pack_return :packing ?:show (self :> text_wrapper)
  end
