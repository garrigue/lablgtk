(* $Id$ *)

open Misc
open Gtk
open GtkBase
open GtkEdit
open GObj

class editable_signals obj = object
  inherit widget_signals obj
  method activate = GtkSignal.connect ~sgn:Editable.Signals.activate obj ~after
  method changed = GtkSignal.connect ~sgn:Editable.Signals.changed obj ~after
  method insert_text =
    GtkSignal.connect ~sgn:Editable.Signals.insert_text obj ~after
  method delete_text =
    GtkSignal.connect ~sgn:Editable.Signals.delete_text obj ~after
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
  method delete_selection () = Editable.delete_selection obj
  method set_position = Editable.set_position obj
  method position = Editable.get_position obj
  method set_editable = Editable.set_editable obj
  method selection =
    if Editable.has_selection obj then
      Some (Editable.selection_start_pos obj, Editable.selection_end_pos obj)
    else None
end

class entry obj = object
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

let set_editable ?editable ?(width = -2) ?(height = -2) w =
  may editable ~f:(Editable.set_editable w);
  if width <> -2 || height <> -2 then Widget.set_usize w ~width ~height

let entry ?max_length ?text ?visibility ?editable
    ?width ?height ?packing ?show () =
  let w = Entry.create ?max_length () in
  Entry.set w ?text ?visibility;
  set_editable w ?editable ?width ?height;
  pack_return (new entry w) ~packing ~show

class spin_button obj = object
  inherit entry (obj : Gtk.spin_button obj)
  method adjustment =  new GData.adjustment (SpinButton.get_adjustment obj)
  method value = SpinButton.get_value obj
  method value_as_int = SpinButton.get_value_as_int obj
  method spin = SpinButton.spin obj
  method update = SpinButton.update obj
  method set_adjustment adj =
    SpinButton.set_adjustment obj (GData.as_adjustment adj)
  method set_digits = SpinButton.set_digits obj
  method set_value = SpinButton.set_value obj
  method set_update_policy = SpinButton.set_update_policy obj
  method set_numeric = SpinButton.set_numeric obj
  method set_wrap = SpinButton.set_wrap obj
  method set_shadow_type = SpinButton.set_shadow_type obj
  method set_snap_to_ticks = SpinButton.set_snap_to_ticks obj
end

let spin_button ?adjustment ?rate ?digits ?value ?update_policy
    ?numeric ?wrap ?shadow_type ?snap_to_ticks
    ?width ?height ?packing ?show () =
  let w = SpinButton.create ?rate ?digits
      ?adjustment:(may_map ~f:GData.as_adjustment adjustment) () in
  SpinButton.set w ?value ?update_policy
    ?numeric ?wrap ?shadow_type ?snap_to_ticks;
  set_editable w ?width ?height;
  pack_return (new spin_button w) ~packing ~show

class combo obj = object
  inherit GObj.widget (obj : Gtk.combo obj)
  method entry = new entry (Combo.entry obj)
  method set_popdown_strings = Combo.set_popdown_strings obj
  method set_use_arrows = Combo.set_use_arrows' obj
  method set_case_sensitive = Combo.set_case_sensitive obj
  method set_value_in_list = Combo.set_value_in_list obj
  method disable_activate () = Combo.disable_activate obj
end

let combo ?popdown_strings ?use_arrows
    ?case_sensitive ?value_in_list ?ok_if_empty
    ?border_width ?width ?height ?packing ?show () =
  let w = Combo.create () in
  Combo.set w ?popdown_strings ?use_arrows
    ?case_sensitive ?value_in_list ?ok_if_empty;
  Container.set w ?border_width ?width ?height;
  pack_return (new combo w) ~packing ~show

class text obj = object
  inherit editable (obj : Gtk.text obj) as super
  method get_chars ~start ~stop:e =
    if start < 0 || e > Text.get_length obj || e < start then
      invalid_arg "GEdit.text#get_chars";
    super#get_chars ~start ~stop:e
  method add_events = Widget.add_events obj
  method set_point = Text.set_point obj
  method set_hadjustment adj =
    Text.set_adjustment obj ~horizontal:(GData.as_adjustment adj) ()
  method set_vadjustment adj =
    Text.set_adjustment obj ~vertical:(GData.as_adjustment adj) ()
  method set_word_wrap = Text.set_word_wrap obj
  method hadjustment = new GData.adjustment (Text.get_hadjustment obj)
  method vadjustment = new GData.adjustment (Text.get_vadjustment obj)
  method point = Text.get_point obj
  method length = Text.get_length obj
  method freeze () = Text.freeze obj
  method thaw () = Text.thaw obj
  method insert ?font ?foreground ?background text =
    Text.insert obj text ?font
      ?foreground:(may_map foreground ~f:GdkObj.color)
      ?background:(may_map background ~f:GdkObj.color)
end

let text ?hadjustment ?vadjustment ?editable
    ?word_wrap ?width ?height ?packing ?show () =
  let w = Text.create ()
      ?hadjustment:(may_map ~f:GData.as_adjustment hadjustment)
      ?vadjustment:(may_map ~f:GData.as_adjustment vadjustment) in
  may word_wrap ~f:(Text.set_word_wrap w);
  set_editable w ?editable ?width ?height;
  pack_return (new text w) ~packing ~show
