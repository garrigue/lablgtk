(* $Id$ *)

open Misc
open Gtk
open Tags
open GtkBase

module Button = struct
  let cast w : button obj =
    if Object.is_a w "GtkButton" then Obj.magic w
    else invalid_arg "Gtk.Button.cast"
  external coerce : [> button] obj -> button obj = "%identity"
  external create : unit -> button obj = "ml_gtk_button_new"
  external create_with_label : string -> button obj
      = "ml_gtk_button_new_with_label"
  let create ?:label ?(_ : unit option) =
    match label with None -> create ()
    | Some x -> create_with_label x
  external pressed : [> button] obj -> unit = "ml_gtk_button_pressed"
  external released : [> button] obj -> unit = "ml_gtk_button_released"
  external clicked : [> button] obj -> unit = "ml_gtk_button_clicked"
  external enter : [> button] obj -> unit = "ml_gtk_button_enter"
  external leave : [> button] obj -> unit = "ml_gtk_button_leave"
  module Signals = struct
    open GtkSignal
    let pressed : ([> button],_) t =
      { name = "pressed"; marshaller = marshal_unit }
    let released : ([> button],_) t =
      { name = "released"; marshaller = marshal_unit }
    let clicked : ([> button],_) t =
      { name = "clicked"; marshaller = marshal_unit }
    let enter : ([> button],_) t =
      { name = "enter"; marshaller = marshal_unit }
    let leave : ([> button],_) t =
      { name = "leave"; marshaller = marshal_unit }
  end
end

module ToggleButton = struct
  let cast w : toggle_button obj =
    if Object.is_a w "GtkToggleButton" then Obj.magic w
    else invalid_arg "Gtk.ToggleButton.cast"
  external coerce : [> toggle] obj -> toggle_button obj = "%identity"
  external toggle_button_create : unit -> toggle_button obj
      = "ml_gtk_toggle_button_new"
  external toggle_button_create_with_label : string -> toggle_button obj
      = "ml_gtk_toggle_button_new_with_label"
  external check_button_create : unit -> toggle_button obj
      = "ml_gtk_check_button_new"
  external check_button_create_with_label : string -> toggle_button obj
      = "ml_gtk_check_button_new_with_label"
  let create_toggle ?:label ?(_ : unit option) =
    match label with None -> toggle_button_create ()
    | Some label -> toggle_button_create_with_label label
  let create_check ?:label ?(_ : unit option) =
    match label with None -> check_button_create ()
    | Some label -> check_button_create_with_label label
  external set_mode : [> toggle] obj -> bool -> unit
      = "ml_gtk_toggle_button_set_mode"
  external set_active : [> toggle] obj -> bool -> unit
      = "ml_gtk_toggle_button_set_active"
  let setter w :cont ?:active ?:draw_indicator =
    may fun:(set_mode w) draw_indicator;
    may fun:(set_active w) active;
    cont w
  external get_active : [> toggle] obj -> bool
      = "ml_gtk_toggle_button_get_active"
  external toggled : [> toggle] obj -> unit
      = "ml_gtk_toggle_button_toggled"
  module Signals = struct
    open GtkSignal
    let toggled : ([> toggle],_) t =
      { name = "toggled"; marshaller = marshal_unit }
  end
end

module RadioButton = struct
  let cast w : radio_button obj =
    if Object.is_a w "GtkRadioButton" then Obj.magic w
    else invalid_arg "Gtk.RadioButton.cast"
  external create : group optpointer -> radio_button obj
      = "ml_gtk_radio_button_new"
  external create_with_label : group optpointer -> string -> radio_button obj
      = "ml_gtk_radio_button_new_with_label"
  external group : [> radio] obj -> group = "ml_gtk_radio_button_group"
  external set_group : [> radio] obj -> group -> unit
      = "ml_gtk_radio_button_set_group"
  let setter w :cont ?:group =
    may group fun:(set_group w);
    cont w
  let create ?:group ?:label ?(_ : unit option) =
    let group = optpointer group in
    match label with None -> create group
    | Some label -> create_with_label group label
end

module Toolbar = struct
  let cast w : toolbar obj =
    if Object.is_a w "GtkToolbar" then Obj.magic w
    else invalid_arg "Gtk.Toolbar.cast"
  external create : orientation -> style:toolbar_style -> toolbar obj
      = "ml_gtk_toolbar_new"
  let create dir ?:style [< `BOTH >] = create dir :style
  external insert_space : [> toolbar] obj -> pos:int -> unit
      = "ml_gtk_toolbar_insert_space"
  let insert_space w ?:pos [< -1 >] = insert_space w :pos
  external insert_button :
      [> toolbar] obj -> type:[BUTTON TOGGLEBUTTON RADIOBUTTON] ->
      text:optstring -> tooltip:optstring -> tooltip_private:optstring ->
      icon:[> widget] optobj -> pos:int -> button obj
      = "ml_gtk_toolbar_insert_element_bc" "ml_gtk_toolbar_insert_element"
  let insert_button w ?type:t [< `BUTTON >] ?:text ?:tooltip ?:tooltip_private
      ?:icon ?:pos [< -1 >] ?:callback =
    let b =insert_button w type:t text:(optpointer text)
	tooltip:(optpointer tooltip)
	tooltip_private:(optpointer tooltip_private) icon:(optboxed icon)
	:pos in
    match callback with
    | None   -> b
    | Some c -> GtkSignal.connect b sig:Button.Signals.clicked
	  callback: c; b
  external insert_widget :
      [> toolbar] obj -> [> widget] obj ->
      tooltip:optstring -> tooltip_private:optstring -> pos:int -> unit
      = "ml_gtk_toolbar_insert_widget"
  let insert_widget w w' ?:tooltip ?:tooltip_private ?:pos [< -1 >] =
    insert_widget w w' tooltip:(optpointer tooltip)
      tooltip_private:(optpointer tooltip_private) :pos
  external set_orientation : [> toolbar] obj -> orientation -> unit =
    "ml_gtk_toolbar_set_orientation"
  external set_style : [> toolbar] obj -> toolbar_style -> unit =
    "ml_gtk_toolbar_set_style"
  external set_space_size : [> toolbar] obj -> int -> unit =
    "ml_gtk_toolbar_set_space_size"
  external set_space_style : [> toolbar] obj -> [ EMPTY LINE ] -> unit =
    "ml_gtk_toolbar_set_space_style"
  external set_tooltips : [> toolbar] obj -> bool -> unit =
    "ml_gtk_toolbar_set_tooltips"
  external set_button_relief : [> toolbar] obj -> relief_type -> unit =
    "ml_gtk_toolbar_set_button_relief"
  external get_button_relief : [> toolbar] obj -> relief_type =
    "ml_gtk_toolbar_get_button_relief"
  let setter w :cont ?:orientation ?:style ?:space_size
      ?:space_style ?:tooltips ?:button_relief =
    may orientation fun:(set_orientation w);
    may style fun:(set_style w);
    may space_size fun:(set_space_size w);
    may space_style fun:(set_space_style w);
    may tooltips fun:(set_tooltips w);
    may button_relief fun:(set_button_relief w);
    cont w
  module Signals = struct
    open GtkSignal
    external val_orientation : int -> orientation = "ml_Val_orientation"
    external val_toolbar_style : int -> toolbar_style
	= "ml_Val_toolbar_style"
    let orientation_changed : ([> toolbar],_) t =
      let marshal f argv = f (val_orientation (GtkArgv.get_int argv pos:0)) in
      { name = "orientation_changed"; marshaller = marshal }
    let style_changed : ([> toolbar],_) t =
      let marshal f argv =
	f (val_toolbar_style (GtkArgv.get_int argv pos:0)) in
      { name = "style_changed"; marshaller = marshal }
  end
end
