(* $Id$ *)

module Type = struct
  type t
  type klass
  external name : t -> string = "ml_gtk_type_name"
  external from_name : string -> t = "ml_gtk_type_from_name"
  external parent : t -> t = "ml_gtk_type_parent"
  external get_class : t -> klass = "ml_gtk_type_class"
  external parent_class : t -> klass = "ml_gtk_type_parent_class"
  external is_a : t -> t -> bool = "ml_gtk_type_is_a"
end

module Object = struct
  type 'a t
  external get_type : 'a t -> Type.t = "ml_gtk_object_type"
end

module Widget = struct
  type 'a t = 'a Object.t constraint 'a = [> widget]
  external show : 'a t -> unit = "ml_gtk_widget_show"
  external show_now : 'a t -> unit = "ml_gtk_widget_show_now"
  external show_all : 'a t -> unit = "ml_gtk_widget_show_all"
  external hide : 'a t -> unit = "ml_gtk_widget_hide"
  external hide_all : 'a t -> unit = "ml_gtk_widget_hide_all"
  external map : 'a t -> unit = "ml_gtk_widget_map"
  external unmap : 'a t -> unit = "ml_gtk_widget_unmap"
  external realize : 'a t -> unit = "ml_gtk_widget_realize"
  external unrealize : 'a t -> unit = "ml_gtk_widget_unrealize"
  external queue_draw : 'a t -> unit = "ml_gtk_widget_queue_draw"
  external queue_resize : 'a t -> unit = "ml_gtk_widget_queue_resize"
  external draw : 'a t -> Gdk.Rectangle.t -> unit = "ml_gtk_widget_draw"
  external draw_focus : 'a t -> unit = "ml_gtk_widget_draw_focus"
  external draw_default : 'a t -> unit = "ml_gtk_widget_draw_default"
  external draw_children : 'a t -> unit = "ml_gtk_widget_draw_children"
  external event : 'a t -> Gdk.Event.t -> unit = "ml_gtk_widget_event"
  external activate : 'a t -> unit = "ml_gtk_widget_activate"
  external reparent : 'a t -> 'b t -> unit = "ml_gtk_widget_reparent"
  external popup : 'a t -> x:int -> y:int -> unit = "ml_gtk_widget_popup"
  external intersect : 'a t -> Gdk.Rectangle.t -> Gdk.Rectangle.t option
      = "ml_gtk_widget_intersect"
end
