(* $Id$ *)

open Misc
open Gtk
open GtkBase
open GtkPack
open GObj
open GContainer

class box_skel obj = object
  inherit container obj
  method pack ?from:f ?expand ?fill ?padding w =
    Box.pack obj (as_widget w) ?from:f ?expand ?fill ?padding
  method set_homogeneous = Box.set_homogeneous obj
  method set_spacing = Box.set_spacing obj
  method set_child_packing ?from:f ?expand ?fill ?padding w =
    Box.set_child_packing obj (as_widget w) ?from:f ?expand ?fill ?padding
  method reorder_child w = Box.reorder_child obj (as_widget w)
end

class box obj = object
  inherit box_skel obj
  method connect = new container_signals obj
end
  
let box dir ?homogeneous ?spacing ?border_width ?width ?height
    ?packing ?show () =
  let w = Box.create dir ?homogeneous ?spacing () in
  Container.set w ?border_width ?width ?height;
  pack_return (new box w) ~packing ~show

let vbox = box `VERTICAL
let hbox = box `HORIZONTAL

class button_box obj = object
  inherit box_skel (obj : Gtk.button_box obj)
  method connect = new container_signals obj
  method set_layout  = BBox.set_layout  obj
  method set_spacing = BBox.set_spacing obj
  method set_child_size = BBox.set_child_size obj
  method set_child_ipadding = BBox.set_child_ipadding obj
end

let button_box dir ?spacing ?child_width ?child_height ?child_ipadx
    ?child_ipady ?layout ?border_width ?width ?height ?packing ?show ()=
  let w = BBox.create dir in
  BBox.set w ?spacing ?child_width ?child_height ?child_ipadx
    ?child_ipady ?layout;
  Container.set w ?border_width ?width ?height;
  pack_return (new button_box w) ~packing ~show

class table obj = object
  inherit container_full (obj : Gtk.table obj)
  method attach ~left ~top ?right ?bottom ?expand ?fill ?shrink
      ?xpadding ?ypadding w =
    Table.attach obj (as_widget w) ~left ~top ?right ?bottom ?expand
      ?fill ?shrink ?xpadding ?ypadding
  method set_row_spacing = Table.set_row_spacing obj
  method set_col_spacing = Table.set_col_spacing obj
  method set_row_spacings = Table.set_row_spacings obj
  method set_col_spacings = Table.set_col_spacings obj
  method set_homogeneous = Table.set_homogeneous obj
end

let table ~rows ~columns ?homogeneous ?row_spacings ?col_spacings
    ?border_width ?width ?height ?packing ?show () =
  let w = Table.create ~rows ~columns ?homogeneous () in
  Table.set w ?row_spacings ?col_spacings;
  Container.set w ?border_width ?width ?height;
  pack_return (new table w) ~packing ~show

class fixed obj = object
  inherit container_full (obj : Gtk.fixed obj)
  method add_events = Widget.add_events obj
  method put w = Fixed.put obj (as_widget w)
  method move w = Fixed.move obj (as_widget w)
end

let fixed ?border_width ?width ?height ?packing ?show () =
  let w = Fixed.create () in
  Container.set w ?border_width ?width ?height;
  pack_return (new fixed w) ~packing ~show

class layout obj = object
  inherit container_full (obj : Gtk.layout obj)
  method add_events = Widget.add_events obj
  method put w = Layout.put obj (as_widget w)
  method move w = Layout.move obj (as_widget w)
  method set_hadjustment adj =
    Layout.set_hadjustment obj (GData.as_adjustment adj)
  method set_vadjustment adj =
    Layout.set_vadjustment obj (GData.as_adjustment adj)
  method set_width width = Layout.set_size obj ~width
  method set_height height = Layout.set_size obj ~height
  method hadjustment = new GData.adjustment (Layout.get_hadjustment obj)
  method vadjustment = new GData.adjustment (Layout.get_vadjustment obj)
  method freeze () = Layout.freeze obj
  method thaw () = Layout.thaw obj
  method width = Layout.get_width obj
  method height = Layout.get_height obj
end

let layout ?hadjustment ?vadjustment ?layout_width ?layout_height
    ?border_width ?width ?height ?packing ?show () =
  let w = Layout.create
      (optboxed (may_map ~f:GData.as_adjustment hadjustment))
      (optboxed (may_map ~f:GData.as_adjustment vadjustment)) in
  if layout_width <> None || layout_height <> None then
    Layout.set_size w ?width:layout_width ?height:layout_height;
  Container.set w ?border_width ?width ?height;
  pack_return (new layout w) ~packing ~show


class packer obj = object
  inherit container_full (obj : Gtk.packer obj)
  method pack ?side ?anchor ?expand ?fill
      ?border_width ?pad_x ?pad_y ?i_pad_x ?i_pad_y w =
    let options = Packer.build_options ?expand ?fill () in
    if border_width == None && pad_x == None && pad_y == None &&
      i_pad_x == None && i_pad_y == None
      then Packer.add_defaults obj (as_widget w) ?side ?anchor ~options
      else Packer.add obj (as_widget w) ?side ?anchor ~options
	  ?border_width ?pad_x ?pad_y ?i_pad_x ?i_pad_y
  method set_child_packing ?side ?anchor ?expand ?fill
      ?border_width ?pad_x ?pad_y ?i_pad_x ?i_pad_y w =
    Packer.set_child_packing obj (as_widget w) ?side ?anchor
      ~options:(Packer.build_options ?expand ?fill ())
      ?border_width ?pad_x ?pad_y ?i_pad_x ?i_pad_y
  method reorder_child w = Packer.reorder_child obj (as_widget w)
  method set_spacing = Packer.set_spacing obj
  method set_defaults = Packer.set_defaults obj
end

let packer ?spacing ?border_width ?width ?height ?packing ?show () =
  let w = Packer.create () in
  may spacing ~f:(Packer.set_spacing w);
  Container.set w ?border_width ?width ?height;
  pack_return (new packer w) ~packing ~show

class paned obj = object
  inherit container_full (obj : Gtk.paned obj)
  method add_events = Widget.add_events obj
  method add w =
    if List.length (Container.children obj) = 2 then
      raise(Error "Gpack.paned#add: already full");
    Container.add obj (as_widget w)
  method add1 w =
    try ignore(Paned.child1 obj); raise(Error "GPack.paned#add1: already full")
    with _ -> Paned.add1 obj (as_widget w)
  method add2 w =
    try ignore(Paned.child2 obj); raise(Error "GPack.paned#add2: already full")
    with _ -> Paned.add2 obj (as_widget w)
  method set_handle_size = Paned.set_handle_size obj
  method set_gutter_size = Paned.set_gutter_size obj
  method child1 = new widget (Paned.child1 obj)
  method child2 = new widget (Paned.child2 obj)
  method handle_size = Paned.handle_size obj
  method gutter_size = Paned.gutter_size obj
end

let paned dir ?handle_size ?gutter_size
    ?border_width ?width ?height ?packing ?show () =
  let w = Paned.create dir in
  Paned.set w ?handle_size ?gutter_size;
  Container.set w ?border_width ?width ?height;
  pack_return (new paned w) ~packing ~show
