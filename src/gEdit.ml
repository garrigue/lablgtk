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
  method set_editable = Editable.set_editable obj
  method editable = Editable.get_editable obj
  method selection = Editable.get_selection_bounds obj
end

class entry_completion_signals obj = object (self)
  inherit [[> `entrycompletion]] GObj.gobject_signals obj
  method action_activated = self#connect EntryCompletion.S.action_activated
  method match_selected ~callback = 
    self#connect EntryCompletion.S.match_selected
      ~callback:(fun _model iter -> callback (new GTree.model _model) iter)
end

class entry_completion obj = object
  method as_entry_completion = (obj :> Gtk.entry_completion)

  method set_minimum_key_length =
    Gobject.set EntryCompletion.P.minimum_key_length obj
  method minimum_key_length =
    Gobject.get EntryCompletion.P.minimum_key_length obj
  method set_model (m : GTree.model) = Gobject.set EntryCompletion.P.model obj m#as_model
  method model = new GTree.model (Gobject.get EntryCompletion.P.model obj)

  method misc = new GObj.gobject_ops obj
  method connect = new entry_completion_signals obj

  method get_entry = may_map (new GObj.widget) (EntryCompletion.get_entry obj)
  method complete () = EntryCompletion.complete obj
  method insert_action_text = EntryCompletion.insert_action_text obj
  method insert_action_markup = EntryCompletion.insert_action_markup obj
  method delete_action = EntryCompletion.delete_action obj
  method set_text_column c = 
    EntryCompletion.set_text_column obj (c : string GTree.column).GTree.index
  method set_match_func =
    EntryCompletion.set_match_func obj

  inherit GTree.cell_layout obj
  val obj = obj
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
  method get_completion = may_map (new entry_completion) (Entry.get_completion obj)
  method set_completion (c : entry_completion) = 
    Entry.set_completion obj c#as_entry_completion
end

let pack_sized ~create pl =
  Widget.size_params pl ~cont:
    (fun pl ?packing ?show () -> pack_return (create pl) ~packing ~show)

let entry =
  Entry.make_params [] ~cont:(
  pack_sized ~create:(fun pl -> new entry (Entry.create pl)))

let entry_completion ?model =
  EntryCompletion.make_params []
    ?model:(may_map (fun m -> m#as_model) model)
    ~cont:(fun pl ?entry () -> 
      let c = new entry_completion (EntryCompletion.create pl) in
      may (fun e -> e#set_completion c) entry ;
      c)

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
    new GTree.model (Gobject.get GtkEdit.ComboBox.P.model obj)
  method set_model (m : GTree.model) =
    Gobject.set GtkEdit.ComboBox.P.model obj m#as_model
  method set_row_span_column (col : int GTree.column) =
    Gobject.set GtkEdit.ComboBox.P.row_span_column obj col.GTree.index
  method set_column_span_column (col : int GTree.column) =
    Gobject.set GtkEdit.ComboBox.P.column_span_column obj col.GTree.index
  method active_iter =
    GtkEdit.ComboBox.get_active_iter obj
  method set_active_iter =
    GtkEdit.ComboBox.set_active_iter obj
end

let combo_box ?model =
  let model = Gaux.may_map (fun m -> m#as_model) model in
  GtkEdit.ComboBox.make_params ?model [] ~cont:(
  GtkBase.Widget.size_params ~cont:(fun pl ?packing ?show () ->
    let c = new combo_box (GtkEdit.ComboBox.create pl) in
    GObj.pack_return c ~packing ~show))

let combo_box_text ?(strings=[]) =
  let (store, column) as model = GTree.store_of_list Gobject.Data.string strings in
  GtkEdit.ComboBox.make_params ~model:store#as_model [] ~cont:(
  GtkBase.Widget.size_params ~cont:(fun pl ?packing ?show () ->
    let combo = new combo_box (GtkEdit.ComboBox.create pl) in
    let r = GTree.cell_renderer_text [] in
    combo#pack r ; 
    combo#add_attribute r "text" column ;
    GObj.pack_return combo ~packing ~show ;
    combo, model))

class combo_box_entry _obj = object (self)
  inherit combo_box _obj
  method text_column = 
    let model_id = 
      Gobject.get_oid (Gobject.get GtkEdit.ComboBox.P.model _obj) in
    let col_list_id = try Hashtbl.find GTree.model_ids model_id 
                      with Not_found -> 0 in
    { GTree.index = Gobject.get GtkEdit.ComboBoxEntry.P.text_column _obj ;
      GTree.conv  = Gobject.Data.string ; 
      GTree.creator = col_list_id }
  method set_text_column (col : string GTree.column) =
    let model_id = 
      Gobject.get_oid (Gobject.get GtkEdit.ComboBox.P.model _obj) in
    begin try
      if Hashtbl.find GTree.model_ids model_id <> col.GTree.creator 
      then invalid_arg "combo_box_entry#set_text_column: bad column"
    with Not_found -> () 
    end ;
    Gobject.set GtkEdit.ComboBoxEntry.P.text_column obj col.GTree.index
  method entry = new entry (GtkEdit.Entry.cast self#child#as_widget)
end

let combo_box_entry ?model ?text_column =
  let model = Gaux.may_map (fun m -> m#as_model) model in
  GtkEdit.ComboBox.make_params ?model
    (Gobject.Property.may_cons GtkEdit.ComboBoxEntry.P.text_column
       (Gaux.may_map (fun c -> c.GTree.index) text_column) []) ~cont:(
  GtkBase.Widget.size_params ~cont:(fun pl ?packing ?show () ->
    GObj.pack_return
      (new combo_box_entry (GtkEdit.ComboBoxEntry.create pl))
      ~packing ~show ))


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
