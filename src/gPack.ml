(**************************************************************************)
(*                Lablgtk                                                 *)
(*                                                                        *)
(*    This program is free software; you can redistribute it              *)
(*    and/or modify it under the terms of the GNU Library General         *)
(*    Public License as published by the Free Software Foundation         *)
(*    version 2, with the exception described in file COPYING which       *)
(*    comes with the library.                                             *)
(*                                                                        *)
(*    This program is distributed in the hope that it will be useful,     *)
(*    but WITHOUT ANY WARRANTY; without even the implied warranty of      *)
(*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the       *)
(*    GNU Library General Public License for more details.                *)
(*                                                                        *)
(*    You should have received a copy of the GNU Library General          *)
(*    Public License along with this program; if not, write to the        *)
(*    Free Software Foundation, Inc., 59 Temple Place, Suite 330,         *)
(*    Boston, MA 02111-1307  USA                                          *)
(*                                                                        *)
(*                                                                        *)
(**************************************************************************)

(* $Id$ *)

open Gaux
open Gobject
open Gtk
open GtkBase
open GtkPack
open OgtkPackProps
open GObj
open GContainer

module P = Box.P

class box_skel obj = object
  inherit [[> Gtk.box]] container_impl obj
  method pack ?from:f ?expand ?fill ?padding w =
    Box.pack obj (as_widget w) ?from:f ?expand ?fill ?padding
  method set_homogeneous = set P.homogeneous obj
  method homogeneous = get P.homogeneous obj
  method set_spacing = set P.spacing obj
  method spacing = get P.spacing obj
  method set_child_packing ?from:f ?expand ?fill ?padding w =
    Box.set_child_packing obj (as_widget w) ?from:f ?expand ?fill ?padding
  method reorder_child w = Box.reorder_child obj (as_widget w)
end

class box obj = object
  inherit box_skel obj
  method connect = new container_signals_impl obj
end
  
let box dir =
  Box.make_params [] ~cont:(
  pack_container ~create:(fun p -> new box (Box.create dir p)))

let vbox = box `VERTICAL
let hbox = box `HORIZONTAL

class button_box obj = object
  inherit box_skel obj
  method connect = new container_signals_impl obj
  method set_layout  = set BBox.P.layout_style  obj
  method layout  = get BBox.P.layout_style  obj
  method get_child_secondary (w : widget) =
    BBox.get_child_secondary obj w#as_widget
  method set_child_secondary (w : widget) =
    BBox.set_child_secondary obj w#as_widget
end

let button_box dir ?layout =
  pack_container [] ~create:(fun p ->
    let p = Property.may_cons BBox.P.layout_style layout p in
    let w = BBox.create dir p in
    new button_box w)

class fixed obj = object
  inherit container_full (obj : Gtk.fixed obj)
  method event = new GObj.event_ops obj
  method put w = Fixed.put obj (as_widget w)
  method move w = Fixed.move obj (as_widget w)
end

let fixed =
  pack_container [] ~create:(fun p -> new fixed (Fixed.create p))

class layout obj = object
  inherit container_full obj
  method event = new GObj.event_ops obj
  method put w = Layout.put obj (as_widget w)
  method move w = Layout.move obj (as_widget w)
  method set_hadjustment adj =
    set Layout.P.hadjustment obj (GData.as_adjustment adj)
  method set_vadjustment adj =
    set Layout.P.vadjustment obj (GData.as_adjustment adj)
  method set_width = set Layout.P.width obj
  method set_height = set Layout.P.height obj
  method hadjustment = new GData.adjustment (get Layout.P.hadjustment obj)
  method vadjustment = new GData.adjustment (get Layout.P.vadjustment obj)
  method bin_window = Layout.get_bin_window obj
  method width = get Layout.P.width obj
  method height = get Layout.P.height obj
end

let layout ?hadjustment ?vadjustment ?layout_width ?layout_height =
  Layout.make_params []
    ?hadjustment:(may_map GData.as_adjustment hadjustment)
    ?vadjustment:(may_map GData.as_adjustment hadjustment)
    ?width:layout_width ?height:layout_height ~cont:(
  pack_container ~create:(fun p -> new layout (Layout.create p)))

(*
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
*)

let check1 obj =
  try ignore(Paned.get_child1 obj);
    raise(Error "GPack.paned#add1: already full")
  with _ -> ()

let check2 obj =
  try ignore(Paned.get_child1 obj);
    raise(Error "GPack.paned#add1: already full")
  with _ -> ()

class paned obj = object
  inherit [Gtk.paned] container_impl obj
  inherit paned_props
  method connect = new container_signals_impl obj
  method event = new GObj.event_ops obj
  method add w =
    if List.length (Container.children obj) = 2 then
      raise(Error "Gpack.paned#add: already full");
    Container.add obj (as_widget w)
  method add1 w = check1 obj; Paned.add1 obj (as_widget w)
  method add2 w = check2 obj; Paned.add2 obj (as_widget w)
  method pack1 ?(resize=false) ?(shrink=false) w =
    check1 obj; Paned.pack1 obj (as_widget w) ~resize ~shrink
  method pack2 ?(resize=false) ?(shrink=false) w =
    check2 obj; Paned.pack2 obj (as_widget w) ~resize ~shrink
  method child1 = new widget (Paned.get_child1 obj)
  method child2 = new widget (Paned.get_child2 obj)
end

let paned dir =
  pack_container [] ~create:(fun p -> new paned (Paned.create dir p))

class notebook_signals obj = object (self)
  inherit container_signals_impl obj
  method switch_page ~callback = 
    self#connect Notebook.S.switch_page (fun _ arg1 -> callback arg1)
  inherit notebook_sigs
end

class notebook obj = object (self)
  inherit [Gtk.notebook] GContainer.container_impl obj
  inherit notebook_props
  method as_notebook = (obj :> Gtk.notebook obj)
  method event = new GObj.event_ops obj
  method connect = new notebook_signals obj
  method insert_page ?tab_label ?menu_label ?pos child =
      Notebook.insert_page_menu obj (as_widget child) 
	~tab_label:(Gpointer.may_box tab_label ~f:as_widget)
	~menu_label:(Gpointer.may_box menu_label ~f:as_widget)
        ?pos
  method append_page ?tab_label ?menu_label child = 
    self#insert_page ?tab_label ?menu_label child 
  method prepend_page = self#insert_page ~pos:0
  method remove_page = Notebook.remove_page obj
  method current_page = get Notebook.P.page obj
  method previous_page () = Notebook.prev_page obj
  method goto_page = set Notebook.P.page obj
  method next_page () = Notebook.next_page obj
  method page_num w = Notebook.page_num obj (as_widget w)
  method get_nth_page n = new widget (Notebook.get_nth_page obj n)
  method get_tab_label w =
    new widget (Notebook.get_tab_label obj (as_widget w))
  method get_menu_label w =
    new widget (Notebook.get_menu_label obj (as_widget w))
  method reorder_child (w : widget) i =
    Notebook.reorder_child obj (as_widget w) i
  method set_page ?tab_label ?menu_label page =
    let child = as_widget page in
    may tab_label
      ~f:(fun lbl -> Notebook.set_tab_label obj child (as_widget lbl));
    may menu_label
      ~f:(fun lbl -> Notebook.set_menu_label obj child (as_widget lbl))
  method set_tab_reorderable (w : widget) = Notebook.set_tab_reorderable obj
  (as_widget w)
  method get_tab_reorderable (w : widget) = Notebook.get_tab_reorderable obj
  (as_widget w)
end

let notebook =
  Notebook.make_params [] ~cont:(
  pack_container ~create:(fun p -> new notebook (Notebook.create p)))
