(* $Id$ *)

open Gaux
open Gtk
open Tags
open GtkBase

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
      text:optstring -> tooltip:optstring -> tooltip_private:optstring ->
      icon:[>`widget] optobj -> pos:int -> button obj
      = "ml_gtk_toolbar_insert_element_bc" "ml_gtk_toolbar_insert_element"
  let insert_button w ?kind:(t=`BUTTON) ?text ?tooltip ?tooltip_private
      ?icon ?(pos = -1) ?callback () =
    let b =insert_button w ~kind:t ~text:(optstring text)
	~tooltip:(optstring tooltip)
	~tooltip_private:(optstring tooltip_private) ~icon:(optboxed icon)
	~pos in
    match callback with
    | None   -> b
    | Some c -> GtkSignal.connect b ~sgn:Button.Signals.clicked
	  ~callback: c; b
  external insert_widget :
      [>`toolbar] obj -> [>`widget] obj ->
      tooltip:optstring -> tooltip_private:optstring -> pos:int -> unit
      = "ml_gtk_toolbar_insert_widget"
  let insert_widget w ?tooltip ?tooltip_private ?(pos = -1) w' =
    insert_widget w w' ~tooltip:(optstring tooltip)
      ~tooltip_private:(optstring tooltip_private) ~pos
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
      let marshal f argv = f (val_orientation (GtkArgv.get_int argv ~pos:0)) in
      { name = "orientation_changed"; marshaller = marshal }
    let style_changed : ([>`toolbar],_) t =
      let marshal f argv =
	f (val_toolbar_style (GtkArgv.get_int argv ~pos:0)) in
      { name = "style_changed"; marshaller = marshal }
  end
end
