(* $Id$ *)

open Misc
open Gtk
open Tags
open GtkBase

module Editable = struct
  let cast w : editable obj =
    if Object.is_a w "GtkEditable" then Obj.magic w
    else invalid_arg "Gtk.Editable.cast"
  external coerce : [> editable] obj -> editable obj = "%identity"
  external select_region : [> editable] obj -> start:int -> end:int -> unit
      = "ml_gtk_editable_select_region"
  external insert_text : [> editable] obj -> string -> pos:int -> int
      = "ml_gtk_editable_select_region"
  let insert_text w s ?:pos [< -1 >] = insert_text w s :pos
  external delete_text : [> editable] obj -> start:int -> end:int -> unit
      = "ml_gtk_editable_delete_text"
  external get_chars : [> editable] obj -> start:int -> end:int -> string
      = "ml_gtk_editable_get_chars"
  external cut_clipboard : [> editable] obj -> unit
      = "ml_gtk_editable_cut_clipboard"
  external copy_clipboard : [> editable] obj -> unit
      = "ml_gtk_editable_copy_clipboard"
  external paste_clipboard : [> editable] obj -> unit
      = "ml_gtk_editable_paste_clipboard"
  external claim_selection :
      [> editable] obj -> claim:bool -> time:int -> unit
      = "ml_gtk_editable_claim_selection"
  external delete_selection : [> editable] obj -> unit
      = "ml_gtk_editable_delete_selection"
  external changed : [> editable] obj -> unit = "ml_gtk_editable_changed"
  module Signals = struct
    open GtkSignal
    let activate : ([> editable],_) t =
      { name = "activate"; marshaller = marshal_unit }
    let changed : ([> editable],_) t =
      { name = "changed"; marshaller = marshal_unit }
  end
end

module Entry = struct
  let cast w : entry obj =
    if Object.is_a w "GtkEntry" then Obj.magic w
    else invalid_arg "Gtk.Entry.cast"
  external coerce : [> entry] obj -> entry obj = "%identity"
  external create : unit -> entry obj = "ml_gtk_entry_new"
  external create_with_max_length : int -> entry obj
      = "ml_gtk_entry_new_with_max_length"
  let create ?:max_length ?(_ : unit option) =
    match max_length with None -> create ()
    | Some len -> create_with_max_length len
  external set_text : [> entry] obj -> string -> unit
      = "ml_gtk_entry_set_text"
  external append_text : [> entry] obj -> string -> unit
      = "ml_gtk_entry_append_text"
  external prepend_text : [> entry] obj -> string -> unit
      = "ml_gtk_entry_prepend_text"
  external set_position : [> entry] obj -> int -> unit
      = "ml_gtk_entry_set_position"
  external get_text : [> entry] obj -> string = "ml_gtk_entry_get_text"
  external set_visibility : [> entry] obj -> bool -> unit
      = "ml_gtk_entry_set_visibility"
  external set_editable : [> entry] obj -> bool -> unit
      = "ml_gtk_entry_set_editable"
  external set_max_length : [> entry] obj -> int -> unit
      = "ml_gtk_entry_set_max_length"
  let setter w :cont ?:text ?:position ?:visibility ?:editable ?:max_length =
    let may_set f = may fun:(f w) in
    may_set set_text text;
    may_set set_position position;
    may_set set_visibility visibility;
    may_set set_editable editable;
    may_set set_max_length max_length;
    cont w
  let set = setter ?cont:null_cont
  external text_length : [> entry] obj -> int
      = "ml_GtkEntry_text_length"
end

module SpinButton = struct
  let cast w : spin_button obj =
    if Object.is_a w "GtkSpinButton" then Obj.magic w
    else invalid_arg "Gtk.SpinButton.cast"
  external create :
      [> adjustment] optobj -> rate:float -> digits:int -> spin_button obj
      = "ml_gtk_spin_button_new"
  let create ?:adjustment = create (optboxed adjustment)
  external configure :
    [> spinbutton] obj -> adjustment:[> adjustment] optobj ->
    rate:float -> digits:int -> unit
    = "ml_gtk_spin_button_configure"
  let configure w ?:adjustment = configure w adjustment:(optboxed adjustment)
  external set_adjustment : [> spinbutton] obj -> [> adjustment] obj -> unit
      = "ml_gtk_spin_button_set_adjustment"
  external get_adjustment : [> spinbutton] obj -> adjustment obj
      = "ml_gtk_spin_button_get_adjustment"
  external set_digits : [> spinbutton] obj -> int -> unit
      = "ml_gtk_spin_button_set_digits"
  external get_value : [> spinbutton] obj -> float
      = "ml_gtk_spin_button_get_value_as_float"
  let get_value_as_int w = floor (get_value w +. 0.5)
  external set_value : [> spinbutton] obj -> float -> unit
      = "ml_gtk_spin_button_set_value"
  external set_update_policy : [> spinbutton] obj -> update_policy -> unit
      = "ml_gtk_spin_button_set_update_policy"
  external set_numeric : [> spinbutton] obj -> bool -> unit
      = "ml_gtk_spin_button_set_numeric"
  external spin : [> spinbutton] obj -> [UP DOWN] -> step:float -> unit
      = "ml_gtk_spin_button_spin"
  external set_wrap : [> spinbutton] obj -> bool -> unit
      = "ml_gtk_spin_button_set_wrap"
  external set_shadow_type : [> spinbutton] obj -> shadow_type -> unit
      = "ml_gtk_spin_button_set_shadow_type"
  external set_snap_to_ticks : [> spinbutton] obj -> bool -> unit
      = "ml_gtk_spin_button_set_snap_to_ticks"
  external update : [> spinbutton] obj -> unit
      = "ml_gtk_spin_button_update"
  let setter w :cont ?:adjustment ?:digits ?:value ?:update_policy
      ?:numeric ?:wrap ?:shadow_type ?:snap_to_ticks =
    let may_set f = may fun:(f w) in
    may_set set_adjustment adjustment;
    may_set set_digits digits;
    may_set set_value value;
    may_set set_update_policy update_policy;
    may_set set_numeric numeric;
    may_set set_wrap wrap;
    may_set set_shadow_type shadow_type;
    may_set set_snap_to_ticks snap_to_ticks;
    cont w
end

module Text = struct
  let cast w : text obj =
    if Object.is_a w "GtkText" then Obj.magic w
    else invalid_arg "Gtk.Text.cast"
  external create : [> adjustment] optobj -> [> adjustment] optobj -> text obj
      = "ml_gtk_text_new"
  let create ?:hadjustment ?:vadjustment ?(_ : unit option) =
    create (optboxed hadjustment) (optboxed vadjustment)
  external set_editable : [> text] obj -> bool -> unit
      = "ml_gtk_text_set_editable"
  external set_word_wrap : [> text] obj -> bool -> unit
      = "ml_gtk_text_set_word_wrap"
  external set_adjustment :
      [> text] obj -> ?horizontal:[> adjustment] obj ->
      ?vertical:[> adjustment] obj -> unit
      = "ml_gtk_text_set_adjustments"
  external get_hadjustment : [> text] obj -> adjustment obj
      = "ml_gtk_text_get_hadj"
  external get_vadjustment : [> text] obj -> adjustment obj
      = "ml_gtk_text_get_vadj"
  external set_point : [> text] obj -> int -> unit
      = "ml_gtk_text_set_point"
  external get_point : [> text] obj -> int = "ml_gtk_text_get_point"
  external get_length : [> text] obj -> int = "ml_gtk_text_get_length"
  external freeze : [> text] obj -> unit = "ml_gtk_text_freeze"
  external thaw : [> text] obj -> unit = "ml_gtk_text_thaw"
  external insert :
      [> text] obj -> ?font:Gdk.font -> ?foreground:Gdk.Color.t ->
      ?background:Gdk.Color.t -> string -> unit
      = "ml_gtk_text_insert"
  let setter w :cont ?:editable ?:word_wrap ?:point =
    may editable fun:(set_editable w);
    may word_wrap fun:(set_word_wrap w);
    may point fun:(set_point w);
    cont w
end

module Combo = struct
  let cast w : combo obj =
    if Object.is_a w "GtkCombo" then Obj.magic w
    else invalid_arg "Gtk.Combo.cast"
  external create : unit -> combo obj = "ml_gtk_combo_new"
  external set_value_in_list :
      [> combo] obj -> bool -> ok_if_empty:bool -> unit
      = "ml_gtk_combo_set_value_in_list"
  external set_use_arrows : [> combo] obj -> bool -> unit
      = "ml_gtk_combo_set_use_arrows"
  external set_use_arrows_always : [> combo] obj -> bool -> unit
      = "ml_gtk_combo_set_use_arrows_always"
  external set_case_sensitive : [> combo] obj -> bool -> unit
      = "ml_gtk_combo_set_case_sensitive"
  external set_item_string : [> combo] obj -> [> item] obj -> string -> unit
      = "ml_gtk_combo_set_item_string"
  external entry : [> combo] obj -> entry obj= "ml_gtk_combo_entry"
  external list : [> combo] obj -> liste obj= "ml_gtk_combo_list"
  let set_popdown_strings combo strings =
    GtkList.Liste.clear_items (list combo) start:0 end:(-1);
    List.iter strings fun:
      begin fun s ->
	let li = GtkList.ListItem.create_with_label s in
	Widget.show li;
	Container.add (list combo) li
      end
  let setter w :cont ?:popdown_strings ?:use_arrows ?:use_arrows_always
      ?:case_sensitive =
    may popdown_strings fun:(set_popdown_strings w);
    may use_arrows fun:(set_use_arrows w);
    may use_arrows_always fun:(set_use_arrows_always w);
    may case_sensitive fun:(set_case_sensitive w);
    cont w
  external disable_activate : [> combo] obj -> unit
      = "ml_gtk_combo_disable_activate"
end
