(* $Id$ *)

open StdLabels
open Gaux
open Gobject
open Gtk
open GtkData
open GtkBase

(* GObject *)

class ['a] gobject_signals ?(after=false) obj = object
  val obj : 'a obj = obj
  val after = after
  method after = {< after = true >}
  method private connect : 'b. ('a,'b) GtkSignal.t -> callback:'b -> _ =
    fun sgn -> GtkSignal.connect obj ~sgn ~after
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

class type ['a] objvar = object
  val obj : 'a obj
  method private obj : 'a obj
end

class gtkobj obj = object
  val obj = obj
  method private obj = obj
  method destroy () = Object.destroy obj
  method get_oid = get_oid obj
end

class gtkobj_signals_impl ?after obj = object (self)
  inherit ['a] gobject_signals ?after obj
  method destroy = self#connect Object.S.destroy
end

class type gtkobj_signals =
  object ('a)
    method after : 'a
    method destroy : callback:(unit -> unit) -> GtkSignal.id
  end

(* Widget *)

class event_signals ?after obj = object (self)
  inherit ['a] gobject_signals ?after (obj :> Gtk.widget obj)
  method any = self#connect Widget.Signals.Event.any
  method after_any = self#connect Widget.S.event_after
  method button_press = self#connect Widget.Signals.Event.button_press
  method button_release = self#connect Widget.Signals.Event.button_release
  method configure = self#connect Widget.Signals.Event.configure
  method delete = self#connect Widget.Signals.Event.delete
  method destroy = self#connect Widget.Signals.Event.destroy
  method enter_notify = self#connect Widget.Signals.Event.enter_notify
  method expose = self#connect Widget.Signals.Event.expose
  method focus_in = self#connect Widget.Signals.Event.focus_in
  method focus_out = self#connect Widget.Signals.Event.focus_out
  method key_press = self#connect Widget.Signals.Event.key_press
  method key_release = self#connect Widget.Signals.Event.key_release
  method leave_notify = self#connect Widget.Signals.Event.leave_notify
  method map = self#connect Widget.Signals.Event.map
  method motion_notify = self#connect Widget.Signals.Event.motion_notify
  method property_notify = self#connect Widget.Signals.Event.property_notify
  method proximity_in = self#connect Widget.Signals.Event.proximity_in
  method proximity_out = self#connect Widget.Signals.Event.proximity_out
  method selection_clear = self#connect Widget.Signals.Event.selection_clear
  method selection_notify = self#connect Widget.Signals.Event.selection_notify
  method selection_request =
    self#connect Widget.Signals.Event.selection_request
  method unmap = self#connect Widget.Signals.Event.unmap
end

class event_ops obj = object
  val obj = (obj :> Gtk.widget obj)
  method add = Widget.add_events obj
  method connect = new event_signals obj
  method send : Gdk.Tags.event_type Gdk.event -> bool = Widget.event obj
  method set_extensions = set Widget.P.extension_events obj
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

open Widget

class drag_signals obj = object (self)
  inherit ['a] gobject_signals obj
  method private connect_drag : 'b. ('a, Gdk.drag_context -> 'b) GtkSignal.t ->
    callback:(drag_context -> 'b) -> _ =
      fun sgn ~callback ->
        self#connect sgn (fun context -> callback (new drag_context context))
  method beginning = self#connect_drag Widget.S.drag_begin
  method ending = self#connect_drag Widget.S.drag_end
  method data_delete = self#connect_drag Widget.S.drag_data_delete
  method leave = self#connect_drag Widget.S.drag_leave
  method motion = self#connect_drag Widget.S.drag_motion
  method drop = self#connect_drag Widget.S.drag_drop
  method data_get ~callback =
    self#connect Widget.S.drag_data_get ~callback:
      begin fun context seldata ~info ~time ->
        callback (new drag_context context) (new selection_context seldata)
          ~info ~time
      end
  method data_received ~callback =
    self#connect Widget.S.drag_data_received
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

and misc_signals ?after obj = object (self)
  inherit gtkobj_signals_impl ?after obj
  method show = self#connect S.show
  method hide = self#connect S.hide
  method map = self#connect S.map
  method unmap = self#connect S.unmap
  method realize = self#connect S.realize
  method unrealize = self#connect S.unrealize
  method state_changed = self#connect S.state_changed
  method size_allocate = self#connect S.size_allocate
  method parent_set ~callback =
    self#connect S.parent_set ~callback:
      begin function
	  None   -> callback None
	| Some w -> callback (Some (new widget (unsafe_cast w)))
      end
  method style_set ~callback =
    self#connect S.style_set ~callback:
      (fun opt -> callback (may opt ~f:(new style)))
  method selection_get ~callback =
    self#connect S.selection_get ~callback:
      begin fun seldata ~info ~time ->
        callback (new selection_context seldata) ~info ~time
      end
  method selection_received ~callback =
    self#connect S.selection_received
      ~callback:(fun data -> callback (new selection_data data)) 
end

and misc_ops obj = object (self)
  inherit gobject_ops obj
  method get_flag = Object.get_flag obj
  method connect = new misc_signals obj
  method show () = show obj
  method unparent () = unparent obj
  method show_all () = show_all obj
  method hide () = hide obj
  method hide_all () = hide_all obj
  method map () = map obj
  method unmap () = unmap obj
  method realize () = realize obj
  method unrealize () = unrealize obj
  method draw = draw obj
  method activate () = activate obj
  method reparent (w : widget) =  reparent obj w#as_widget
  (* method popup = popup obj *)
  method intersect = intersect obj
  method grab_focus () = set P.has_focus obj true
  method grab_default () = set P.has_default obj true
  method is_ancestor (w : widget) = is_ancestor obj w#as_widget
  method add_accelerator ~sgn:sg ~group ?modi ?flags key =
    add_accelerator obj ~sgn:sg group ~key ?modi ?flags
  method remove_accelerator ~group ?modi key =
    remove_accelerator obj group ~key ?modi
  (* method lock_accelerators () = lock_accelerators obj *)
  method set_name = set P.name obj
  method set_state = set_state obj
  method set_sensitive = set P.sensitive obj
  method set_can_default = set P.can_default obj
  method set_can_focus = set P.can_focus obj
  method set_app_paintable = set P.app_paintable obj
  method set_double_buffered = Widget.set_double_buffered obj
  method set_size_request =
    Widget.size_params [] ~cont:(fun p () -> set_params obj p)
  method set_size_chars ?desc ?lang ?width ?height () =
    let metrics = 
      (self#pango_context : GPango.context)#get_metrics ?desc ?lang () in
    let width = may_map width ~f:
        (fun w -> w * GPango.to_pixels metrics#approx_digit_width)
    and height = may_map height ~f:
        (fun h -> h * GPango.to_pixels (metrics#ascent+metrics#descent)) in
    self#set_size_request ?width ?height ()
  method set_style (style : style) = set P.style obj style#as_style
  method modify_fg = iter_setcol modify_fg obj
  method modify_bg = iter_setcol modify_bg obj
  method modify_text = iter_setcol modify_text obj
  method modify_base = iter_setcol modify_base obj
  method modify_font = modify_font obj
  method modify_font_by_name s =
    modify_font obj (Pango.Font.from_string s)
  method create_pango_context =
    new GPango.context_rw (create_pango_context obj)
  (* get functions *)
  method name = get P.name obj
  method toplevel =
    try new widget (unsafe_cast (get_toplevel obj))
    with Gpointer.Null -> failwith "GObj.misc_ops#toplevel"
  method window = window obj
  method colormap = get_colormap obj
  method visual = get_visual obj
  method visual_depth = Gdk.Visual.depth (get_visual obj)
  method pointer = get_pointer obj
  method style = new style (get P.style obj)
  method visible = self#get_flag `VISIBLE
  method parent =
    may_map (fun w -> new widget (unsafe_cast w)) (get P.parent obj)
  method allocation = allocation obj
  method pango_context = new GPango.context (get_pango_context obj)
  (* icon *)
  method render_icon ?detail ~size id =
    render_icon obj (GtkStock.convert_id id) size detail
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

class widget_signals_impl (obj : [>Gtk.widget] obj) = gtkobj_signals_impl obj

class type widget_signals = gtkobj_signals

class ['a] widget_impl (obj : 'a obj) = widget obj

class widget_full obj = object
  inherit widget obj
  method connect = new widget_signals_impl obj
end

let as_widget (w : widget) = w#as_widget

let wrap_widget w = new widget (unsafe_cast w)
let unwrap_widget w = unsafe_cast w#as_widget
let conv_widget_option =
  { kind = `OBJECT;
    proj = (function `OBJECT c -> may_map ~f:wrap_widget c
           | _ -> failwith "GObj.get_object");
    inj = (fun c -> `OBJECT (may_map ~f:unwrap_widget c)) }
let conv_widget =
  { kind = `OBJECT;
    proj = (function `OBJECT (Some c) -> wrap_widget c
           | `OBJECT None -> raise Gpointer.Null
           | _ -> failwith "GObj.get_object");
    inj = (fun c -> `OBJECT (Some (unwrap_widget c))) }


let pack_return self ~packing ~show =
  may packing ~f:(fun f -> (f (self :> widget) : unit));
  if show <> Some false then self#misc#show ();
  self
