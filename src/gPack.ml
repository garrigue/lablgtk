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
  method reorder_child : 'a. (#is_widget as 'a) -> _ =
    fun w -> Box.reorder_child obj w#as_widget
end

class box_wrapper obj = object
  inherit box_skel (Box.coerce obj)
  method connect = new container_signals ?obj
end

class box dir ?:homogeneous ?:spacing
    ?:border_width ?:width ?:height ?:packing ?:show =
  let w = Box.create dir ?:homogeneous ?:spacing in
  let () =
    Container.set w ?:border_width ?:width ?:height in
  object (self)
    inherit box_wrapper w
    initializer pack_return :packing ?:show (self :> box_wrapper)
  end

class vbox = box ?`VERTICAL
class hbox = box ?`HORIZONTAL

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
    Container.set w ?:border_width ?:width ?:height in
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
    Container.set w ?:border_width ?:width ?:height in
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
  let () = Container.set w ?:border_width ?:width ?:height in
  object (self)
    inherit fixed_wrapper w
    initializer pack_return :packing ?:show (self :> fixed_wrapper)
  end

class layout_wrapper obj = object
  inherit container_wrapper (obj : layout obj)
  method add_events = Widget.add_events obj
  method put : 'a. (#is_widget as 'a) -> _ =
    fun w -> Layout.put obj w#as_widget
  method move : 'a. (#is_widget as 'a) -> _ =
    fun w -> Layout.move obj w#as_widget
  method set_layout ?:hadjustment ?:vadjustment =
    may (GData.adjustment_option hadjustment) fun:(Layout.set_hadjustment obj);
    may (GData.adjustment_option vadjustment) fun:(Layout.set_vadjustment obj);
    Layout.set ?obj
  method hadjustment =
    new GData.adjustment_wrapper (Layout.get_hadjustment obj)
  method vadjustment =
    new GData.adjustment_wrapper (Layout.get_vadjustment obj)
  method freeze () = Layout.freeze obj
  method thaw () = Layout.thaw obj
  method width = Layout.get_width obj
  method height = Layout.get_height obj
end

class layout ?:hadjustment ?:vadjustment ?:layout_width ?:layout_height
    ?:border_width ?:width ?:height ?:packing ?:show =
  let w = Layout.create
      (optboxed (GData.adjustment_option hadjustment))
      (optboxed (GData.adjustment_option vadjustment)) in
  let () =
    Layout.set w ?width:layout_width ?height:layout_height;
    Container.set w ?:border_width ?:width ?:height in
  object (self)
    inherit layout_wrapper w
    initializer pack_return :packing ?:show (self :> layout_wrapper)
  end

class packer_wrapper obj = object
  inherit container_wrapper (obj : packer obj)
  method pack : 'a. (#is_widget as 'a) -> _ =
    fun w ?:side ?:anchor ?:expand ?:fill
	?:border_width ?:pad_x ?:pad_y ?:i_pad_x ?:i_pad_y ->
      let options = Packer.build_options ?:expand ?:fill in
      if border_width == None && pad_x == None && pad_y == None &&
	i_pad_x == None && i_pad_y == None
      then Packer.add_defaults obj w#as_widget ?:side ?:anchor :options
      else Packer.add obj w#as_widget ?:side ?:anchor :options
	  ?:border_width ?:pad_x ?:pad_y ?:i_pad_x ?:i_pad_y
  method set_child_packing : 'a. (#is_widget as 'a) -> _ =
    fun w ?:side ?:anchor ?:expand ?:fill ->
      Packer.set_child_packing ?obj ?w#as_widget ?:side ?:anchor
	?options:(Some (Packer.build_options ?:expand ?:fill))
  method reorder_child : 'a. (#is_widget as 'a) -> _ =
    fun w -> Packer.reorder_child obj w#as_widget
  method set_spacing = Packer.set_spacing obj
  method set_defaults = Packer.set_defaults ?obj
end

class packer ?:spacing ?:border_width ?:width ?:height ?:packing ?:show =
  let w = Packer.create () in
  let () =
    may spacing fun:(Packer.set_spacing w);
    Container.set w ?:border_width ?:width ?:height in
  object (self)
    inherit packer_wrapper w
    initializer pack_return :packing ?:show (self :> packer_wrapper)
  end

class paned_wrapper obj = object
  inherit container_wrapper (obj : paned obj)
  method add_events = Widget.add_events obj
  method add1 : 'a. (#is_widget as 'a) -> _ =
    fun w -> Paned.add1 obj w#as_widget
  method add2 : 'a. (#is_widget as 'a) -> _ =
    fun w -> Paned.add2 obj w#as_widget
  method set_size ?:handle ?:gutter =
    Paned.setter obj cont:null_cont ?handle_size:handle ?gutter_size:gutter
end

class paned dir ?:handle_size ?:gutter_size ?:border_width
    ?:width ?:height ?:packing ?:show =
  let w = Paned.create dir in
  let () =
    Paned.setter w cont:null_cont ?:handle_size ?:gutter_size;
    Container.set w ?:border_width ?:width ?:height in
  object (self)
    inherit paned_wrapper w
    initializer pack_return :packing ?:show (self :> paned_wrapper)
  end
