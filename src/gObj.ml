(* $Id$ *)

open StdLabels
open Gaux
open Gobject
open Gtk
open GtkData
open GtkBase

(* GObject *)

class gobject_signals ?(after=false) obj = object
  val obj = obj
  val after = after
  method after = {< after = true >}
end

class gobject_ops obj = object
  val obj = obj
  method get_oid = get_oid obj
  method get_type = Type.name (get_type obj)
  method disconnect = GtkSignal.disconnect obj
  method handler_block = GtkSignal.handler_block obj
  method handler_unblock = GtkSignal.handler_unblock obj
  method set_property : 'a. string -> 'a data_set -> unit =
    Property.set_dyn obj
  method get_property = Property.get_dyn obj
  method freeze_notify () = Property.freeze_notify obj
  method thaw_notify () = Property.thaw_notify obj
end

(* GtkObject *)

class gtkobj obj = object
  val obj = obj
  method destroy () = Object.destroy obj
  method get_oid = get_oid obj
end

class gtkobj_signals ?after obj = object
  inherit gobject_signals ?after obj
  method destroy = GtkSignal.connect ~sgn:Object.Signals.destroy obj
end

(* Widget *)

class event_signals ?(after=false) obj = object
  val obj = (obj :> Gtk.widget obj)
  val after = after
  method after = {< after = true >}
  method any = GtkSignal.connect ~sgn:Widget.Signals.Event.any ~after obj
  method button_press =
    GtkSignal.connect ~sgn:Widget.Signals.Event.button_press ~after obj
  method button_release =
    GtkSignal.connect ~sgn:Widget.Signals.Event.button_release ~after obj
  method configure =
    GtkSignal.connect ~sgn:Widget.Signals.Event.configure ~after obj
  method delete =
    GtkSignal.connect ~sgn:Widget.Signals.Event.delete ~after obj
  method destroy =
    GtkSignal.connect ~sgn:Widget.Signals.Event.destroy ~after obj
  method enter_notify =
    GtkSignal.connect ~sgn:Widget.Signals.Event.enter_notify ~after obj
  method expose =
    GtkSignal.connect ~sgn:Widget.Signals.Event.expose ~after obj
  method focus_in =
    GtkSignal.connect ~sgn:Widget.Signals.Event.focus_in ~after obj
  method focus_out =
    GtkSignal.connect ~sgn:Widget.Signals.Event.focus_out ~after obj
  method key_press =
    GtkSignal.connect ~sgn:Widget.Signals.Event.key_press ~after obj
  method key_release =
    GtkSignal.connect ~sgn:Widget.Signals.Event.key_release ~after obj
  method leave_notify =
    GtkSignal.connect ~sgn:Widget.Signals.Event.leave_notify ~after obj
  method map = GtkSignal.connect ~sgn:Widget.Signals.Event.map ~after obj
  method motion_notify =
    GtkSignal.connect ~sgn:Widget.Signals.Event.motion_notify ~after obj
  method property_notify =
    GtkSignal.connect ~sgn:Widget.Signals.Event.property_notify ~after obj
  method proximity_in =
    GtkSignal.connect ~sgn:Widget.Signals.Event.proximity_in ~after obj
  method proximity_out =
    GtkSignal.connect ~sgn:Widget.Signals.Event.proximity_out ~after obj
  method selection_clear =
    GtkSignal.connect ~sgn:Widget.Signals.Event.selection_clear ~after obj
  method selection_notify =
    GtkSignal.connect ~sgn:Widget.Signals.Event.selection_notify ~after obj
  method selection_request =
    GtkSignal.connect ~sgn:Widget.Signals.Event.selection_request ~after obj
  method unmap = GtkSignal.connect ~sgn:Widget.Signals.Event.unmap ~after obj
end

class event_ops obj = object
  val obj = (obj :> Gtk.widget obj)
  method add = Widget.add_events obj
  method connect = new event_signals obj
  method send : Gdk.Tags.event_type Gdk.event -> bool = Widget.event obj
  method set_extensions = Widget.set_extension_events obj
end

let iter_setcol set style =
  List.iter ~f:(fun (state, color) -> set style state (GDraw.color color))

class style st = object
  val style = st
  method as_style = style
  method copy = {< style = Style.copy style >}
  method colormap = Style.get_colormap style
  method font = Style.get_font style
  method bg = Style.get_bg style
  method set_bg = iter_setcol Style.set_bg style
  method fg = Style.get_fg style
  method set_fg = iter_setcol Style.set_fg style
  method light = Style.get_light style
  method set_light = iter_setcol Style.set_light style
  method dark = Style.get_dark style
  method set_dark = iter_setcol Style.set_dark style
  method mid = Style.get_mid style
  method set_mid = iter_setcol Style.set_mid style
  method base = Style.get_base style
  method set_base = iter_setcol Style.set_base style
  method text = Style.get_text style
  method set_text = iter_setcol Style.set_text style
  method set_font = Style.set_font style
end

class selection_input (sel : Gtk.selection_data) = object
  val sel = sel
  method selection = Selection.selection sel
  method target = Gdk.Atom.name (Selection.target sel)
end

class selection_data sel = object
  inherit selection_input sel
  method typ = Gdk.Atom.name (Selection.seltype sel)
  method data = Selection.get_data sel
  method format = Selection.format sel
end

class selection_context sel = object
  inherit selection_input sel
  method return ?typ ?(format=8) data =
    let typ =
      match typ with Some t -> Gdk.Atom.intern t | _ -> Selection.target sel in
    Selection.set sel ~typ ~format ~data:(Some data)
end

class drag_signals obj = object
  val obj =  obj
  val after = false
  method after = {< after = true >}
  method beginning ~callback =
    GtkSignal.connect ~sgn:DnD.Signals.drag_begin ~after obj
      ~callback:(fun context -> callback (new drag_context context))
  method ending ~callback =
    GtkSignal.connect ~sgn:DnD.Signals.drag_end ~after obj
      ~callback:(fun context -> callback (new drag_context context))
  method data_delete ~callback =
    GtkSignal.connect ~sgn:DnD.Signals.drag_data_delete ~after obj
      ~callback:(fun context -> callback (new drag_context context))
  method leave ~callback =
    GtkSignal.connect ~sgn:DnD.Signals.drag_leave ~after obj
      ~callback:(fun context -> callback (new drag_context context))
  method motion ~callback =
    GtkSignal.connect ~sgn:DnD.Signals.drag_motion ~after obj
      ~callback:(fun context -> callback (new drag_context context))
  method drop ~callback =
    GtkSignal.connect ~sgn:DnD.Signals.drag_drop ~after obj
      ~callback:(fun context -> callback (new drag_context context))
  method data_get ~callback =
    GtkSignal.connect ~sgn:DnD.Signals.drag_data_get ~after obj ~callback:
      begin fun context seldata ~info ~time ->
        callback (new drag_context context) (new selection_context seldata)
          ~info ~time
      end
  method data_received ~callback =
    GtkSignal.connect ~sgn:DnD.Signals.drag_data_received ~after obj
      ~callback:(fun context ~x ~y data -> callback (new drag_context context)
	       ~x ~y (new selection_data data))

end

and drag_ops obj = object
  val obj = obj
  method connect = new drag_signals obj
  method dest_set ?(flags=[`ALL]) ?(actions=[]) targets =
    DnD.dest_set obj ~flags ~actions ~targets:(Array.of_list targets)
  method dest_unset () = DnD.dest_unset obj
  method get_data ~target ?(time=Int32.zero) (context : drag_context) =
    DnD.get_data obj context#context ~target:(Gdk.Atom.intern target) ~time
  method highlight () = DnD.highlight obj
  method unhighlight () = DnD.unhighlight obj
  method source_set ?modi:m ?(actions=[]) targets =
    DnD.source_set obj ?modi:m ~actions ~targets:(Array.of_list targets)
  method source_set_icon ?(colormap = Gdk.Color.get_system_colormap ())
      (pix : GDraw.pixmap) =
    DnD.source_set_icon obj ~colormap pix#pixmap ?mask:pix#mask
  method source_unset () = DnD.source_unset obj
end

and drag_context context = object
  inherit GDraw.drag_context context
  method context = context
  method finish = DnD.finish context
  method source_widget =
    new widget (unsafe_cast (DnD.get_source_widget context))
  method set_icon_widget (w : widget) =
    DnD.set_icon_widget context (w#as_widget)
  method set_icon_pixmap ?(colormap = Gdk.Color.get_system_colormap ())
      (pix : GDraw.pixmap) =
    DnD.set_icon_pixmap context ~colormap pix#pixmap ?mask:pix#mask
end

and misc_signals ?after obj = object
  inherit gtkobj_signals ?after obj
  method show = GtkSignal.connect ~sgn:Widget.Signals.show ~after obj
  method hide = GtkSignal.connect ~sgn:Widget.Signals.hide ~after obj
  method map = GtkSignal.connect ~sgn:Widget.Signals.map ~after obj
  method unmap = GtkSignal.connect ~sgn:Widget.Signals.unmap ~after obj
  method realize = GtkSignal.connect ~sgn:Widget.Signals.realize ~after obj
  method size_allocate =
    GtkSignal.connect ~sgn:Widget.Signals.size_allocate ~after obj
  method state_changed =
    GtkSignal.connect ~sgn:Widget.Signals.state_changed ~after obj
  method parent_set ~callback =
    GtkSignal.connect obj ~sgn:Widget.Signals.parent_set ~after ~callback:
      begin function
	  None   -> callback None
	| Some w -> callback (Some (new widget (unsafe_cast w)))
      end
  method style_set ~callback =
    GtkSignal.connect obj ~sgn:Widget.Signals.style_set ~after ~callback:
      (fun opt -> callback (may opt ~f:(new style)))
  method selection_get ~callback =
    GtkSignal.connect obj ~sgn:Selection.Signals.selection_get ~after
      ~callback:
      begin fun seldata ~info ~time ->
        callback (new selection_context seldata) ~info ~time
      end
  method selection_received ~callback =
    GtkSignal.connect obj ~sgn:Selection.Signals.selection_received ~after
      ~callback:(fun data -> callback (new selection_data data)) 
end

and misc_ops obj = object (self)
  inherit gobject_ops obj
  method connect = new misc_signals obj
  method show () = Widget.show obj
  method unparent () = Widget.unparent obj
  method show_all () = Widget.show_all obj
  method hide () = Widget.hide obj
  method hide_all () = Widget.hide_all obj
  method map () = Widget.map obj
  method unmap () = Widget.unmap obj
  method realize () = Widget.realize obj
  method unrealize () = Widget.unrealize obj
  method draw = Widget.draw obj
  method activate () = Widget.activate obj
  method reparent (w : widget) =  Widget.reparent obj w#as_widget
  (* method popup = Widget.popup obj *)
  method intersect = Widget.intersect obj
  method grab_focus () = Widget.grab_focus obj
  method grab_default () = Widget.grab_default obj
  method is_ancestor (w : widget) = Widget.is_ancestor obj w#as_widget
  method add_accelerator ~sgn:sg ~group ?modi ?flags key =
    Widget.add_accelerator obj ~sgn:sg group ~key ?modi ?flags
  method remove_accelerator ~group ?modi key =
    Widget.remove_accelerator obj group ~key ?modi
  (* method lock_accelerators () = Widget.lock_accelerators obj *)
  method set_name = Widget.set_name obj
  method set_state = Widget.set_state obj
  method set_sensitive = Widget.set_sensitive obj
  method set_can_default = Widget.set_can_default obj
  method set_can_focus = Widget.set_can_focus obj
  method set_geometry ?(x = -2) ?(y = -2) ?(width = -2) ?(height = -2)  () =
    if x+y <> -4 then Widget.set_uposition obj ~x ~y;
    if width+height <> -4 then Widget.set_usize obj ~width ~height
  method set_size_request = Widget.set_size_request obj
  method set_size_chars ?desc ?lang ?width ?height () =
    let metrics = 
      (self#pango_context : GPango.context)#get_metrics ?desc ?lang () in
    let width = may_map width ~f:
        (fun w -> w * GPango.to_pixels metrics#approx_digit_width)
    and height = may_map height ~f:
        (fun h -> h * GPango.to_pixels (metrics#ascent+metrics#descent)) in
    self#set_geometry ?width ?height ()
  method set_style (style : style) = Widget.set_style obj style#as_style
  method modify_fg = iter_setcol Widget.modify_fg obj
  method modify_bg = iter_setcol Widget.modify_bg obj
  method modify_text = iter_setcol Widget.modify_text obj
  method modify_base = iter_setcol Widget.modify_base obj
  method modify_font = Widget.modify_font obj
  method modify_font_by_name s =
    Widget.modify_font obj (Pango.Font.from_string s)
  method create_pango_context () =
    new GPango.context_rw (Widget.create_pango_context obj)
  (* get functions *)
  method name = Widget.get_name obj
  method toplevel =
    try new widget (unsafe_cast (Widget.get_toplevel obj))
    with Gpointer.Null -> failwith "GObj.misc_ops#toplevel"
  method window = Widget.window obj
  method colormap = Widget.get_colormap obj
  method visual = Widget.get_visual obj
  method visual_depth = Gdk.Visual.depth (Widget.get_visual obj)
  method pointer = Widget.get_pointer obj
  method style = new style (Widget.get_style obj)
  method visible = Widget.visible obj
  method has_focus = Widget.has_focus obj
  method parent =
    try Some (new widget (unsafe_cast (Widget.parent obj)))
    with Gpointer.Null -> None
  method set_app_paintable = Widget.set_app_paintable obj
  method allocation = Widget.allocation obj
  method pango_context = new GPango.context (Widget.get_pango_context obj)
  (* selection *)
  method convert_selection ~target ?(time=Int32.zero) sel =
    Selection.convert obj ~sel ~target:(Gdk.Atom.intern target) ~time
  method grab_selection ?(time=Int32.zero) sel = Selection.owner_set obj ~sel ~time
  method add_selection_target ~target ?(info=0) sel =
    Selection.add_target obj ~sel ~target:(Gdk.Atom.intern target) ~info
end

and widget obj = object (self)
  inherit gtkobj obj
  method as_widget = (obj :> Gtk.widget obj)
  method misc = new misc_ops (obj :> Gtk.widget obj)
  method drag = new drag_ops (unsafe_cast obj : Gtk.widget obj)
  method coerce = (self :> widget)
end

(* just to check that GDraw.misc_ops is compatible with misc_ops *)
let _ = fun (x : #GDraw.misc_ops) -> (x : misc_ops)

class widget_signals (obj : [> `widget] obj) =
  gtkobj_signals obj

class widget_full obj = object
  inherit widget obj
  method connect = new widget_signals obj
end

let as_widget (w : widget) = w#as_widget

let pack_return self ~packing ~show =
  may packing ~f:(fun f -> (f (self :> widget) : unit));
  if show <> Some false then self#misc#show ();
  self
