(* $Id$ *)

open Gaux
open Gtk
open Tags
open GtkBase

module Box = struct
  let cast w : box obj = Object.try_cast w "GtkBox"
  external pack_start :
      [>`box] obj -> [>`widget] obj ->
      expand:bool -> fill:bool -> padding:int -> unit
      = "ml_gtk_box_pack_start"
  external pack_end :
      [>`box] obj -> [>`widget] obj ->
      expand:bool -> fill:bool -> padding:int -> unit
      = "ml_gtk_box_pack_end"
  let pack box ?from:( dir = (`START : pack_type))
      ?(expand=false) ?(fill=true) ?(padding=0) child =
    (match dir with `START -> pack_start | `END -> pack_end)
      box child ~expand ~fill ~padding
  external reorder_child : [>`box] obj -> [>`widget] obj -> pos:int -> unit
      = "ml_gtk_box_reorder_child"
  external set_homogeneous : [>`box] obj -> bool -> unit
      = "ml_gtk_box_set_homogeneous"
  external set_spacing : [>`box] obj -> int -> unit
      = "ml_gtk_box_set_spacing"
  external get_spacing : [>`box] obj -> int
      = "ml_gtk_box_get_spacing"
  let set ?homogeneous ?spacing w =
    may homogeneous ~f:(set_homogeneous w);
    may spacing ~f:(set_spacing w)
  type packing =
      { expand: bool; fill: bool; padding: int; pack_type: pack_type }
  external query_child_packing : [>`box] obj -> [>`widget] obj -> packing
      = "ml_gtk_box_query_child_packing"
  external set_child_packing :
      [>`box] obj -> [>`widget] obj ->
      ?expand:bool -> ?fill:bool -> ?padding:int -> ?from:pack_type -> unit
      = "ml_gtk_box_set_child_packing_bc" "ml_gtk_box_set_child_packing"
  external hbox_new : homogeneous:bool -> spacing:int -> box obj
      = "ml_gtk_hbox_new"
  external vbox_new : homogeneous:bool -> spacing:int -> box obj
      = "ml_gtk_vbox_new"
  let create (dir : orientation) ?(homogeneous=false) ?(spacing=0) () =
    (match dir with `HORIZONTAL -> hbox_new | `VERTICAL -> vbox_new)
      ~homogeneous ~spacing
end

module BBox = struct
  (* Omitted defaults setting *)
  let cast w : button_box obj = Object.try_cast w "GtkBBox"
  type bbox_style = [ `DEFAULT_STYLE|`SPREAD|`EDGE|`START|`END ]
  external get_child_width : [>`bbox] obj -> int
      = "ml_gtk_button_box_get_child_min_width"
  external get_child_height : [>`bbox] obj -> int
      = "ml_gtk_button_box_get_child_min_height"
  external get_child_ipadx : [>`bbox] obj -> int
      = "ml_gtk_button_box_get_child_ipad_x"
  external get_child_ipady : [>`bbox] obj -> int
      = "ml_gtk_button_box_get_child_ipad_y"
  external get_layout : [>`bbox] obj -> bbox_style
      = "ml_gtk_button_box_get_layout_style"
  external set_child_size : [>`bbox] obj -> width:int -> height:int -> unit
      = "ml_gtk_button_box_set_child_size"
  external set_child_ipadding : [>`bbox] obj -> x:int -> y:int -> unit
      = "ml_gtk_button_box_set_child_ipadding"
  external set_layout : [>`bbox] obj -> bbox_style -> unit
      = "ml_gtk_button_box_set_layout"
  let set_child_size w ?width ?height () =
    set_child_size w ~width:(may_default get_child_width w ~opt:width)
      ~height:(may_default get_child_height w ~opt:height)
  let set_child_ipadding w ?x ?y () =
    set_child_ipadding w
      ~x:(may_default get_child_ipadx w ~opt:x)
      ~y:(may_default get_child_ipady w ~opt:y)
  let set ?child_width ?child_height ?child_ipadx
      ?child_ipady ?layout w =
    if child_width <> None || child_height <> None then
      set_child_size w ?width:child_width ?height:child_height ();
    if child_ipadx <> None || child_ipady <> None then
      set_child_ipadding w ?x:child_ipadx ?y:child_ipady ();
    may layout ~f:(set_layout w)
  external create_hbbox : unit -> button_box obj = "ml_gtk_hbutton_box_new"
  external create_vbbox : unit -> button_box obj = "ml_gtk_vbutton_box_new"
  let create (dir : orientation) =
    if dir = `HORIZONTAL then create_hbbox () else create_vbbox ()
end

module Fixed = struct
  let cast w : fixed obj = Object.try_cast w "GtkFixed"
  external create : unit -> fixed obj = "ml_gtk_fixed_new"
  external put : [>`fixed] obj -> [>`widget] obj -> x:int -> y:int -> unit
      = "ml_gtk_fixed_put"
  external move : [>`fixed] obj -> [>`widget] obj -> x:int -> y:int -> unit
      = "ml_gtk_fixed_move"
  external set_has_window : [>`fixed] obj -> bool -> unit
      = "ml_gtk_fixed_set_has_window"
  external get_has_window : [>`fixed] obj -> bool
      = "ml_gtk_fixed_get_has_window"
end

module Layout = struct
  let cast w : layout obj = Object.try_cast w "GtkLayout"
  external create :
      [>`adjustment] optobj -> [>`adjustment] optobj -> layout obj
      = "ml_gtk_layout_new"
  external put : [>`layout] obj -> [>`widget] obj -> x:int -> y:int -> unit
      = "ml_gtk_layout_put"
  external move : [>`layout] obj -> [>`widget] obj -> x:int -> y:int -> unit
      = "ml_gtk_layout_move"
  external set_size : [>`layout] obj -> width:int -> height:int -> unit
      = "ml_gtk_layout_set_size"
  external get_hadjustment : [>`layout] obj -> adjustment obj
      = "ml_gtk_layout_get_hadjustment"
  external get_vadjustment : [>`layout] obj -> adjustment obj
      = "ml_gtk_layout_get_vadjustment"
  external set_hadjustment : [>`layout] obj -> [>`adjustment] obj -> unit
      = "ml_gtk_layout_set_hadjustment"
  external set_vadjustment : [>`layout] obj -> [>`adjustment] obj -> unit
      = "ml_gtk_layout_set_vadjustment"
  external freeze : [>`layout] obj -> unit
      = "ml_gtk_layout_freeze"
  external thaw : [>`layout] obj -> unit
      = "ml_gtk_layout_thaw"
  external get_height : [>`layout] obj -> int
      = "ml_gtk_layout_get_height"
  external get_width : [>`layout] obj -> int
      = "ml_gtk_layout_get_width"
  let set_size ?width ?height w =
    set_size w ~width:(may_default get_width w ~opt:width)
      ~height:(may_default get_height w ~opt:height)
end

(*
module Packer = struct
  let cast w : packer obj = Object.try_cast w "GtkPacker"
  external create : unit -> packer obj = "ml_gtk_packer_new"
  external add :
      [>`packer] obj -> [>`widget] obj ->
      ?side:side_type -> ?anchor:anchor_type ->
      ?options:packer_options list ->
      ?border_width:int -> ?pad_x:int -> ?pad_y:int ->
      ?i_pad_x:int -> ?i_pad_y:int -> unit
      = "ml_gtk_packer_add_bc" "ml_gtk_packer_add"
  external add_defaults :
      [>`packer] obj -> [>`widget] obj ->
      ?side:side_type -> ?anchor:anchor_type ->
      ?options:packer_options list -> unit
      = "ml_gtk_packer_add_defaults"
  external set_child_packing :
      [>`packer] obj -> [>`widget] obj ->
      ?side:side_type -> ?anchor:anchor_type ->
      ?options:packer_options list ->
      ?border_width:int -> ?pad_x:int -> ?pad_y:int ->
      ?i_pad_x:int -> ?i_pad_y:int -> unit
      = "ml_gtk_packer_set_child_packing_bc" "ml_gtk_packer_set_child_packing"
  external reorder_child : [>`packer] obj -> [>`widget] obj -> pos:int -> unit
      = "ml_gtk_packer_reorder_child"
  external set_spacing : [>`packer] obj -> int -> unit
      = "ml_gtk_packer_set_spacing"
  external set_defaults :
      [>`packer] obj -> ?border_width:int -> ?pad_x:int -> ?pad_y:int ->
      ?i_pad_x:int -> ?i_pad_y:int -> unit -> unit
      = "ml_gtk_packer_set_defaults_bc" "ml_gtk_packer_set_defaults"

  let build_options ?(expand=false) ?(fill=`BOTH) () =
    (if expand then [`PACK_EXPAND] else []) @
    (match (fill : expand_type) with `NONE -> []
    | `X -> [`FILL_X]
    | `Y -> [`FILL_Y]
    | `BOTH -> [`FILL_X;`FILL_Y])
end
*)

module Paned = struct
  let cast w : paned obj = Object.try_cast w "GtkPaned"
  external add1 : [>`paned] obj -> [>`widget] obj -> unit
      = "ml_gtk_paned_add1"
  external add2 : [>`paned] obj -> [>`widget] obj -> unit
      = "ml_gtk_paned_add2"
  external pack1 :
      [>`paned] obj -> [>`widget] obj -> resize:bool -> shrink:bool -> unit
      = "ml_gtk_paned_pack1"
  external pack2 :
      [>`paned] obj -> [>`widget] obj -> resize:bool -> shrink:bool -> unit
      = "ml_gtk_paned_pack2"
  external set_position : [>`paned] obj -> int -> unit
      = "ml_gtk_paned_set_position"
  external child1 : [>`paned] obj -> widget obj = "ml_gtk_paned_child1"
  external child2 : [>`paned] obj -> widget obj = "ml_gtk_paned_child2"
  external hpaned_new : unit -> paned obj = "ml_gtk_hpaned_new"
  external vpaned_new : unit -> paned obj = "ml_gtk_vpaned_new"
  let create (dir : orientation) =
    if dir = `HORIZONTAL then hpaned_new () else vpaned_new ()
end

module Table = struct
  let cast w : table obj = Object.try_cast w "GtkTable"
  external create : int -> int -> homogeneous:bool -> table obj
      = "ml_gtk_table_new"
  let create ~rows:r ~columns:c ?(homogeneous=false) () =
    create r c ~homogeneous
  external attach :
      [>`table] obj -> [>`widget] obj -> left:int -> right:int ->
      top:int -> bottom:int -> xoptions:attach_options list ->
      yoptions:attach_options list -> xpadding:int -> ypadding:int -> unit
      = "ml_gtk_table_attach_bc" "ml_gtk_table_attach"
  let has_x : expand_type -> bool =
    function `X|`BOTH -> true | `Y|`NONE -> false
  let has_y : expand_type -> bool =
    function `Y|`BOTH -> true | `X|`NONE -> false
  let attach t ~left ~top ?(right=left+1) ?(bottom=top+1)
      ?(expand=`NONE) ?(fill=`BOTH) ?(shrink=`NONE)
      ?(xpadding=0) ?(ypadding=0) w =
    let xoptions = if has_x shrink then [`SHRINK] else [] in
    let xoptions = if has_x fill then `FILL::xoptions else xoptions in
    let xoptions = if has_x expand then `EXPAND::xoptions else xoptions in
    let yoptions = if has_y shrink then [`SHRINK] else [] in
    let yoptions = if has_y fill then `FILL::yoptions else yoptions in
    let yoptions = if has_y expand then `EXPAND::yoptions else yoptions in
    attach t w ~left ~top ~right ~bottom ~xoptions ~yoptions
      ~xpadding ~ypadding
  external set_row_spacing : [>`table] obj -> int -> int -> unit
      = "ml_gtk_table_set_row_spacing"
  external set_col_spacing : [>`table] obj -> int -> int -> unit
      = "ml_gtk_table_set_col_spacing"
  external set_row_spacings : [>`table] obj -> int -> unit
      = "ml_gtk_table_set_row_spacings"
  external set_col_spacings : [>`table] obj -> int -> unit
      = "ml_gtk_table_set_col_spacings"
  external set_homogeneous : [>`table] obj -> bool -> unit
      = "ml_gtk_table_set_homogeneous"
  let set ?homogeneous ?row_spacings ?col_spacings w =
    may row_spacings ~f:(set_row_spacings w);
    may col_spacings ~f:(set_col_spacings w);
    may homogeneous ~f:(set_homogeneous w)
end

module Notebook = struct
  let cast w : notebook obj = Object.try_cast w "GtkNotebook"
  external create : unit -> notebook obj = "ml_gtk_notebook_new"
  external insert_page :
      [>`notebook] obj -> [>`widget] obj -> tab_label:[>`widget] optobj ->
      menu_label:[>`widget] optobj -> pos:int -> unit
      = "ml_gtk_notebook_insert_page_menu"
      (* default is append to end *)
  external remove_page : [>`notebook] obj -> int -> unit
      = "ml_gtk_notebook_remove_page"
  external get_current_page : [>`notebook] obj -> int
      = "ml_gtk_notebook_get_current_page"
  external set_page : [>`notebook] obj -> int -> unit
      = "ml_gtk_notebook_set_page"
  external set_tab_pos : [>`notebook] obj -> position -> unit
      = "ml_gtk_notebook_set_tab_pos"
  external set_homogeneous_tabs : [>`notebook] obj -> bool -> unit
      = "ml_gtk_notebook_set_homogeneous_tabs"
  external set_show_tabs : [>`notebook] obj -> bool -> unit
      = "ml_gtk_notebook_set_show_tabs"
  external set_show_border : [>`notebook] obj -> bool -> unit
      = "ml_gtk_notebook_set_show_border"
  external set_scrollable : [>`notebook] obj -> bool -> unit
      = "ml_gtk_notebook_set_scrollable"
  external set_tab_border : [>`notebook] obj -> int -> unit
      = "ml_gtk_notebook_set_tab_border"
  external popup_enable : [>`notebook] obj -> unit
      = "ml_gtk_notebook_popup_enable"
  external popup_disable : [>`notebook] obj -> unit
      = "ml_gtk_notebook_popup_disable"
  external get_nth_page : [>`notebook] obj -> int -> widget obj
      = "ml_gtk_notebook_get_nth_page"
  external page_num : [>`notebook] obj -> [>`widget] obj -> int
      = "ml_gtk_notebook_page_num"
  external next_page : [>`notebook] obj -> unit
      = "ml_gtk_notebook_next_page"
  external prev_page : [>`notebook] obj -> unit
      = "ml_gtk_notebook_prev_page"
  external get_tab_label : [>`notebook] obj -> [>`widget] obj -> widget obj
      = "ml_gtk_notebook_get_tab_label"
  external set_tab_label :
      [>`notebook] obj -> [>`widget] obj -> [>`widget] obj -> unit
      = "ml_gtk_notebook_set_tab_label"
  external get_menu_label : [>`notebook] obj -> [>`widget] obj -> widget obj
      = "ml_gtk_notebook_get_menu_label"
  external set_menu_label :
      [>`notebook] obj -> [>`widget] obj -> [>`widget] obj -> unit
      = "ml_gtk_notebook_set_menu_label"
  external reorder_child : [>`notebook] obj -> [>`widget] obj -> int -> unit
      = "ml_gtk_notebook_reorder_child"

  let set_popup w = function
      true -> popup_enable w
    | false -> popup_disable w
  let set ?page ?tab_pos ?show_tabs ?homogeneous_tabs
      ?show_border ?scrollable ?tab_border ?popup w =
    let may_set f = may ~f:(f w) in
    may_set set_page page;
    may_set set_tab_pos tab_pos;
    may_set set_show_tabs show_tabs;
    may_set set_homogeneous_tabs homogeneous_tabs;
    may_set set_show_border show_border;
    may_set set_scrollable scrollable;
    may_set set_tab_border tab_border;
    may_set set_popup popup
  module Signals = struct
    open GtkSignal
    let marshal_page f argv = function
      |	_ :: `INT page :: _ -> f page
      |	_ -> invalid_arg "GtkPack.Notebook.Signals.marshal_page"
    let switch_page =
      { name = "switch_page"; classe = `notebook; marshaller = marshal_page }
  end
end
