(* $Id$ *)

open Gaux
open Gtk
open Tags
open GtkBase

module Button = struct
  let cast w : button obj = Object.try_cast w "GtkButton"
  external coerce : [>`button] obj -> button obj = "%identity"
  external create : unit -> button obj = "ml_gtk_button_new"
  external create_with_label : string -> button obj
      = "ml_gtk_button_new_with_label"
  let create ?label () =
    match label with None -> create ()
    | Some x -> create_with_label x
  external pressed : [>`button] obj -> unit = "ml_gtk_button_pressed"
  external released : [>`button] obj -> unit = "ml_gtk_button_released"
  external clicked : [>`button] obj -> unit = "ml_gtk_button_clicked"
  external enter : [>`button] obj -> unit = "ml_gtk_button_enter"
  external leave : [>`button] obj -> unit = "ml_gtk_button_leave"
  module Signals = struct
    open GtkSignal
    let pressed : ([>`button],_) t =
      { name = "pressed"; marshaller = marshal_unit }
    let released : ([>`button],_) t =
      { name = "released"; marshaller = marshal_unit }
    let clicked : ([>`button],_) t =
      { name = "clicked"; marshaller = marshal_unit }
    let enter : ([>`button],_) t =
      { name = "enter"; marshaller = marshal_unit }
    let leave : ([>`button],_) t =
      { name = "leave"; marshaller = marshal_unit }
  end
end

module ToggleButton = struct
  let cast w : toggle_button obj = Object.try_cast w "GtkToggleButton"
  external coerce : [>`toggle] obj -> toggle_button obj = "%identity"
  external toggle_button_create : unit -> toggle_button obj
      = "ml_gtk_toggle_button_new"
  external toggle_button_create_with_label : string -> toggle_button obj
      = "ml_gtk_toggle_button_new_with_label"
  external check_button_create : unit -> toggle_button obj
      = "ml_gtk_check_button_new"
  external check_button_create_with_label : string -> toggle_button obj
      = "ml_gtk_check_button_new_with_label"
  let create_toggle ?label () =
    match label with None -> toggle_button_create ()
    | Some label -> toggle_button_create_with_label label
  let create_check ?label () =
    match label with None -> check_button_create ()
    | Some label -> check_button_create_with_label label
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
    let toggled : ([>`toggle],_) t =
      { name = "toggled"; marshaller = marshal_unit }
  end
end

module RadioButton = struct
  let cast w : radio_button obj = Object.try_cast w "GtkRadioButton"
  external create : radio_button group -> radio_button obj
      = "ml_gtk_radio_button_new"
  external create_with_label : radio_button group -> string -> radio_button obj
      = "ml_gtk_radio_button_new_with_label"
  external set_group : [>`radio] obj -> radio_button group -> unit
      = "ml_gtk_radio_button_set_group"
  let create ?(group = None) ?label () =
    match label with None -> create group
    | Some label -> create_with_label group label
end

module Toolbar = struct
  let cast w : toolbar obj = Object.try_cast w "GtkToolbar"
  external create : orientation -> style:toolbar_style -> toolbar obj
      = "ml_gtk_toolbar_new"
  let create dir ?(style=`BOTH) () = create dir ~style
  external insert_space : [>`toolbar] obj -> pos:int -> unit
      = "ml_gtk_toolbar_insert_space"
  let insert_space w ?(pos = -1) () = insert_space w ~pos
  external insert_button :
      [>`toolbar] obj -> kind:[`BUTTON|`TOGGLEBUTTON|`RADIOBUTTON] ->
      text:Gpointer.optstring -> tooltip:Gpointer.optstring ->
      tooltip_private:Gpointer.optstring ->
      icon:[>`widget] optobj -> pos:int -> button obj
      = "ml_gtk_toolbar_insert_element_bc" "ml_gtk_toolbar_insert_element"
  let insert_button w ?kind:(t=`BUTTON) ?text ?tooltip ?tooltip_private
      ?icon ?(pos = -1) ?callback () =
    let b =insert_button w ~kind:t ~text:(Gpointer.optstring text)
	~tooltip:(Gpointer.optstring tooltip)
	~tooltip_private:(Gpointer.optstring tooltip_private)
        ~icon:(Gpointer.optboxed icon)
	~pos in
    match callback with
    | None   -> b
    | Some c -> GtkSignal.connect b ~sgn:Button.Signals.clicked
	  ~callback: c; b
  external insert_widget :
      [>`toolbar] obj -> [>`widget] obj ->
      tooltip:Gpointer.optstring ->
      tooltip_private:Gpointer.optstring -> pos:int -> unit
      = "ml_gtk_toolbar_insert_widget"
  let insert_widget w ?tooltip ?tooltip_private ?(pos = -1) w' =
    insert_widget w w' ~tooltip:(Gpointer.optstring tooltip)
      ~tooltip_private:(Gpointer.optstring tooltip_private) ~pos
  external set_orientation : [>`toolbar] obj -> orientation -> unit =
    "ml_gtk_toolbar_set_orientation"
  external set_style : [>`toolbar] obj -> toolbar_style -> unit =
    "ml_gtk_toolbar_set_style"
  external set_space_size : [>`toolbar] obj -> int -> unit =
    "ml_gtk_toolbar_set_space_size"
  external set_space_style : [>`toolbar] obj -> [ `EMPTY|`LINE ] -> unit =
    "ml_gtk_toolbar_set_space_style"
  external set_tooltips : [>`toolbar] obj -> bool -> unit =
    "ml_gtk_toolbar_set_tooltips"
  external set_button_relief : [>`toolbar] obj -> relief_style -> unit =
    "ml_gtk_toolbar_set_button_relief"
  external get_button_relief : [>`toolbar] obj -> relief_style =
    "ml_gtk_toolbar_get_button_relief"
  let set ?orientation ?style ?space_size
      ?space_style ?tooltips ?button_relief w =
    may orientation ~f:(set_orientation w);
    may style ~f:(set_style w);
    may space_size ~f:(set_space_size w);
    may space_style ~f:(set_space_style w);
    may tooltips ~f:(set_tooltips w);
    may button_relief ~f:(set_button_relief w)
  module Signals = struct
    open GtkSignal
    external val_orientation : int -> orientation = "ml_Val_orientation"
    external val_toolbar_style : int -> toolbar_style
	= "ml_Val_toolbar_style"
    let orientation_changed : ([>`toolbar],_) t =
      let marshal f = marshal_int (fun x -> f (val_orientation x)) in
      { name = "orientation_changed"; marshaller = marshal }
    let style_changed : ([>`toolbar],_) t =
      let marshal f = marshal_int (fun x -> f (val_toolbar_style x)) in
      { name = "style_changed"; marshaller = marshal }
  end
end
