(* $Id$ *)

open Misc
open Gtk
open Tags
open GtkBase

module Editable = struct
  let cast w : editable obj = Object.try_cast w "GtkEditable"
  external coerce : [>`editable] obj -> editable obj = "%identity"
  external select_region : [>`editable] obj -> start:int -> end:int -> unit
      = "ml_gtk_editable_select_region"
  external insert_text : [>`editable] obj -> string -> pos:int -> int
      = "ml_gtk_editable_insert_text"
  external delete_text : [>`editable] obj -> start:int -> end:int -> unit
      = "ml_gtk_editable_delete_text"
  external get_chars : [>`editable] obj -> start:int -> end:int -> string
      = "ml_gtk_editable_get_chars"
  external cut_clipboard : [>`editable] obj -> unit
      = "ml_gtk_editable_cut_clipboard"
  external copy_clipboard : [>`editable] obj -> unit
      = "ml_gtk_editable_copy_clipboard"
  external paste_clipboard : [>`editable] obj -> unit
      = "ml_gtk_editable_paste_clipboard"
  external claim_selection :
      [>`editable] obj -> claim:bool -> time:int -> unit
      = "ml_gtk_editable_claim_selection"
  external delete_selection : [>`editable] obj -> unit
      = "ml_gtk_editable_delete_selection"
  external changed : [>`editable] obj -> unit = "ml_gtk_editable_changed"
  external set_position : [>`editable] obj -> int -> unit
      = "ml_gtk_editable_set_position"
  external get_position : [>`editable] obj -> int
      = "ml_gtk_editable_get_position"
  external set_editable : [>`editable] obj -> bool -> unit
      = "ml_gtk_editable_set_editable"
  external selection_start_pos : [>`editable] obj -> int
      = "ml_gtk_editable_selection_start_pos"
  external selection_end_pos : [>`editable] obj -> int
      = "ml_gtk_editable_selection_end_pos"
  external has_selection : [>`editable] obj -> bool
      = "ml_gtk_editable_has_selection"
  module Signals = struct
    open GtkSignal
    let activate : ([>`editable],_) t =
      { name = "activate"; marshaller = marshal_unit }
    let changed : ([>`editable],_) t =
      { name = "changed"; marshaller = marshal_unit }
  end
end

module Entry = struct
  let cast w : entry obj = Object.try_cast w "GtkEntry"
  external coerce : [>`entry] obj -> entry obj = "%identity"
  external create : unit -> entry obj = "ml_gtk_entry_new"
  external create_with_max_length : int -> entry obj
      = "ml_gtk_entry_new_with_max_length"
  let create ?:max_length () =
    match max_length with None -> create ()
    | Some len -> create_with_max_length len
  external set_text : [>`entry] obj -> string -> unit
      = "ml_gtk_entry_set_text"
  external append_text : [>`entry] obj -> string -> unit
      = "ml_gtk_entry_append_text"
  external prepend_text : [>`entry] obj -> string -> unit
      = "ml_gtk_entry_prepend_text"
  external get_text : [>`entry] obj -> string = "ml_gtk_entry_get_text"
  external set_visibility : [>`entry] obj -> bool -> unit
      = "ml_gtk_entry_set_visibility"
  external set_max_length : [>`entry] obj -> int -> unit
      = "ml_gtk_entry_set_max_length"
  let set ?:text ?:visibility ?:max_length w =
    let may_set f = may fun:(f w) in
    may_set set_text text;
    may_set set_visibility visibility;
    may_set set_max_length max_length
  external text_length : [>`entry] obj -> int
      = "ml_GtkEntry_text_length"
end

module SpinButton = struct
  let cast w : spin_button obj = Object.try_cast w "GtkSpinButton"
  external create :
      [>`adjustment] optobj -> rate:float -> digits:int -> spin_button obj
      = "ml_gtk_spin_button_new"
  let create ?:adjustment ?:rate{=0.5} ?:digits{=0} () =
    create (optboxed adjustment) :rate :digits
  external configure :
    [>`spinbutton] obj -> adjustment:[>`adjustment] obj ->
    rate:float -> digits:int -> unit
    = "ml_gtk_spin_button_configure"
  external set_adjustment : [>`spinbutton] obj -> [>`adjustment] obj -> unit
      = "ml_gtk_spin_button_set_adjustment"
  external get_adjustment : [>`spinbutton] obj -> adjustment obj
      = "ml_gtk_spin_button_get_adjustment"
  external set_digits : [>`spinbutton] obj -> int -> unit
      = "ml_gtk_spin_button_set_digits"
  external get_value : [>`spinbutton] obj -> float
      = "ml_gtk_spin_button_get_value_as_float"
  let get_value_as_int w = truncate (get_value w +. 0.5)
  external set_value : [>`spinbutton] obj -> float -> unit
      = "ml_gtk_spin_button_set_value"
  external set_update_policy :
      [>`spinbutton] obj -> [`ALWAYS|`IF_VALID] -> unit
      = "ml_gtk_spin_button_set_update_policy"
  external set_numeric : [>`spinbutton] obj -> bool -> unit
      = "ml_gtk_spin_button_set_numeric"
  external spin : [>`spinbutton] obj -> spin_type -> unit
      = "ml_gtk_spin_button_spin"
  external set_wrap : [>`spinbutton] obj -> bool -> unit
      = "ml_gtk_spin_button_set_wrap"
  external set_shadow_type : [>`spinbutton] obj -> shadow_type -> unit
      = "ml_gtk_spin_button_set_shadow_type"
  external set_snap_to_ticks : [>`spinbutton] obj -> bool -> unit
      = "ml_gtk_spin_button_set_snap_to_ticks"
  external update : [>`spinbutton] obj -> unit
      = "ml_gtk_spin_button_update"
  let set ?:adjustment ?:digits ?:value ?:update_policy
      ?:numeric ?:wrap ?:shadow_type ?:snap_to_ticks w =
    let may_set f = may fun:(f w) in
    may_set set_adjustment adjustment;
    may_set set_digits digits;
    may_set set_value value;
    may_set set_update_policy update_policy;
    may_set set_numeric numeric;
    may_set set_wrap wrap;
    may_set set_shadow_type shadow_type;
    may_set set_snap_to_ticks snap_to_ticks
end

module Text = struct
  let cast w : text obj = Object.try_cast w "GtkText"
  external create : [>`adjustment] optobj -> [>`adjustment] optobj -> text obj
      = "ml_gtk_text_new"
  let create ?:hadjustment ?:vadjustment () =
    create (optboxed hadjustment) (optboxed vadjustment)
  external set_word_wrap : [>`text] obj -> bool -> unit
      = "ml_gtk_text_set_word_wrap"
  external set_adjustment :
      [>`text] obj -> ?horizontal:[>`adjustment] obj ->
      ?vertical:[>`adjustment] obj -> unit -> unit
      = "ml_gtk_text_set_adjustments"
  external get_hadjustment : [>`text] obj -> adjustment obj
      = "ml_gtk_text_get_hadj"
  external get_vadjustment : [>`text] obj -> adjustment obj
      = "ml_gtk_text_get_vadj"
  external set_point : [>`text] obj -> int -> unit
      = "ml_gtk_text_set_point"
  external get_point : [>`text] obj -> int = "ml_gtk_text_get_point"
  external get_length : [>`text] obj -> int = "ml_gtk_text_get_length"
  external freeze : [>`text] obj -> unit = "ml_gtk_text_freeze"
  external thaw : [>`text] obj -> unit = "ml_gtk_text_thaw"
  external insert :
      [>`text] obj -> ?font:Gdk.font -> ?foreground:Gdk.Color.t ->
      ?background:Gdk.Color.t -> string -> unit
      = "ml_gtk_text_insert"
  let set ?:hadjustment ?:vadjustment ?:word_wrap w =
    if hadjustment <> None || vadjustment <> None then
      set_adjustment w ?horizontal: hadjustment ?vertical: vadjustment ();
    may word_wrap fun:(set_word_wrap w)
end

module Combo = struct
  let cast w : combo obj = Object.try_cast w "GtkCombo"
  external create : unit -> combo obj = "ml_gtk_combo_new"
  external set_value_in_list :
      [>`combo] obj -> ?required:bool -> ?ok_if_empty:bool -> unit -> unit
      = "ml_gtk_combo_set_value_in_list"
  external set_use_arrows : [>`combo] obj -> bool -> unit
      = "ml_gtk_combo_set_use_arrows"
  external set_use_arrows_always : [>`combo] obj -> bool -> unit
      = "ml_gtk_combo_set_use_arrows_always"
  external set_case_sensitive : [>`combo] obj -> bool -> unit
      = "ml_gtk_combo_set_case_sensitive"
  external set_item_string : [>`combo] obj -> [>`item] obj -> string -> unit
      = "ml_gtk_combo_set_item_string"
  external entry : [>`combo] obj -> entry obj= "ml_gtk_combo_entry"
  external list : [>`combo] obj -> liste obj= "ml_gtk_combo_list"
  let set_popdown_strings combo strings =
    GtkList.Liste.clear_items (list combo) start:0 end:(-1);
    List.iter strings fun:
      begin fun s ->
	let li = GtkList.ListItem.create_with_label s in
	Widget.show li;
	Container.add (list combo) li
      end
  let set_use_arrows' w (mode : [`NEVER|`DEFAULT|`ALWAYS]) =
    let def,always =
      match mode with
	`NEVER -> false, false
      |	`DEFAULT -> true, false
      |	`ALWAYS -> true, true
    in
    set_use_arrows w def;
    set_use_arrows_always w always
  let set ?:popdown_strings ?:use_arrows
      ?:case_sensitive ?:value_in_list ?:ok_if_empty w =
    may popdown_strings fun:(set_popdown_strings w);
    may use_arrows fun:(set_use_arrows' w);
    may case_sensitive fun:(set_case_sensitive w);
    if value_in_list <> None || ok_if_empty <> None then
      set_value_in_list w ?required:value_in_list ?:ok_if_empty ()
  external disable_activate : [>`combo] obj -> unit
      = "ml_gtk_combo_disable_activate"
end
