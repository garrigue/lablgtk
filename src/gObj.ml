(* $Id$ *)

open Misc
open Gtk
open GtkData
open GtkBase

(* Class declarations *)

class type is_widget = object method as_widget : widget obj end

class type ['a] is_item = object
  constraint 'a = [> item]
  method as_item : 'a obj
end

class type is_menu = object method as_menu : menu obj end

class type is_tree = object method as_tree : tree obj end

class type is_window = object method as_window : window obj end

(* Object *)

class gtkobj obj = object
  val obj = obj
  method destroy () = Object.destroy obj
  method get_type = Object.get_type obj
  method get_id = Object.get_id obj
end

class gtkobj_signals obj = object
  val obj = obj
  method destroy = GtkSignal.connect sig:Object.Signals.destroy obj
  method disconnect = GtkSignal.disconnect obj
  method stop_emit :name = GtkSignal.emit_stop_by_name obj :name
end

(* Widget *)

class event_signals obj = object
  val obj = Widget.coerce obj
  method any = GtkSignal.connect sig:Widget.Signals.Event.any obj
  method button_press =
    GtkSignal.connect sig:Widget.Signals.Event.button_press obj
  method button_release =
    GtkSignal.connect sig:Widget.Signals.Event.button_release obj
  method configure =
    GtkSignal.connect sig:Widget.Signals.Event.configure obj
  method delete =
    GtkSignal.connect sig:Widget.Signals.Event.delete obj
  method destroy =
    GtkSignal.connect sig:Widget.Signals.Event.destroy obj
  method enter_notify =
    GtkSignal.connect sig:Widget.Signals.Event.enter_notify obj
  method expose =
    GtkSignal.connect sig:Widget.Signals.Event.expose obj
  method focus_in =
    GtkSignal.connect sig:Widget.Signals.Event.focus_in obj
  method focus_out =
    GtkSignal.connect sig:Widget.Signals.Event.focus_out obj
  method key_press =
    GtkSignal.connect sig:Widget.Signals.Event.key_press obj
  method key_release =
    GtkSignal.connect sig:Widget.Signals.Event.key_release obj
  method leave_notify =
    GtkSignal.connect sig:Widget.Signals.Event.leave_notify obj
  method map = GtkSignal.connect sig:Widget.Signals.Event.map obj
  method motion_notify =
    GtkSignal.connect sig:Widget.Signals.Event.motion_notify obj
  method property_notify =
    GtkSignal.connect sig:Widget.Signals.Event.property_notify obj
  method proximity_in =
    GtkSignal.connect sig:Widget.Signals.Event.proximity_in obj
  method proximity_out =
    GtkSignal.connect sig:Widget.Signals.Event.proximity_out obj
  method selection_clear =
    GtkSignal.connect sig:Widget.Signals.Event.selection_clear obj
  method selection_notify =
    GtkSignal.connect sig:Widget.Signals.Event.selection_notify obj
  method selection_request =
    GtkSignal.connect sig:Widget.Signals.Event.selection_request obj
  method unmap = GtkSignal.connect sig:Widget.Signals.Event.unmap obj
end

class event_ops obj = object
  val obj = (Widget.coerce obj)
  method connect = new event_signals ?obj
  method set_extensions = Widget.set_extension_events obj
end

class style st = object
  val style = st
  method as_style = style
  method copy = {< style = Style.copy style >}
  method bg state = Style.get_bg style :state
  method colormap = Style.get_colormap style
  method font = Style.get_font style
  method set_bg =
    List.iter fun:
      (fun (state,c) -> Style.set_bg style :state color:(GdkObj.color c))
  method set_font = Style.set_font style
  method set_background = Style.set_background style
end

class selection_data (sel : Selection.t) = object
  val sel = sel
  method selection = Selection.selection sel
  method target = Selection.target sel
  method seltype = Selection.seltype sel
  method format = Selection.format sel
  method data = Selection.get_data sel
  method set = Selection.set sel
end

class widget_drag obj = object
  val obj = Widget.coerce obj
  method dest_set ?:flags [< [`ALL] >] :targets =
    DnD.dest_set obj :flags targets:(Array.of_list targets)
  method dest_unset () = DnD.dest_unset obj
  method get_data (context : drag_context) :target ?:time [< 0 >] =
    DnD.get_data obj (context : < context : Gdk.drag_context; .. >)#context
      :target :time
  method highlight () = DnD.highlight obj
  method unhighlight () = DnD.unhighlight obj
  method source_set ?mod:m :targets =
    DnD.source_set obj ?mod:m targets:(Array.of_list targets)
  method source_set_icon ?:colormap (pix : GdkObj.pixmap) =
    DnD.source_set_icon obj ?:colormap pix#pixmap ?mask:pix#mask
  method source_unset () = DnD.source_unset obj
end


and drag_context context = object
  inherit GdkObj.drag_context context
  method context = context
  method finish :success :del ?:time [< 0 >] =
    DnD.finish context :success :del :time
  method source_widget =
    new widget_wrapper (Object.unsafe_cast (DnD.get_source_widget context))
  method set_icon_widget : 'a . (#is_widget as 'a) -> _ = fun w ->
    DnD.set_icon_widget context (w#as_widget)
  method set_icon_pixmap ?:colormap (pix : GdkObj.pixmap) =
    DnD.set_icon_pixmap context ?:colormap pix#pixmap ?mask:pix#mask
end

and drag_signals obj = object
  val obj =  Widget.coerce obj
  method beginning :callback =
    GtkSignal.connect ?sig:Widget.Signals.drag_begin ?obj
      ?callback:(fun context -> callback (new drag_context context))
  method ending :callback =
    GtkSignal.connect ?sig:Widget.Signals.drag_end ?obj
      ?callback:(fun context -> callback (new drag_context context))
  method data_delete :callback =
    GtkSignal.connect ?sig:Widget.Signals.drag_data_delete ?obj
      ?callback:(fun context -> callback (new drag_context context))
  method leave :callback =
    GtkSignal.connect ?sig:Widget.Signals.drag_leave ?obj
      ?callback:(fun context -> callback (new drag_context context))
  method motion :callback =
    GtkSignal.connect ?sig:Widget.Signals.drag_motion ?obj
      ?callback:(fun context -> callback (new drag_context context))
  method drop :callback =
    GtkSignal.connect ?sig:Widget.Signals.drag_drop ?obj
      ?callback:(fun context -> callback (new drag_context context))
  method data_get :callback =
    GtkSignal.connect ?sig:Widget.Signals.drag_data_get ?obj
      ?callback:(fun context data -> callback (new drag_context context)
	       (new selection_data data))
  method data_received :callback =
    GtkSignal.connect ?sig:Widget.Signals.drag_data_received ?obj
      ?callback:(fun context :x :y data -> callback (new drag_context context)
	       :x :y (new selection_data data))

end

and widget_misc obj = object
  val obj = Widget.coerce obj
  method show () = Widget.show obj
  method unparent () = Widget.unparent obj
  method show_all () = Widget.show_all obj
  method hide () = Widget.hide obj
  method hide_all () = Widget.hide_all obj
  method map () = Widget.map obj
  method unmap () = Widget.unmap obj
  method realize () = Widget.realize obj
  method unrealize () = Widget.realize obj
  method draw = Widget.draw obj
  method event : 'a. 'a Gdk.event -> bool = Widget.event obj
  method activate () = Widget.activate obj
  method reparent : 'a. (#is_widget as 'a) -> unit =
    fun w -> Widget.reparent obj w#as_widget
  method popup = Widget.popup obj
  method intersect = Widget.intersect obj
  method grab_focus () = Widget.grab_focus obj
  method grab_default () = Widget.grab_default obj
  method is_ancestor : 'a. (#is_widget as 'a) -> bool =
    fun w -> Widget.is_ancestor obj w#as_widget
  method add_accelerator = Widget.add_accelerator obj
  method remove_accelerator = Widget.remove_accelerator obj
  method lock_accelerators () = Widget.lock_accelerators obj
  method set_name = Widget.set_name obj
  method set_state = Widget.set_state obj
  method set_sensitive = Widget.set_sensitive obj
  method set_extension_events = Widget.set_extension_events obj
  method set_can_default = Widget.set_can_default obj
  method set_can_focus = Widget.set_can_focus obj
  method set_position = Widget.set_position ?obj
  method set_size = Widget.set_size ?obj
  method set_style (style : style) = Widget.set_style obj style#as_style
  (* get functions *)
  method name = Widget.get_name obj
  method toplevel =
    try new widget_wrapper (Object.unsafe_cast (Widget.get_toplevel obj))
    with Null_pointer -> raise Not_found
  method window = Widget.window obj
  method colormap = Widget.get_colormap obj
  method visual = Widget.get_visual obj
  method visual_depth = Gdk.Window.visual_depth (Widget.get_visual obj)
  method pointer = Widget.get_pointer obj
  method style = new style (Widget.get_style obj)
  method visible = Widget.visible obj
  method has_focus = Widget.has_focus obj
  method parent =
    try new widget_wrapper (Object.unsafe_cast (Widget.parent obj))
    with Null_pointer -> raise Not_found
  method set_app_paintable = Widget.set_app_paintable obj
  method allocation = Widget.allocation obj
end

and widget obj = object (self)
  inherit gtkobj obj
  method as_widget = Widget.coerce obj
  method misc = new widget_misc obj
  method drag = new widget_drag (Object.unsafe_cast obj)
end

and widget_signals obj = object
  inherit gtkobj_signals obj
  method event = new event_signals obj
  method drag = new drag_signals obj
  method realize = GtkSignal.connect sig:Widget.Signals.realize obj
  method show = GtkSignal.connect sig:Widget.Signals.show obj
  method parent_set :callback =
    GtkSignal.connect ?obj ?sig:Widget.Signals.parent_set ?callback:
      begin function
	  None   -> callback None
	| Some w -> callback (Some (new widget_wrapper (Object.unsafe_cast w)))
      end
end

and widget_wrapper obj = object
  inherit widget obj
  method connect = new widget_signals obj
end



let pack_return (self : #widget) :packing ?:show [< true >] =
  may packing fun:(fun f -> (f self : unit));
  if show then self#misc#show ()
