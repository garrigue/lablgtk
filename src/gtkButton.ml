(* $Id$ *)

open Gaux
open Gtk
open Tags
open GtkBase

module Button = struct
  let cast w : button obj = Object.try_cast w "GtkButton"
  external create : unit -> button obj = "ml_gtk_button_new"
  external create_with_label : string -> button obj
      = "ml_gtk_button_new_with_label"
  external create_with_mnemonic : string -> button obj
      = "ml_gtk_button_new_with_mnemonic"
  external create_from_stock : string -> button obj
      = "ml_gtk_button_new_from_stock"
  let create ?label ?(use_mnemonic=false) ?stock () =
    match label, use_mnemonic, stock with 
      None, _, None -> create ()
    | _, _, Some x -> create_from_stock (GtkStock.convert_id x)
    | Some x, true, _ -> create_with_mnemonic x
    | Some x, false, _ -> create_with_label x
  external pressed : [>`button] obj -> unit = "ml_gtk_button_pressed"
  external released : [>`button] obj -> unit = "ml_gtk_button_released"
  external clicked : [>`button] obj -> unit = "ml_gtk_button_clicked"
  external enter : [>`button] obj -> unit = "ml_gtk_button_enter"
  external leave : [>`button] obj -> unit = "ml_gtk_button_leave"
  external set_relief : [>`button] obj -> relief_style -> unit
      = "ml_gtk_button_set_relief"
  external get_relief : [>`button] obj -> relief_style
      = "ml_gtk_button_get_relief"
  external set_label : [>`button] obj -> string -> unit
      = "ml_gtk_button_set_label"
  external get_label : [>`button] obj -> string
      = "ml_gtk_button_get_label"
  module Signals = struct
    open GtkSignal
    let pressed =
      { name = "pressed"; classe = `button; marshaller = marshal_unit }
    let released =
      { name = "released"; classe = `button; marshaller = marshal_unit }
    let clicked =
      { name = "clicked"; classe = `button; marshaller = marshal_unit }
    let enter =
      { name = "enter"; classe = `button; marshaller = marshal_unit }
    let leave =
      { name = "leave"; classe = `button; marshaller = marshal_unit }
  end
end

module ToggleButton = struct
  let cast w : toggle_button obj = Object.try_cast w "GtkToggleButton"
  external toggle_button_create : unit -> toggle_button obj
      = "ml_gtk_toggle_button_new"
  external toggle_button_create_with_label : string -> toggle_button obj
      = "ml_gtk_toggle_button_new_with_label"
  external toggle_button_create_with_mnemonic : string -> toggle_button obj
      = "ml_gtk_toggle_button_new_with_mnemonic"
  external check_button_create : unit -> toggle_button obj
      = "ml_gtk_check_button_new"
  external check_button_create_with_label : string -> toggle_button obj
      = "ml_gtk_check_button_new_with_label"
  external check_button_create_with_mnemonic : string -> toggle_button obj
      = "ml_gtk_check_button_new_with_mnemonic"
  let create_toggle ?label ?(use_mnemonic=false) () =
    match label, use_mnemonic with 
      None, _ -> toggle_button_create ()
    | Some m, true  -> toggle_button_create_with_mnemonic m
    | Some l, false -> toggle_button_create_with_label l
  let create_check ?label ?(use_mnemonic=false) () =
    match label, use_mnemonic with 
      None, _ -> check_button_create ()
    | Some m, true  -> check_button_create_with_mnemonic m
    | Some l, false -> check_button_create_with_label l
  external set_mode : [>`toggle] obj -> bool -> unit
      = "ml_gtk_toggle_button_set_mode"
  external set_active : [>`toggle] obj -> bool -> unit
      = "ml_gtk_toggle_button_set_active"
  let set ?active ?draw_indicator w =
    may ~f:(set_mode w) draw_indicator;
    may ~f:(set_active w) active
  external get_active : [>`toggle] obj -> bool
      = "ml_gtk_toggle_button_get_active"
  external toggled : [>`toggle] obj -> unit
      = "ml_gtk_toggle_button_toggled"
  module Signals = struct
    open GtkSignal
    let toggled =
      { name = "toggled"; classe = `toggle; marshaller = marshal_unit }
  end
end

module RadioButton = struct
  let cast w : radio_button obj = Object.try_cast w "GtkRadioButton"
  external create : radio_button group -> radio_button obj
      = "ml_gtk_radio_button_new"
  external create_with_label : radio_button group -> string -> radio_button obj
      = "ml_gtk_radio_button_new_with_label"
  external create_with_mnemonic : radio_button group -> string -> radio_button obj
      = "ml_gtk_radio_button_new_with_mnemonic"
  external set_group : [>`radio] obj -> radio_button group -> unit
      = "ml_gtk_radio_button_set_group"
  let create ?(group = None) ?label ?(use_mnemonic=false) () =
    match label, use_mnemonic with 
      None, _ -> create group
    | Some m, true  -> create_with_mnemonic group m
    | Some l, false -> create_with_label group l
end

module Toolbar = struct
  let cast w : toolbar obj = Object.try_cast w "GtkToolbar"
  external create : unit -> toolbar obj
      = "ml_gtk_toolbar_new"
  external insert_space : [>`toolbar] obj -> pos:int -> unit
      = "ml_gtk_toolbar_insert_space"
  let insert_space w ?(pos = -1) () = insert_space w ~pos
  external insert_button :
      [>`toolbar] obj -> kind:[`BUTTON|`TOGGLEBUTTON|`RADIOBUTTON] ->
      text:string -> tooltip:string ->
      tooltip_private:string ->
      icon:[>`widget] optobj -> pos:int -> button obj
      = "ml_gtk_toolbar_insert_element_bc" "ml_gtk_toolbar_insert_element"
  let insert_button w ?(kind=`BUTTON) ?(text="") ?(tooltip="")
      ?(tooltip_private="") ?icon ?(pos = -1) ?callback () =
    let b =insert_button w ~kind ~text ~tooltip ~tooltip_private ~pos
        ~icon:(Gpointer.optboxed icon)
    in
    match callback with
    | None   -> b
    | Some c -> GtkSignal.connect b ~sgn:Button.Signals.clicked
	  ~callback: c; b
  external insert_widget :
      [>`toolbar] obj -> [>`widget] obj ->
      tooltip:string -> tooltip_private:string -> pos:int -> unit
      = "ml_gtk_toolbar_insert_widget"
  let insert_widget w ?(tooltip="") ?(tooltip_private="") ?(pos = -1) w' =
    insert_widget w w' ~tooltip ~tooltip_private ~pos
  external set_orientation : [>`toolbar] obj -> orientation -> unit =
    "ml_gtk_toolbar_set_orientation"
  external set_style : [>`toolbar] obj -> toolbar_style -> unit =
    "ml_gtk_toolbar_set_style"
  external set_tooltips : [>`toolbar] obj -> bool -> unit =
    "ml_gtk_toolbar_set_tooltips"
  let set ?orientation ?style ?tooltips w =
    may orientation ~f:(set_orientation w);
    may style ~f:(set_style w);
    may tooltips ~f:(set_tooltips w)
  module Signals = struct
    open GtkSignal
    let orientation_changed =
      let marshal f = marshal_int
          (fun x -> f (Gpointer.decode_variant GtkEnums.orientation x)) in
      { name = "orientation_changed"; classe = `toolbar;
        marshaller = marshal }
    let style_changed =
      let marshal f = marshal_int
          (fun x -> f (Gpointer.decode_variant GtkEnums.toolbar_style x)) in
      { name = "style_changed"; classe = `toolbar; marshaller = marshal }
  end
end
