(* $Id$ *)

open Gaux
open Gtk
open GtkBase
open GtkEdit
open OGtkProps
open GObj

class editable_signals obj = object
  inherit widget_signals_impl (obj : [>editable] obj)
  method changed = GtkSignal.connect ~sgn:Editable.Signals.changed obj
  method insert_text =
    GtkSignal.connect ~sgn:Editable.Signals.insert_text obj
  method delete_text =
    GtkSignal.connect ~sgn:Editable.Signals.delete_text obj
end

class editable obj = object
  inherit ['a] widget_impl obj
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
  method selection = Editable.get_selection_bounds obj
end

class entry_signals obj = object
  inherit editable_signals obj
  method activate = GtkSignal.connect ~sgn:Entry.S.activate obj
end

class entry obj = object
  inherit editable obj
  method connect = new entry_signals obj
  inherit entry_props
  method event = new GObj.event_ops obj
  method append_text = Entry.append_text obj
  method prepend_text = Entry.prepend_text obj
  method text_length = Entry.text_length obj
end

let pack_sized ~create pl =
  Widget.size_params pl ~cont:
    (fun pl ?packing ?show () -> pack_return (create pl) ~packing ~show)

let entry =
  Entry.make_params [] ~cont:(
  pack_sized ~create:(fun pl -> new entry (Entry.create pl)))

class spin_button obj = object
  inherit [Gtk.spin_button] widget_impl obj
  method connect = new editable_signals obj
  method event = new event_ops obj
  inherit spin_button_props
  method value_as_int = SpinButton.get_value_as_int obj
  method spin = SpinButton.spin obj
  method update = SpinButton.update obj
end

let spin_button ?adjustment =
  SpinButton.make_params []
    ?adjustment:(may_map ~f:GData.as_adjustment adjustment) ~cont:(
  pack_sized ~create:(fun pl -> new spin_button (SpinButton.create pl)))

class combo obj = object
  inherit [Gtk.combo] widget_impl obj
  inherit combo_props
  method entry = new entry (Combo.entry obj)
  method list = new GList.liste (Combo.list obj)
  method set_popdown_strings = Combo.set_popdown_strings obj
  method disable_activate () = Combo.disable_activate obj
  method set_item_string (item : GList.list_item) =
    Combo.set_item_string obj item#as_item
end

let combo ?popdown_strings =
  Combo.make_params [] ~cont:(
  GContainer.pack_container ~create:(fun pl ->
    let w = Combo.create pl in
    may (Combo.set_popdown_strings w) popdown_strings;
    new combo w))

(*
class text obj = object (self)
  inherit editable (obj : Gtk.text obj) as super
  method get_chars ~start ~stop:e =
    if start < 0 || e > Text.get_length obj || e < start then
      invalid_arg "GEdit.text#get_chars";
    super#get_chars ~start ~stop:e
  method event = new GObj.event_ops obj
  method set_point = Text.set_point obj
  method set_hadjustment adj =
    Text.set_adjustment obj ~horizontal:(GData.as_adjustment adj) ()
  method set_vadjustment adj =
    Text.set_adjustment obj ~vertical:(GData.as_adjustment adj) ()
  method set_word_wrap = Text.set_word_wrap obj
  method set_line_wrap = Text.set_line_wrap obj
  method hadjustment = new GData.adjustment (Text.get_hadjustment obj)
  method vadjustment = new GData.adjustment (Text.get_vadjustment obj)
  method point = Text.get_point obj
  method length = Text.get_length obj
  method freeze () = Text.freeze obj
  method thaw () = Text.thaw obj
  method insert ?font ?foreground ?background text =
    let colormap = try Some self#misc#colormap with _ -> None in
    Text.insert obj text ?font
      ?foreground:(may_map foreground ~f:(GDraw.color ?colormap))
      ?background:(may_map background ~f:(GDraw.color ?colormap))
end

let text ?hadjustment ?vadjustment ?editable
    ?word_wrap ?line_wrap ?width ?height ?packing ?show () =
  let w = Text.create ()
      ?hadjustment:(may_map ~f:GData.as_adjustment hadjustment)
      ?vadjustment:(may_map ~f:GData.as_adjustment vadjustment) in
  may word_wrap ~f:(Text.set_word_wrap w);
  may line_wrap ~f:(Text.set_line_wrap w);
  set_editable w ?editable ?width ?height;
  pack_return (new text w) ~packing ~show
*)
