(* $Id$ *)

open Misc
open Gtk
open GtkBase
open GtkPack
open GObj
open GContainer

class box_skel obj = object
  inherit container obj
  method pack : 'b . (#is_widget as 'b) -> _ =
    fun w ->  Box.pack ?obj ?w#as_widget
  method set_packing = Box.setter ?obj ?cont:null_cont
  method set_child_packing : 'b . (#is_widget as 'b) -> _ =
    fun w -> Box.set_child_packing ?obj ?w#as_widget
end

class box_wrapper obj = object
  inherit box_skel (Box.coerce obj)
  method connect = new container_signals ?obj
end

class box dir ?:homogeneous ?:spacing
    ?:border_width ?:width ?:height ?:packing ?:show =
  let w = Box.create dir ?:homogeneous ?:spacing in
  let () =
    Container.setter w cont:null_cont ?:border_width ?:width ?:height in
  object (self)
    inherit box_wrapper w
    initializer pack_return :packing ?:show (self :> box_wrapper)
  end

class button_box_wrapper obj = object
  inherit box_skel (BBox.coerce obj)
  method connect = new container_signals ?obj
  method set_layout  = BBox.set_layout  obj
  method set_spacing = BBox.set_spacing obj
  method set_child_size = BBox.set_child_size obj
end

class button_box dir ?:spacing ?:child_width ?:child_height ?:child_ipadx
    ?:child_ipady ?:layout ?:border_width ?:width ?:height ?:packing ?:show =
  let w = BBox.create dir in
  let () =
    BBox.setter w cont:null_cont ?:spacing ?:child_width ?:child_height
      ?:child_ipadx ?:child_ipady ?:layout;
    Container.setter w cont:null_cont ?:border_width ?:width ?:height in
  object (self)
    inherit button_box_wrapper w
    initializer pack_return :packing ?:show (self :> button_box_wrapper)
  end

class table_wrapper obj = object
  inherit container_wrapper (obj : Gtk.table obj)
  method attach : 'a. (#is_widget as 'a) -> _ =
    fun w -> Table.attach obj w#as_widget
  method set_packing = Table.setter ?obj ?cont:null_cont
end

class table :rows :columns ?:homogeneous ?:row_spacings ?:col_spacings
    ?:border_width ?:width ?:height ?:packing ?:show =
  let w = Table.create :rows :columns ?:homogeneous in
  let () =
    Table.setter w cont:null_cont ?:row_spacings ?:col_spacings;
    Container.setter w cont:null_cont ?:border_width ?:width ?:height in
  object (self)
    inherit table_wrapper w
    initializer pack_return :packing ?:show (self :> table_wrapper)
  end

class fixed_wrapper obj = object
  inherit container_wrapper (obj : fixed obj)
  method add_events = Widget.add_events obj
  method put : 'a. (#is_widget as 'a) -> _ =
    fun w -> Fixed.put obj w#as_widget
  method move : 'a. (#is_widget as 'a) -> _ =
    fun w -> Fixed.move obj w#as_widget
end

class fixed ?:border_width ?:width ?:height ?:packing ?:show =
  let w = Fixed.create () in
  let () = Container.setter w cont:null_cont ?:border_width ?:width ?:height in
  object (self)
    inherit fixed_wrapper w
    initializer pack_return :packing ?:show (self :> fixed_wrapper)
  end
