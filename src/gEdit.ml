(* $Id$ *)

open Gaux
open Gtk
open GtkBase
open GtkEdit
open OgtkEditProps
open GObj

class editable_signals obj = object
  inherit widget_signals_impl (obj : [>editable] obj)
  inherit editable_sigs
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

class entry_signals obj = object (self)
  inherit editable_signals obj
  inherit entry_sigs
  method populate_popup ~callback =
    self#connect Entry.S.populate_popup ~callback:
      (fun m -> callback (new GMenu.menu m))
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

class spin_button_signals obj = object
  inherit entry_signals obj
  inherit spin_button_sigs
end

class spin_button obj = object
  inherit [Gtk.spin_button] widget_impl obj
  method connect = new spin_button_signals obj
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

class combo_box_signals obj = object
  inherit GContainer.container_signals_impl (obj :> Gtk.combo_box Gtk.obj)
  inherit OgtkEditProps.combo_box_sigs
end

class combo_box _obj = object
  inherit [[> Gtk.combo_box]] GContainer.bin_impl _obj
  inherit OgtkEditProps.combo_box_props
  inherit GTree.cell_layout _obj
  method connect = new combo_box_signals obj
  method model =
    new GTree.model (Gobject.get GtkEditProps.ComboBox.P.model obj)
  method set_row_span_column (col : int GTree.column) =
    Gobject.set GtkEdit.ComboBox.P.row_span_column obj col.GTree.index
  method set_column_span_column (col : int GTree.column) =
    Gobject.set GtkEdit.ComboBox.P.column_span_column obj col.GTree.index
  method active_iter =
    GtkEdit.ComboBox.get_active_iter obj
  method set_active_iter =
    GtkEdit.ComboBox.set_active_iter obj
end

let combo_box ~model =
  GtkEdit.ComboBox.make_params [] ~cont:(
  GContainer.pack_container ~create:(fun pl ->
    let w = GtkEdit.ComboBox.create ~model:model#as_model pl in
    new combo_box w))
  
class combo_box_text _obj = object
  inherit combo_box _obj
  val column =
    let model_id = 
      Gobject.get_oid (Gobject.get GtkEdit.ComboBox.P.model _obj) in
    let col_list = new GTree.column_list in
    Hashtbl.add GTree.model_ids model_id col_list#id ;
    { GTree.index = 0 ; GTree.conv = Gobject.Data.string ; 
      GTree.creator = col_list#id }
  method column = column
  method append_text = GtkEdit.ComboBox.append_text obj
  method insert_text = GtkEdit.ComboBox.insert_text obj
  method prepend_text = GtkEdit.ComboBox.prepend_text obj
end

(* convenience functions for simple text-only comboboxes *)
let combo_box_text =
  GtkEdit.ComboBox.make_params [] ~cont:(
  GContainer.pack_container ~create:(fun pl ->
    let w = GtkEdit.ComboBox.new_text () in
    Gobject.set_params w pl ;
    new combo_box_text w))

class combo_box_entry _obj = object (self)
  inherit combo_box _obj
  val text_column =
    let model_id = 
      Gobject.get_oid (Gobject.get GtkEdit.ComboBox.P.model _obj) in
    let col_list_id = Hashtbl.find GTree.model_ids model_id in
    { GTree.index = Gobject.get GtkEdit.ComboBoxEntry.P.text_column _obj ;
      GTree.conv  = Gobject.Data.string ; 
      GTree.creator = col_list_id }
  method text_column = text_column
  method entry = new entry (GtkEdit.Entry.cast self#child#as_widget)
end

let combo_box_entry ~model ~text_column =
  GtkEdit.ComboBox.make_params 
    [ Gobject.param GtkEdit.ComboBox.P.model model#as_model ;
      Gobject.param GtkEdit.ComboBoxEntry.P.text_column text_column.GTree.index ]
    ~cont:(
  GContainer.pack_container ~create:(fun pl ->
    new combo_box_entry (GtkEdit.ComboBoxEntry.create pl)))


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
