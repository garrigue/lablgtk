(* $Id$ *)

open StdLabels
open Gaux
open Gobject
open Gtk
open Tags
open GtkProps
open GtkBase

external _gtkedit_init : unit -> unit = "ml_gtkedit_init"
let () = _gtkedit_init ()

module Editable = struct
  include Editable
  external select_region : [>`editable] obj -> start:int -> stop:int -> unit
      = "ml_gtk_editable_select_region"
  external get_selection_bounds : [>`editable] obj -> (int * int) option
      = "ml_gtk_editable_get_selection_bounds"
  external insert_text : [>`editable] obj -> string -> pos:int -> int
      = "ml_gtk_editable_insert_text"
  external delete_text : [>`editable] obj -> start:int -> stop:int -> unit
      = "ml_gtk_editable_delete_text"
  external get_chars : [>`editable] obj -> start:int -> stop:int -> string
      = "ml_gtk_editable_get_chars"
  external cut_clipboard : [>`editable] obj -> unit
      = "ml_gtk_editable_cut_clipboard"
  external copy_clipboard : [>`editable] obj -> unit
      = "ml_gtk_editable_copy_clipboard"
  external paste_clipboard : [>`editable] obj -> unit
      = "ml_gtk_editable_paste_clipboard"
  external delete_selection : [>`editable] obj -> unit
      = "ml_gtk_editable_delete_selection"
  external set_position : [>`editable] obj -> int -> unit
      = "ml_gtk_editable_set_position"
  external get_position : [>`editable] obj -> int
      = "ml_gtk_editable_get_position"
  module Signals = struct
    open GtkSignal
    let changed =
      { name = "changed"; classe = `editable; marshaller = marshal_unit }
    let marshal_insert f argv = function
      | `STRING _ :: `INT len :: `POINTER(Some pos) :: _ ->
          (* XXX These two accesses are implementation-dependent *)
          let s = Gpointer.peek_string (Closure.get_pointer argv ~pos:1) ~len
          and pos = Gpointer.peek_int pos in
          f s ~pos
      | _ -> invalid_arg "GtkEdit.Editable.Signals.marshal_insert"
    let insert_text =
      { name = "insert_text"; classe = `editable; marshaller = marshal_insert }
    let marshal_delete f _ = function
      | `INT start :: `INT stop :: _ ->
          f ~start ~stop
      | _ -> invalid_arg "GtkEdit.Editable.Signals.marshal_delete"
    let delete_text =
      { name = "delete_text"; classe = `editable; marshaller = marshal_delete }
  end
end

module Entry = struct
  include Entry
  external append_text : [>`entry] obj -> string -> unit
      = "ml_gtk_entry_append_text"
  external prepend_text : [>`entry] obj -> string -> unit
      = "ml_gtk_entry_prepend_text"
  external text_length : [>`entry] obj -> int
      = "ml_GtkEntry_text_length"
  module S = struct
    open GtkSignal
    let activate =
      { name = "activate"; classe = `entry; marshaller = marshal_unit }
    let copy_clipboard =
      { name = "copy_clipboard"; classe = `entry; marshaller = marshal_unit }
    let cut_clipboard =
      { name = "cut_clipboard"; classe = `entry; marshaller = marshal_unit }
    let paste_clipboard =
      { name = "paste_clipboard"; classe = `entry; marshaller = marshal_unit }
    let toggle_overwrite =
      { name = "toggle_overwrite"; classe = `entry; marshaller = marshal_unit }
    let insert_at_cursor =
      { name = "insert_at_cursor"; classe = `entry;
        marshaller = marshal_string }
    let delete_from_cursor =
      let marshal f _ = function
          `INT dt :: `INT len :: _ ->
            f (Gpointer.decode_variant GtkEnums.delete_type) len
        | _ -> invalid_arg "GtkEdit.Entry.S.delete_from_cursor" in
      { name = "insert_at_cursor"; classe = `entry; marshaller = marshal }
  end
end

module SpinButton = struct
  include SpinButton
  external spin : [>`spinbutton] obj -> spin_type -> unit
      = "ml_gtk_spin_button_spin"
  external update : [>`spinbutton] obj -> unit = "ml_gtk_spin_button_update"
  let get_value_as_int w = truncate (floor (get P.value w +. 0.5))
end

(*
module Text = struct
  let cast w : text obj = Object.try_cast w "GtkText"
  external create : [>`adjustment] optobj -> [>`adjustment] optobj -> text obj
      = "ml_gtk_text_new"
  let create ?hadjustment ?vadjustment () =
    create (Gpointer.optboxed hadjustment) (Gpointer.optboxed vadjustment)
  external set_word_wrap : [>`text] obj -> bool -> unit
      = "ml_gtk_text_set_word_wrap"
  external set_line_wrap : [>`text] obj -> bool -> unit
      = "ml_gtk_text_set_line_wrap"
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
  let set ?hadjustment ?vadjustment ?word_wrap w =
    if hadjustment <> None || vadjustment <> None then
      set_adjustment w ?horizontal: hadjustment ?vertical: vadjustment ();
    may word_wrap ~f:(set_word_wrap w)
end
*)

module Combo = struct
  include Combo
  external entry : [>`combo] obj -> entry obj = "ml_gtk_combo_entry"
  external list : [>`combo] obj -> liste obj = "ml_gtk_combo_list"
  let set_popdown_strings combo strings =
    GtkList.Liste.clear_items (list combo) ~start:0 ~stop:(-1);
    List.iter strings ~f:
      begin fun s ->
	let li = GtkList.ListItem.create_with_label s in
	Widget.show li;
	Container.add (list combo) li
      end
  external disable_activate : [>`combo] obj -> unit
      = "ml_gtk_combo_disable_activate"
  external set_item_string : [>`combo] obj -> [>`item] obj -> string -> unit
      = "ml_gtk_combo_set_item_string"
end
