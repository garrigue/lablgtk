(* $Id$ *)

open Misc
open Gtk
open GObj
open GCont

class box_skel obj = object
  inherit container obj
  method pack : 'b . (#is_widget as 'b) -> _ =
    fun w ->  Box.pack ?obj ?w#as_widget
  method set_packing = Box.setter ?obj ?cont:null_cont
  method set_child_packing : 'b . (#is_widget as 'b) -> _ =
    fun w -> Box.set_child_packing ?obj ?w#as_widget
end

class box obj = object
  inherit box_skel (Box.coerce obj)
  method connect = new container_signals ?obj
end

class pack2 :packing :coerce =
  object (self)
    initializer
      may packing fun:(fun f -> (f (coerce self) : unit))
  end

class hbox ?:homogeneous [< false >] ?:spacing [< 0 >]
    ?:border_width ?:width ?:height ?:packing : box =
  let w = Box.hbox_new :homogeneous :spacing in
  let () =
    Container.setter w cont:null_cont ?:border_width ?:width ?:height in
  object (self)
    inherit box w
    initializer GUtil.pack_return :packing (self :> box)
  end

class vbox ?:homogeneous [< false >] ?:spacing [< 0 >]
    ?:border_width ?:width ?:height ?:packing : box =
  let w = Box.vbox_new :homogeneous :spacing in
  let () =
    Container.setter w cont:null_cont ?:border_width ?:width ?:height in
  object (self)
    inherit box w
    initializer GUtil.pack_return :packing (self :> box)
  end

class button_box obj = object
  inherit box_skel (BBox.coerce obj)
  method connect = new container_signals ?obj
  method set_layout  = BBox.set_layout  obj
  method set_spacing = BBox.set_spacing obj
  method set_child_size = BBox.set_child_size obj
end

class hbutton_box ?:spacing ?:child_width ?:child_height ?:child_ipadx
    ?:child_ipady ?:layout ?:border_width ?:width ?:height ?:packing
    : button_box =
  let w = BBox.create_hbbox () in
  let () =
    BBox.setter w cont:null_cont ?:spacing ?:child_width ?:child_height
      ?:child_ipadx ?:child_ipady ?:layout;
    Container.setter w cont:null_cont ?:border_width ?:width ?:height in
  object (self)
    inherit button_box w
    initializer GUtil.pack_return :packing (self :> button_box)
  end

class vbutton_box ?:spacing ?:child_width ?:child_height ?:child_ipadx
    ?:child_ipady ?:layout ?:border_width ?:width ?:height ?:packing =
  let w = BBox.create_vbbox () in
  let () =
    BBox.setter w cont:null_cont ?:spacing ?:child_width ?:child_height
      ?:child_ipadx ?:child_ipady ?:layout;
    Container.setter w cont:null_cont ?:border_width ?:width ?:height in
  object (self)
    inherit button_box w
    initializer GUtil.pack_return :packing (self :> button_box)
  end

class color_selection_wrapper obj = object
  inherit box_skel (ColorSelection.coerce obj)
  method connect = new container_signals ?obj
  method set_update_policy = ColorSelection.set_update_policy obj
  method set_opacity = ColorSelection.set_opacity obj
  method set_color = ColorSelection.set_color obj
  method get_color = ColorSelection.get_color obj
end

class color_selection ?:border_width ?:width ?:height ?:packing =
  let w = ColorSelection.create () in
  let () = Container.setter w cont:null_cont ?:border_width ?:width ?:height in
  object (self)
    inherit color_selection_wrapper w
    initializer GUtil.pack_return :packing (self :> color_selection_wrapper)
  end
