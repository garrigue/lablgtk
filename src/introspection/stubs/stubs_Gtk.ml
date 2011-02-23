type -'a obj

module WindowPrivate = struct
  end
module WindowGroupPrivate = struct
  end
module WindowGroupClass = struct
  end
module WindowGroup = struct
  external remove_window: [>`gtkwindowgroup] obj -> [>`gtkwindow] obj -> unit = "ml_gtk_window_group_remove_window"
  external list_windows: [>`gtkwindowgroup] obj -> [<`glist] obj = "ml_gtk_window_group_list_windows"
  external get_current_grab: [>`gtkwindowgroup] obj -> [<`gtkwidget] obj = "ml_gtk_window_group_get_current_grab"
  external get_current_device_grab: [>`gtkwindowgroup] obj -> [>`gdkdevice] obj -> [<`gtkwidget] obj = "ml_gtk_window_group_get_current_device_grab"
  external add_window: [>`gtkwindowgroup] obj -> [>`gtkwindow] obj -> unit = "ml_gtk_window_group_add_window"
  end
module WindowGeometryInfo = struct
  end
module WindowClass = struct
  end
module Window = struct
  external unstick: [>`gtkwindow] obj -> unit = "ml_gtk_window_unstick"
  external unmaximize: [>`gtkwindow] obj -> unit = "ml_gtk_window_unmaximize"
  external unfullscreen: [>`gtkwindow] obj -> unit = "ml_gtk_window_unfullscreen"
  external stick: [>`gtkwindow] obj -> unit = "ml_gtk_window_stick"
  external set_wmclass: [>`gtkwindow] obj -> string -> string -> unit = "ml_gtk_window_set_wmclass"
  external set_urgency_hint: [>`gtkwindow] obj -> bool -> unit = "ml_gtk_window_set_urgency_hint"
  external set_transient_for: [>`gtkwindow] obj -> [>`gtkwindow] obj option -> unit = "ml_gtk_window_set_transient_for"
  external set_title: [>`gtkwindow] obj -> string -> unit = "ml_gtk_window_set_title"
  external set_startup_id: [>`gtkwindow] obj -> string -> unit = "ml_gtk_window_set_startup_id"
  external set_skip_taskbar_hint: [>`gtkwindow] obj -> bool -> unit = "ml_gtk_window_set_skip_taskbar_hint"
  external set_skip_pager_hint: [>`gtkwindow] obj -> bool -> unit = "ml_gtk_window_set_skip_pager_hint"
  external set_screen: [>`gtkwindow] obj -> [>`gdkscreen] obj -> unit = "ml_gtk_window_set_screen"
  external set_role: [>`gtkwindow] obj -> string -> unit = "ml_gtk_window_set_role"
  external set_resizable: [>`gtkwindow] obj -> bool -> unit = "ml_gtk_window_set_resizable"
  external set_opacity: [>`gtkwindow] obj -> float -> unit = "ml_gtk_window_set_opacity"
  external set_modal: [>`gtkwindow] obj -> bool -> unit = "ml_gtk_window_set_modal"
  external set_mnemonics_visible: [>`gtkwindow] obj -> bool -> unit = "ml_gtk_window_set_mnemonics_visible"
  external set_keep_below: [>`gtkwindow] obj -> bool -> unit = "ml_gtk_window_set_keep_below"
  external set_keep_above: [>`gtkwindow] obj -> bool -> unit = "ml_gtk_window_set_keep_above"
  external set_icon_name: [>`gtkwindow] obj -> string option -> unit = "ml_gtk_window_set_icon_name"
  external set_icon_list: [>`gtkwindow] obj -> [>`glist] obj -> unit = "ml_gtk_window_set_icon_list"
  external set_icon: [>`gtkwindow] obj -> [>`gdkpixbuf] obj option -> unit = "ml_gtk_window_set_icon"
  external set_has_user_ref_count: [>`gtkwindow] obj -> bool -> unit = "ml_gtk_window_set_has_user_ref_count"
  external set_has_resize_grip: [>`gtkwindow] obj -> bool -> unit = "ml_gtk_window_set_has_resize_grip"
  external set_focus_on_map: [>`gtkwindow] obj -> bool -> unit = "ml_gtk_window_set_focus_on_map"
  external set_focus: [>`gtkwindow] obj -> [>`gtkwidget] obj option -> unit = "ml_gtk_window_set_focus"
  external set_destroy_with_parent: [>`gtkwindow] obj -> bool -> unit = "ml_gtk_window_set_destroy_with_parent"
  external set_deletable: [>`gtkwindow] obj -> bool -> unit = "ml_gtk_window_set_deletable"
  external set_default_size: [>`gtkwindow] obj -> int -> int -> unit = "ml_gtk_window_set_default_size"
  external set_default_geometry: [>`gtkwindow] obj -> int -> int -> unit = "ml_gtk_window_set_default_geometry"
  external set_default: [>`gtkwindow] obj -> [>`gtkwidget] obj option -> unit = "ml_gtk_window_set_default"
  external set_decorated: [>`gtkwindow] obj -> bool -> unit = "ml_gtk_window_set_decorated"
  external set_application: [>`gtkwindow] obj -> [>`gtkapplication] obj option -> unit = "ml_gtk_window_set_application"
  external set_accept_focus: [>`gtkwindow] obj -> bool -> unit = "ml_gtk_window_set_accept_focus"
  external resize_to_geometry: [>`gtkwindow] obj -> int -> int -> unit = "ml_gtk_window_resize_to_geometry"
  external resize_grip_is_visible: [>`gtkwindow] obj -> bool = "ml_gtk_window_resize_grip_is_visible"
  external resize: [>`gtkwindow] obj -> int -> int -> unit = "ml_gtk_window_resize"
  external reshow_with_initial_size: [>`gtkwindow] obj -> unit = "ml_gtk_window_reshow_with_initial_size"
  external remove_mnemonic: [>`gtkwindow] obj -> int -> [>`gtkwidget] obj -> unit = "ml_gtk_window_remove_mnemonic"
  external remove_accel_group: [>`gtkwindow] obj -> [>`gtkaccelgroup] obj -> unit = "ml_gtk_window_remove_accel_group"
  external propagate_key_event: [>`gtkwindow] obj -> [>`gdkeventkey] obj -> bool = "ml_gtk_window_propagate_key_event"
  external present_with_time: [>`gtkwindow] obj -> int32 -> unit = "ml_gtk_window_present_with_time"
  external present: [>`gtkwindow] obj -> unit = "ml_gtk_window_present"
  external parse_geometry: [>`gtkwindow] obj -> string -> bool = "ml_gtk_window_parse_geometry"
  external move: [>`gtkwindow] obj -> int -> int -> unit = "ml_gtk_window_move"
  external maximize: [>`gtkwindow] obj -> unit = "ml_gtk_window_maximize"
  external is_active: [>`gtkwindow] obj -> bool = "ml_gtk_window_is_active"
  external iconify: [>`gtkwindow] obj -> unit = "ml_gtk_window_iconify"
  external has_toplevel_focus: [>`gtkwindow] obj -> bool = "ml_gtk_window_has_toplevel_focus"
  external has_group: [>`gtkwindow] obj -> bool = "ml_gtk_window_has_group"
  external get_urgency_hint: [>`gtkwindow] obj -> bool = "ml_gtk_window_get_urgency_hint"
  external get_transient_for: [>`gtkwindow] obj -> [<`gtkwindow] obj = "ml_gtk_window_get_transient_for"
  external get_title: [>`gtkwindow] obj -> string = "ml_gtk_window_get_title"
  external get_skip_taskbar_hint: [>`gtkwindow] obj -> bool = "ml_gtk_window_get_skip_taskbar_hint"
  external get_skip_pager_hint: [>`gtkwindow] obj -> bool = "ml_gtk_window_get_skip_pager_hint"
  external get_screen: [>`gtkwindow] obj -> [<`gdkscreen] obj = "ml_gtk_window_get_screen"
  external get_role: [>`gtkwindow] obj -> string = "ml_gtk_window_get_role"
  external get_resizable: [>`gtkwindow] obj -> bool = "ml_gtk_window_get_resizable"
  external get_opacity: [>`gtkwindow] obj -> float = "ml_gtk_window_get_opacity"
  external get_modal: [>`gtkwindow] obj -> bool = "ml_gtk_window_get_modal"
  external get_mnemonics_visible: [>`gtkwindow] obj -> bool = "ml_gtk_window_get_mnemonics_visible"
  external get_icon_name: [>`gtkwindow] obj -> string = "ml_gtk_window_get_icon_name"
  external get_icon_list: [>`gtkwindow] obj -> [<`glist] obj = "ml_gtk_window_get_icon_list"
  external get_icon: [>`gtkwindow] obj -> [<`gdkpixbuf] obj = "ml_gtk_window_get_icon"
  external get_has_resize_grip: [>`gtkwindow] obj -> bool = "ml_gtk_window_get_has_resize_grip"
  external get_group: [>`gtkwindow] obj -> [<`gtkwindowgroup] obj = "ml_gtk_window_get_group"
  external get_focus_on_map: [>`gtkwindow] obj -> bool = "ml_gtk_window_get_focus_on_map"
  external get_focus: [>`gtkwindow] obj -> [<`gtkwidget] obj = "ml_gtk_window_get_focus"
  external get_destroy_with_parent: [>`gtkwindow] obj -> bool = "ml_gtk_window_get_destroy_with_parent"
  external get_deletable: [>`gtkwindow] obj -> bool = "ml_gtk_window_get_deletable"
  external get_default_widget: [>`gtkwindow] obj -> [<`gtkwidget] obj = "ml_gtk_window_get_default_widget"
  external get_decorated: [>`gtkwindow] obj -> bool = "ml_gtk_window_get_decorated"
  external get_application: [>`gtkwindow] obj -> [<`gtkapplication] obj = "ml_gtk_window_get_application"
  external get_accept_focus: [>`gtkwindow] obj -> bool = "ml_gtk_window_get_accept_focus"
  external fullscreen: [>`gtkwindow] obj -> unit = "ml_gtk_window_fullscreen"
  external deiconify: [>`gtkwindow] obj -> unit = "ml_gtk_window_deiconify"
  external begin_move_drag: [>`gtkwindow] obj -> int -> int -> int -> int32 -> unit = "ml_gtk_window_begin_move_drag"
  external add_mnemonic: [>`gtkwindow] obj -> int -> [>`gtkwidget] obj -> unit = "ml_gtk_window_add_mnemonic"
  external add_accel_group: [>`gtkwindow] obj -> [>`gtkaccelgroup] obj -> unit = "ml_gtk_window_add_accel_group"
  external activate_key: [>`gtkwindow] obj -> [>`gdkeventkey] obj -> bool = "ml_gtk_window_activate_key"
  external activate_focus: [>`gtkwindow] obj -> bool = "ml_gtk_window_activate_focus"
  external activate_default: [>`gtkwindow] obj -> bool = "ml_gtk_window_activate_default"
  external set_default_icon_name: string -> unit = "ml_gtk_window_set_default_icon_name"
  external set_default_icon_list: [>`glist] obj -> unit = "ml_gtk_window_set_default_icon_list"
  external set_default_icon: [>`gdkpixbuf] obj -> unit = "ml_gtk_window_set_default_icon"
  external set_auto_startup_notification: bool -> unit = "ml_gtk_window_set_auto_startup_notification"
  external list_toplevels: unit -> [<`glist] obj = "ml_gtk_window_list_toplevels"
  external get_default_icon_name: unit -> string = "ml_gtk_window_get_default_icon_name"
  external get_default_icon_list: unit -> [<`glist] obj = "ml_gtk_window_get_default_icon_list"
  end
module WidgetPrivate = struct
  end
module WidgetPath = struct
  external prepend_type: [>`gtkwidgetpath] obj -> int -> unit = "ml_gtk_widget_path_prepend_type"
  external length: [>`gtkwidgetpath] obj -> int = "ml_gtk_widget_path_length"
  external iter_set_object_type: [>`gtkwidgetpath] obj -> int -> int -> unit = "ml_gtk_widget_path_iter_set_object_type"
  external iter_set_name: [>`gtkwidgetpath] obj -> int -> string -> unit = "ml_gtk_widget_path_iter_set_name"
  external iter_remove_region: [>`gtkwidgetpath] obj -> int -> string -> unit = "ml_gtk_widget_path_iter_remove_region"
  external iter_remove_class: [>`gtkwidgetpath] obj -> int -> string -> unit = "ml_gtk_widget_path_iter_remove_class"
  external iter_list_regions: [>`gtkwidgetpath] obj -> int -> [<`gslist] obj = "ml_gtk_widget_path_iter_list_regions"
  external iter_list_classes: [>`gtkwidgetpath] obj -> int -> [<`gslist] obj = "ml_gtk_widget_path_iter_list_classes"
  external iter_has_qname: [>`gtkwidgetpath] obj -> int -> int32 -> bool = "ml_gtk_widget_path_iter_has_qname"
  external iter_has_qclass: [>`gtkwidgetpath] obj -> int -> int32 -> bool = "ml_gtk_widget_path_iter_has_qclass"
  external iter_has_name: [>`gtkwidgetpath] obj -> int -> string -> bool = "ml_gtk_widget_path_iter_has_name"
  external iter_has_class: [>`gtkwidgetpath] obj -> int -> string -> bool = "ml_gtk_widget_path_iter_has_class"
  external iter_get_object_type: [>`gtkwidgetpath] obj -> int -> int = "ml_gtk_widget_path_iter_get_object_type"
  external iter_get_name: [>`gtkwidgetpath] obj -> int -> string = "ml_gtk_widget_path_iter_get_name"
  external iter_clear_regions: [>`gtkwidgetpath] obj -> int -> unit = "ml_gtk_widget_path_iter_clear_regions"
  external iter_clear_classes: [>`gtkwidgetpath] obj -> int -> unit = "ml_gtk_widget_path_iter_clear_classes"
  external iter_add_class: [>`gtkwidgetpath] obj -> int -> string -> unit = "ml_gtk_widget_path_iter_add_class"
  external is_type: [>`gtkwidgetpath] obj -> int -> bool = "ml_gtk_widget_path_is_type"
  external has_parent: [>`gtkwidgetpath] obj -> int -> bool = "ml_gtk_widget_path_has_parent"
  external get_object_type: [>`gtkwidgetpath] obj -> int = "ml_gtk_widget_path_get_object_type"
  external free: [>`gtkwidgetpath] obj -> unit = "ml_gtk_widget_path_free"
  external copy: [>`gtkwidgetpath] obj -> [<`gtkwidgetpath] obj = "ml_gtk_widget_path_copy"
  external append_type: [>`gtkwidgetpath] obj -> int -> int = "ml_gtk_widget_path_append_type"
  end
module WidgetClass = struct
  external install_style_property: [>`gtkwidgetclass] obj -> [>`gparamspec] obj -> unit = "ml_gtk_widget_class_install_style_property"
  external find_style_property: [>`gtkwidgetclass] obj -> string -> [<`gparamspec] obj = "ml_gtk_widget_class_find_style_property"
  end
module WidgetAuxInfo = struct
  end
module Widget = struct
  external unrealize: [>`gtkwidget] obj -> unit = "ml_gtk_widget_unrealize"
  external unparent: [>`gtkwidget] obj -> unit = "ml_gtk_widget_unparent"
  external unmap: [>`gtkwidget] obj -> unit = "ml_gtk_widget_unmap"
  external trigger_tooltip_query: [>`gtkwidget] obj -> unit = "ml_gtk_widget_trigger_tooltip_query"
  external thaw_child_notify: [>`gtkwidget] obj -> unit = "ml_gtk_widget_thaw_child_notify"
  external style_get_property: [>`gtkwidget] obj -> string -> [>`gvalue] obj -> unit = "ml_gtk_widget_style_get_property"
  external style_attach: [>`gtkwidget] obj -> unit = "ml_gtk_widget_style_attach"
  external show_now: [>`gtkwidget] obj -> unit = "ml_gtk_widget_show_now"
  external show_all: [>`gtkwidget] obj -> unit = "ml_gtk_widget_show_all"
  external show: [>`gtkwidget] obj -> unit = "ml_gtk_widget_show"
  external shape_combine_region: [>`gtkwidget] obj -> [>`cairo_region_t] obj option -> unit = "ml_gtk_widget_shape_combine_region"
  external set_window: [>`gtkwidget] obj -> [>`gdkwindow] obj -> unit = "ml_gtk_widget_set_window"
  external set_visual: [>`gtkwidget] obj -> [>`gdkvisual] obj -> unit = "ml_gtk_widget_set_visual"
  external set_visible: [>`gtkwidget] obj -> bool -> unit = "ml_gtk_widget_set_visible"
  external set_vexpand_set: [>`gtkwidget] obj -> bool -> unit = "ml_gtk_widget_set_vexpand_set"
  external set_vexpand: [>`gtkwidget] obj -> bool -> unit = "ml_gtk_widget_set_vexpand"
  external set_tooltip_window: [>`gtkwidget] obj -> [>`gtkwindow] obj option -> unit = "ml_gtk_widget_set_tooltip_window"
  external set_tooltip_text: [>`gtkwidget] obj -> string -> unit = "ml_gtk_widget_set_tooltip_text"
  external set_tooltip_markup: [>`gtkwidget] obj -> string option -> unit = "ml_gtk_widget_set_tooltip_markup"
  external set_support_multidevice: [>`gtkwidget] obj -> bool -> unit = "ml_gtk_widget_set_support_multidevice"
  external set_style: [>`gtkwidget] obj -> [>`gtkstyle] obj option -> unit = "ml_gtk_widget_set_style"
  external set_size_request: [>`gtkwidget] obj -> int -> int -> unit = "ml_gtk_widget_set_size_request"
  external set_sensitive: [>`gtkwidget] obj -> bool -> unit = "ml_gtk_widget_set_sensitive"
  external set_redraw_on_allocate: [>`gtkwidget] obj -> bool -> unit = "ml_gtk_widget_set_redraw_on_allocate"
  external set_receives_default: [>`gtkwidget] obj -> bool -> unit = "ml_gtk_widget_set_receives_default"
  external set_realized: [>`gtkwidget] obj -> bool -> unit = "ml_gtk_widget_set_realized"
  external set_parent_window: [>`gtkwidget] obj -> [>`gdkwindow] obj -> unit = "ml_gtk_widget_set_parent_window"
  external set_parent: [>`gtkwidget] obj -> [>`gtkwidget] obj -> unit = "ml_gtk_widget_set_parent"
  external set_no_show_all: [>`gtkwidget] obj -> bool -> unit = "ml_gtk_widget_set_no_show_all"
  external set_name: [>`gtkwidget] obj -> string -> unit = "ml_gtk_widget_set_name"
  external set_margin_top: [>`gtkwidget] obj -> int -> unit = "ml_gtk_widget_set_margin_top"
  external set_margin_right: [>`gtkwidget] obj -> int -> unit = "ml_gtk_widget_set_margin_right"
  external set_margin_left: [>`gtkwidget] obj -> int -> unit = "ml_gtk_widget_set_margin_left"
  external set_margin_bottom: [>`gtkwidget] obj -> int -> unit = "ml_gtk_widget_set_margin_bottom"
  external set_mapped: [>`gtkwidget] obj -> bool -> unit = "ml_gtk_widget_set_mapped"
  external set_hexpand_set: [>`gtkwidget] obj -> bool -> unit = "ml_gtk_widget_set_hexpand_set"
  external set_hexpand: [>`gtkwidget] obj -> bool -> unit = "ml_gtk_widget_set_hexpand"
  external set_has_window: [>`gtkwidget] obj -> bool -> unit = "ml_gtk_widget_set_has_window"
  external set_has_tooltip: [>`gtkwidget] obj -> bool -> unit = "ml_gtk_widget_set_has_tooltip"
  external set_events: [>`gtkwidget] obj -> int -> unit = "ml_gtk_widget_set_events"
  external set_double_buffered: [>`gtkwidget] obj -> bool -> unit = "ml_gtk_widget_set_double_buffered"
  external set_device_enabled: [>`gtkwidget] obj -> [>`gdkdevice] obj -> bool -> unit = "ml_gtk_widget_set_device_enabled"
  external set_composite_name: [>`gtkwidget] obj -> string -> unit = "ml_gtk_widget_set_composite_name"
  external set_child_visible: [>`gtkwidget] obj -> bool -> unit = "ml_gtk_widget_set_child_visible"
  external set_can_focus: [>`gtkwidget] obj -> bool -> unit = "ml_gtk_widget_set_can_focus"
  external set_can_default: [>`gtkwidget] obj -> bool -> unit = "ml_gtk_widget_set_can_default"
  external set_app_paintable: [>`gtkwidget] obj -> bool -> unit = "ml_gtk_widget_set_app_paintable"
  external set_accel_path: [>`gtkwidget] obj -> string option -> [>`gtkaccelgroup] obj option -> unit = "ml_gtk_widget_set_accel_path"
  external reset_style: [>`gtkwidget] obj -> unit = "ml_gtk_widget_reset_style"
  external reset_rc_styles: [>`gtkwidget] obj -> unit = "ml_gtk_widget_reset_rc_styles"
  external reparent: [>`gtkwidget] obj -> [>`gtkwidget] obj -> unit = "ml_gtk_widget_reparent"
  external remove_mnemonic_label: [>`gtkwidget] obj -> [>`gtkwidget] obj -> unit = "ml_gtk_widget_remove_mnemonic_label"
  external region_intersect: [>`gtkwidget] obj -> [>`cairo_region_t] obj -> [<`cairo_region_t] obj = "ml_gtk_widget_region_intersect"
  external realize: [>`gtkwidget] obj -> unit = "ml_gtk_widget_realize"
  external queue_resize_no_redraw: [>`gtkwidget] obj -> unit = "ml_gtk_widget_queue_resize_no_redraw"
  external queue_resize: [>`gtkwidget] obj -> unit = "ml_gtk_widget_queue_resize"
  external queue_draw_region: [>`gtkwidget] obj -> [>`cairo_region_t] obj -> unit = "ml_gtk_widget_queue_draw_region"
  external queue_draw_area: [>`gtkwidget] obj -> int -> int -> int -> int -> unit = "ml_gtk_widget_queue_draw_area"
  external queue_draw: [>`gtkwidget] obj -> unit = "ml_gtk_widget_queue_draw"
  external queue_compute_expand: [>`gtkwidget] obj -> unit = "ml_gtk_widget_queue_compute_expand"
  external override_symbolic_color: [>`gtkwidget] obj -> string -> [>`gdkrgba] obj option -> unit = "ml_gtk_widget_override_symbolic_color"
  external override_font: [>`gtkwidget] obj -> [>`pangofontdescription] obj -> unit = "ml_gtk_widget_override_font"
  external override_cursor: [>`gtkwidget] obj -> [>`gdkrgba] obj -> [>`gdkrgba] obj -> unit = "ml_gtk_widget_override_cursor"
  external modify_style: [>`gtkwidget] obj -> [>`gtkrcstyle] obj -> unit = "ml_gtk_widget_modify_style"
  external modify_font: [>`gtkwidget] obj -> [>`pangofontdescription] obj option -> unit = "ml_gtk_widget_modify_font"
  external modify_cursor: [>`gtkwidget] obj -> [>`gdkcolor] obj -> [>`gdkcolor] obj -> unit = "ml_gtk_widget_modify_cursor"
  external mnemonic_activate: [>`gtkwidget] obj -> bool -> bool = "ml_gtk_widget_mnemonic_activate"
  external map: [>`gtkwidget] obj -> unit = "ml_gtk_widget_map"
  external list_mnemonic_labels: [>`gtkwidget] obj -> [<`glist] obj = "ml_gtk_widget_list_mnemonic_labels"
  external list_accel_closures: [>`gtkwidget] obj -> [<`glist] obj = "ml_gtk_widget_list_accel_closures"
  external is_toplevel: [>`gtkwidget] obj -> bool = "ml_gtk_widget_is_toplevel"
  external is_sensitive: [>`gtkwidget] obj -> bool = "ml_gtk_widget_is_sensitive"
  external is_focus: [>`gtkwidget] obj -> bool = "ml_gtk_widget_is_focus"
  external is_drawable: [>`gtkwidget] obj -> bool = "ml_gtk_widget_is_drawable"
  external is_composited: [>`gtkwidget] obj -> bool = "ml_gtk_widget_is_composited"
  external is_ancestor: [>`gtkwidget] obj -> [>`gtkwidget] obj -> bool = "ml_gtk_widget_is_ancestor"
  external input_shape_combine_region: [>`gtkwidget] obj -> [>`cairo_region_t] obj option -> unit = "ml_gtk_widget_input_shape_combine_region"
  external in_destruction: [>`gtkwidget] obj -> bool = "ml_gtk_widget_in_destruction"
  external hide_on_delete: [>`gtkwidget] obj -> bool = "ml_gtk_widget_hide_on_delete"
  external hide: [>`gtkwidget] obj -> unit = "ml_gtk_widget_hide"
  external has_screen: [>`gtkwidget] obj -> bool = "ml_gtk_widget_has_screen"
  external has_rc_style: [>`gtkwidget] obj -> bool = "ml_gtk_widget_has_rc_style"
  external has_grab: [>`gtkwidget] obj -> bool = "ml_gtk_widget_has_grab"
  external has_focus: [>`gtkwidget] obj -> bool = "ml_gtk_widget_has_focus"
  external has_default: [>`gtkwidget] obj -> bool = "ml_gtk_widget_has_default"
  external grab_remove: [>`gtkwidget] obj -> unit = "ml_gtk_grab_remove"
  external grab_focus: [>`gtkwidget] obj -> unit = "ml_gtk_widget_grab_focus"
  external grab_default: [>`gtkwidget] obj -> unit = "ml_gtk_widget_grab_default"
  external grab_add: [>`gtkwidget] obj -> unit = "ml_gtk_grab_add"
  external get_window: [>`gtkwidget] obj -> [<`gdkwindow] obj = "ml_gtk_widget_get_window"
  external get_visual: [>`gtkwidget] obj -> [<`gdkvisual] obj = "ml_gtk_widget_get_visual"
  external get_visible: [>`gtkwidget] obj -> bool = "ml_gtk_widget_get_visible"
  external get_vexpand_set: [>`gtkwidget] obj -> bool = "ml_gtk_widget_get_vexpand_set"
  external get_vexpand: [>`gtkwidget] obj -> bool = "ml_gtk_widget_get_vexpand"
  external get_toplevel: [>`gtkwidget] obj -> [<`gtkwidget] obj = "ml_gtk_widget_get_toplevel"
  external get_tooltip_window: [>`gtkwidget] obj -> [<`gtkwindow] obj = "ml_gtk_widget_get_tooltip_window"
  external get_tooltip_text: [>`gtkwidget] obj -> string = "ml_gtk_widget_get_tooltip_text"
  external get_tooltip_markup: [>`gtkwidget] obj -> string = "ml_gtk_widget_get_tooltip_markup"
  external get_support_multidevice: [>`gtkwidget] obj -> bool = "ml_gtk_widget_get_support_multidevice"
  external get_style_context: [>`gtkwidget] obj -> [<`gtkstylecontext] obj = "ml_gtk_widget_get_style_context"
  external get_style: [>`gtkwidget] obj -> [<`gtkstyle] obj = "ml_gtk_widget_get_style"
  external get_settings: [>`gtkwidget] obj -> [<`gtksettings] obj = "ml_gtk_widget_get_settings"
  external get_sensitive: [>`gtkwidget] obj -> bool = "ml_gtk_widget_get_sensitive"
  external get_screen: [>`gtkwidget] obj -> [<`gdkscreen] obj = "ml_gtk_widget_get_screen"
  external get_root_window: [>`gtkwidget] obj -> [<`gdkwindow] obj = "ml_gtk_widget_get_root_window"
  external get_receives_default: [>`gtkwidget] obj -> bool = "ml_gtk_widget_get_receives_default"
  external get_realized: [>`gtkwidget] obj -> bool = "ml_gtk_widget_get_realized"
  external get_path: [>`gtkwidget] obj -> [<`gtkwidgetpath] obj = "ml_gtk_widget_get_path"
  external get_parent_window: [>`gtkwidget] obj -> [<`gdkwindow] obj = "ml_gtk_widget_get_parent_window"
  external get_parent: [>`gtkwidget] obj -> [<`gtkwidget] obj = "ml_gtk_widget_get_parent"
  external get_pango_context: [>`gtkwidget] obj -> [<`pangocontext] obj = "ml_gtk_widget_get_pango_context"
  external get_no_show_all: [>`gtkwidget] obj -> bool = "ml_gtk_widget_get_no_show_all"
  external get_name: [>`gtkwidget] obj -> string = "ml_gtk_widget_get_name"
  external get_modifier_style: [>`gtkwidget] obj -> [<`gtkrcstyle] obj = "ml_gtk_widget_get_modifier_style"
  external get_margin_top: [>`gtkwidget] obj -> int = "ml_gtk_widget_get_margin_top"
  external get_margin_right: [>`gtkwidget] obj -> int = "ml_gtk_widget_get_margin_right"
  external get_margin_left: [>`gtkwidget] obj -> int = "ml_gtk_widget_get_margin_left"
  external get_margin_bottom: [>`gtkwidget] obj -> int = "ml_gtk_widget_get_margin_bottom"
  external get_mapped: [>`gtkwidget] obj -> bool = "ml_gtk_widget_get_mapped"
  external get_hexpand_set: [>`gtkwidget] obj -> bool = "ml_gtk_widget_get_hexpand_set"
  external get_hexpand: [>`gtkwidget] obj -> bool = "ml_gtk_widget_get_hexpand"
  external get_has_window: [>`gtkwidget] obj -> bool = "ml_gtk_widget_get_has_window"
  external get_has_tooltip: [>`gtkwidget] obj -> bool = "ml_gtk_widget_get_has_tooltip"
  external get_events: [>`gtkwidget] obj -> int = "ml_gtk_widget_get_events"
  external get_double_buffered: [>`gtkwidget] obj -> bool = "ml_gtk_widget_get_double_buffered"
  external get_display: [>`gtkwidget] obj -> [<`gdkdisplay] obj = "ml_gtk_widget_get_display"
  external get_device_enabled: [>`gtkwidget] obj -> [>`gdkdevice] obj -> bool = "ml_gtk_widget_get_device_enabled"
  external get_composite_name: [>`gtkwidget] obj -> string = "ml_gtk_widget_get_composite_name"
  external get_child_visible: [>`gtkwidget] obj -> bool = "ml_gtk_widget_get_child_visible"
  external get_can_focus: [>`gtkwidget] obj -> bool = "ml_gtk_widget_get_can_focus"
  external get_can_default: [>`gtkwidget] obj -> bool = "ml_gtk_widget_get_can_default"
  external get_app_paintable: [>`gtkwidget] obj -> bool = "ml_gtk_widget_get_app_paintable"
  external get_ancestor: [>`gtkwidget] obj -> int -> [<`gtkwidget] obj = "ml_gtk_widget_get_ancestor"
  external get_allocated_width: [>`gtkwidget] obj -> int = "ml_gtk_widget_get_allocated_width"
  external get_allocated_height: [>`gtkwidget] obj -> int = "ml_gtk_widget_get_allocated_height"
  external get_accessible: [>`gtkwidget] obj -> [<`atkobject] obj = "ml_gtk_widget_get_accessible"
  external freeze_child_notify: [>`gtkwidget] obj -> unit = "ml_gtk_widget_freeze_child_notify"
  external error_bell: [>`gtkwidget] obj -> unit = "ml_gtk_widget_error_bell"
  external ensure_style: [>`gtkwidget] obj -> unit = "ml_gtk_widget_ensure_style"
  external draw: [>`gtkwidget] obj -> [>`cairo_t] obj -> unit = "ml_gtk_widget_draw"
  external drag_unhighlight: [>`gtkwidget] obj -> unit = "ml_gtk_drag_unhighlight"
  external drag_source_unset: [>`gtkwidget] obj -> unit = "ml_gtk_drag_source_unset"
  external drag_source_set_target_list: [>`gtkwidget] obj -> [>`gtktargetlist] obj option -> unit = "ml_gtk_drag_source_set_target_list"
  external drag_source_set_icon_stock: [>`gtkwidget] obj -> string -> unit = "ml_gtk_drag_source_set_icon_stock"
  external drag_source_set_icon_pixbuf: [>`gtkwidget] obj -> [>`gdkpixbuf] obj -> unit = "ml_gtk_drag_source_set_icon_pixbuf"
  external drag_source_set_icon_name: [>`gtkwidget] obj -> string -> unit = "ml_gtk_drag_source_set_icon_name"
  external drag_source_get_target_list: [>`gtkwidget] obj -> [<`gtktargetlist] obj = "ml_gtk_drag_source_get_target_list"
  external drag_source_add_uri_targets: [>`gtkwidget] obj -> unit = "ml_gtk_drag_source_add_uri_targets"
  external drag_source_add_text_targets: [>`gtkwidget] obj -> unit = "ml_gtk_drag_source_add_text_targets"
  external drag_source_add_image_targets: [>`gtkwidget] obj -> unit = "ml_gtk_drag_source_add_image_targets"
  external drag_highlight: [>`gtkwidget] obj -> unit = "ml_gtk_drag_highlight"
  external drag_dest_unset: [>`gtkwidget] obj -> unit = "ml_gtk_drag_dest_unset"
  external drag_dest_set_track_motion: [>`gtkwidget] obj -> bool -> unit = "ml_gtk_drag_dest_set_track_motion"
  external drag_dest_set_target_list: [>`gtkwidget] obj -> [>`gtktargetlist] obj option -> unit = "ml_gtk_drag_dest_set_target_list"
  external drag_dest_get_track_motion: [>`gtkwidget] obj -> bool = "ml_gtk_drag_dest_get_track_motion"
  external drag_dest_get_target_list: [>`gtkwidget] obj -> [<`gtktargetlist] obj = "ml_gtk_drag_dest_get_target_list"
  external drag_dest_add_uri_targets: [>`gtkwidget] obj -> unit = "ml_gtk_drag_dest_add_uri_targets"
  external drag_dest_add_text_targets: [>`gtkwidget] obj -> unit = "ml_gtk_drag_dest_add_text_targets"
  external drag_dest_add_image_targets: [>`gtkwidget] obj -> unit = "ml_gtk_drag_dest_add_image_targets"
  external drag_check_threshold: [>`gtkwidget] obj -> int -> int -> int -> int -> bool = "ml_gtk_drag_check_threshold"
  external device_is_shadowed: [>`gtkwidget] obj -> [>`gdkdevice] obj -> bool = "ml_gtk_widget_device_is_shadowed"
  external destroy: [>`gtkwidget] obj -> unit = "ml_gtk_widget_destroy"
  external create_pango_layout: [>`gtkwidget] obj -> string -> [<`pangolayout] obj = "ml_gtk_widget_create_pango_layout"
  external create_pango_context: [>`gtkwidget] obj -> [<`pangocontext] obj = "ml_gtk_widget_create_pango_context"
  external child_notify: [>`gtkwidget] obj -> string -> unit = "ml_gtk_widget_child_notify"
  external can_activate_accel: [>`gtkwidget] obj -> int -> bool = "ml_gtk_widget_can_activate_accel"
  external add_mnemonic_label: [>`gtkwidget] obj -> [>`gtkwidget] obj -> unit = "ml_gtk_widget_add_mnemonic_label"
  external add_events: [>`gtkwidget] obj -> int -> unit = "ml_gtk_widget_add_events"
  external activate: [>`gtkwidget] obj -> bool = "ml_gtk_widget_activate"
  external push_composite_child: unit -> unit = "ml_gtk_widget_push_composite_child"
  external pop_composite_child: unit -> unit = "ml_gtk_widget_pop_composite_child"
  external get_default_style: unit -> [<`gtkstyle] obj = "ml_gtk_widget_get_default_style"
  end
module VolumeButtonClass = struct
  end
module VolumeButton = struct
  end
module ViewportPrivate = struct
  end
module ViewportClass = struct
  end
module Viewport = struct
  external set_vadjustment: [>`gtkviewport] obj -> [>`gtkadjustment] obj option -> unit = "ml_gtk_viewport_set_vadjustment"
  external set_hadjustment: [>`gtkviewport] obj -> [>`gtkadjustment] obj option -> unit = "ml_gtk_viewport_set_hadjustment"
  external get_view_window: [>`gtkviewport] obj -> [<`gdkwindow] obj = "ml_gtk_viewport_get_view_window"
  external get_vadjustment: [>`gtkviewport] obj -> [<`gtkadjustment] obj = "ml_gtk_viewport_get_vadjustment"
  external get_hadjustment: [>`gtkviewport] obj -> [<`gtkadjustment] obj = "ml_gtk_viewport_get_hadjustment"
  external get_bin_window: [>`gtkviewport] obj -> [<`gdkwindow] obj = "ml_gtk_viewport_get_bin_window"
  end
module VSeparatorClass = struct
  end
module VSeparator = struct
  end
module VScrollbarClass = struct
  end
module VScrollbar = struct
  end
module VScaleClass = struct
  end
module VScale = struct
  end
module VPanedClass = struct
  end
module VPaned = struct
  end
module VButtonBoxClass = struct
  end
module VButtonBox = struct
  end
module VBoxClass = struct
  end
module VBox = struct
  end
module UIManagerPrivate = struct
  end
module UIManagerClass = struct
  end
module UIManager = struct
  external set_add_tearoffs: [>`gtkuimanager] obj -> bool -> unit = "ml_gtk_ui_manager_set_add_tearoffs"
  external remove_ui: [>`gtkuimanager] obj -> int -> unit = "ml_gtk_ui_manager_remove_ui"
  external remove_action_group: [>`gtkuimanager] obj -> [>`gtkactiongroup] obj -> unit = "ml_gtk_ui_manager_remove_action_group"
  external new_merge_id: [>`gtkuimanager] obj -> int = "ml_gtk_ui_manager_new_merge_id"
  external insert_action_group: [>`gtkuimanager] obj -> [>`gtkactiongroup] obj -> int -> unit = "ml_gtk_ui_manager_insert_action_group"
  external get_widget: [>`gtkuimanager] obj -> string -> [<`gtkwidget] obj = "ml_gtk_ui_manager_get_widget"
  external get_ui: [>`gtkuimanager] obj -> string = "ml_gtk_ui_manager_get_ui"
  external get_add_tearoffs: [>`gtkuimanager] obj -> bool = "ml_gtk_ui_manager_get_add_tearoffs"
  external get_action_groups: [>`gtkuimanager] obj -> [<`glist] obj = "ml_gtk_ui_manager_get_action_groups"
  external get_action: [>`gtkuimanager] obj -> string -> [<`gtkaction] obj = "ml_gtk_ui_manager_get_action"
  external get_accel_group: [>`gtkuimanager] obj -> [<`gtkaccelgroup] obj = "ml_gtk_ui_manager_get_accel_group"
  external ensure_update: [>`gtkuimanager] obj -> unit = "ml_gtk_ui_manager_ensure_update"
  end
module TreeViewPrivate = struct
  end
module TreeViewColumnPrivate = struct
  end
module TreeViewColumnClass = struct
  end
module TreeViewColumn = struct
  external set_widget: [>`gtktreeviewcolumn] obj -> [>`gtkwidget] obj option -> unit = "ml_gtk_tree_view_column_set_widget"
  external set_visible: [>`gtktreeviewcolumn] obj -> bool -> unit = "ml_gtk_tree_view_column_set_visible"
  external set_title: [>`gtktreeviewcolumn] obj -> string -> unit = "ml_gtk_tree_view_column_set_title"
  external set_spacing: [>`gtktreeviewcolumn] obj -> int -> unit = "ml_gtk_tree_view_column_set_spacing"
  external set_sort_indicator: [>`gtktreeviewcolumn] obj -> bool -> unit = "ml_gtk_tree_view_column_set_sort_indicator"
  external set_sort_column_id: [>`gtktreeviewcolumn] obj -> int -> unit = "ml_gtk_tree_view_column_set_sort_column_id"
  external set_resizable: [>`gtktreeviewcolumn] obj -> bool -> unit = "ml_gtk_tree_view_column_set_resizable"
  external set_reorderable: [>`gtktreeviewcolumn] obj -> bool -> unit = "ml_gtk_tree_view_column_set_reorderable"
  external set_min_width: [>`gtktreeviewcolumn] obj -> int -> unit = "ml_gtk_tree_view_column_set_min_width"
  external set_max_width: [>`gtktreeviewcolumn] obj -> int -> unit = "ml_gtk_tree_view_column_set_max_width"
  external set_fixed_width: [>`gtktreeviewcolumn] obj -> int -> unit = "ml_gtk_tree_view_column_set_fixed_width"
  external set_expand: [>`gtktreeviewcolumn] obj -> bool -> unit = "ml_gtk_tree_view_column_set_expand"
  external set_clickable: [>`gtktreeviewcolumn] obj -> bool -> unit = "ml_gtk_tree_view_column_set_clickable"
  external queue_resize: [>`gtktreeviewcolumn] obj -> unit = "ml_gtk_tree_view_column_queue_resize"
  external pack_start: [>`gtktreeviewcolumn] obj -> [>`gtkcellrenderer] obj -> bool -> unit = "ml_gtk_tree_view_column_pack_start"
  external pack_end: [>`gtktreeviewcolumn] obj -> [>`gtkcellrenderer] obj -> bool -> unit = "ml_gtk_tree_view_column_pack_end"
  external get_width: [>`gtktreeviewcolumn] obj -> int = "ml_gtk_tree_view_column_get_width"
  external get_widget: [>`gtktreeviewcolumn] obj -> [<`gtkwidget] obj = "ml_gtk_tree_view_column_get_widget"
  external get_visible: [>`gtktreeviewcolumn] obj -> bool = "ml_gtk_tree_view_column_get_visible"
  external get_tree_view: [>`gtktreeviewcolumn] obj -> [<`gtkwidget] obj = "ml_gtk_tree_view_column_get_tree_view"
  external get_title: [>`gtktreeviewcolumn] obj -> string = "ml_gtk_tree_view_column_get_title"
  external get_spacing: [>`gtktreeviewcolumn] obj -> int = "ml_gtk_tree_view_column_get_spacing"
  external get_sort_indicator: [>`gtktreeviewcolumn] obj -> bool = "ml_gtk_tree_view_column_get_sort_indicator"
  external get_sort_column_id: [>`gtktreeviewcolumn] obj -> int = "ml_gtk_tree_view_column_get_sort_column_id"
  external get_resizable: [>`gtktreeviewcolumn] obj -> bool = "ml_gtk_tree_view_column_get_resizable"
  external get_reorderable: [>`gtktreeviewcolumn] obj -> bool = "ml_gtk_tree_view_column_get_reorderable"
  external get_min_width: [>`gtktreeviewcolumn] obj -> int = "ml_gtk_tree_view_column_get_min_width"
  external get_max_width: [>`gtktreeviewcolumn] obj -> int = "ml_gtk_tree_view_column_get_max_width"
  external get_fixed_width: [>`gtktreeviewcolumn] obj -> int = "ml_gtk_tree_view_column_get_fixed_width"
  external get_expand: [>`gtktreeviewcolumn] obj -> bool = "ml_gtk_tree_view_column_get_expand"
  external get_clickable: [>`gtktreeviewcolumn] obj -> bool = "ml_gtk_tree_view_column_get_clickable"
  external get_button: [>`gtktreeviewcolumn] obj -> [<`gtkwidget] obj = "ml_gtk_tree_view_column_get_button"
  external focus_cell: [>`gtktreeviewcolumn] obj -> [>`gtkcellrenderer] obj -> unit = "ml_gtk_tree_view_column_focus_cell"
  external clicked: [>`gtktreeviewcolumn] obj -> unit = "ml_gtk_tree_view_column_clicked"
  external clear_attributes: [>`gtktreeviewcolumn] obj -> [>`gtkcellrenderer] obj -> unit = "ml_gtk_tree_view_column_clear_attributes"
  external clear: [>`gtktreeviewcolumn] obj -> unit = "ml_gtk_tree_view_column_clear"
  external cell_is_visible: [>`gtktreeviewcolumn] obj -> bool = "ml_gtk_tree_view_column_cell_is_visible"
  external add_attribute: [>`gtktreeviewcolumn] obj -> [>`gtkcellrenderer] obj -> string -> int -> unit = "ml_gtk_tree_view_column_add_attribute"
  end
module TreeViewClass = struct
  end
module TreeView = struct
  external unset_rows_drag_source: [>`gtktreeview] obj -> unit = "ml_gtk_tree_view_unset_rows_drag_source"
  external unset_rows_drag_dest: [>`gtktreeview] obj -> unit = "ml_gtk_tree_view_unset_rows_drag_dest"
  external set_vadjustment: [>`gtktreeview] obj -> [>`gtkadjustment] obj option -> unit = "ml_gtk_tree_view_set_vadjustment"
  external set_tooltip_row: [>`gtktreeview] obj -> [>`gtktooltip] obj -> [>`gtktreepath] obj -> unit = "ml_gtk_tree_view_set_tooltip_row"
  external set_tooltip_column: [>`gtktreeview] obj -> int -> unit = "ml_gtk_tree_view_set_tooltip_column"
  external set_tooltip_cell: [>`gtktreeview] obj -> [>`gtktooltip] obj -> [>`gtktreepath] obj option -> [>`gtktreeviewcolumn] obj option -> [>`gtkcellrenderer] obj option -> unit = "ml_gtk_tree_view_set_tooltip_cell"
  external set_show_expanders: [>`gtktreeview] obj -> bool -> unit = "ml_gtk_tree_view_set_show_expanders"
  external set_search_entry: [>`gtktreeview] obj -> [>`gtkentry] obj option -> unit = "ml_gtk_tree_view_set_search_entry"
  external set_search_column: [>`gtktreeview] obj -> int -> unit = "ml_gtk_tree_view_set_search_column"
  external set_rules_hint: [>`gtktreeview] obj -> bool -> unit = "ml_gtk_tree_view_set_rules_hint"
  external set_rubber_banding: [>`gtktreeview] obj -> bool -> unit = "ml_gtk_tree_view_set_rubber_banding"
  external set_reorderable: [>`gtktreeview] obj -> bool -> unit = "ml_gtk_tree_view_set_reorderable"
  external set_level_indentation: [>`gtktreeview] obj -> int -> unit = "ml_gtk_tree_view_set_level_indentation"
  external set_hover_selection: [>`gtktreeview] obj -> bool -> unit = "ml_gtk_tree_view_set_hover_selection"
  external set_hover_expand: [>`gtktreeview] obj -> bool -> unit = "ml_gtk_tree_view_set_hover_expand"
  external set_headers_visible: [>`gtktreeview] obj -> bool -> unit = "ml_gtk_tree_view_set_headers_visible"
  external set_headers_clickable: [>`gtktreeview] obj -> bool -> unit = "ml_gtk_tree_view_set_headers_clickable"
  external set_hadjustment: [>`gtktreeview] obj -> [>`gtkadjustment] obj option -> unit = "ml_gtk_tree_view_set_hadjustment"
  external set_fixed_height_mode: [>`gtktreeview] obj -> bool -> unit = "ml_gtk_tree_view_set_fixed_height_mode"
  external set_expander_column: [>`gtktreeview] obj -> [>`gtktreeviewcolumn] obj -> unit = "ml_gtk_tree_view_set_expander_column"
  external set_enable_tree_lines: [>`gtktreeview] obj -> bool -> unit = "ml_gtk_tree_view_set_enable_tree_lines"
  external set_enable_search: [>`gtktreeview] obj -> bool -> unit = "ml_gtk_tree_view_set_enable_search"
  external set_cursor_on_cell: [>`gtktreeview] obj -> [>`gtktreepath] obj -> [>`gtktreeviewcolumn] obj option -> [>`gtkcellrenderer] obj option -> bool -> unit = "ml_gtk_tree_view_set_cursor_on_cell"
  external set_cursor: [>`gtktreeview] obj -> [>`gtktreepath] obj -> [>`gtktreeviewcolumn] obj option -> bool -> unit = "ml_gtk_tree_view_set_cursor"
  external scroll_to_point: [>`gtktreeview] obj -> int -> int -> unit = "ml_gtk_tree_view_scroll_to_point"
  external row_expanded: [>`gtktreeview] obj -> [>`gtktreepath] obj -> bool = "ml_gtk_tree_view_row_expanded"
  external row_activated: [>`gtktreeview] obj -> [>`gtktreepath] obj -> [>`gtktreeviewcolumn] obj -> unit = "ml_gtk_tree_view_row_activated"
  external remove_column: [>`gtktreeview] obj -> [>`gtktreeviewcolumn] obj -> int = "ml_gtk_tree_view_remove_column"
  external move_column_after: [>`gtktreeview] obj -> [>`gtktreeviewcolumn] obj -> [>`gtktreeviewcolumn] obj option -> unit = "ml_gtk_tree_view_move_column_after"
  external is_rubber_banding_active: [>`gtktreeview] obj -> bool = "ml_gtk_tree_view_is_rubber_banding_active"
  external insert_column: [>`gtktreeview] obj -> [>`gtktreeviewcolumn] obj -> int -> int = "ml_gtk_tree_view_insert_column"
  external get_vadjustment: [>`gtktreeview] obj -> [<`gtkadjustment] obj = "ml_gtk_tree_view_get_vadjustment"
  external get_tooltip_column: [>`gtktreeview] obj -> int = "ml_gtk_tree_view_get_tooltip_column"
  external get_show_expanders: [>`gtktreeview] obj -> bool = "ml_gtk_tree_view_get_show_expanders"
  external get_selection: [>`gtktreeview] obj -> [<`gtktreeselection] obj = "ml_gtk_tree_view_get_selection"
  external get_search_entry: [>`gtktreeview] obj -> [<`gtkentry] obj = "ml_gtk_tree_view_get_search_entry"
  external get_search_column: [>`gtktreeview] obj -> int = "ml_gtk_tree_view_get_search_column"
  external get_rules_hint: [>`gtktreeview] obj -> bool = "ml_gtk_tree_view_get_rules_hint"
  external get_rubber_banding: [>`gtktreeview] obj -> bool = "ml_gtk_tree_view_get_rubber_banding"
  external get_reorderable: [>`gtktreeview] obj -> bool = "ml_gtk_tree_view_get_reorderable"
  external get_level_indentation: [>`gtktreeview] obj -> int = "ml_gtk_tree_view_get_level_indentation"
  external get_hover_selection: [>`gtktreeview] obj -> bool = "ml_gtk_tree_view_get_hover_selection"
  external get_hover_expand: [>`gtktreeview] obj -> bool = "ml_gtk_tree_view_get_hover_expand"
  external get_headers_visible: [>`gtktreeview] obj -> bool = "ml_gtk_tree_view_get_headers_visible"
  external get_headers_clickable: [>`gtktreeview] obj -> bool = "ml_gtk_tree_view_get_headers_clickable"
  external get_hadjustment: [>`gtktreeview] obj -> [<`gtkadjustment] obj = "ml_gtk_tree_view_get_hadjustment"
  external get_fixed_height_mode: [>`gtktreeview] obj -> bool = "ml_gtk_tree_view_get_fixed_height_mode"
  external get_expander_column: [>`gtktreeview] obj -> [<`gtktreeviewcolumn] obj = "ml_gtk_tree_view_get_expander_column"
  external get_enable_tree_lines: [>`gtktreeview] obj -> bool = "ml_gtk_tree_view_get_enable_tree_lines"
  external get_enable_search: [>`gtktreeview] obj -> bool = "ml_gtk_tree_view_get_enable_search"
  external get_columns: [>`gtktreeview] obj -> [<`glist] obj = "ml_gtk_tree_view_get_columns"
  external get_column: [>`gtktreeview] obj -> int -> [<`gtktreeviewcolumn] obj = "ml_gtk_tree_view_get_column"
  external get_bin_window: [>`gtktreeview] obj -> [<`gdkwindow] obj = "ml_gtk_tree_view_get_bin_window"
  external expand_to_path: [>`gtktreeview] obj -> [>`gtktreepath] obj -> unit = "ml_gtk_tree_view_expand_to_path"
  external expand_row: [>`gtktreeview] obj -> [>`gtktreepath] obj -> bool -> bool = "ml_gtk_tree_view_expand_row"
  external expand_all: [>`gtktreeview] obj -> unit = "ml_gtk_tree_view_expand_all"
  external create_row_drag_icon: [>`gtktreeview] obj -> [>`gtktreepath] obj -> [<`cairo_surface_t] obj = "ml_gtk_tree_view_create_row_drag_icon"
  external columns_autosize: [>`gtktreeview] obj -> unit = "ml_gtk_tree_view_columns_autosize"
  external collapse_row: [>`gtktreeview] obj -> [>`gtktreepath] obj -> bool = "ml_gtk_tree_view_collapse_row"
  external collapse_all: [>`gtktreeview] obj -> unit = "ml_gtk_tree_view_collapse_all"
  external append_column: [>`gtktreeview] obj -> [>`gtktreeviewcolumn] obj -> int = "ml_gtk_tree_view_append_column"
  end
module TreeStorePrivate = struct
  end
module TreeStoreClass = struct
  end
module TreeStore = struct
  external swap: [>`gtktreestore] obj -> [>`gtktreeiter] obj -> [>`gtktreeiter] obj -> unit = "ml_gtk_tree_store_swap"
  external set_value: [>`gtktreestore] obj -> [>`gtktreeiter] obj -> int -> [>`gvalue] obj -> unit = "ml_gtk_tree_store_set_value"
  external remove: [>`gtktreestore] obj -> [>`gtktreeiter] obj -> bool = "ml_gtk_tree_store_remove"
  external move_before: [>`gtktreestore] obj -> [>`gtktreeiter] obj -> [>`gtktreeiter] obj option -> unit = "ml_gtk_tree_store_move_before"
  external move_after: [>`gtktreestore] obj -> [>`gtktreeiter] obj -> [>`gtktreeiter] obj option -> unit = "ml_gtk_tree_store_move_after"
  external iter_is_valid: [>`gtktreestore] obj -> [>`gtktreeiter] obj -> bool = "ml_gtk_tree_store_iter_is_valid"
  external iter_depth: [>`gtktreestore] obj -> [>`gtktreeiter] obj -> int = "ml_gtk_tree_store_iter_depth"
  external is_ancestor: [>`gtktreestore] obj -> [>`gtktreeiter] obj -> [>`gtktreeiter] obj -> bool = "ml_gtk_tree_store_is_ancestor"
  external clear: [>`gtktreestore] obj -> unit = "ml_gtk_tree_store_clear"
  end
module TreeSortableIface = struct
  end
module TreeSelectionPrivate = struct
  end
module TreeSelectionClass = struct
  end
module TreeSelection = struct
  external unselect_range: [>`gtktreeselection] obj -> [>`gtktreepath] obj -> [>`gtktreepath] obj -> unit = "ml_gtk_tree_selection_unselect_range"
  external unselect_path: [>`gtktreeselection] obj -> [>`gtktreepath] obj -> unit = "ml_gtk_tree_selection_unselect_path"
  external unselect_iter: [>`gtktreeselection] obj -> [>`gtktreeiter] obj -> unit = "ml_gtk_tree_selection_unselect_iter"
  external unselect_all: [>`gtktreeselection] obj -> unit = "ml_gtk_tree_selection_unselect_all"
  external select_range: [>`gtktreeselection] obj -> [>`gtktreepath] obj -> [>`gtktreepath] obj -> unit = "ml_gtk_tree_selection_select_range"
  external select_path: [>`gtktreeselection] obj -> [>`gtktreepath] obj -> unit = "ml_gtk_tree_selection_select_path"
  external select_iter: [>`gtktreeselection] obj -> [>`gtktreeiter] obj -> unit = "ml_gtk_tree_selection_select_iter"
  external select_all: [>`gtktreeselection] obj -> unit = "ml_gtk_tree_selection_select_all"
  external path_is_selected: [>`gtktreeselection] obj -> [>`gtktreepath] obj -> bool = "ml_gtk_tree_selection_path_is_selected"
  external iter_is_selected: [>`gtktreeselection] obj -> [>`gtktreeiter] obj -> bool = "ml_gtk_tree_selection_iter_is_selected"
  external get_tree_view: [>`gtktreeselection] obj -> [<`gtktreeview] obj = "ml_gtk_tree_selection_get_tree_view"
  external count_selected_rows: [>`gtktreeselection] obj -> int = "ml_gtk_tree_selection_count_selected_rows"
  end
module TreeRowReference = struct
  external valid: [>`gtktreerowreference] obj -> bool = "ml_gtk_tree_row_reference_valid"
  external get_path: [>`gtktreerowreference] obj -> [<`gtktreepath] obj = "ml_gtk_tree_row_reference_get_path"
  external free: [>`gtktreerowreference] obj -> unit = "ml_gtk_tree_row_reference_free"
  external copy: [>`gtktreerowreference] obj -> [<`gtktreerowreference] obj = "ml_gtk_tree_row_reference_copy"
  end
module TreePath = struct
  external up: [>`gtktreepath] obj -> bool = "ml_gtk_tree_path_up"
  external to_string: [>`gtktreepath] obj -> string = "ml_gtk_tree_path_to_string"
  external prev: [>`gtktreepath] obj -> bool = "ml_gtk_tree_path_prev"
  external prepend_index: [>`gtktreepath] obj -> int -> unit = "ml_gtk_tree_path_prepend_index"
  external next: [>`gtktreepath] obj -> unit = "ml_gtk_tree_path_next"
  external is_descendant: [>`gtktreepath] obj -> [>`gtktreepath] obj -> bool = "ml_gtk_tree_path_is_descendant"
  external is_ancestor: [>`gtktreepath] obj -> [>`gtktreepath] obj -> bool = "ml_gtk_tree_path_is_ancestor"
  external get_depth: [>`gtktreepath] obj -> int = "ml_gtk_tree_path_get_depth"
  external free: [>`gtktreepath] obj -> unit = "ml_gtk_tree_path_free"
  external down: [>`gtktreepath] obj -> unit = "ml_gtk_tree_path_down"
  external copy: [>`gtktreepath] obj -> [<`gtktreepath] obj = "ml_gtk_tree_path_copy"
  external compare: [>`gtktreepath] obj -> [>`gtktreepath] obj -> int = "ml_gtk_tree_path_compare"
  external append_index: [>`gtktreepath] obj -> int -> unit = "ml_gtk_tree_path_append_index"
  end
module TreeModelSortPrivate = struct
  end
module TreeModelSortClass = struct
  end
module TreeModelSort = struct
  external reset_default_sort_func: [>`gtktreemodelsort] obj -> unit = "ml_gtk_tree_model_sort_reset_default_sort_func"
  external iter_is_valid: [>`gtktreemodelsort] obj -> [>`gtktreeiter] obj -> bool = "ml_gtk_tree_model_sort_iter_is_valid"
  external convert_path_to_child_path: [>`gtktreemodelsort] obj -> [>`gtktreepath] obj -> [<`gtktreepath] obj = "ml_gtk_tree_model_sort_convert_path_to_child_path"
  external convert_child_path_to_path: [>`gtktreemodelsort] obj -> [>`gtktreepath] obj -> [<`gtktreepath] obj = "ml_gtk_tree_model_sort_convert_child_path_to_path"
  external clear_cache: [>`gtktreemodelsort] obj -> unit = "ml_gtk_tree_model_sort_clear_cache"
  end
module TreeModelIface = struct
  end
module TreeModelFilterPrivate = struct
  end
module TreeModelFilterClass = struct
  end
module TreeModelFilter = struct
  external set_visible_column: [>`gtktreemodelfilter] obj -> int -> unit = "ml_gtk_tree_model_filter_set_visible_column"
  external refilter: [>`gtktreemodelfilter] obj -> unit = "ml_gtk_tree_model_filter_refilter"
  external convert_path_to_child_path: [>`gtktreemodelfilter] obj -> [>`gtktreepath] obj -> [<`gtktreepath] obj = "ml_gtk_tree_model_filter_convert_path_to_child_path"
  external convert_child_path_to_path: [>`gtktreemodelfilter] obj -> [>`gtktreepath] obj -> [<`gtktreepath] obj = "ml_gtk_tree_model_filter_convert_child_path_to_path"
  external clear_cache: [>`gtktreemodelfilter] obj -> unit = "ml_gtk_tree_model_filter_clear_cache"
  end
module TreeIter = struct
  external free: [>`gtktreeiter] obj -> unit = "ml_gtk_tree_iter_free"
  external copy: [>`gtktreeiter] obj -> [<`gtktreeiter] obj = "ml_gtk_tree_iter_copy"
  end
module TreeDragSourceIface = struct
  end
module TreeDragDestIface = struct
  end
module Tooltip = struct
  external set_text: [>`gtktooltip] obj -> string option -> unit = "ml_gtk_tooltip_set_text"
  external set_markup: [>`gtktooltip] obj -> string option -> unit = "ml_gtk_tooltip_set_markup"
  external set_icon: [>`gtktooltip] obj -> [>`gdkpixbuf] obj option -> unit = "ml_gtk_tooltip_set_icon"
  external set_custom: [>`gtktooltip] obj -> [>`gtkwidget] obj option -> unit = "ml_gtk_tooltip_set_custom"
  external trigger_tooltip_query: [>`gdkdisplay] obj -> unit = "ml_gtk_tooltip_trigger_tooltip_query"
  end
module ToolbarPrivate = struct
  end
module ToolbarClass = struct
  end
module Toolbar = struct
  external unset_style: [>`gtktoolbar] obj -> unit = "ml_gtk_toolbar_unset_style"
  external unset_icon_size: [>`gtktoolbar] obj -> unit = "ml_gtk_toolbar_unset_icon_size"
  external set_show_arrow: [>`gtktoolbar] obj -> bool -> unit = "ml_gtk_toolbar_set_show_arrow"
  external set_drop_highlight_item: [>`gtktoolbar] obj -> [>`gtktoolitem] obj option -> int -> unit = "ml_gtk_toolbar_set_drop_highlight_item"
  external insert: [>`gtktoolbar] obj -> [>`gtktoolitem] obj -> int -> unit = "ml_gtk_toolbar_insert"
  external get_show_arrow: [>`gtktoolbar] obj -> bool = "ml_gtk_toolbar_get_show_arrow"
  external get_nth_item: [>`gtktoolbar] obj -> int -> [<`gtktoolitem] obj = "ml_gtk_toolbar_get_nth_item"
  external get_n_items: [>`gtktoolbar] obj -> int = "ml_gtk_toolbar_get_n_items"
  external get_item_index: [>`gtktoolbar] obj -> [>`gtktoolitem] obj -> int = "ml_gtk_toolbar_get_item_index"
  external get_drop_index: [>`gtktoolbar] obj -> int -> int -> int = "ml_gtk_toolbar_get_drop_index"
  end
module ToolShellIface = struct
  end
module ToolPalettePrivate = struct
  end
module ToolPaletteClass = struct
  end
module ToolPalette = struct
  external unset_style: [>`gtktoolpalette] obj -> unit = "ml_gtk_tool_palette_unset_style"
  external unset_icon_size: [>`gtktoolpalette] obj -> unit = "ml_gtk_tool_palette_unset_icon_size"
  external set_group_position: [>`gtktoolpalette] obj -> [>`gtktoolitemgroup] obj -> int -> unit = "ml_gtk_tool_palette_set_group_position"
  external set_expand: [>`gtktoolpalette] obj -> [>`gtktoolitemgroup] obj -> bool -> unit = "ml_gtk_tool_palette_set_expand"
  external set_exclusive: [>`gtktoolpalette] obj -> [>`gtktoolitemgroup] obj -> bool -> unit = "ml_gtk_tool_palette_set_exclusive"
  external get_vadjustment: [>`gtktoolpalette] obj -> [<`gtkadjustment] obj = "ml_gtk_tool_palette_get_vadjustment"
  external get_hadjustment: [>`gtktoolpalette] obj -> [<`gtkadjustment] obj = "ml_gtk_tool_palette_get_hadjustment"
  external get_group_position: [>`gtktoolpalette] obj -> [>`gtktoolitemgroup] obj -> int = "ml_gtk_tool_palette_get_group_position"
  external get_expand: [>`gtktoolpalette] obj -> [>`gtktoolitemgroup] obj -> bool = "ml_gtk_tool_palette_get_expand"
  external get_exclusive: [>`gtktoolpalette] obj -> [>`gtktoolitemgroup] obj -> bool = "ml_gtk_tool_palette_get_exclusive"
  external get_drop_item: [>`gtktoolpalette] obj -> int -> int -> [<`gtktoolitem] obj = "ml_gtk_tool_palette_get_drop_item"
  external get_drop_group: [>`gtktoolpalette] obj -> int -> int -> [<`gtktoolitemgroup] obj = "ml_gtk_tool_palette_get_drop_group"
  external get_drag_item: [>`gtktoolpalette] obj -> [>`gtkselectiondata] obj -> [<`gtkwidget] obj = "ml_gtk_tool_palette_get_drag_item"
  external get_drag_target_item: unit -> [<`gtktargetentry] obj = "ml_gtk_tool_palette_get_drag_target_item"
  external get_drag_target_group: unit -> [<`gtktargetentry] obj = "ml_gtk_tool_palette_get_drag_target_group"
  end
module ToolItemPrivate = struct
  end
module ToolItemGroupPrivate = struct
  end
module ToolItemGroupClass = struct
  end
module ToolItemGroup = struct
  external set_label_widget: [>`gtktoolitemgroup] obj -> [>`gtkwidget] obj -> unit = "ml_gtk_tool_item_group_set_label_widget"
  external set_label: [>`gtktoolitemgroup] obj -> string -> unit = "ml_gtk_tool_item_group_set_label"
  external set_item_position: [>`gtktoolitemgroup] obj -> [>`gtktoolitem] obj -> int -> unit = "ml_gtk_tool_item_group_set_item_position"
  external set_collapsed: [>`gtktoolitemgroup] obj -> bool -> unit = "ml_gtk_tool_item_group_set_collapsed"
  external insert: [>`gtktoolitemgroup] obj -> [>`gtktoolitem] obj -> int -> unit = "ml_gtk_tool_item_group_insert"
  external get_nth_item: [>`gtktoolitemgroup] obj -> int -> [<`gtktoolitem] obj = "ml_gtk_tool_item_group_get_nth_item"
  external get_n_items: [>`gtktoolitemgroup] obj -> int = "ml_gtk_tool_item_group_get_n_items"
  external get_label_widget: [>`gtktoolitemgroup] obj -> [<`gtkwidget] obj = "ml_gtk_tool_item_group_get_label_widget"
  external get_label: [>`gtktoolitemgroup] obj -> string = "ml_gtk_tool_item_group_get_label"
  external get_item_position: [>`gtktoolitemgroup] obj -> [>`gtktoolitem] obj -> int = "ml_gtk_tool_item_group_get_item_position"
  external get_drop_item: [>`gtktoolitemgroup] obj -> int -> int -> [<`gtktoolitem] obj = "ml_gtk_tool_item_group_get_drop_item"
  external get_collapsed: [>`gtktoolitemgroup] obj -> bool = "ml_gtk_tool_item_group_get_collapsed"
  end
module ToolItemClass = struct
  end
module ToolItem = struct
  external toolbar_reconfigured: [>`gtktoolitem] obj -> unit = "ml_gtk_tool_item_toolbar_reconfigured"
  external set_visible_vertical: [>`gtktoolitem] obj -> bool -> unit = "ml_gtk_tool_item_set_visible_vertical"
  external set_visible_horizontal: [>`gtktoolitem] obj -> bool -> unit = "ml_gtk_tool_item_set_visible_horizontal"
  external set_use_drag_window: [>`gtktoolitem] obj -> bool -> unit = "ml_gtk_tool_item_set_use_drag_window"
  external set_tooltip_text: [>`gtktoolitem] obj -> string -> unit = "ml_gtk_tool_item_set_tooltip_text"
  external set_tooltip_markup: [>`gtktoolitem] obj -> string -> unit = "ml_gtk_tool_item_set_tooltip_markup"
  external set_proxy_menu_item: [>`gtktoolitem] obj -> string -> [>`gtkwidget] obj -> unit = "ml_gtk_tool_item_set_proxy_menu_item"
  external set_is_important: [>`gtktoolitem] obj -> bool -> unit = "ml_gtk_tool_item_set_is_important"
  external set_homogeneous: [>`gtktoolitem] obj -> bool -> unit = "ml_gtk_tool_item_set_homogeneous"
  external set_expand: [>`gtktoolitem] obj -> bool -> unit = "ml_gtk_tool_item_set_expand"
  external retrieve_proxy_menu_item: [>`gtktoolitem] obj -> [<`gtkwidget] obj = "ml_gtk_tool_item_retrieve_proxy_menu_item"
  external rebuild_menu: [>`gtktoolitem] obj -> unit = "ml_gtk_tool_item_rebuild_menu"
  external get_visible_vertical: [>`gtktoolitem] obj -> bool = "ml_gtk_tool_item_get_visible_vertical"
  external get_visible_horizontal: [>`gtktoolitem] obj -> bool = "ml_gtk_tool_item_get_visible_horizontal"
  external get_use_drag_window: [>`gtktoolitem] obj -> bool = "ml_gtk_tool_item_get_use_drag_window"
  external get_text_size_group: [>`gtktoolitem] obj -> [<`gtksizegroup] obj = "ml_gtk_tool_item_get_text_size_group"
  external get_proxy_menu_item: [>`gtktoolitem] obj -> string -> [<`gtkwidget] obj = "ml_gtk_tool_item_get_proxy_menu_item"
  external get_is_important: [>`gtktoolitem] obj -> bool = "ml_gtk_tool_item_get_is_important"
  external get_homogeneous: [>`gtktoolitem] obj -> bool = "ml_gtk_tool_item_get_homogeneous"
  external get_expand: [>`gtktoolitem] obj -> bool = "ml_gtk_tool_item_get_expand"
  end
module ToolButtonPrivate = struct
  end
module ToolButtonClass = struct
  end
module ToolButton = struct
  external set_use_underline: [>`gtktoolbutton] obj -> bool -> unit = "ml_gtk_tool_button_set_use_underline"
  external set_stock_id: [>`gtktoolbutton] obj -> string option -> unit = "ml_gtk_tool_button_set_stock_id"
  external set_label_widget: [>`gtktoolbutton] obj -> [>`gtkwidget] obj option -> unit = "ml_gtk_tool_button_set_label_widget"
  external set_label: [>`gtktoolbutton] obj -> string option -> unit = "ml_gtk_tool_button_set_label"
  external set_icon_widget: [>`gtktoolbutton] obj -> [>`gtkwidget] obj option -> unit = "ml_gtk_tool_button_set_icon_widget"
  external set_icon_name: [>`gtktoolbutton] obj -> string option -> unit = "ml_gtk_tool_button_set_icon_name"
  external get_use_underline: [>`gtktoolbutton] obj -> bool = "ml_gtk_tool_button_get_use_underline"
  external get_stock_id: [>`gtktoolbutton] obj -> string = "ml_gtk_tool_button_get_stock_id"
  external get_label_widget: [>`gtktoolbutton] obj -> [<`gtkwidget] obj = "ml_gtk_tool_button_get_label_widget"
  external get_label: [>`gtktoolbutton] obj -> string = "ml_gtk_tool_button_get_label"
  external get_icon_widget: [>`gtktoolbutton] obj -> [<`gtkwidget] obj = "ml_gtk_tool_button_get_icon_widget"
  external get_icon_name: [>`gtktoolbutton] obj -> string = "ml_gtk_tool_button_get_icon_name"
  end
module ToggleToolButtonPrivate = struct
  end
module ToggleToolButtonClass = struct
  end
module ToggleToolButton = struct
  external set_active: [>`gtktoggletoolbutton] obj -> bool -> unit = "ml_gtk_toggle_tool_button_set_active"
  external get_active: [>`gtktoggletoolbutton] obj -> bool = "ml_gtk_toggle_tool_button_get_active"
  end
module ToggleButtonPrivate = struct
  end
module ToggleButtonClass = struct
  end
module ToggleButton = struct
  external toggled: [>`gtktogglebutton] obj -> unit = "ml_gtk_toggle_button_toggled"
  external set_mode: [>`gtktogglebutton] obj -> bool -> unit = "ml_gtk_toggle_button_set_mode"
  external set_inconsistent: [>`gtktogglebutton] obj -> bool -> unit = "ml_gtk_toggle_button_set_inconsistent"
  external set_active: [>`gtktogglebutton] obj -> bool -> unit = "ml_gtk_toggle_button_set_active"
  external get_mode: [>`gtktogglebutton] obj -> bool = "ml_gtk_toggle_button_get_mode"
  external get_inconsistent: [>`gtktogglebutton] obj -> bool = "ml_gtk_toggle_button_get_inconsistent"
  external get_active: [>`gtktogglebutton] obj -> bool = "ml_gtk_toggle_button_get_active"
  end
module ToggleActionPrivate = struct
  end
module ToggleActionEntry = struct
  end
module ToggleActionClass = struct
  end
module ToggleAction = struct
  external toggled: [>`gtktoggleaction] obj -> unit = "ml_gtk_toggle_action_toggled"
  external set_draw_as_radio: [>`gtktoggleaction] obj -> bool -> unit = "ml_gtk_toggle_action_set_draw_as_radio"
  external set_active: [>`gtktoggleaction] obj -> bool -> unit = "ml_gtk_toggle_action_set_active"
  external get_draw_as_radio: [>`gtktoggleaction] obj -> bool = "ml_gtk_toggle_action_get_draw_as_radio"
  external get_active: [>`gtktoggleaction] obj -> bool = "ml_gtk_toggle_action_get_active"
  end
module ThemingEngineClass = struct
  end
module ThemingEngine = struct
  external has_class: [>`gtkthemingengine] obj -> string -> bool = "ml_gtk_theming_engine_has_class"
  external get_style_property: [>`gtkthemingengine] obj -> string -> [>`gvalue] obj -> unit = "ml_gtk_theming_engine_get_style_property"
  external get_screen: [>`gtkthemingengine] obj -> [<`gdkscreen] obj = "ml_gtk_theming_engine_get_screen"
  external get_path: [>`gtkthemingengine] obj -> [<`gtkwidgetpath] obj = "ml_gtk_theming_engine_get_path"
  external load: string -> [<`gtkthemingengine] obj = "ml_gtk_theming_engine_load"
  end
module ThemeEngine = struct
  end
module TextViewPrivate = struct
  end
module TextViewClass = struct
  end
module TextView = struct
  external starts_display_line: [>`gtktextview] obj -> [>`gtktextiter] obj -> bool = "ml_gtk_text_view_starts_display_line"
  external set_tabs: [>`gtktextview] obj -> [>`pangotabarray] obj -> unit = "ml_gtk_text_view_set_tabs"
  external set_right_margin: [>`gtktextview] obj -> int -> unit = "ml_gtk_text_view_set_right_margin"
  external set_pixels_inside_wrap: [>`gtktextview] obj -> int -> unit = "ml_gtk_text_view_set_pixels_inside_wrap"
  external set_pixels_below_lines: [>`gtktextview] obj -> int -> unit = "ml_gtk_text_view_set_pixels_below_lines"
  external set_pixels_above_lines: [>`gtktextview] obj -> int -> unit = "ml_gtk_text_view_set_pixels_above_lines"
  external set_overwrite: [>`gtktextview] obj -> bool -> unit = "ml_gtk_text_view_set_overwrite"
  external set_left_margin: [>`gtktextview] obj -> int -> unit = "ml_gtk_text_view_set_left_margin"
  external set_indent: [>`gtktextview] obj -> int -> unit = "ml_gtk_text_view_set_indent"
  external set_editable: [>`gtktextview] obj -> bool -> unit = "ml_gtk_text_view_set_editable"
  external set_cursor_visible: [>`gtktextview] obj -> bool -> unit = "ml_gtk_text_view_set_cursor_visible"
  external set_buffer: [>`gtktextview] obj -> [>`gtktextbuffer] obj option -> unit = "ml_gtk_text_view_set_buffer"
  external set_accepts_tab: [>`gtktextview] obj -> bool -> unit = "ml_gtk_text_view_set_accepts_tab"
  external scroll_to_mark: [>`gtktextview] obj -> [>`gtktextmark] obj -> float -> bool -> float -> float -> unit = "ml_gtk_text_view_scroll_to_mark"
  external scroll_to_iter: [>`gtktextview] obj -> [>`gtktextiter] obj -> float -> bool -> float -> float -> bool = "ml_gtk_text_view_scroll_to_iter"
  external scroll_mark_onscreen: [>`gtktextview] obj -> [>`gtktextmark] obj -> unit = "ml_gtk_text_view_scroll_mark_onscreen"
  external reset_im_context: [>`gtktextview] obj -> unit = "ml_gtk_text_view_reset_im_context"
  external place_cursor_onscreen: [>`gtktextview] obj -> bool = "ml_gtk_text_view_place_cursor_onscreen"
  external move_visually: [>`gtktextview] obj -> [>`gtktextiter] obj -> int -> bool = "ml_gtk_text_view_move_visually"
  external move_mark_onscreen: [>`gtktextview] obj -> [>`gtktextmark] obj -> bool = "ml_gtk_text_view_move_mark_onscreen"
  external move_child: [>`gtktextview] obj -> [>`gtkwidget] obj -> int -> int -> unit = "ml_gtk_text_view_move_child"
  external im_context_filter_keypress: [>`gtktextview] obj -> [>`gdkeventkey] obj -> bool = "ml_gtk_text_view_im_context_filter_keypress"
  external get_vadjustment: [>`gtktextview] obj -> [<`gtkadjustment] obj = "ml_gtk_text_view_get_vadjustment"
  external get_tabs: [>`gtktextview] obj -> [<`pangotabarray] obj = "ml_gtk_text_view_get_tabs"
  external get_right_margin: [>`gtktextview] obj -> int = "ml_gtk_text_view_get_right_margin"
  external get_pixels_inside_wrap: [>`gtktextview] obj -> int = "ml_gtk_text_view_get_pixels_inside_wrap"
  external get_pixels_below_lines: [>`gtktextview] obj -> int = "ml_gtk_text_view_get_pixels_below_lines"
  external get_pixels_above_lines: [>`gtktextview] obj -> int = "ml_gtk_text_view_get_pixels_above_lines"
  external get_overwrite: [>`gtktextview] obj -> bool = "ml_gtk_text_view_get_overwrite"
  external get_left_margin: [>`gtktextview] obj -> int = "ml_gtk_text_view_get_left_margin"
  external get_indent: [>`gtktextview] obj -> int = "ml_gtk_text_view_get_indent"
  external get_hadjustment: [>`gtktextview] obj -> [<`gtkadjustment] obj = "ml_gtk_text_view_get_hadjustment"
  external get_editable: [>`gtktextview] obj -> bool = "ml_gtk_text_view_get_editable"
  external get_default_attributes: [>`gtktextview] obj -> [<`gtktextattributes] obj = "ml_gtk_text_view_get_default_attributes"
  external get_cursor_visible: [>`gtktextview] obj -> bool = "ml_gtk_text_view_get_cursor_visible"
  external get_buffer: [>`gtktextview] obj -> [<`gtktextbuffer] obj = "ml_gtk_text_view_get_buffer"
  external get_accepts_tab: [>`gtktextview] obj -> bool = "ml_gtk_text_view_get_accepts_tab"
  external forward_display_line_end: [>`gtktextview] obj -> [>`gtktextiter] obj -> bool = "ml_gtk_text_view_forward_display_line_end"
  external forward_display_line: [>`gtktextview] obj -> [>`gtktextiter] obj -> bool = "ml_gtk_text_view_forward_display_line"
  external backward_display_line_start: [>`gtktextview] obj -> [>`gtktextiter] obj -> bool = "ml_gtk_text_view_backward_display_line_start"
  external backward_display_line: [>`gtktextview] obj -> [>`gtktextiter] obj -> bool = "ml_gtk_text_view_backward_display_line"
  external add_child_at_anchor: [>`gtktextview] obj -> [>`gtkwidget] obj -> [>`gtktextchildanchor] obj -> unit = "ml_gtk_text_view_add_child_at_anchor"
  end
module TextTagTablePrivate = struct
  end
module TextTagTableClass = struct
  end
module TextTagTable = struct
  external remove: [>`gtktexttagtable] obj -> [>`gtktexttag] obj -> unit = "ml_gtk_text_tag_table_remove"
  external lookup: [>`gtktexttagtable] obj -> string -> [<`gtktexttag] obj = "ml_gtk_text_tag_table_lookup"
  external get_size: [>`gtktexttagtable] obj -> int = "ml_gtk_text_tag_table_get_size"
  external add: [>`gtktexttagtable] obj -> [>`gtktexttag] obj -> unit = "ml_gtk_text_tag_table_add"
  end
module TextTagPrivate = struct
  end
module TextTagClass = struct
  end
module TextTag = struct
  external set_priority: [>`gtktexttag] obj -> int -> unit = "ml_gtk_text_tag_set_priority"
  external get_priority: [>`gtktexttag] obj -> int = "ml_gtk_text_tag_get_priority"
  end
module TextMarkClass = struct
  end
module TextMark = struct
  external set_visible: [>`gtktextmark] obj -> bool -> unit = "ml_gtk_text_mark_set_visible"
  external get_visible: [>`gtktextmark] obj -> bool = "ml_gtk_text_mark_get_visible"
  external get_name: [>`gtktextmark] obj -> string = "ml_gtk_text_mark_get_name"
  external get_left_gravity: [>`gtktextmark] obj -> bool = "ml_gtk_text_mark_get_left_gravity"
  external get_deleted: [>`gtktextmark] obj -> bool = "ml_gtk_text_mark_get_deleted"
  external get_buffer: [>`gtktextmark] obj -> [<`gtktextbuffer] obj = "ml_gtk_text_mark_get_buffer"
  end
module TextIter = struct
  external toggles_tag: [>`gtktextiter] obj -> [>`gtktexttag] obj option -> bool = "ml_gtk_text_iter_toggles_tag"
  external starts_word: [>`gtktextiter] obj -> bool = "ml_gtk_text_iter_starts_word"
  external starts_sentence: [>`gtktextiter] obj -> bool = "ml_gtk_text_iter_starts_sentence"
  external starts_line: [>`gtktextiter] obj -> bool = "ml_gtk_text_iter_starts_line"
  external set_visible_line_offset: [>`gtktextiter] obj -> int -> unit = "ml_gtk_text_iter_set_visible_line_offset"
  external set_visible_line_index: [>`gtktextiter] obj -> int -> unit = "ml_gtk_text_iter_set_visible_line_index"
  external set_offset: [>`gtktextiter] obj -> int -> unit = "ml_gtk_text_iter_set_offset"
  external set_line_offset: [>`gtktextiter] obj -> int -> unit = "ml_gtk_text_iter_set_line_offset"
  external set_line_index: [>`gtktextiter] obj -> int -> unit = "ml_gtk_text_iter_set_line_index"
  external set_line: [>`gtktextiter] obj -> int -> unit = "ml_gtk_text_iter_set_line"
  external order: [>`gtktextiter] obj -> [>`gtktextiter] obj -> unit = "ml_gtk_text_iter_order"
  external is_start: [>`gtktextiter] obj -> bool = "ml_gtk_text_iter_is_start"
  external is_end: [>`gtktextiter] obj -> bool = "ml_gtk_text_iter_is_end"
  external is_cursor_position: [>`gtktextiter] obj -> bool = "ml_gtk_text_iter_is_cursor_position"
  external inside_word: [>`gtktextiter] obj -> bool = "ml_gtk_text_iter_inside_word"
  external inside_sentence: [>`gtktextiter] obj -> bool = "ml_gtk_text_iter_inside_sentence"
  external in_range: [>`gtktextiter] obj -> [>`gtktextiter] obj -> [>`gtktextiter] obj -> bool = "ml_gtk_text_iter_in_range"
  external has_tag: [>`gtktextiter] obj -> [>`gtktexttag] obj -> bool = "ml_gtk_text_iter_has_tag"
  external get_visible_text: [>`gtktextiter] obj -> [>`gtktextiter] obj -> string = "ml_gtk_text_iter_get_visible_text"
  external get_visible_slice: [>`gtktextiter] obj -> [>`gtktextiter] obj -> string = "ml_gtk_text_iter_get_visible_slice"
  external get_visible_line_offset: [>`gtktextiter] obj -> int = "ml_gtk_text_iter_get_visible_line_offset"
  external get_visible_line_index: [>`gtktextiter] obj -> int = "ml_gtk_text_iter_get_visible_line_index"
  external get_toggled_tags: [>`gtktextiter] obj -> bool -> [<`gslist] obj = "ml_gtk_text_iter_get_toggled_tags"
  external get_text: [>`gtktextiter] obj -> [>`gtktextiter] obj -> string = "ml_gtk_text_iter_get_text"
  external get_tags: [>`gtktextiter] obj -> [<`gslist] obj = "ml_gtk_text_iter_get_tags"
  external get_slice: [>`gtktextiter] obj -> [>`gtktextiter] obj -> string = "ml_gtk_text_iter_get_slice"
  external get_pixbuf: [>`gtktextiter] obj -> [<`gdkpixbuf] obj = "ml_gtk_text_iter_get_pixbuf"
  external get_offset: [>`gtktextiter] obj -> int = "ml_gtk_text_iter_get_offset"
  external get_marks: [>`gtktextiter] obj -> [<`gslist] obj = "ml_gtk_text_iter_get_marks"
  external get_line_offset: [>`gtktextiter] obj -> int = "ml_gtk_text_iter_get_line_offset"
  external get_line_index: [>`gtktextiter] obj -> int = "ml_gtk_text_iter_get_line_index"
  external get_line: [>`gtktextiter] obj -> int = "ml_gtk_text_iter_get_line"
  external get_language: [>`gtktextiter] obj -> [<`pangolanguage] obj = "ml_gtk_text_iter_get_language"
  external get_child_anchor: [>`gtktextiter] obj -> [<`gtktextchildanchor] obj = "ml_gtk_text_iter_get_child_anchor"
  external get_chars_in_line: [>`gtktextiter] obj -> int = "ml_gtk_text_iter_get_chars_in_line"
  external get_char: [>`gtktextiter] obj -> int32 = "ml_gtk_text_iter_get_char"
  external get_bytes_in_line: [>`gtktextiter] obj -> int = "ml_gtk_text_iter_get_bytes_in_line"
  external get_buffer: [>`gtktextiter] obj -> [<`gtktextbuffer] obj = "ml_gtk_text_iter_get_buffer"
  external free: [>`gtktextiter] obj -> unit = "ml_gtk_text_iter_free"
  external forward_word_ends: [>`gtktextiter] obj -> int -> bool = "ml_gtk_text_iter_forward_word_ends"
  external forward_word_end: [>`gtktextiter] obj -> bool = "ml_gtk_text_iter_forward_word_end"
  external forward_visible_word_ends: [>`gtktextiter] obj -> int -> bool = "ml_gtk_text_iter_forward_visible_word_ends"
  external forward_visible_word_end: [>`gtktextiter] obj -> bool = "ml_gtk_text_iter_forward_visible_word_end"
  external forward_visible_lines: [>`gtktextiter] obj -> int -> bool = "ml_gtk_text_iter_forward_visible_lines"
  external forward_visible_line: [>`gtktextiter] obj -> bool = "ml_gtk_text_iter_forward_visible_line"
  external forward_visible_cursor_positions: [>`gtktextiter] obj -> int -> bool = "ml_gtk_text_iter_forward_visible_cursor_positions"
  external forward_visible_cursor_position: [>`gtktextiter] obj -> bool = "ml_gtk_text_iter_forward_visible_cursor_position"
  external forward_to_tag_toggle: [>`gtktextiter] obj -> [>`gtktexttag] obj option -> bool = "ml_gtk_text_iter_forward_to_tag_toggle"
  external forward_to_line_end: [>`gtktextiter] obj -> bool = "ml_gtk_text_iter_forward_to_line_end"
  external forward_to_end: [>`gtktextiter] obj -> unit = "ml_gtk_text_iter_forward_to_end"
  external forward_sentence_ends: [>`gtktextiter] obj -> int -> bool = "ml_gtk_text_iter_forward_sentence_ends"
  external forward_sentence_end: [>`gtktextiter] obj -> bool = "ml_gtk_text_iter_forward_sentence_end"
  external forward_lines: [>`gtktextiter] obj -> int -> bool = "ml_gtk_text_iter_forward_lines"
  external forward_line: [>`gtktextiter] obj -> bool = "ml_gtk_text_iter_forward_line"
  external forward_cursor_positions: [>`gtktextiter] obj -> int -> bool = "ml_gtk_text_iter_forward_cursor_positions"
  external forward_cursor_position: [>`gtktextiter] obj -> bool = "ml_gtk_text_iter_forward_cursor_position"
  external forward_chars: [>`gtktextiter] obj -> int -> bool = "ml_gtk_text_iter_forward_chars"
  external forward_char: [>`gtktextiter] obj -> bool = "ml_gtk_text_iter_forward_char"
  external equal: [>`gtktextiter] obj -> [>`gtktextiter] obj -> bool = "ml_gtk_text_iter_equal"
  external ends_word: [>`gtktextiter] obj -> bool = "ml_gtk_text_iter_ends_word"
  external ends_tag: [>`gtktextiter] obj -> [>`gtktexttag] obj option -> bool = "ml_gtk_text_iter_ends_tag"
  external ends_sentence: [>`gtktextiter] obj -> bool = "ml_gtk_text_iter_ends_sentence"
  external ends_line: [>`gtktextiter] obj -> bool = "ml_gtk_text_iter_ends_line"
  external editable: [>`gtktextiter] obj -> bool -> bool = "ml_gtk_text_iter_editable"
  external copy: [>`gtktextiter] obj -> [<`gtktextiter] obj = "ml_gtk_text_iter_copy"
  external compare: [>`gtktextiter] obj -> [>`gtktextiter] obj -> int = "ml_gtk_text_iter_compare"
  external can_insert: [>`gtktextiter] obj -> bool -> bool = "ml_gtk_text_iter_can_insert"
  external begins_tag: [>`gtktextiter] obj -> [>`gtktexttag] obj option -> bool = "ml_gtk_text_iter_begins_tag"
  external backward_word_starts: [>`gtktextiter] obj -> int -> bool = "ml_gtk_text_iter_backward_word_starts"
  external backward_word_start: [>`gtktextiter] obj -> bool = "ml_gtk_text_iter_backward_word_start"
  external backward_visible_word_starts: [>`gtktextiter] obj -> int -> bool = "ml_gtk_text_iter_backward_visible_word_starts"
  external backward_visible_word_start: [>`gtktextiter] obj -> bool = "ml_gtk_text_iter_backward_visible_word_start"
  external backward_visible_lines: [>`gtktextiter] obj -> int -> bool = "ml_gtk_text_iter_backward_visible_lines"
  external backward_visible_line: [>`gtktextiter] obj -> bool = "ml_gtk_text_iter_backward_visible_line"
  external backward_visible_cursor_positions: [>`gtktextiter] obj -> int -> bool = "ml_gtk_text_iter_backward_visible_cursor_positions"
  external backward_visible_cursor_position: [>`gtktextiter] obj -> bool = "ml_gtk_text_iter_backward_visible_cursor_position"
  external backward_to_tag_toggle: [>`gtktextiter] obj -> [>`gtktexttag] obj option -> bool = "ml_gtk_text_iter_backward_to_tag_toggle"
  external backward_sentence_starts: [>`gtktextiter] obj -> int -> bool = "ml_gtk_text_iter_backward_sentence_starts"
  external backward_sentence_start: [>`gtktextiter] obj -> bool = "ml_gtk_text_iter_backward_sentence_start"
  external backward_lines: [>`gtktextiter] obj -> int -> bool = "ml_gtk_text_iter_backward_lines"
  external backward_line: [>`gtktextiter] obj -> bool = "ml_gtk_text_iter_backward_line"
  external backward_cursor_positions: [>`gtktextiter] obj -> int -> bool = "ml_gtk_text_iter_backward_cursor_positions"
  external backward_cursor_position: [>`gtktextiter] obj -> bool = "ml_gtk_text_iter_backward_cursor_position"
  external backward_chars: [>`gtktextiter] obj -> int -> bool = "ml_gtk_text_iter_backward_chars"
  external backward_char: [>`gtktextiter] obj -> bool = "ml_gtk_text_iter_backward_char"
  end
module TextChildAnchorClass = struct
  end
module TextChildAnchor = struct
  external get_widgets: [>`gtktextchildanchor] obj -> [<`glist] obj = "ml_gtk_text_child_anchor_get_widgets"
  external get_deleted: [>`gtktextchildanchor] obj -> bool = "ml_gtk_text_child_anchor_get_deleted"
  end
module TextBufferPrivate = struct
  end
module TextBufferClass = struct
  end
module TextBuffer = struct
  external set_text: [>`gtktextbuffer] obj -> string -> int -> unit = "ml_gtk_text_buffer_set_text"
  external set_modified: [>`gtktextbuffer] obj -> bool -> unit = "ml_gtk_text_buffer_set_modified"
  external select_range: [>`gtktextbuffer] obj -> [>`gtktextiter] obj -> [>`gtktextiter] obj -> unit = "ml_gtk_text_buffer_select_range"
  external remove_tag_by_name: [>`gtktextbuffer] obj -> string -> [>`gtktextiter] obj -> [>`gtktextiter] obj -> unit = "ml_gtk_text_buffer_remove_tag_by_name"
  external remove_tag: [>`gtktextbuffer] obj -> [>`gtktexttag] obj -> [>`gtktextiter] obj -> [>`gtktextiter] obj -> unit = "ml_gtk_text_buffer_remove_tag"
  external remove_selection_clipboard: [>`gtktextbuffer] obj -> [>`gtkclipboard] obj -> unit = "ml_gtk_text_buffer_remove_selection_clipboard"
  external remove_all_tags: [>`gtktextbuffer] obj -> [>`gtktextiter] obj -> [>`gtktextiter] obj -> unit = "ml_gtk_text_buffer_remove_all_tags"
  external place_cursor: [>`gtktextbuffer] obj -> [>`gtktextiter] obj -> unit = "ml_gtk_text_buffer_place_cursor"
  external paste_clipboard: [>`gtktextbuffer] obj -> [>`gtkclipboard] obj -> [>`gtktextiter] obj option -> bool -> unit = "ml_gtk_text_buffer_paste_clipboard"
  external move_mark_by_name: [>`gtktextbuffer] obj -> string -> [>`gtktextiter] obj -> unit = "ml_gtk_text_buffer_move_mark_by_name"
  external move_mark: [>`gtktextbuffer] obj -> [>`gtktextmark] obj -> [>`gtktextiter] obj -> unit = "ml_gtk_text_buffer_move_mark"
  external insert_range_interactive: [>`gtktextbuffer] obj -> [>`gtktextiter] obj -> [>`gtktextiter] obj -> [>`gtktextiter] obj -> bool -> bool = "ml_gtk_text_buffer_insert_range_interactive"
  external insert_range: [>`gtktextbuffer] obj -> [>`gtktextiter] obj -> [>`gtktextiter] obj -> [>`gtktextiter] obj -> unit = "ml_gtk_text_buffer_insert_range"
  external insert_pixbuf: [>`gtktextbuffer] obj -> [>`gtktextiter] obj -> [>`gdkpixbuf] obj -> unit = "ml_gtk_text_buffer_insert_pixbuf"
  external insert_interactive_at_cursor: [>`gtktextbuffer] obj -> string -> int -> bool -> bool = "ml_gtk_text_buffer_insert_interactive_at_cursor"
  external insert_interactive: [>`gtktextbuffer] obj -> [>`gtktextiter] obj -> string -> int -> bool -> bool = "ml_gtk_text_buffer_insert_interactive"
  external insert_child_anchor: [>`gtktextbuffer] obj -> [>`gtktextiter] obj -> [>`gtktextchildanchor] obj -> unit = "ml_gtk_text_buffer_insert_child_anchor"
  external insert_at_cursor: [>`gtktextbuffer] obj -> string -> int -> unit = "ml_gtk_text_buffer_insert_at_cursor"
  external insert: [>`gtktextbuffer] obj -> [>`gtktextiter] obj -> string -> int -> unit = "ml_gtk_text_buffer_insert"
  external get_text: [>`gtktextbuffer] obj -> [>`gtktextiter] obj -> [>`gtktextiter] obj -> bool -> string = "ml_gtk_text_buffer_get_text"
  external get_tag_table: [>`gtktextbuffer] obj -> [<`gtktexttagtable] obj = "ml_gtk_text_buffer_get_tag_table"
  external get_slice: [>`gtktextbuffer] obj -> [>`gtktextiter] obj -> [>`gtktextiter] obj -> bool -> string = "ml_gtk_text_buffer_get_slice"
  external get_selection_bound: [>`gtktextbuffer] obj -> [<`gtktextmark] obj = "ml_gtk_text_buffer_get_selection_bound"
  external get_paste_target_list: [>`gtktextbuffer] obj -> [<`gtktargetlist] obj = "ml_gtk_text_buffer_get_paste_target_list"
  external get_modified: [>`gtktextbuffer] obj -> bool = "ml_gtk_text_buffer_get_modified"
  external get_mark: [>`gtktextbuffer] obj -> string -> [<`gtktextmark] obj = "ml_gtk_text_buffer_get_mark"
  external get_line_count: [>`gtktextbuffer] obj -> int = "ml_gtk_text_buffer_get_line_count"
  external get_insert: [>`gtktextbuffer] obj -> [<`gtktextmark] obj = "ml_gtk_text_buffer_get_insert"
  external get_has_selection: [>`gtktextbuffer] obj -> bool = "ml_gtk_text_buffer_get_has_selection"
  external get_copy_target_list: [>`gtktextbuffer] obj -> [<`gtktargetlist] obj = "ml_gtk_text_buffer_get_copy_target_list"
  external get_char_count: [>`gtktextbuffer] obj -> int = "ml_gtk_text_buffer_get_char_count"
  external end_user_action: [>`gtktextbuffer] obj -> unit = "ml_gtk_text_buffer_end_user_action"
  external delete_selection: [>`gtktextbuffer] obj -> bool -> bool -> bool = "ml_gtk_text_buffer_delete_selection"
  external delete_mark_by_name: [>`gtktextbuffer] obj -> string -> unit = "ml_gtk_text_buffer_delete_mark_by_name"
  external delete_mark: [>`gtktextbuffer] obj -> [>`gtktextmark] obj -> unit = "ml_gtk_text_buffer_delete_mark"
  external delete_interactive: [>`gtktextbuffer] obj -> [>`gtktextiter] obj -> [>`gtktextiter] obj -> bool -> bool = "ml_gtk_text_buffer_delete_interactive"
  external delete: [>`gtktextbuffer] obj -> [>`gtktextiter] obj -> [>`gtktextiter] obj -> unit = "ml_gtk_text_buffer_delete"
  external cut_clipboard: [>`gtktextbuffer] obj -> [>`gtkclipboard] obj -> bool -> unit = "ml_gtk_text_buffer_cut_clipboard"
  external create_mark: [>`gtktextbuffer] obj -> string option -> [>`gtktextiter] obj -> bool -> [<`gtktextmark] obj = "ml_gtk_text_buffer_create_mark"
  external create_child_anchor: [>`gtktextbuffer] obj -> [>`gtktextiter] obj -> [<`gtktextchildanchor] obj = "ml_gtk_text_buffer_create_child_anchor"
  external copy_clipboard: [>`gtktextbuffer] obj -> [>`gtkclipboard] obj -> unit = "ml_gtk_text_buffer_copy_clipboard"
  external begin_user_action: [>`gtktextbuffer] obj -> unit = "ml_gtk_text_buffer_begin_user_action"
  external backspace: [>`gtktextbuffer] obj -> [>`gtktextiter] obj -> bool -> bool -> bool = "ml_gtk_text_buffer_backspace"
  external apply_tag_by_name: [>`gtktextbuffer] obj -> string -> [>`gtktextiter] obj -> [>`gtktextiter] obj -> unit = "ml_gtk_text_buffer_apply_tag_by_name"
  external apply_tag: [>`gtktextbuffer] obj -> [>`gtktexttag] obj -> [>`gtktextiter] obj -> [>`gtktextiter] obj -> unit = "ml_gtk_text_buffer_apply_tag"
  external add_selection_clipboard: [>`gtktextbuffer] obj -> [>`gtkclipboard] obj -> unit = "ml_gtk_text_buffer_add_selection_clipboard"
  external add_mark: [>`gtktextbuffer] obj -> [>`gtktextmark] obj -> [>`gtktextiter] obj -> unit = "ml_gtk_text_buffer_add_mark"
  end
module TextBTree = struct
  end
module TextAttributes = struct
  external unref: [>`gtktextattributes] obj -> unit = "ml_gtk_text_attributes_unref"
  external ref: [>`gtktextattributes] obj -> [<`gtktextattributes] obj = "ml_gtk_text_attributes_ref"
  external copy_values: [>`gtktextattributes] obj -> [>`gtktextattributes] obj -> unit = "ml_gtk_text_attributes_copy_values"
  external copy: [>`gtktextattributes] obj -> [<`gtktextattributes] obj = "ml_gtk_text_attributes_copy"
  end
module TextAppearance = struct
  end
module TearoffMenuItemPrivate = struct
  end
module TearoffMenuItemClass = struct
  end
module TearoffMenuItem = struct
  end
module TargetList = struct
  external unref: [>`gtktargetlist] obj -> unit = "ml_gtk_target_list_unref"
  external ref: [>`gtktargetlist] obj -> [<`gtktargetlist] obj = "ml_gtk_target_list_ref"
  external add_uri_targets: [>`gtktargetlist] obj -> int -> unit = "ml_gtk_target_list_add_uri_targets"
  external add_text_targets: [>`gtktargetlist] obj -> int -> unit = "ml_gtk_target_list_add_text_targets"
  external add_rich_text_targets: [>`gtktargetlist] obj -> int -> bool -> [>`gtktextbuffer] obj -> unit = "ml_gtk_target_list_add_rich_text_targets"
  external add_image_targets: [>`gtktargetlist] obj -> int -> bool -> unit = "ml_gtk_target_list_add_image_targets"
  end
module TargetEntry = struct
  external free: [>`gtktargetentry] obj -> unit = "ml_gtk_target_entry_free"
  external copy: [>`gtktargetentry] obj -> [<`gtktargetentry] obj = "ml_gtk_target_entry_copy"
  end
module TableRowCol = struct
  end
module TablePrivate = struct
  end
module TableClass = struct
  end
module TableChild = struct
  end
module Table = struct
  external set_row_spacings: [>`gtktable] obj -> int -> unit = "ml_gtk_table_set_row_spacings"
  external set_row_spacing: [>`gtktable] obj -> int -> int -> unit = "ml_gtk_table_set_row_spacing"
  external set_homogeneous: [>`gtktable] obj -> bool -> unit = "ml_gtk_table_set_homogeneous"
  external set_col_spacings: [>`gtktable] obj -> int -> unit = "ml_gtk_table_set_col_spacings"
  external set_col_spacing: [>`gtktable] obj -> int -> int -> unit = "ml_gtk_table_set_col_spacing"
  external resize: [>`gtktable] obj -> int -> int -> unit = "ml_gtk_table_resize"
  external get_row_spacing: [>`gtktable] obj -> int -> int = "ml_gtk_table_get_row_spacing"
  external get_homogeneous: [>`gtktable] obj -> bool = "ml_gtk_table_get_homogeneous"
  external get_default_row_spacing: [>`gtktable] obj -> int = "ml_gtk_table_get_default_row_spacing"
  external get_default_col_spacing: [>`gtktable] obj -> int = "ml_gtk_table_get_default_col_spacing"
  external get_col_spacing: [>`gtktable] obj -> int -> int = "ml_gtk_table_get_col_spacing"
  external attach_defaults: [>`gtktable] obj -> [>`gtkwidget] obj -> int -> int -> int -> int -> unit = "ml_gtk_table_attach_defaults"
  end
module SymbolicColor = struct
  external unref: [>`gtksymboliccolor] obj -> unit = "ml_gtk_symbolic_color_unref"
  external ref: [>`gtksymboliccolor] obj -> [<`gtksymboliccolor] obj = "ml_gtk_symbolic_color_ref"
  external new_shade: [>`gtksymboliccolor] obj -> float -> [<`gtksymboliccolor] obj = "ml_gtk_symbolic_color_new_shade"
  external new_mix: [>`gtksymboliccolor] obj -> [>`gtksymboliccolor] obj -> float -> [<`gtksymboliccolor] obj = "ml_gtk_symbolic_color_new_mix"
  external new_alpha: [>`gtksymboliccolor] obj -> float -> [<`gtksymboliccolor] obj = "ml_gtk_symbolic_color_new_alpha"
  end
module SwitchPrivate = struct
  end
module SwitchClass = struct
  end
module Switch = struct
  external set_active: [>`gtkswitch] obj -> bool -> unit = "ml_gtk_switch_set_active"
  external get_active: [>`gtkswitch] obj -> bool = "ml_gtk_switch_get_active"
  end
module StyleProviderIface = struct
  end
module StylePropertiesClass = struct
  end
module StyleProperties = struct
  external merge: [>`gtkstyleproperties] obj -> [>`gtkstyleproperties] obj -> bool -> unit = "ml_gtk_style_properties_merge"
  external map_color: [>`gtkstyleproperties] obj -> string -> [>`gtksymboliccolor] obj -> unit = "ml_gtk_style_properties_map_color"
  external lookup_color: [>`gtkstyleproperties] obj -> string -> [<`gtksymboliccolor] obj = "ml_gtk_style_properties_lookup_color"
  external clear: [>`gtkstyleproperties] obj -> unit = "ml_gtk_style_properties_clear"
  end
module StyleContextClass = struct
  end
module StyleContext = struct
  external set_screen: [>`gtkstylecontext] obj -> [>`gdkscreen] obj -> unit = "ml_gtk_style_context_set_screen"
  external set_path: [>`gtkstylecontext] obj -> [>`gtkwidgetpath] obj -> unit = "ml_gtk_style_context_set_path"
  external set_background: [>`gtkstylecontext] obj -> [>`gdkwindow] obj -> unit = "ml_gtk_style_context_set_background"
  external scroll_animations: [>`gtkstylecontext] obj -> [>`gdkwindow] obj -> int -> int -> unit = "ml_gtk_style_context_scroll_animations"
  external save: [>`gtkstylecontext] obj -> unit = "ml_gtk_style_context_save"
  external restore: [>`gtkstylecontext] obj -> unit = "ml_gtk_style_context_restore"
  external remove_region: [>`gtkstylecontext] obj -> string -> unit = "ml_gtk_style_context_remove_region"
  external remove_class: [>`gtkstylecontext] obj -> string -> unit = "ml_gtk_style_context_remove_class"
  external pop_animatable_region: [>`gtkstylecontext] obj -> unit = "ml_gtk_style_context_pop_animatable_region"
  external lookup_icon_set: [>`gtkstylecontext] obj -> string -> [<`gtkiconset] obj = "ml_gtk_style_context_lookup_icon_set"
  external list_regions: [>`gtkstylecontext] obj -> [<`glist] obj = "ml_gtk_style_context_list_regions"
  external list_classes: [>`gtkstylecontext] obj -> [<`glist] obj = "ml_gtk_style_context_list_classes"
  external invalidate: [>`gtkstylecontext] obj -> unit = "ml_gtk_style_context_invalidate"
  external has_class: [>`gtkstylecontext] obj -> string -> bool = "ml_gtk_style_context_has_class"
  external get_style_property: [>`gtkstylecontext] obj -> string -> [>`gvalue] obj -> unit = "ml_gtk_style_context_get_style_property"
  external get_screen: [>`gtkstylecontext] obj -> [<`gdkscreen] obj = "ml_gtk_style_context_get_screen"
  external get_path: [>`gtkstylecontext] obj -> [<`gtkwidgetpath] obj = "ml_gtk_style_context_get_path"
  external add_class: [>`gtkstylecontext] obj -> string -> unit = "ml_gtk_style_context_add_class"
  external reset_widgets: [>`gdkscreen] obj -> unit = "ml_gtk_style_context_reset_widgets"
  end
module StyleClass = struct
  end
module Style = struct
  external lookup_icon_set: [>`gtkstyle] obj -> string -> [<`gtkiconset] obj = "ml_gtk_style_lookup_icon_set"
  external has_context: [>`gtkstyle] obj -> bool = "ml_gtk_style_has_context"
  external get_style_property: [>`gtkstyle] obj -> int -> string -> [>`gvalue] obj -> unit = "ml_gtk_style_get_style_property"
  external detach: [>`gtkstyle] obj -> unit = "ml_gtk_style_detach"
  external copy: [>`gtkstyle] obj -> [<`gtkstyle] obj = "ml_gtk_style_copy"
  external attach: [>`gtkstyle] obj -> [>`gdkwindow] obj -> [<`gtkstyle] obj = "ml_gtk_style_attach"
  end
module StockItem = struct
  external free: [>`gtkstockitem] obj -> unit = "ml_gtk_stock_item_free"
  external copy: [>`gtkstockitem] obj -> [<`gtkstockitem] obj = "ml_gtk_stock_item_copy"
  end
module StatusbarPrivate = struct
  end
module StatusbarClass = struct
  end
module Statusbar = struct
  external remove_all: [>`gtkstatusbar] obj -> int -> unit = "ml_gtk_statusbar_remove_all"
  external remove: [>`gtkstatusbar] obj -> int -> int -> unit = "ml_gtk_statusbar_remove"
  external push: [>`gtkstatusbar] obj -> int -> string -> int = "ml_gtk_statusbar_push"
  external pop: [>`gtkstatusbar] obj -> int -> unit = "ml_gtk_statusbar_pop"
  external get_message_area: [>`gtkstatusbar] obj -> [<`gtkwidget] obj = "ml_gtk_statusbar_get_message_area"
  external get_context_id: [>`gtkstatusbar] obj -> string -> int = "ml_gtk_statusbar_get_context_id"
  end
module StatusIconPrivate = struct
  end
module StatusIconClass = struct
  end
module StatusIcon = struct
  external set_visible: [>`gtkstatusicon] obj -> bool -> unit = "ml_gtk_status_icon_set_visible"
  external set_tooltip_text: [>`gtkstatusicon] obj -> string -> unit = "ml_gtk_status_icon_set_tooltip_text"
  external set_tooltip_markup: [>`gtkstatusicon] obj -> string option -> unit = "ml_gtk_status_icon_set_tooltip_markup"
  external set_title: [>`gtkstatusicon] obj -> string -> unit = "ml_gtk_status_icon_set_title"
  external set_screen: [>`gtkstatusicon] obj -> [>`gdkscreen] obj -> unit = "ml_gtk_status_icon_set_screen"
  external set_name: [>`gtkstatusicon] obj -> string -> unit = "ml_gtk_status_icon_set_name"
  external set_has_tooltip: [>`gtkstatusicon] obj -> bool -> unit = "ml_gtk_status_icon_set_has_tooltip"
  external set_from_stock: [>`gtkstatusicon] obj -> string -> unit = "ml_gtk_status_icon_set_from_stock"
  external set_from_pixbuf: [>`gtkstatusicon] obj -> [>`gdkpixbuf] obj option -> unit = "ml_gtk_status_icon_set_from_pixbuf"
  external set_from_icon_name: [>`gtkstatusicon] obj -> string -> unit = "ml_gtk_status_icon_set_from_icon_name"
  external is_embedded: [>`gtkstatusicon] obj -> bool = "ml_gtk_status_icon_is_embedded"
  external get_x11_window_id: [>`gtkstatusicon] obj -> int32 = "ml_gtk_status_icon_get_x11_window_id"
  external get_visible: [>`gtkstatusicon] obj -> bool = "ml_gtk_status_icon_get_visible"
  external get_tooltip_text: [>`gtkstatusicon] obj -> string = "ml_gtk_status_icon_get_tooltip_text"
  external get_tooltip_markup: [>`gtkstatusicon] obj -> string = "ml_gtk_status_icon_get_tooltip_markup"
  external get_title: [>`gtkstatusicon] obj -> string = "ml_gtk_status_icon_get_title"
  external get_stock: [>`gtkstatusicon] obj -> string = "ml_gtk_status_icon_get_stock"
  external get_size: [>`gtkstatusicon] obj -> int = "ml_gtk_status_icon_get_size"
  external get_screen: [>`gtkstatusicon] obj -> [<`gdkscreen] obj = "ml_gtk_status_icon_get_screen"
  external get_pixbuf: [>`gtkstatusicon] obj -> [<`gdkpixbuf] obj = "ml_gtk_status_icon_get_pixbuf"
  external get_icon_name: [>`gtkstatusicon] obj -> string = "ml_gtk_status_icon_get_icon_name"
  external get_has_tooltip: [>`gtkstatusicon] obj -> bool = "ml_gtk_status_icon_get_has_tooltip"
  end
module SpinnerPrivate = struct
  end
module SpinnerClass = struct
  end
module Spinner = struct
  external stop: [>`gtkspinner] obj -> unit = "ml_gtk_spinner_stop"
  external start: [>`gtkspinner] obj -> unit = "ml_gtk_spinner_start"
  end
module SpinButtonPrivate = struct
  end
module SpinButtonClass = struct
  end
module SpinButton = struct
  external update: [>`gtkspinbutton] obj -> unit = "ml_gtk_spin_button_update"
  external set_wrap: [>`gtkspinbutton] obj -> bool -> unit = "ml_gtk_spin_button_set_wrap"
  external set_value: [>`gtkspinbutton] obj -> float -> unit = "ml_gtk_spin_button_set_value"
  external set_snap_to_ticks: [>`gtkspinbutton] obj -> bool -> unit = "ml_gtk_spin_button_set_snap_to_ticks"
  external set_range: [>`gtkspinbutton] obj -> float -> float -> unit = "ml_gtk_spin_button_set_range"
  external set_numeric: [>`gtkspinbutton] obj -> bool -> unit = "ml_gtk_spin_button_set_numeric"
  external set_increments: [>`gtkspinbutton] obj -> float -> float -> unit = "ml_gtk_spin_button_set_increments"
  external set_digits: [>`gtkspinbutton] obj -> int -> unit = "ml_gtk_spin_button_set_digits"
  external set_adjustment: [>`gtkspinbutton] obj -> [>`gtkadjustment] obj -> unit = "ml_gtk_spin_button_set_adjustment"
  external get_wrap: [>`gtkspinbutton] obj -> bool = "ml_gtk_spin_button_get_wrap"
  external get_value_as_int: [>`gtkspinbutton] obj -> int = "ml_gtk_spin_button_get_value_as_int"
  external get_value: [>`gtkspinbutton] obj -> float = "ml_gtk_spin_button_get_value"
  external get_snap_to_ticks: [>`gtkspinbutton] obj -> bool = "ml_gtk_spin_button_get_snap_to_ticks"
  external get_numeric: [>`gtkspinbutton] obj -> bool = "ml_gtk_spin_button_get_numeric"
  external get_digits: [>`gtkspinbutton] obj -> int = "ml_gtk_spin_button_get_digits"
  external get_adjustment: [>`gtkspinbutton] obj -> [<`gtkadjustment] obj = "ml_gtk_spin_button_get_adjustment"
  external configure: [>`gtkspinbutton] obj -> [>`gtkadjustment] obj option -> float -> int -> unit = "ml_gtk_spin_button_configure"
  end
module SocketPrivate = struct
  end
module SocketClass = struct
  end
module Socket = struct
  external get_plug_window: [>`gtksocket] obj -> [<`gdkwindow] obj = "ml_gtk_socket_get_plug_window"
  end
module SizeGroupPrivate = struct
  end
module SizeGroupClass = struct
  end
module SizeGroup = struct
  external set_ignore_hidden: [>`gtksizegroup] obj -> bool -> unit = "ml_gtk_size_group_set_ignore_hidden"
  external remove_widget: [>`gtksizegroup] obj -> [>`gtkwidget] obj -> unit = "ml_gtk_size_group_remove_widget"
  external get_widgets: [>`gtksizegroup] obj -> [<`gslist] obj = "ml_gtk_size_group_get_widgets"
  external get_ignore_hidden: [>`gtksizegroup] obj -> bool = "ml_gtk_size_group_get_ignore_hidden"
  external add_widget: [>`gtksizegroup] obj -> [>`gtkwidget] obj -> unit = "ml_gtk_size_group_add_widget"
  end
module SettingsValue = struct
  end
module SettingsPrivate = struct
  end
module SettingsClass = struct
  end
module Settings = struct
  external set_string_property: [>`gtksettings] obj -> string -> string -> string -> unit = "ml_gtk_settings_set_string_property"
  external set_property_value: [>`gtksettings] obj -> string -> [>`gtksettingsvalue] obj -> unit = "ml_gtk_settings_set_property_value"
  external set_long_property: [>`gtksettings] obj -> string -> float -> string -> unit = "ml_gtk_settings_set_long_property"
  external set_double_property: [>`gtksettings] obj -> string -> float -> string -> unit = "ml_gtk_settings_set_double_property"
  external install_property: [>`gparamspec] obj -> unit = "ml_gtk_settings_install_property"
  external get_for_screen: [>`gdkscreen] obj -> [<`gtksettings] obj = "ml_gtk_settings_get_for_screen"
  external get_default: unit -> [<`gtksettings] obj = "ml_gtk_settings_get_default"
  end
module SeparatorToolItemPrivate = struct
  end
module SeparatorToolItemClass = struct
  end
module SeparatorToolItem = struct
  external set_draw: [>`gtkseparatortoolitem] obj -> bool -> unit = "ml_gtk_separator_tool_item_set_draw"
  external get_draw: [>`gtkseparatortoolitem] obj -> bool = "ml_gtk_separator_tool_item_get_draw"
  end
module SeparatorPrivate = struct
  end
module SeparatorMenuItemClass = struct
  end
module SeparatorMenuItem = struct
  end
module SeparatorClass = struct
  end
module Separator = struct
  end
module SelectionData = struct
  external targets_include_uri: [>`gtkselectiondata] obj -> bool = "ml_gtk_selection_data_targets_include_uri"
  external targets_include_text: [>`gtkselectiondata] obj -> bool = "ml_gtk_selection_data_targets_include_text"
  external targets_include_rich_text: [>`gtkselectiondata] obj -> [>`gtktextbuffer] obj -> bool = "ml_gtk_selection_data_targets_include_rich_text"
  external targets_include_image: [>`gtkselectiondata] obj -> bool -> bool = "ml_gtk_selection_data_targets_include_image"
  external set_text: [>`gtkselectiondata] obj -> string -> int -> bool = "ml_gtk_selection_data_set_text"
  external set_pixbuf: [>`gtkselectiondata] obj -> [>`gdkpixbuf] obj -> bool = "ml_gtk_selection_data_set_pixbuf"
  external get_pixbuf: [>`gtkselectiondata] obj -> [<`gdkpixbuf] obj = "ml_gtk_selection_data_get_pixbuf"
  external get_length: [>`gtkselectiondata] obj -> int = "ml_gtk_selection_data_get_length"
  external get_format: [>`gtkselectiondata] obj -> int = "ml_gtk_selection_data_get_format"
  external get_display: [>`gtkselectiondata] obj -> [<`gdkdisplay] obj = "ml_gtk_selection_data_get_display"
  external get_data: [>`gtkselectiondata] obj -> string = "ml_gtk_selection_data_get_data"
  external free: [>`gtkselectiondata] obj -> unit = "ml_gtk_selection_data_free"
  external copy: [>`gtkselectiondata] obj -> [<`gtkselectiondata] obj = "ml_gtk_selection_data_copy"
  end
module ScrolledWindowPrivate = struct
  end
module ScrolledWindowClass = struct
  end
module ScrolledWindow = struct
  external unset_placement: [>`gtkscrolledwindow] obj -> unit = "ml_gtk_scrolled_window_unset_placement"
  external set_vadjustment: [>`gtkscrolledwindow] obj -> [>`gtkadjustment] obj -> unit = "ml_gtk_scrolled_window_set_vadjustment"
  external set_min_content_width: [>`gtkscrolledwindow] obj -> int -> unit = "ml_gtk_scrolled_window_set_min_content_width"
  external set_min_content_height: [>`gtkscrolledwindow] obj -> int -> unit = "ml_gtk_scrolled_window_set_min_content_height"
  external set_hadjustment: [>`gtkscrolledwindow] obj -> [>`gtkadjustment] obj -> unit = "ml_gtk_scrolled_window_set_hadjustment"
  external get_vscrollbar: [>`gtkscrolledwindow] obj -> [<`gtkwidget] obj = "ml_gtk_scrolled_window_get_vscrollbar"
  external get_vadjustment: [>`gtkscrolledwindow] obj -> [<`gtkadjustment] obj = "ml_gtk_scrolled_window_get_vadjustment"
  external get_min_content_width: [>`gtkscrolledwindow] obj -> int = "ml_gtk_scrolled_window_get_min_content_width"
  external get_min_content_height: [>`gtkscrolledwindow] obj -> int = "ml_gtk_scrolled_window_get_min_content_height"
  external get_hscrollbar: [>`gtkscrolledwindow] obj -> [<`gtkwidget] obj = "ml_gtk_scrolled_window_get_hscrollbar"
  external get_hadjustment: [>`gtkscrolledwindow] obj -> [<`gtkadjustment] obj = "ml_gtk_scrolled_window_get_hadjustment"
  external add_with_viewport: [>`gtkscrolledwindow] obj -> [>`gtkwidget] obj -> unit = "ml_gtk_scrolled_window_add_with_viewport"
  end
module ScrollbarClass = struct
  end
module Scrollbar = struct
  end
module ScrollableInterface = struct
  end
module ScalePrivate = struct
  end
module ScaleClass = struct
  end
module ScaleButtonPrivate = struct
  end
module ScaleButtonClass = struct
  end
module ScaleButton = struct
  external set_value: [>`gtkscalebutton] obj -> float -> unit = "ml_gtk_scale_button_set_value"
  external set_adjustment: [>`gtkscalebutton] obj -> [>`gtkadjustment] obj -> unit = "ml_gtk_scale_button_set_adjustment"
  external get_value: [>`gtkscalebutton] obj -> float = "ml_gtk_scale_button_get_value"
  external get_popup: [>`gtkscalebutton] obj -> [<`gtkwidget] obj = "ml_gtk_scale_button_get_popup"
  external get_plus_button: [>`gtkscalebutton] obj -> [<`gtkwidget] obj = "ml_gtk_scale_button_get_plus_button"
  external get_minus_button: [>`gtkscalebutton] obj -> [<`gtkwidget] obj = "ml_gtk_scale_button_get_minus_button"
  external get_adjustment: [>`gtkscalebutton] obj -> [<`gtkadjustment] obj = "ml_gtk_scale_button_get_adjustment"
  end
module Scale = struct
  external set_draw_value: [>`gtkscale] obj -> bool -> unit = "ml_gtk_scale_set_draw_value"
  external set_digits: [>`gtkscale] obj -> int -> unit = "ml_gtk_scale_set_digits"
  external get_layout: [>`gtkscale] obj -> [<`pangolayout] obj = "ml_gtk_scale_get_layout"
  external get_draw_value: [>`gtkscale] obj -> bool = "ml_gtk_scale_get_draw_value"
  external get_digits: [>`gtkscale] obj -> int = "ml_gtk_scale_get_digits"
  external clear_marks: [>`gtkscale] obj -> unit = "ml_gtk_scale_clear_marks"
  end
module Requisition = struct
  external free: [>`gtkrequisition] obj -> unit = "ml_gtk_requisition_free"
  external copy: [>`gtkrequisition] obj -> [<`gtkrequisition] obj = "ml_gtk_requisition_copy"
  end
module RequestedSize = struct
  end
module RecentManagerPrivate = struct
  end
module RecentManagerClass = struct
  end
module RecentManager = struct
  external has_item: [>`gtkrecentmanager] obj -> string -> bool = "ml_gtk_recent_manager_has_item"
  external get_items: [>`gtkrecentmanager] obj -> [<`glist] obj = "ml_gtk_recent_manager_get_items"
  external add_item: [>`gtkrecentmanager] obj -> string -> bool = "ml_gtk_recent_manager_add_item"
  external add_full: [>`gtkrecentmanager] obj -> string -> [>`gtkrecentdata] obj -> bool = "ml_gtk_recent_manager_add_full"
  external get_default: unit -> [<`gtkrecentmanager] obj = "ml_gtk_recent_manager_get_default"
  end
module RecentInfo = struct
  external unref: [>`gtkrecentinfo] obj -> unit = "ml_gtk_recent_info_unref"
  external ref: [>`gtkrecentinfo] obj -> [<`gtkrecentinfo] obj = "ml_gtk_recent_info_ref"
  external match: [>`gtkrecentinfo] obj -> [>`gtkrecentinfo] obj -> bool = "ml_gtk_recent_info_match"
  external last_application: [>`gtkrecentinfo] obj -> string = "ml_gtk_recent_info_last_application"
  external is_local: [>`gtkrecentinfo] obj -> bool = "ml_gtk_recent_info_is_local"
  external has_group: [>`gtkrecentinfo] obj -> string -> bool = "ml_gtk_recent_info_has_group"
  external has_application: [>`gtkrecentinfo] obj -> string -> bool = "ml_gtk_recent_info_has_application"
  external get_uri_display: [>`gtkrecentinfo] obj -> string = "ml_gtk_recent_info_get_uri_display"
  external get_uri: [>`gtkrecentinfo] obj -> string = "ml_gtk_recent_info_get_uri"
  external get_short_name: [>`gtkrecentinfo] obj -> string = "ml_gtk_recent_info_get_short_name"
  external get_private_hint: [>`gtkrecentinfo] obj -> bool = "ml_gtk_recent_info_get_private_hint"
  external get_mime_type: [>`gtkrecentinfo] obj -> string = "ml_gtk_recent_info_get_mime_type"
  external get_icon: [>`gtkrecentinfo] obj -> int -> [<`gdkpixbuf] obj = "ml_gtk_recent_info_get_icon"
  external get_display_name: [>`gtkrecentinfo] obj -> string = "ml_gtk_recent_info_get_display_name"
  external get_description: [>`gtkrecentinfo] obj -> string = "ml_gtk_recent_info_get_description"
  external get_age: [>`gtkrecentinfo] obj -> int = "ml_gtk_recent_info_get_age"
  external exists: [>`gtkrecentinfo] obj -> bool = "ml_gtk_recent_info_exists"
  end
module RecentFilterInfo = struct
  end
module RecentFilter = struct
  external set_name: [>`gtkrecentfilter] obj -> string -> unit = "ml_gtk_recent_filter_set_name"
  external get_name: [>`gtkrecentfilter] obj -> string = "ml_gtk_recent_filter_get_name"
  external filter: [>`gtkrecentfilter] obj -> [>`gtkrecentfilterinfo] obj -> bool = "ml_gtk_recent_filter_filter"
  external add_pixbuf_formats: [>`gtkrecentfilter] obj -> unit = "ml_gtk_recent_filter_add_pixbuf_formats"
  external add_pattern: [>`gtkrecentfilter] obj -> string -> unit = "ml_gtk_recent_filter_add_pattern"
  external add_mime_type: [>`gtkrecentfilter] obj -> string -> unit = "ml_gtk_recent_filter_add_mime_type"
  external add_group: [>`gtkrecentfilter] obj -> string -> unit = "ml_gtk_recent_filter_add_group"
  external add_application: [>`gtkrecentfilter] obj -> string -> unit = "ml_gtk_recent_filter_add_application"
  external add_age: [>`gtkrecentfilter] obj -> int -> unit = "ml_gtk_recent_filter_add_age"
  end
module RecentData = struct
  end
module RecentChooserWidgetPrivate = struct
  end
module RecentChooserWidgetClass = struct
  end
module RecentChooserWidget = struct
  end
module RecentChooserMenuPrivate = struct
  end
module RecentChooserMenuClass = struct
  end
module RecentChooserMenu = struct
  external set_show_numbers: [>`gtkrecentchoosermenu] obj -> bool -> unit = "ml_gtk_recent_chooser_menu_set_show_numbers"
  external get_show_numbers: [>`gtkrecentchoosermenu] obj -> bool = "ml_gtk_recent_chooser_menu_get_show_numbers"
  end
module RecentChooserIface = struct
  end
module RecentChooserDialogPrivate = struct
  end
module RecentChooserDialogClass = struct
  end
module RecentChooserDialog = struct
  end
module RecentActionPrivate = struct
  end
module RecentActionClass = struct
  end
module RecentAction = struct
  external set_show_numbers: [>`gtkrecentaction] obj -> bool -> unit = "ml_gtk_recent_action_set_show_numbers"
  external get_show_numbers: [>`gtkrecentaction] obj -> bool = "ml_gtk_recent_action_get_show_numbers"
  end
module RcStyleClass = struct
  end
module RcStyle = struct
  external copy: [>`gtkrcstyle] obj -> [<`gtkrcstyle] obj = "ml_gtk_rc_style_copy"
  end
module RcProperty = struct
  end
module RcContext = struct
  end
module RangePrivate = struct
  end
module RangeClass = struct
  end
module Range = struct
  external set_value: [>`gtkrange] obj -> float -> unit = "ml_gtk_range_set_value"
  external set_slider_size_fixed: [>`gtkrange] obj -> bool -> unit = "ml_gtk_range_set_slider_size_fixed"
  external set_show_fill_level: [>`gtkrange] obj -> bool -> unit = "ml_gtk_range_set_show_fill_level"
  external set_round_digits: [>`gtkrange] obj -> int -> unit = "ml_gtk_range_set_round_digits"
  external set_restrict_to_fill_level: [>`gtkrange] obj -> bool -> unit = "ml_gtk_range_set_restrict_to_fill_level"
  external set_range: [>`gtkrange] obj -> float -> float -> unit = "ml_gtk_range_set_range"
  external set_min_slider_size: [>`gtkrange] obj -> int -> unit = "ml_gtk_range_set_min_slider_size"
  external set_inverted: [>`gtkrange] obj -> bool -> unit = "ml_gtk_range_set_inverted"
  external set_increments: [>`gtkrange] obj -> float -> float -> unit = "ml_gtk_range_set_increments"
  external set_flippable: [>`gtkrange] obj -> bool -> unit = "ml_gtk_range_set_flippable"
  external set_fill_level: [>`gtkrange] obj -> float -> unit = "ml_gtk_range_set_fill_level"
  external set_adjustment: [>`gtkrange] obj -> [>`gtkadjustment] obj -> unit = "ml_gtk_range_set_adjustment"
  external get_value: [>`gtkrange] obj -> float = "ml_gtk_range_get_value"
  external get_slider_size_fixed: [>`gtkrange] obj -> bool = "ml_gtk_range_get_slider_size_fixed"
  external get_show_fill_level: [>`gtkrange] obj -> bool = "ml_gtk_range_get_show_fill_level"
  external get_round_digits: [>`gtkrange] obj -> int = "ml_gtk_range_get_round_digits"
  external get_restrict_to_fill_level: [>`gtkrange] obj -> bool = "ml_gtk_range_get_restrict_to_fill_level"
  external get_min_slider_size: [>`gtkrange] obj -> int = "ml_gtk_range_get_min_slider_size"
  external get_inverted: [>`gtkrange] obj -> bool = "ml_gtk_range_get_inverted"
  external get_flippable: [>`gtkrange] obj -> bool = "ml_gtk_range_get_flippable"
  external get_fill_level: [>`gtkrange] obj -> float = "ml_gtk_range_get_fill_level"
  external get_event_window: [>`gtkrange] obj -> [<`gdkwindow] obj = "ml_gtk_range_get_event_window"
  external get_adjustment: [>`gtkrange] obj -> [<`gtkadjustment] obj = "ml_gtk_range_get_adjustment"
  end
module RadioToolButtonClass = struct
  end
module RadioToolButton = struct
  external set_group: [>`gtkradiotoolbutton] obj -> [>`gslist] obj -> unit = "ml_gtk_radio_tool_button_set_group"
  external new_with_stock_from_widget: [>`gtkradiotoolbutton] obj -> string -> [<`gtktoolitem] obj = "ml_gtk_radio_tool_button_new_with_stock_from_widget"
  external new_from_widget: [>`gtkradiotoolbutton] obj -> [<`gtktoolitem] obj = "ml_gtk_radio_tool_button_new_from_widget"
  external get_group: [>`gtkradiotoolbutton] obj -> [<`gslist] obj = "ml_gtk_radio_tool_button_get_group"
  end
module RadioMenuItemPrivate = struct
  end
module RadioMenuItemClass = struct
  end
module RadioMenuItem = struct
  external set_group: [>`gtkradiomenuitem] obj -> [>`gslist] obj -> unit = "ml_gtk_radio_menu_item_set_group"
  external new_with_mnemonic_from_widget: [>`gtkradiomenuitem] obj -> string -> [<`gtkwidget] obj = "ml_gtk_radio_menu_item_new_with_mnemonic_from_widget"
  external new_with_label_from_widget: [>`gtkradiomenuitem] obj -> string -> [<`gtkwidget] obj = "ml_gtk_radio_menu_item_new_with_label_from_widget"
  external new_from_widget: [>`gtkradiomenuitem] obj -> [<`gtkwidget] obj = "ml_gtk_radio_menu_item_new_from_widget"
  external get_group: [>`gtkradiomenuitem] obj -> [<`gslist] obj = "ml_gtk_radio_menu_item_get_group"
  end
module RadioButtonPrivate = struct
  end
module RadioButtonClass = struct
  end
module RadioButton = struct
  external set_group: [>`gtkradiobutton] obj -> [>`gslist] obj -> unit = "ml_gtk_radio_button_set_group"
  external new_from_widget: [>`gtkradiobutton] obj -> [<`gtkwidget] obj = "ml_gtk_radio_button_new_from_widget"
  external join_group: [>`gtkradiobutton] obj -> [>`gtkradiobutton] obj option -> unit = "ml_gtk_radio_button_join_group"
  external get_group: [>`gtkradiobutton] obj -> [<`gslist] obj = "ml_gtk_radio_button_get_group"
  end
module RadioActionPrivate = struct
  end
module RadioActionEntry = struct
  end
module RadioActionClass = struct
  end
module RadioAction = struct
  external set_group: [>`gtkradioaction] obj -> [>`gslist] obj -> unit = "ml_gtk_radio_action_set_group"
  external set_current_value: [>`gtkradioaction] obj -> int -> unit = "ml_gtk_radio_action_set_current_value"
  external join_group: [>`gtkradioaction] obj -> [>`gtkradioaction] obj option -> unit = "ml_gtk_radio_action_join_group"
  external get_group: [>`gtkradioaction] obj -> [<`gslist] obj = "ml_gtk_radio_action_get_group"
  external get_current_value: [>`gtkradioaction] obj -> int = "ml_gtk_radio_action_get_current_value"
  end
module ProgressBarPrivate = struct
  end
module ProgressBarClass = struct
  end
module ProgressBar = struct
  external set_text: [>`gtkprogressbar] obj -> string option -> unit = "ml_gtk_progress_bar_set_text"
  external set_show_text: [>`gtkprogressbar] obj -> bool -> unit = "ml_gtk_progress_bar_set_show_text"
  external set_pulse_step: [>`gtkprogressbar] obj -> float -> unit = "ml_gtk_progress_bar_set_pulse_step"
  external set_inverted: [>`gtkprogressbar] obj -> bool -> unit = "ml_gtk_progress_bar_set_inverted"
  external set_fraction: [>`gtkprogressbar] obj -> float -> unit = "ml_gtk_progress_bar_set_fraction"
  external pulse: [>`gtkprogressbar] obj -> unit = "ml_gtk_progress_bar_pulse"
  external get_text: [>`gtkprogressbar] obj -> string = "ml_gtk_progress_bar_get_text"
  external get_show_text: [>`gtkprogressbar] obj -> bool = "ml_gtk_progress_bar_get_show_text"
  external get_pulse_step: [>`gtkprogressbar] obj -> float = "ml_gtk_progress_bar_get_pulse_step"
  external get_inverted: [>`gtkprogressbar] obj -> bool = "ml_gtk_progress_bar_get_inverted"
  external get_fraction: [>`gtkprogressbar] obj -> float = "ml_gtk_progress_bar_get_fraction"
  end
module PrintSettings = struct
  external unset: [>`gtkprintsettings] obj -> string -> unit = "ml_gtk_print_settings_unset"
  external to_key_file: [>`gtkprintsettings] obj -> [>`gkeyfile] obj -> string -> unit = "ml_gtk_print_settings_to_key_file"
  external set_use_color: [>`gtkprintsettings] obj -> bool -> unit = "ml_gtk_print_settings_set_use_color"
  external set_scale: [>`gtkprintsettings] obj -> float -> unit = "ml_gtk_print_settings_set_scale"
  external set_reverse: [>`gtkprintsettings] obj -> bool -> unit = "ml_gtk_print_settings_set_reverse"
  external set_resolution_xy: [>`gtkprintsettings] obj -> int -> int -> unit = "ml_gtk_print_settings_set_resolution_xy"
  external set_resolution: [>`gtkprintsettings] obj -> int -> unit = "ml_gtk_print_settings_set_resolution"
  external set_printer_lpi: [>`gtkprintsettings] obj -> float -> unit = "ml_gtk_print_settings_set_printer_lpi"
  external set_printer: [>`gtkprintsettings] obj -> string -> unit = "ml_gtk_print_settings_set_printer"
  external set_paper_size: [>`gtkprintsettings] obj -> [>`gtkpapersize] obj -> unit = "ml_gtk_print_settings_set_paper_size"
  external set_output_bin: [>`gtkprintsettings] obj -> string -> unit = "ml_gtk_print_settings_set_output_bin"
  external set_number_up: [>`gtkprintsettings] obj -> int -> unit = "ml_gtk_print_settings_set_number_up"
  external set_n_copies: [>`gtkprintsettings] obj -> int -> unit = "ml_gtk_print_settings_set_n_copies"
  external set_media_type: [>`gtkprintsettings] obj -> string -> unit = "ml_gtk_print_settings_set_media_type"
  external set_int: [>`gtkprintsettings] obj -> string -> int -> unit = "ml_gtk_print_settings_set_int"
  external set_finishings: [>`gtkprintsettings] obj -> string -> unit = "ml_gtk_print_settings_set_finishings"
  external set_double: [>`gtkprintsettings] obj -> string -> float -> unit = "ml_gtk_print_settings_set_double"
  external set_dither: [>`gtkprintsettings] obj -> string -> unit = "ml_gtk_print_settings_set_dither"
  external set_default_source: [>`gtkprintsettings] obj -> string -> unit = "ml_gtk_print_settings_set_default_source"
  external set_collate: [>`gtkprintsettings] obj -> bool -> unit = "ml_gtk_print_settings_set_collate"
  external set_bool: [>`gtkprintsettings] obj -> string -> bool -> unit = "ml_gtk_print_settings_set_bool"
  external set: [>`gtkprintsettings] obj -> string -> string option -> unit = "ml_gtk_print_settings_set"
  external has_key: [>`gtkprintsettings] obj -> string -> bool = "ml_gtk_print_settings_has_key"
  external get_use_color: [>`gtkprintsettings] obj -> bool = "ml_gtk_print_settings_get_use_color"
  external get_scale: [>`gtkprintsettings] obj -> float = "ml_gtk_print_settings_get_scale"
  external get_reverse: [>`gtkprintsettings] obj -> bool = "ml_gtk_print_settings_get_reverse"
  external get_resolution_y: [>`gtkprintsettings] obj -> int = "ml_gtk_print_settings_get_resolution_y"
  external get_resolution_x: [>`gtkprintsettings] obj -> int = "ml_gtk_print_settings_get_resolution_x"
  external get_resolution: [>`gtkprintsettings] obj -> int = "ml_gtk_print_settings_get_resolution"
  external get_printer_lpi: [>`gtkprintsettings] obj -> float = "ml_gtk_print_settings_get_printer_lpi"
  external get_printer: [>`gtkprintsettings] obj -> string = "ml_gtk_print_settings_get_printer"
  external get_paper_size: [>`gtkprintsettings] obj -> [<`gtkpapersize] obj = "ml_gtk_print_settings_get_paper_size"
  external get_output_bin: [>`gtkprintsettings] obj -> string = "ml_gtk_print_settings_get_output_bin"
  external get_number_up: [>`gtkprintsettings] obj -> int = "ml_gtk_print_settings_get_number_up"
  external get_n_copies: [>`gtkprintsettings] obj -> int = "ml_gtk_print_settings_get_n_copies"
  external get_media_type: [>`gtkprintsettings] obj -> string = "ml_gtk_print_settings_get_media_type"
  external get_int_with_default: [>`gtkprintsettings] obj -> string -> int -> int = "ml_gtk_print_settings_get_int_with_default"
  external get_int: [>`gtkprintsettings] obj -> string -> int = "ml_gtk_print_settings_get_int"
  external get_finishings: [>`gtkprintsettings] obj -> string = "ml_gtk_print_settings_get_finishings"
  external get_double_with_default: [>`gtkprintsettings] obj -> string -> float -> float = "ml_gtk_print_settings_get_double_with_default"
  external get_double: [>`gtkprintsettings] obj -> string -> float = "ml_gtk_print_settings_get_double"
  external get_dither: [>`gtkprintsettings] obj -> string = "ml_gtk_print_settings_get_dither"
  external get_default_source: [>`gtkprintsettings] obj -> string = "ml_gtk_print_settings_get_default_source"
  external get_collate: [>`gtkprintsettings] obj -> bool = "ml_gtk_print_settings_get_collate"
  external get_bool: [>`gtkprintsettings] obj -> string -> bool = "ml_gtk_print_settings_get_bool"
  external get: [>`gtkprintsettings] obj -> string -> string = "ml_gtk_print_settings_get"
  external copy: [>`gtkprintsettings] obj -> [<`gtkprintsettings] obj = "ml_gtk_print_settings_copy"
  end
module PrintOperationPrivate = struct
  end
module PrintOperationPreviewIface = struct
  end
module PrintOperationClass = struct
  end
module PrintOperation = struct
  external set_use_full_page: [>`gtkprintoperation] obj -> bool -> unit = "ml_gtk_print_operation_set_use_full_page"
  external set_track_print_status: [>`gtkprintoperation] obj -> bool -> unit = "ml_gtk_print_operation_set_track_print_status"
  external set_support_selection: [>`gtkprintoperation] obj -> bool -> unit = "ml_gtk_print_operation_set_support_selection"
  external set_show_progress: [>`gtkprintoperation] obj -> bool -> unit = "ml_gtk_print_operation_set_show_progress"
  external set_print_settings: [>`gtkprintoperation] obj -> [>`gtkprintsettings] obj option -> unit = "ml_gtk_print_operation_set_print_settings"
  external set_n_pages: [>`gtkprintoperation] obj -> int -> unit = "ml_gtk_print_operation_set_n_pages"
  external set_job_name: [>`gtkprintoperation] obj -> string -> unit = "ml_gtk_print_operation_set_job_name"
  external set_has_selection: [>`gtkprintoperation] obj -> bool -> unit = "ml_gtk_print_operation_set_has_selection"
  external set_embed_page_setup: [>`gtkprintoperation] obj -> bool -> unit = "ml_gtk_print_operation_set_embed_page_setup"
  external set_defer_drawing: [>`gtkprintoperation] obj -> unit = "ml_gtk_print_operation_set_defer_drawing"
  external set_default_page_setup: [>`gtkprintoperation] obj -> [>`gtkpagesetup] obj option -> unit = "ml_gtk_print_operation_set_default_page_setup"
  external set_custom_tab_label: [>`gtkprintoperation] obj -> string option -> unit = "ml_gtk_print_operation_set_custom_tab_label"
  external set_current_page: [>`gtkprintoperation] obj -> int -> unit = "ml_gtk_print_operation_set_current_page"
  external set_allow_async: [>`gtkprintoperation] obj -> bool -> unit = "ml_gtk_print_operation_set_allow_async"
  external is_finished: [>`gtkprintoperation] obj -> bool = "ml_gtk_print_operation_is_finished"
  external get_support_selection: [>`gtkprintoperation] obj -> bool = "ml_gtk_print_operation_get_support_selection"
  external get_status_string: [>`gtkprintoperation] obj -> string = "ml_gtk_print_operation_get_status_string"
  external get_print_settings: [>`gtkprintoperation] obj -> [<`gtkprintsettings] obj = "ml_gtk_print_operation_get_print_settings"
  external get_n_pages_to_print: [>`gtkprintoperation] obj -> int = "ml_gtk_print_operation_get_n_pages_to_print"
  external get_has_selection: [>`gtkprintoperation] obj -> bool = "ml_gtk_print_operation_get_has_selection"
  external get_embed_page_setup: [>`gtkprintoperation] obj -> bool = "ml_gtk_print_operation_get_embed_page_setup"
  external get_default_page_setup: [>`gtkprintoperation] obj -> [<`gtkpagesetup] obj = "ml_gtk_print_operation_get_default_page_setup"
  external draw_page_finish: [>`gtkprintoperation] obj -> unit = "ml_gtk_print_operation_draw_page_finish"
  external cancel: [>`gtkprintoperation] obj -> unit = "ml_gtk_print_operation_cancel"
  end
module PrintContext = struct
  external set_cairo_context: [>`gtkprintcontext] obj -> [>`cairo_t] obj -> float -> float -> unit = "ml_gtk_print_context_set_cairo_context"
  external get_width: [>`gtkprintcontext] obj -> float = "ml_gtk_print_context_get_width"
  external get_pango_fontmap: [>`gtkprintcontext] obj -> [<`pangofontmap] obj = "ml_gtk_print_context_get_pango_fontmap"
  external get_page_setup: [>`gtkprintcontext] obj -> [<`gtkpagesetup] obj = "ml_gtk_print_context_get_page_setup"
  external get_height: [>`gtkprintcontext] obj -> float = "ml_gtk_print_context_get_height"
  external get_dpi_y: [>`gtkprintcontext] obj -> float = "ml_gtk_print_context_get_dpi_y"
  external get_dpi_x: [>`gtkprintcontext] obj -> float = "ml_gtk_print_context_get_dpi_x"
  external get_cairo_context: [>`gtkprintcontext] obj -> [<`cairo_t] obj = "ml_gtk_print_context_get_cairo_context"
  external create_pango_layout: [>`gtkprintcontext] obj -> [<`pangolayout] obj = "ml_gtk_print_context_create_pango_layout"
  external create_pango_context: [>`gtkprintcontext] obj -> [<`pangocontext] obj = "ml_gtk_print_context_create_pango_context"
  end
module PlugPrivate = struct
  end
module PlugClass = struct
  end
module Plug = struct
  external get_socket_window: [>`gtkplug] obj -> [<`gdkwindow] obj = "ml_gtk_plug_get_socket_window"
  external get_embedded: [>`gtkplug] obj -> bool = "ml_gtk_plug_get_embedded"
  end
module PaperSize = struct
  external to_key_file: [>`gtkpapersize] obj -> [>`gkeyfile] obj -> string -> unit = "ml_gtk_paper_size_to_key_file"
  external is_equal: [>`gtkpapersize] obj -> [>`gtkpapersize] obj -> bool = "ml_gtk_paper_size_is_equal"
  external is_custom: [>`gtkpapersize] obj -> bool = "ml_gtk_paper_size_is_custom"
  external get_ppd_name: [>`gtkpapersize] obj -> string = "ml_gtk_paper_size_get_ppd_name"
  external get_name: [>`gtkpapersize] obj -> string = "ml_gtk_paper_size_get_name"
  external get_display_name: [>`gtkpapersize] obj -> string = "ml_gtk_paper_size_get_display_name"
  external free: [>`gtkpapersize] obj -> unit = "ml_gtk_paper_size_free"
  external copy: [>`gtkpapersize] obj -> [<`gtkpapersize] obj = "ml_gtk_paper_size_copy"
  end
module PanedPrivate = struct
  end
module PanedClass = struct
  end
module Paned = struct
  external set_position: [>`gtkpaned] obj -> int -> unit = "ml_gtk_paned_set_position"
  external pack2: [>`gtkpaned] obj -> [>`gtkwidget] obj -> bool -> bool -> unit = "ml_gtk_paned_pack2"
  external pack1: [>`gtkpaned] obj -> [>`gtkwidget] obj -> bool -> bool -> unit = "ml_gtk_paned_pack1"
  external get_position: [>`gtkpaned] obj -> int = "ml_gtk_paned_get_position"
  external get_handle_window: [>`gtkpaned] obj -> [<`gdkwindow] obj = "ml_gtk_paned_get_handle_window"
  external get_child2: [>`gtkpaned] obj -> [<`gtkwidget] obj = "ml_gtk_paned_get_child2"
  external get_child1: [>`gtkpaned] obj -> [<`gtkwidget] obj = "ml_gtk_paned_get_child1"
  external add2: [>`gtkpaned] obj -> [>`gtkwidget] obj -> unit = "ml_gtk_paned_add2"
  external add1: [>`gtkpaned] obj -> [>`gtkwidget] obj -> unit = "ml_gtk_paned_add1"
  end
module PageSetup = struct
  external to_key_file: [>`gtkpagesetup] obj -> [>`gkeyfile] obj -> string -> unit = "ml_gtk_page_setup_to_key_file"
  external set_paper_size_and_default_margins: [>`gtkpagesetup] obj -> [>`gtkpapersize] obj -> unit = "ml_gtk_page_setup_set_paper_size_and_default_margins"
  external set_paper_size: [>`gtkpagesetup] obj -> [>`gtkpapersize] obj -> unit = "ml_gtk_page_setup_set_paper_size"
  external get_paper_size: [>`gtkpagesetup] obj -> [<`gtkpapersize] obj = "ml_gtk_page_setup_get_paper_size"
  external copy: [>`gtkpagesetup] obj -> [<`gtkpagesetup] obj = "ml_gtk_page_setup_copy"
  end
module PageRange = struct
  end
module OrientableIface = struct
  end
module OffscreenWindowClass = struct
  end
module OffscreenWindow = struct
  external get_surface: [>`gtkoffscreenwindow] obj -> [<`cairo_surface_t] obj = "ml_gtk_offscreen_window_get_surface"
  external get_pixbuf: [>`gtkoffscreenwindow] obj -> [<`gdkpixbuf] obj = "ml_gtk_offscreen_window_get_pixbuf"
  end
module NumerableIconPrivate = struct
  end
module NumerableIconClass = struct
  end
module NumerableIcon = struct
  external set_style_context: [>`gtknumerableicon] obj -> [>`gtkstylecontext] obj -> unit = "ml_gtk_numerable_icon_set_style_context"
  external set_label: [>`gtknumerableicon] obj -> string option -> unit = "ml_gtk_numerable_icon_set_label"
  external set_count: [>`gtknumerableicon] obj -> int -> unit = "ml_gtk_numerable_icon_set_count"
  external set_background_icon_name: [>`gtknumerableicon] obj -> string option -> unit = "ml_gtk_numerable_icon_set_background_icon_name"
  external get_style_context: [>`gtknumerableicon] obj -> [<`gtkstylecontext] obj = "ml_gtk_numerable_icon_get_style_context"
  external get_label: [>`gtknumerableicon] obj -> string = "ml_gtk_numerable_icon_get_label"
  external get_count: [>`gtknumerableicon] obj -> int = "ml_gtk_numerable_icon_get_count"
  external get_background_icon_name: [>`gtknumerableicon] obj -> string = "ml_gtk_numerable_icon_get_background_icon_name"
  end
module NotebookPrivate = struct
  end
module NotebookClass = struct
  end
module Notebook = struct
  external set_tab_reorderable: [>`gtknotebook] obj -> [>`gtkwidget] obj -> bool -> unit = "ml_gtk_notebook_set_tab_reorderable"
  external set_tab_label_text: [>`gtknotebook] obj -> [>`gtkwidget] obj -> string -> unit = "ml_gtk_notebook_set_tab_label_text"
  external set_tab_label: [>`gtknotebook] obj -> [>`gtkwidget] obj -> [>`gtkwidget] obj option -> unit = "ml_gtk_notebook_set_tab_label"
  external set_tab_detachable: [>`gtknotebook] obj -> [>`gtkwidget] obj -> bool -> unit = "ml_gtk_notebook_set_tab_detachable"
  external set_show_tabs: [>`gtknotebook] obj -> bool -> unit = "ml_gtk_notebook_set_show_tabs"
  external set_show_border: [>`gtknotebook] obj -> bool -> unit = "ml_gtk_notebook_set_show_border"
  external set_scrollable: [>`gtknotebook] obj -> bool -> unit = "ml_gtk_notebook_set_scrollable"
  external set_menu_label_text: [>`gtknotebook] obj -> [>`gtkwidget] obj -> string -> unit = "ml_gtk_notebook_set_menu_label_text"
  external set_menu_label: [>`gtknotebook] obj -> [>`gtkwidget] obj -> [>`gtkwidget] obj option -> unit = "ml_gtk_notebook_set_menu_label"
  external set_group_name: [>`gtknotebook] obj -> string option -> unit = "ml_gtk_notebook_set_group_name"
  external set_current_page: [>`gtknotebook] obj -> int -> unit = "ml_gtk_notebook_set_current_page"
  external reorder_child: [>`gtknotebook] obj -> [>`gtkwidget] obj -> int -> unit = "ml_gtk_notebook_reorder_child"
  external remove_page: [>`gtknotebook] obj -> int -> unit = "ml_gtk_notebook_remove_page"
  external prev_page: [>`gtknotebook] obj -> unit = "ml_gtk_notebook_prev_page"
  external prepend_page_menu: [>`gtknotebook] obj -> [>`gtkwidget] obj -> [>`gtkwidget] obj option -> [>`gtkwidget] obj option -> int = "ml_gtk_notebook_prepend_page_menu"
  external prepend_page: [>`gtknotebook] obj -> [>`gtkwidget] obj -> [>`gtkwidget] obj option -> int = "ml_gtk_notebook_prepend_page"
  external popup_enable: [>`gtknotebook] obj -> unit = "ml_gtk_notebook_popup_enable"
  external popup_disable: [>`gtknotebook] obj -> unit = "ml_gtk_notebook_popup_disable"
  external page_num: [>`gtknotebook] obj -> [>`gtkwidget] obj -> int = "ml_gtk_notebook_page_num"
  external next_page: [>`gtknotebook] obj -> unit = "ml_gtk_notebook_next_page"
  external insert_page_menu: [>`gtknotebook] obj -> [>`gtkwidget] obj -> [>`gtkwidget] obj option -> [>`gtkwidget] obj option -> int -> int = "ml_gtk_notebook_insert_page_menu"
  external insert_page: [>`gtknotebook] obj -> [>`gtkwidget] obj -> [>`gtkwidget] obj option -> int -> int = "ml_gtk_notebook_insert_page"
  external get_tab_vborder: [>`gtknotebook] obj -> int = "ml_gtk_notebook_get_tab_vborder"
  external get_tab_reorderable: [>`gtknotebook] obj -> [>`gtkwidget] obj -> bool = "ml_gtk_notebook_get_tab_reorderable"
  external get_tab_label_text: [>`gtknotebook] obj -> [>`gtkwidget] obj -> string = "ml_gtk_notebook_get_tab_label_text"
  external get_tab_label: [>`gtknotebook] obj -> [>`gtkwidget] obj -> [<`gtkwidget] obj = "ml_gtk_notebook_get_tab_label"
  external get_tab_hborder: [>`gtknotebook] obj -> int = "ml_gtk_notebook_get_tab_hborder"
  external get_tab_detachable: [>`gtknotebook] obj -> [>`gtkwidget] obj -> bool = "ml_gtk_notebook_get_tab_detachable"
  external get_show_tabs: [>`gtknotebook] obj -> bool = "ml_gtk_notebook_get_show_tabs"
  external get_show_border: [>`gtknotebook] obj -> bool = "ml_gtk_notebook_get_show_border"
  external get_scrollable: [>`gtknotebook] obj -> bool = "ml_gtk_notebook_get_scrollable"
  external get_nth_page: [>`gtknotebook] obj -> int -> [<`gtkwidget] obj = "ml_gtk_notebook_get_nth_page"
  external get_n_pages: [>`gtknotebook] obj -> int = "ml_gtk_notebook_get_n_pages"
  external get_menu_label_text: [>`gtknotebook] obj -> [>`gtkwidget] obj -> string = "ml_gtk_notebook_get_menu_label_text"
  external get_menu_label: [>`gtknotebook] obj -> [>`gtkwidget] obj -> [<`gtkwidget] obj = "ml_gtk_notebook_get_menu_label"
  external get_group_name: [>`gtknotebook] obj -> string = "ml_gtk_notebook_get_group_name"
  external get_current_page: [>`gtknotebook] obj -> int = "ml_gtk_notebook_get_current_page"
  external append_page_menu: [>`gtknotebook] obj -> [>`gtkwidget] obj -> [>`gtkwidget] obj option -> [>`gtkwidget] obj option -> int = "ml_gtk_notebook_append_page_menu"
  external append_page: [>`gtknotebook] obj -> [>`gtkwidget] obj -> [>`gtkwidget] obj option -> int = "ml_gtk_notebook_append_page"
  end
module MountOperationPrivate = struct
  end
module MountOperationClass = struct
  end
module MountOperation = struct
  external set_screen: [>`gtkmountoperation] obj -> [>`gdkscreen] obj -> unit = "ml_gtk_mount_operation_set_screen"
  external set_parent: [>`gtkmountoperation] obj -> [>`gtkwindow] obj option -> unit = "ml_gtk_mount_operation_set_parent"
  external is_showing: [>`gtkmountoperation] obj -> bool = "ml_gtk_mount_operation_is_showing"
  external get_screen: [>`gtkmountoperation] obj -> [<`gdkscreen] obj = "ml_gtk_mount_operation_get_screen"
  external get_parent: [>`gtkmountoperation] obj -> [<`gtkwindow] obj = "ml_gtk_mount_operation_get_parent"
  end
module MiscPrivate = struct
  end
module MiscClass = struct
  end
module Misc = struct
  external set_padding: [>`gtkmisc] obj -> int -> int -> unit = "ml_gtk_misc_set_padding"
  end
module MessageDialogPrivate = struct
  end
module MessageDialogClass = struct
  end
module MessageDialog = struct
  external set_markup: [>`gtkmessagedialog] obj -> string -> unit = "ml_gtk_message_dialog_set_markup"
  external set_image: [>`gtkmessagedialog] obj -> [>`gtkwidget] obj -> unit = "ml_gtk_message_dialog_set_image"
  external get_message_area: [>`gtkmessagedialog] obj -> [<`gtkwidget] obj = "ml_gtk_message_dialog_get_message_area"
  external get_image: [>`gtkmessagedialog] obj -> [<`gtkwidget] obj = "ml_gtk_message_dialog_get_image"
  end
module MenuToolButtonPrivate = struct
  end
module MenuToolButtonClass = struct
  end
module MenuToolButton = struct
  external set_menu: [>`gtkmenutoolbutton] obj -> [>`gtkwidget] obj -> unit = "ml_gtk_menu_tool_button_set_menu"
  external set_arrow_tooltip_text: [>`gtkmenutoolbutton] obj -> string -> unit = "ml_gtk_menu_tool_button_set_arrow_tooltip_text"
  external set_arrow_tooltip_markup: [>`gtkmenutoolbutton] obj -> string -> unit = "ml_gtk_menu_tool_button_set_arrow_tooltip_markup"
  external get_menu: [>`gtkmenutoolbutton] obj -> [<`gtkwidget] obj = "ml_gtk_menu_tool_button_get_menu"
  end
module MenuShellPrivate = struct
  end
module MenuShellClass = struct
  end
module MenuShell = struct
  external set_take_focus: [>`gtkmenushell] obj -> bool -> unit = "ml_gtk_menu_shell_set_take_focus"
  external select_item: [>`gtkmenushell] obj -> [>`gtkwidget] obj -> unit = "ml_gtk_menu_shell_select_item"
  external select_first: [>`gtkmenushell] obj -> bool -> unit = "ml_gtk_menu_shell_select_first"
  external prepend: [>`gtkmenushell] obj -> [>`gtkwidget] obj -> unit = "ml_gtk_menu_shell_prepend"
  external insert: [>`gtkmenushell] obj -> [>`gtkwidget] obj -> int -> unit = "ml_gtk_menu_shell_insert"
  external get_take_focus: [>`gtkmenushell] obj -> bool = "ml_gtk_menu_shell_get_take_focus"
  external get_selected_item: [>`gtkmenushell] obj -> [<`gtkwidget] obj = "ml_gtk_menu_shell_get_selected_item"
  external get_parent_shell: [>`gtkmenushell] obj -> [<`gtkwidget] obj = "ml_gtk_menu_shell_get_parent_shell"
  external deselect: [>`gtkmenushell] obj -> unit = "ml_gtk_menu_shell_deselect"
  external deactivate: [>`gtkmenushell] obj -> unit = "ml_gtk_menu_shell_deactivate"
  external cancel: [>`gtkmenushell] obj -> unit = "ml_gtk_menu_shell_cancel"
  external append: [>`gtkmenushell] obj -> [>`gtkwidget] obj -> unit = "ml_gtk_menu_shell_append"
  external activate_item: [>`gtkmenushell] obj -> [>`gtkwidget] obj -> bool -> unit = "ml_gtk_menu_shell_activate_item"
  end
module MenuPrivate = struct
  end
module MenuItemPrivate = struct
  end
module MenuItemClass = struct
  end
module MenuItem = struct
  external toggle_size_allocate: [>`gtkmenuitem] obj -> int -> unit = "ml_gtk_menu_item_toggle_size_allocate"
  external set_use_underline: [>`gtkmenuitem] obj -> bool -> unit = "ml_gtk_menu_item_set_use_underline"
  external set_submenu: [>`gtkmenuitem] obj -> [>`gtkwidget] obj option -> unit = "ml_gtk_menu_item_set_submenu"
  external set_right_justified: [>`gtkmenuitem] obj -> bool -> unit = "ml_gtk_menu_item_set_right_justified"
  external set_reserve_indicator: [>`gtkmenuitem] obj -> bool -> unit = "ml_gtk_menu_item_set_reserve_indicator"
  external set_label: [>`gtkmenuitem] obj -> string -> unit = "ml_gtk_menu_item_set_label"
  external set_accel_path: [>`gtkmenuitem] obj -> string option -> unit = "ml_gtk_menu_item_set_accel_path"
  external select: [>`gtkmenuitem] obj -> unit = "ml_gtk_menu_item_select"
  external get_use_underline: [>`gtkmenuitem] obj -> bool = "ml_gtk_menu_item_get_use_underline"
  external get_submenu: [>`gtkmenuitem] obj -> [<`gtkwidget] obj = "ml_gtk_menu_item_get_submenu"
  external get_right_justified: [>`gtkmenuitem] obj -> bool = "ml_gtk_menu_item_get_right_justified"
  external get_reserve_indicator: [>`gtkmenuitem] obj -> bool = "ml_gtk_menu_item_get_reserve_indicator"
  external get_label: [>`gtkmenuitem] obj -> string = "ml_gtk_menu_item_get_label"
  external get_accel_path: [>`gtkmenuitem] obj -> string = "ml_gtk_menu_item_get_accel_path"
  external deselect: [>`gtkmenuitem] obj -> unit = "ml_gtk_menu_item_deselect"
  external activate: [>`gtkmenuitem] obj -> unit = "ml_gtk_menu_item_activate"
  end
module MenuClass = struct
  end
module MenuBarPrivate = struct
  end
module MenuBarClass = struct
  end
module MenuBar = struct
  end
module Menu = struct
  external set_title: [>`gtkmenu] obj -> string -> unit = "ml_gtk_menu_set_title"
  external set_tearoff_state: [>`gtkmenu] obj -> bool -> unit = "ml_gtk_menu_set_tearoff_state"
  external set_screen: [>`gtkmenu] obj -> [>`gdkscreen] obj option -> unit = "ml_gtk_menu_set_screen"
  external set_reserve_toggle_size: [>`gtkmenu] obj -> bool -> unit = "ml_gtk_menu_set_reserve_toggle_size"
  external set_monitor: [>`gtkmenu] obj -> int -> unit = "ml_gtk_menu_set_monitor"
  external set_active: [>`gtkmenu] obj -> int -> unit = "ml_gtk_menu_set_active"
  external set_accel_path: [>`gtkmenu] obj -> string option -> unit = "ml_gtk_menu_set_accel_path"
  external set_accel_group: [>`gtkmenu] obj -> [>`gtkaccelgroup] obj option -> unit = "ml_gtk_menu_set_accel_group"
  external reposition: [>`gtkmenu] obj -> unit = "ml_gtk_menu_reposition"
  external reorder_child: [>`gtkmenu] obj -> [>`gtkwidget] obj -> int -> unit = "ml_gtk_menu_reorder_child"
  external popdown: [>`gtkmenu] obj -> unit = "ml_gtk_menu_popdown"
  external get_title: [>`gtkmenu] obj -> string = "ml_gtk_menu_get_title"
  external get_tearoff_state: [>`gtkmenu] obj -> bool = "ml_gtk_menu_get_tearoff_state"
  external get_reserve_toggle_size: [>`gtkmenu] obj -> bool = "ml_gtk_menu_get_reserve_toggle_size"
  external get_monitor: [>`gtkmenu] obj -> int = "ml_gtk_menu_get_monitor"
  external get_attach_widget: [>`gtkmenu] obj -> [<`gtkwidget] obj = "ml_gtk_menu_get_attach_widget"
  external get_active: [>`gtkmenu] obj -> [<`gtkwidget] obj = "ml_gtk_menu_get_active"
  external get_accel_path: [>`gtkmenu] obj -> string = "ml_gtk_menu_get_accel_path"
  external get_accel_group: [>`gtkmenu] obj -> [<`gtkaccelgroup] obj = "ml_gtk_menu_get_accel_group"
  external detach: [>`gtkmenu] obj -> unit = "ml_gtk_menu_detach"
  external attach: [>`gtkmenu] obj -> [>`gtkwidget] obj -> int -> int -> int -> int -> unit = "ml_gtk_menu_attach"
  external get_for_attach_widget: [>`gtkwidget] obj -> [<`glist] obj = "ml_gtk_menu_get_for_attach_widget"
  end
module ListStorePrivate = struct
  end
module ListStoreClass = struct
  end
module ListStore = struct
  external swap: [>`gtkliststore] obj -> [>`gtktreeiter] obj -> [>`gtktreeiter] obj -> unit = "ml_gtk_list_store_swap"
  external set_value: [>`gtkliststore] obj -> [>`gtktreeiter] obj -> int -> [>`gvalue] obj -> unit = "ml_gtk_list_store_set_value"
  external remove: [>`gtkliststore] obj -> [>`gtktreeiter] obj -> bool = "ml_gtk_list_store_remove"
  external move_before: [>`gtkliststore] obj -> [>`gtktreeiter] obj -> [>`gtktreeiter] obj option -> unit = "ml_gtk_list_store_move_before"
  external move_after: [>`gtkliststore] obj -> [>`gtktreeiter] obj -> [>`gtktreeiter] obj option -> unit = "ml_gtk_list_store_move_after"
  external iter_is_valid: [>`gtkliststore] obj -> [>`gtktreeiter] obj -> bool = "ml_gtk_list_store_iter_is_valid"
  external clear: [>`gtkliststore] obj -> unit = "ml_gtk_list_store_clear"
  end
module LinkButtonPrivate = struct
  end
module LinkButtonClass = struct
  end
module LinkButton = struct
  external set_visited: [>`gtklinkbutton] obj -> bool -> unit = "ml_gtk_link_button_set_visited"
  external set_uri: [>`gtklinkbutton] obj -> string -> unit = "ml_gtk_link_button_set_uri"
  external get_visited: [>`gtklinkbutton] obj -> bool = "ml_gtk_link_button_get_visited"
  external get_uri: [>`gtklinkbutton] obj -> string = "ml_gtk_link_button_get_uri"
  end
module LayoutPrivate = struct
  end
module LayoutClass = struct
  end
module Layout = struct
  external set_vadjustment: [>`gtklayout] obj -> [>`gtkadjustment] obj option -> unit = "ml_gtk_layout_set_vadjustment"
  external set_size: [>`gtklayout] obj -> int -> int -> unit = "ml_gtk_layout_set_size"
  external set_hadjustment: [>`gtklayout] obj -> [>`gtkadjustment] obj option -> unit = "ml_gtk_layout_set_hadjustment"
  external put: [>`gtklayout] obj -> [>`gtkwidget] obj -> int -> int -> unit = "ml_gtk_layout_put"
  external move: [>`gtklayout] obj -> [>`gtkwidget] obj -> int -> int -> unit = "ml_gtk_layout_move"
  external get_vadjustment: [>`gtklayout] obj -> [<`gtkadjustment] obj = "ml_gtk_layout_get_vadjustment"
  external get_hadjustment: [>`gtklayout] obj -> [<`gtkadjustment] obj = "ml_gtk_layout_get_hadjustment"
  external get_bin_window: [>`gtklayout] obj -> [<`gdkwindow] obj = "ml_gtk_layout_get_bin_window"
  end
module LabelSelectionInfo = struct
  end
module LabelPrivate = struct
  end
module LabelClass = struct
  end
module Label = struct
  external set_width_chars: [>`gtklabel] obj -> int -> unit = "ml_gtk_label_set_width_chars"
  external set_use_underline: [>`gtklabel] obj -> bool -> unit = "ml_gtk_label_set_use_underline"
  external set_use_markup: [>`gtklabel] obj -> bool -> unit = "ml_gtk_label_set_use_markup"
  external set_track_visited_links: [>`gtklabel] obj -> bool -> unit = "ml_gtk_label_set_track_visited_links"
  external set_text_with_mnemonic: [>`gtklabel] obj -> string -> unit = "ml_gtk_label_set_text_with_mnemonic"
  external set_text: [>`gtklabel] obj -> string -> unit = "ml_gtk_label_set_text"
  external set_single_line_mode: [>`gtklabel] obj -> bool -> unit = "ml_gtk_label_set_single_line_mode"
  external set_selectable: [>`gtklabel] obj -> bool -> unit = "ml_gtk_label_set_selectable"
  external set_pattern: [>`gtklabel] obj -> string -> unit = "ml_gtk_label_set_pattern"
  external set_mnemonic_widget: [>`gtklabel] obj -> [>`gtkwidget] obj option -> unit = "ml_gtk_label_set_mnemonic_widget"
  external set_max_width_chars: [>`gtklabel] obj -> int -> unit = "ml_gtk_label_set_max_width_chars"
  external set_markup_with_mnemonic: [>`gtklabel] obj -> string -> unit = "ml_gtk_label_set_markup_with_mnemonic"
  external set_markup: [>`gtklabel] obj -> string -> unit = "ml_gtk_label_set_markup"
  external set_line_wrap: [>`gtklabel] obj -> bool -> unit = "ml_gtk_label_set_line_wrap"
  external set_label: [>`gtklabel] obj -> string -> unit = "ml_gtk_label_set_label"
  external set_attributes: [>`gtklabel] obj -> [>`pangoattrlist] obj -> unit = "ml_gtk_label_set_attributes"
  external set_angle: [>`gtklabel] obj -> float -> unit = "ml_gtk_label_set_angle"
  external select_region: [>`gtklabel] obj -> int -> int -> unit = "ml_gtk_label_select_region"
  external get_width_chars: [>`gtklabel] obj -> int = "ml_gtk_label_get_width_chars"
  external get_use_underline: [>`gtklabel] obj -> bool = "ml_gtk_label_get_use_underline"
  external get_use_markup: [>`gtklabel] obj -> bool = "ml_gtk_label_get_use_markup"
  external get_track_visited_links: [>`gtklabel] obj -> bool = "ml_gtk_label_get_track_visited_links"
  external get_text: [>`gtklabel] obj -> string = "ml_gtk_label_get_text"
  external get_single_line_mode: [>`gtklabel] obj -> bool = "ml_gtk_label_get_single_line_mode"
  external get_selectable: [>`gtklabel] obj -> bool = "ml_gtk_label_get_selectable"
  external get_mnemonic_widget: [>`gtklabel] obj -> [<`gtkwidget] obj = "ml_gtk_label_get_mnemonic_widget"
  external get_mnemonic_keyval: [>`gtklabel] obj -> int = "ml_gtk_label_get_mnemonic_keyval"
  external get_max_width_chars: [>`gtklabel] obj -> int = "ml_gtk_label_get_max_width_chars"
  external get_line_wrap: [>`gtklabel] obj -> bool = "ml_gtk_label_get_line_wrap"
  external get_layout: [>`gtklabel] obj -> [<`pangolayout] obj = "ml_gtk_label_get_layout"
  external get_label: [>`gtklabel] obj -> string = "ml_gtk_label_get_label"
  external get_current_uri: [>`gtklabel] obj -> string = "ml_gtk_label_get_current_uri"
  external get_attributes: [>`gtklabel] obj -> [<`pangoattrlist] obj = "ml_gtk_label_get_attributes"
  external get_angle: [>`gtklabel] obj -> float = "ml_gtk_label_get_angle"
  end
module InvisiblePrivate = struct
  end
module InvisibleClass = struct
  end
module Invisible = struct
  external set_screen: [>`gtkinvisible] obj -> [>`gdkscreen] obj -> unit = "ml_gtk_invisible_set_screen"
  external get_screen: [>`gtkinvisible] obj -> [<`gdkscreen] obj = "ml_gtk_invisible_get_screen"
  end
module InfoBarPrivate = struct
  end
module InfoBarClass = struct
  end
module InfoBar = struct
  external set_response_sensitive: [>`gtkinfobar] obj -> int -> bool -> unit = "ml_gtk_info_bar_set_response_sensitive"
  external set_default_response: [>`gtkinfobar] obj -> int -> unit = "ml_gtk_info_bar_set_default_response"
  external response: [>`gtkinfobar] obj -> int -> unit = "ml_gtk_info_bar_response"
  external get_content_area: [>`gtkinfobar] obj -> [<`gtkwidget] obj = "ml_gtk_info_bar_get_content_area"
  external get_action_area: [>`gtkinfobar] obj -> [<`gtkwidget] obj = "ml_gtk_info_bar_get_action_area"
  external add_button: [>`gtkinfobar] obj -> string -> int -> [<`gtkwidget] obj = "ml_gtk_info_bar_add_button"
  external add_action_widget: [>`gtkinfobar] obj -> [>`gtkwidget] obj -> int -> unit = "ml_gtk_info_bar_add_action_widget"
  end
module ImagePrivate = struct
  end
module ImageMenuItemPrivate = struct
  end
module ImageMenuItemClass = struct
  end
module ImageMenuItem = struct
  external set_use_stock: [>`gtkimagemenuitem] obj -> bool -> unit = "ml_gtk_image_menu_item_set_use_stock"
  external set_image: [>`gtkimagemenuitem] obj -> [>`gtkwidget] obj option -> unit = "ml_gtk_image_menu_item_set_image"
  external set_always_show_image: [>`gtkimagemenuitem] obj -> bool -> unit = "ml_gtk_image_menu_item_set_always_show_image"
  external set_accel_group: [>`gtkimagemenuitem] obj -> [>`gtkaccelgroup] obj -> unit = "ml_gtk_image_menu_item_set_accel_group"
  external get_use_stock: [>`gtkimagemenuitem] obj -> bool = "ml_gtk_image_menu_item_get_use_stock"
  external get_image: [>`gtkimagemenuitem] obj -> [<`gtkwidget] obj = "ml_gtk_image_menu_item_get_image"
  external get_always_show_image: [>`gtkimagemenuitem] obj -> bool = "ml_gtk_image_menu_item_get_always_show_image"
  end
module ImageClass = struct
  end
module Image = struct
  external set_pixel_size: [>`gtkimage] obj -> int -> unit = "ml_gtk_image_set_pixel_size"
  external set_from_pixbuf: [>`gtkimage] obj -> [>`gdkpixbuf] obj option -> unit = "ml_gtk_image_set_from_pixbuf"
  external set_from_animation: [>`gtkimage] obj -> [>`gdkpixbufanimation] obj -> unit = "ml_gtk_image_set_from_animation"
  external get_pixel_size: [>`gtkimage] obj -> int = "ml_gtk_image_get_pixel_size"
  external get_pixbuf: [>`gtkimage] obj -> [<`gdkpixbuf] obj = "ml_gtk_image_get_pixbuf"
  external get_animation: [>`gtkimage] obj -> [<`gdkpixbufanimation] obj = "ml_gtk_image_get_animation"
  external clear: [>`gtkimage] obj -> unit = "ml_gtk_image_clear"
  end
module IconViewPrivate = struct
  end
module IconViewClass = struct
  end
module IconView = struct
  external unset_model_drag_source: [>`gtkiconview] obj -> unit = "ml_gtk_icon_view_unset_model_drag_source"
  external unset_model_drag_dest: [>`gtkiconview] obj -> unit = "ml_gtk_icon_view_unset_model_drag_dest"
  external unselect_path: [>`gtkiconview] obj -> [>`gtktreepath] obj -> unit = "ml_gtk_icon_view_unselect_path"
  external unselect_all: [>`gtkiconview] obj -> unit = "ml_gtk_icon_view_unselect_all"
  external set_tooltip_item: [>`gtkiconview] obj -> [>`gtktooltip] obj -> [>`gtktreepath] obj -> unit = "ml_gtk_icon_view_set_tooltip_item"
  external set_tooltip_column: [>`gtkiconview] obj -> int -> unit = "ml_gtk_icon_view_set_tooltip_column"
  external set_tooltip_cell: [>`gtkiconview] obj -> [>`gtktooltip] obj -> [>`gtktreepath] obj -> [>`gtkcellrenderer] obj option -> unit = "ml_gtk_icon_view_set_tooltip_cell"
  external set_text_column: [>`gtkiconview] obj -> int -> unit = "ml_gtk_icon_view_set_text_column"
  external set_spacing: [>`gtkiconview] obj -> int -> unit = "ml_gtk_icon_view_set_spacing"
  external set_row_spacing: [>`gtkiconview] obj -> int -> unit = "ml_gtk_icon_view_set_row_spacing"
  external set_reorderable: [>`gtkiconview] obj -> bool -> unit = "ml_gtk_icon_view_set_reorderable"
  external set_pixbuf_column: [>`gtkiconview] obj -> int -> unit = "ml_gtk_icon_view_set_pixbuf_column"
  external set_markup_column: [>`gtkiconview] obj -> int -> unit = "ml_gtk_icon_view_set_markup_column"
  external set_margin: [>`gtkiconview] obj -> int -> unit = "ml_gtk_icon_view_set_margin"
  external set_item_width: [>`gtkiconview] obj -> int -> unit = "ml_gtk_icon_view_set_item_width"
  external set_item_padding: [>`gtkiconview] obj -> int -> unit = "ml_gtk_icon_view_set_item_padding"
  external set_cursor: [>`gtkiconview] obj -> [>`gtktreepath] obj -> [>`gtkcellrenderer] obj option -> bool -> unit = "ml_gtk_icon_view_set_cursor"
  external set_columns: [>`gtkiconview] obj -> int -> unit = "ml_gtk_icon_view_set_columns"
  external set_column_spacing: [>`gtkiconview] obj -> int -> unit = "ml_gtk_icon_view_set_column_spacing"
  external select_path: [>`gtkiconview] obj -> [>`gtktreepath] obj -> unit = "ml_gtk_icon_view_select_path"
  external select_all: [>`gtkiconview] obj -> unit = "ml_gtk_icon_view_select_all"
  external path_is_selected: [>`gtkiconview] obj -> [>`gtktreepath] obj -> bool = "ml_gtk_icon_view_path_is_selected"
  external item_activated: [>`gtkiconview] obj -> [>`gtktreepath] obj -> unit = "ml_gtk_icon_view_item_activated"
  external get_tooltip_column: [>`gtkiconview] obj -> int = "ml_gtk_icon_view_get_tooltip_column"
  external get_text_column: [>`gtkiconview] obj -> int = "ml_gtk_icon_view_get_text_column"
  external get_spacing: [>`gtkiconview] obj -> int = "ml_gtk_icon_view_get_spacing"
  external get_selected_items: [>`gtkiconview] obj -> [<`glist] obj = "ml_gtk_icon_view_get_selected_items"
  external get_row_spacing: [>`gtkiconview] obj -> int = "ml_gtk_icon_view_get_row_spacing"
  external get_reorderable: [>`gtkiconview] obj -> bool = "ml_gtk_icon_view_get_reorderable"
  external get_pixbuf_column: [>`gtkiconview] obj -> int = "ml_gtk_icon_view_get_pixbuf_column"
  external get_path_at_pos: [>`gtkiconview] obj -> int -> int -> [<`gtktreepath] obj = "ml_gtk_icon_view_get_path_at_pos"
  external get_markup_column: [>`gtkiconview] obj -> int = "ml_gtk_icon_view_get_markup_column"
  external get_margin: [>`gtkiconview] obj -> int = "ml_gtk_icon_view_get_margin"
  external get_item_width: [>`gtkiconview] obj -> int = "ml_gtk_icon_view_get_item_width"
  external get_item_row: [>`gtkiconview] obj -> [>`gtktreepath] obj -> int = "ml_gtk_icon_view_get_item_row"
  external get_item_padding: [>`gtkiconview] obj -> int = "ml_gtk_icon_view_get_item_padding"
  external get_item_column: [>`gtkiconview] obj -> [>`gtktreepath] obj -> int = "ml_gtk_icon_view_get_item_column"
  external get_columns: [>`gtkiconview] obj -> int = "ml_gtk_icon_view_get_columns"
  external get_column_spacing: [>`gtkiconview] obj -> int = "ml_gtk_icon_view_get_column_spacing"
  external create_drag_icon: [>`gtkiconview] obj -> [>`gtktreepath] obj -> [<`cairo_surface_t] obj = "ml_gtk_icon_view_create_drag_icon"
  end
module IconThemePrivate = struct
  end
module IconThemeClass = struct
  end
module IconTheme = struct
  external set_screen: [>`gtkicontheme] obj -> [>`gdkscreen] obj -> unit = "ml_gtk_icon_theme_set_screen"
  external set_custom_theme: [>`gtkicontheme] obj -> string option -> unit = "ml_gtk_icon_theme_set_custom_theme"
  external rescan_if_needed: [>`gtkicontheme] obj -> bool = "ml_gtk_icon_theme_rescan_if_needed"
  external list_icons: [>`gtkicontheme] obj -> string option -> [<`glist] obj = "ml_gtk_icon_theme_list_icons"
  external list_contexts: [>`gtkicontheme] obj -> [<`glist] obj = "ml_gtk_icon_theme_list_contexts"
  external has_icon: [>`gtkicontheme] obj -> string -> bool = "ml_gtk_icon_theme_has_icon"
  external get_example_icon_name: [>`gtkicontheme] obj -> string = "ml_gtk_icon_theme_get_example_icon_name"
  external get_for_screen: [>`gdkscreen] obj -> [<`gtkicontheme] obj = "ml_gtk_icon_theme_get_for_screen"
  external get_default: unit -> [<`gtkicontheme] obj = "ml_gtk_icon_theme_get_default"
  external add_builtin_icon: string -> int -> [>`gdkpixbuf] obj -> unit = "ml_gtk_icon_theme_add_builtin_icon"
  end
module IconSource = struct
  external set_state_wildcarded: [>`gtkiconsource] obj -> bool -> unit = "ml_gtk_icon_source_set_state_wildcarded"
  external set_size_wildcarded: [>`gtkiconsource] obj -> bool -> unit = "ml_gtk_icon_source_set_size_wildcarded"
  external set_pixbuf: [>`gtkiconsource] obj -> [>`gdkpixbuf] obj -> unit = "ml_gtk_icon_source_set_pixbuf"
  external set_icon_name: [>`gtkiconsource] obj -> string option -> unit = "ml_gtk_icon_source_set_icon_name"
  external set_direction_wildcarded: [>`gtkiconsource] obj -> bool -> unit = "ml_gtk_icon_source_set_direction_wildcarded"
  external get_state_wildcarded: [>`gtkiconsource] obj -> bool = "ml_gtk_icon_source_get_state_wildcarded"
  external get_size_wildcarded: [>`gtkiconsource] obj -> bool = "ml_gtk_icon_source_get_size_wildcarded"
  external get_pixbuf: [>`gtkiconsource] obj -> [<`gdkpixbuf] obj = "ml_gtk_icon_source_get_pixbuf"
  external get_icon_name: [>`gtkiconsource] obj -> string = "ml_gtk_icon_source_get_icon_name"
  external get_direction_wildcarded: [>`gtkiconsource] obj -> bool = "ml_gtk_icon_source_get_direction_wildcarded"
  external free: [>`gtkiconsource] obj -> unit = "ml_gtk_icon_source_free"
  external copy: [>`gtkiconsource] obj -> [<`gtkiconsource] obj = "ml_gtk_icon_source_copy"
  end
module IconSet = struct
  external unref: [>`gtkiconset] obj -> unit = "ml_gtk_icon_set_unref"
  external ref: [>`gtkiconset] obj -> [<`gtkiconset] obj = "ml_gtk_icon_set_ref"
  external copy: [>`gtkiconset] obj -> [<`gtkiconset] obj = "ml_gtk_icon_set_copy"
  external add_source: [>`gtkiconset] obj -> [>`gtkiconsource] obj -> unit = "ml_gtk_icon_set_add_source"
  end
module IconInfo = struct
  external set_raw_coordinates: [>`gtkiconinfo] obj -> bool -> unit = "ml_gtk_icon_info_set_raw_coordinates"
  external get_display_name: [>`gtkiconinfo] obj -> string = "ml_gtk_icon_info_get_display_name"
  external get_builtin_pixbuf: [>`gtkiconinfo] obj -> [<`gdkpixbuf] obj = "ml_gtk_icon_info_get_builtin_pixbuf"
  external get_base_size: [>`gtkiconinfo] obj -> int = "ml_gtk_icon_info_get_base_size"
  external free: [>`gtkiconinfo] obj -> unit = "ml_gtk_icon_info_free"
  external copy: [>`gtkiconinfo] obj -> [<`gtkiconinfo] obj = "ml_gtk_icon_info_copy"
  end
module IconFactoryPrivate = struct
  end
module IconFactoryClass = struct
  end
module IconFactory = struct
  external remove_default: [>`gtkiconfactory] obj -> unit = "ml_gtk_icon_factory_remove_default"
  external lookup: [>`gtkiconfactory] obj -> string -> [<`gtkiconset] obj = "ml_gtk_icon_factory_lookup"
  external add_default: [>`gtkiconfactory] obj -> unit = "ml_gtk_icon_factory_add_default"
  external add: [>`gtkiconfactory] obj -> string -> [>`gtkiconset] obj -> unit = "ml_gtk_icon_factory_add"
  external lookup_default: string -> [<`gtkiconset] obj = "ml_gtk_icon_factory_lookup_default"
  end
module IMMulticontextPrivate = struct
  end
module IMMulticontextClass = struct
  end
module IMMulticontext = struct
  external set_context_id: [>`gtkimmulticontext] obj -> string -> unit = "ml_gtk_im_multicontext_set_context_id"
  external get_context_id: [>`gtkimmulticontext] obj -> string = "ml_gtk_im_multicontext_get_context_id"
  external append_menuitems: [>`gtkimmulticontext] obj -> [>`gtkmenushell] obj -> unit = "ml_gtk_im_multicontext_append_menuitems"
  end
module IMContextSimplePrivate = struct
  end
module IMContextSimpleClass = struct
  end
module IMContextSimple = struct
  end
module IMContextInfo = struct
  end
module IMContextClass = struct
  end
module IMContext = struct
  external set_use_preedit: [>`gtkimcontext] obj -> bool -> unit = "ml_gtk_im_context_set_use_preedit"
  external set_surrounding: [>`gtkimcontext] obj -> string -> int -> int -> unit = "ml_gtk_im_context_set_surrounding"
  external set_client_window: [>`gtkimcontext] obj -> [>`gdkwindow] obj option -> unit = "ml_gtk_im_context_set_client_window"
  external reset: [>`gtkimcontext] obj -> unit = "ml_gtk_im_context_reset"
  external focus_out: [>`gtkimcontext] obj -> unit = "ml_gtk_im_context_focus_out"
  external focus_in: [>`gtkimcontext] obj -> unit = "ml_gtk_im_context_focus_in"
  external filter_keypress: [>`gtkimcontext] obj -> [>`gdkeventkey] obj -> bool = "ml_gtk_im_context_filter_keypress"
  external delete_surrounding: [>`gtkimcontext] obj -> int -> int -> bool = "ml_gtk_im_context_delete_surrounding"
  end
module HandleBoxPrivate = struct
  end
module HandleBoxClass = struct
  end
module HandleBox = struct
  external get_child_detached: [>`gtkhandlebox] obj -> bool = "ml_gtk_handle_box_get_child_detached"
  end
module HSeparatorClass = struct
  end
module HSeparator = struct
  end
module HScrollbarClass = struct
  end
module HScrollbar = struct
  end
module HScaleClass = struct
  end
module HScale = struct
  end
module HSVPrivate = struct
  end
module HSVClass = struct
  end
module HSV = struct
  external set_metrics: [>`gtkhsv] obj -> int -> int -> unit = "ml_gtk_hsv_set_metrics"
  external set_color: [>`gtkhsv] obj -> float -> float -> float -> unit = "ml_gtk_hsv_set_color"
  external is_adjusting: [>`gtkhsv] obj -> bool = "ml_gtk_hsv_is_adjusting"
  end
module HPanedClass = struct
  end
module HPaned = struct
  end
module HButtonBoxClass = struct
  end
module HButtonBox = struct
  end
module HBoxClass = struct
  end
module HBox = struct
  end
module GridPrivate = struct
  end
module GridClass = struct
  end
module Grid = struct
  external set_row_spacing: [>`gtkgrid] obj -> int -> unit = "ml_gtk_grid_set_row_spacing"
  external set_row_homogeneous: [>`gtkgrid] obj -> bool -> unit = "ml_gtk_grid_set_row_homogeneous"
  external set_column_spacing: [>`gtkgrid] obj -> int -> unit = "ml_gtk_grid_set_column_spacing"
  external set_column_homogeneous: [>`gtkgrid] obj -> bool -> unit = "ml_gtk_grid_set_column_homogeneous"
  external get_row_spacing: [>`gtkgrid] obj -> int = "ml_gtk_grid_get_row_spacing"
  external get_row_homogeneous: [>`gtkgrid] obj -> bool = "ml_gtk_grid_get_row_homogeneous"
  external get_column_spacing: [>`gtkgrid] obj -> int = "ml_gtk_grid_get_column_spacing"
  external get_column_homogeneous: [>`gtkgrid] obj -> bool = "ml_gtk_grid_get_column_homogeneous"
  external attach: [>`gtkgrid] obj -> [>`gtkwidget] obj -> int -> int -> int -> int -> unit = "ml_gtk_grid_attach"
  end
module Gradient = struct
  external unref: [>`gtkgradient] obj -> unit = "ml_gtk_gradient_unref"
  external ref: [>`gtkgradient] obj -> [<`gtkgradient] obj = "ml_gtk_gradient_ref"
  external add_color_stop: [>`gtkgradient] obj -> float -> [>`gtksymboliccolor] obj -> unit = "ml_gtk_gradient_add_color_stop"
  end
module FramePrivate = struct
  end
module FrameClass = struct
  end
module Frame = struct
  external set_label_widget: [>`gtkframe] obj -> [>`gtkwidget] obj -> unit = "ml_gtk_frame_set_label_widget"
  external set_label: [>`gtkframe] obj -> string option -> unit = "ml_gtk_frame_set_label"
  external get_label_widget: [>`gtkframe] obj -> [<`gtkwidget] obj = "ml_gtk_frame_get_label_widget"
  external get_label: [>`gtkframe] obj -> string = "ml_gtk_frame_get_label"
  end
module FontSelectionPrivate = struct
  end
module FontSelectionDialogPrivate = struct
  end
module FontSelectionDialogClass = struct
  end
module FontSelectionDialog = struct
  external set_preview_text: [>`gtkfontselectiondialog] obj -> string -> unit = "ml_gtk_font_selection_dialog_set_preview_text"
  external set_font_name: [>`gtkfontselectiondialog] obj -> string -> bool = "ml_gtk_font_selection_dialog_set_font_name"
  external get_preview_text: [>`gtkfontselectiondialog] obj -> string = "ml_gtk_font_selection_dialog_get_preview_text"
  external get_ok_button: [>`gtkfontselectiondialog] obj -> [<`gtkwidget] obj = "ml_gtk_font_selection_dialog_get_ok_button"
  external get_font_selection: [>`gtkfontselectiondialog] obj -> [<`gtkwidget] obj = "ml_gtk_font_selection_dialog_get_font_selection"
  external get_font_name: [>`gtkfontselectiondialog] obj -> string = "ml_gtk_font_selection_dialog_get_font_name"
  external get_cancel_button: [>`gtkfontselectiondialog] obj -> [<`gtkwidget] obj = "ml_gtk_font_selection_dialog_get_cancel_button"
  end
module FontSelectionClass = struct
  end
module FontSelection = struct
  external set_preview_text: [>`gtkfontselection] obj -> string -> unit = "ml_gtk_font_selection_set_preview_text"
  external set_font_name: [>`gtkfontselection] obj -> string -> bool = "ml_gtk_font_selection_set_font_name"
  external get_size_list: [>`gtkfontselection] obj -> [<`gtkwidget] obj = "ml_gtk_font_selection_get_size_list"
  external get_size_entry: [>`gtkfontselection] obj -> [<`gtkwidget] obj = "ml_gtk_font_selection_get_size_entry"
  external get_size: [>`gtkfontselection] obj -> int = "ml_gtk_font_selection_get_size"
  external get_preview_text: [>`gtkfontselection] obj -> string = "ml_gtk_font_selection_get_preview_text"
  external get_preview_entry: [>`gtkfontselection] obj -> [<`gtkwidget] obj = "ml_gtk_font_selection_get_preview_entry"
  external get_font_name: [>`gtkfontselection] obj -> string = "ml_gtk_font_selection_get_font_name"
  external get_family_list: [>`gtkfontselection] obj -> [<`gtkwidget] obj = "ml_gtk_font_selection_get_family_list"
  external get_family: [>`gtkfontselection] obj -> [<`pangofontfamily] obj = "ml_gtk_font_selection_get_family"
  external get_face_list: [>`gtkfontselection] obj -> [<`gtkwidget] obj = "ml_gtk_font_selection_get_face_list"
  external get_face: [>`gtkfontselection] obj -> [<`pangofontface] obj = "ml_gtk_font_selection_get_face"
  end
module FontButtonPrivate = struct
  end
module FontButtonClass = struct
  end
module FontButton = struct
  external set_use_size: [>`gtkfontbutton] obj -> bool -> unit = "ml_gtk_font_button_set_use_size"
  external set_use_font: [>`gtkfontbutton] obj -> bool -> unit = "ml_gtk_font_button_set_use_font"
  external set_title: [>`gtkfontbutton] obj -> string -> unit = "ml_gtk_font_button_set_title"
  external set_show_style: [>`gtkfontbutton] obj -> bool -> unit = "ml_gtk_font_button_set_show_style"
  external set_show_size: [>`gtkfontbutton] obj -> bool -> unit = "ml_gtk_font_button_set_show_size"
  external set_font_name: [>`gtkfontbutton] obj -> string -> bool = "ml_gtk_font_button_set_font_name"
  external get_use_size: [>`gtkfontbutton] obj -> bool = "ml_gtk_font_button_get_use_size"
  external get_use_font: [>`gtkfontbutton] obj -> bool = "ml_gtk_font_button_get_use_font"
  external get_title: [>`gtkfontbutton] obj -> string = "ml_gtk_font_button_get_title"
  external get_show_style: [>`gtkfontbutton] obj -> bool = "ml_gtk_font_button_get_show_style"
  external get_show_size: [>`gtkfontbutton] obj -> bool = "ml_gtk_font_button_get_show_size"
  external get_font_name: [>`gtkfontbutton] obj -> string = "ml_gtk_font_button_get_font_name"
  end
module FixedPrivate = struct
  end
module FixedClass = struct
  end
module FixedChild = struct
  end
module Fixed = struct
  external put: [>`gtkfixed] obj -> [>`gtkwidget] obj -> int -> int -> unit = "ml_gtk_fixed_put"
  external move: [>`gtkfixed] obj -> [>`gtkwidget] obj -> int -> int -> unit = "ml_gtk_fixed_move"
  end
module FileFilterInfo = struct
  end
module FileFilter = struct
  external set_name: [>`gtkfilefilter] obj -> string option -> unit = "ml_gtk_file_filter_set_name"
  external get_name: [>`gtkfilefilter] obj -> string = "ml_gtk_file_filter_get_name"
  external filter: [>`gtkfilefilter] obj -> [>`gtkfilefilterinfo] obj -> bool = "ml_gtk_file_filter_filter"
  external add_pixbuf_formats: [>`gtkfilefilter] obj -> unit = "ml_gtk_file_filter_add_pixbuf_formats"
  external add_pattern: [>`gtkfilefilter] obj -> string -> unit = "ml_gtk_file_filter_add_pattern"
  external add_mime_type: [>`gtkfilefilter] obj -> string -> unit = "ml_gtk_file_filter_add_mime_type"
  end
module FileChooserWidgetPrivate = struct
  end
module FileChooserWidgetClass = struct
  end
module FileChooserWidget = struct
  end
module FileChooserDialogPrivate = struct
  end
module FileChooserDialogClass = struct
  end
module FileChooserDialog = struct
  end
module FileChooserButtonPrivate = struct
  end
module FileChooserButtonClass = struct
  end
module FileChooserButton = struct
  external set_width_chars: [>`gtkfilechooserbutton] obj -> int -> unit = "ml_gtk_file_chooser_button_set_width_chars"
  external set_title: [>`gtkfilechooserbutton] obj -> string -> unit = "ml_gtk_file_chooser_button_set_title"
  external set_focus_on_click: [>`gtkfilechooserbutton] obj -> bool -> unit = "ml_gtk_file_chooser_button_set_focus_on_click"
  external get_width_chars: [>`gtkfilechooserbutton] obj -> int = "ml_gtk_file_chooser_button_get_width_chars"
  external get_title: [>`gtkfilechooserbutton] obj -> string = "ml_gtk_file_chooser_button_get_title"
  external get_focus_on_click: [>`gtkfilechooserbutton] obj -> bool = "ml_gtk_file_chooser_button_get_focus_on_click"
  end
module ExpanderPrivate = struct
  end
module ExpanderClass = struct
  end
module Expander = struct
  external set_use_underline: [>`gtkexpander] obj -> bool -> unit = "ml_gtk_expander_set_use_underline"
  external set_use_markup: [>`gtkexpander] obj -> bool -> unit = "ml_gtk_expander_set_use_markup"
  external set_spacing: [>`gtkexpander] obj -> int -> unit = "ml_gtk_expander_set_spacing"
  external set_label_widget: [>`gtkexpander] obj -> [>`gtkwidget] obj option -> unit = "ml_gtk_expander_set_label_widget"
  external set_label_fill: [>`gtkexpander] obj -> bool -> unit = "ml_gtk_expander_set_label_fill"
  external set_label: [>`gtkexpander] obj -> string option -> unit = "ml_gtk_expander_set_label"
  external set_expanded: [>`gtkexpander] obj -> bool -> unit = "ml_gtk_expander_set_expanded"
  external get_use_underline: [>`gtkexpander] obj -> bool = "ml_gtk_expander_get_use_underline"
  external get_use_markup: [>`gtkexpander] obj -> bool = "ml_gtk_expander_get_use_markup"
  external get_spacing: [>`gtkexpander] obj -> int = "ml_gtk_expander_get_spacing"
  external get_label_widget: [>`gtkexpander] obj -> [<`gtkwidget] obj = "ml_gtk_expander_get_label_widget"
  external get_label_fill: [>`gtkexpander] obj -> bool = "ml_gtk_expander_get_label_fill"
  external get_label: [>`gtkexpander] obj -> string = "ml_gtk_expander_get_label"
  external get_expanded: [>`gtkexpander] obj -> bool = "ml_gtk_expander_get_expanded"
  end
module EventBoxPrivate = struct
  end
module EventBoxClass = struct
  end
module EventBox = struct
  external set_visible_window: [>`gtkeventbox] obj -> bool -> unit = "ml_gtk_event_box_set_visible_window"
  external set_above_child: [>`gtkeventbox] obj -> bool -> unit = "ml_gtk_event_box_set_above_child"
  external get_visible_window: [>`gtkeventbox] obj -> bool = "ml_gtk_event_box_get_visible_window"
  external get_above_child: [>`gtkeventbox] obj -> bool = "ml_gtk_event_box_get_above_child"
  end
module EntryPrivate = struct
  end
module EntryCompletionPrivate = struct
  end
module EntryCompletionClass = struct
  end
module EntryCompletion = struct
  external set_text_column: [>`gtkentrycompletion] obj -> int -> unit = "ml_gtk_entry_completion_set_text_column"
  external set_popup_single_match: [>`gtkentrycompletion] obj -> bool -> unit = "ml_gtk_entry_completion_set_popup_single_match"
  external set_popup_set_width: [>`gtkentrycompletion] obj -> bool -> unit = "ml_gtk_entry_completion_set_popup_set_width"
  external set_popup_completion: [>`gtkentrycompletion] obj -> bool -> unit = "ml_gtk_entry_completion_set_popup_completion"
  external set_minimum_key_length: [>`gtkentrycompletion] obj -> int -> unit = "ml_gtk_entry_completion_set_minimum_key_length"
  external set_inline_selection: [>`gtkentrycompletion] obj -> bool -> unit = "ml_gtk_entry_completion_set_inline_selection"
  external set_inline_completion: [>`gtkentrycompletion] obj -> bool -> unit = "ml_gtk_entry_completion_set_inline_completion"
  external insert_prefix: [>`gtkentrycompletion] obj -> unit = "ml_gtk_entry_completion_insert_prefix"
  external insert_action_text: [>`gtkentrycompletion] obj -> int -> string -> unit = "ml_gtk_entry_completion_insert_action_text"
  external insert_action_markup: [>`gtkentrycompletion] obj -> int -> string -> unit = "ml_gtk_entry_completion_insert_action_markup"
  external get_text_column: [>`gtkentrycompletion] obj -> int = "ml_gtk_entry_completion_get_text_column"
  external get_popup_single_match: [>`gtkentrycompletion] obj -> bool = "ml_gtk_entry_completion_get_popup_single_match"
  external get_popup_set_width: [>`gtkentrycompletion] obj -> bool = "ml_gtk_entry_completion_get_popup_set_width"
  external get_popup_completion: [>`gtkentrycompletion] obj -> bool = "ml_gtk_entry_completion_get_popup_completion"
  external get_minimum_key_length: [>`gtkentrycompletion] obj -> int = "ml_gtk_entry_completion_get_minimum_key_length"
  external get_inline_selection: [>`gtkentrycompletion] obj -> bool = "ml_gtk_entry_completion_get_inline_selection"
  external get_inline_completion: [>`gtkentrycompletion] obj -> bool = "ml_gtk_entry_completion_get_inline_completion"
  external get_entry: [>`gtkentrycompletion] obj -> [<`gtkwidget] obj = "ml_gtk_entry_completion_get_entry"
  external get_completion_prefix: [>`gtkentrycompletion] obj -> string = "ml_gtk_entry_completion_get_completion_prefix"
  external delete_action: [>`gtkentrycompletion] obj -> int -> unit = "ml_gtk_entry_completion_delete_action"
  external complete: [>`gtkentrycompletion] obj -> unit = "ml_gtk_entry_completion_complete"
  end
module EntryClass = struct
  end
module EntryBufferPrivate = struct
  end
module EntryBufferClass = struct
  end
module EntryBuffer = struct
  external set_text: [>`gtkentrybuffer] obj -> string -> int -> unit = "ml_gtk_entry_buffer_set_text"
  external set_max_length: [>`gtkentrybuffer] obj -> int -> unit = "ml_gtk_entry_buffer_set_max_length"
  external insert_text: [>`gtkentrybuffer] obj -> int -> string -> int -> int = "ml_gtk_entry_buffer_insert_text"
  external get_text: [>`gtkentrybuffer] obj -> string = "ml_gtk_entry_buffer_get_text"
  external get_max_length: [>`gtkentrybuffer] obj -> int = "ml_gtk_entry_buffer_get_max_length"
  external get_length: [>`gtkentrybuffer] obj -> int = "ml_gtk_entry_buffer_get_length"
  external get_bytes: [>`gtkentrybuffer] obj -> int = "ml_gtk_entry_buffer_get_bytes"
  external emit_inserted_text: [>`gtkentrybuffer] obj -> int -> string -> int -> unit = "ml_gtk_entry_buffer_emit_inserted_text"
  external emit_deleted_text: [>`gtkentrybuffer] obj -> int -> int -> unit = "ml_gtk_entry_buffer_emit_deleted_text"
  external delete_text: [>`gtkentrybuffer] obj -> int -> int -> int = "ml_gtk_entry_buffer_delete_text"
  end
module Entry = struct
  external unset_invisible_char: [>`gtkentry] obj -> unit = "ml_gtk_entry_unset_invisible_char"
  external text_index_to_layout_index: [>`gtkentry] obj -> int -> int = "ml_gtk_entry_text_index_to_layout_index"
  external set_width_chars: [>`gtkentry] obj -> int -> unit = "ml_gtk_entry_set_width_chars"
  external set_visibility: [>`gtkentry] obj -> bool -> unit = "ml_gtk_entry_set_visibility"
  external set_text: [>`gtkentry] obj -> string -> unit = "ml_gtk_entry_set_text"
  external set_progress_pulse_step: [>`gtkentry] obj -> float -> unit = "ml_gtk_entry_set_progress_pulse_step"
  external set_progress_fraction: [>`gtkentry] obj -> float -> unit = "ml_gtk_entry_set_progress_fraction"
  external set_overwrite_mode: [>`gtkentry] obj -> bool -> unit = "ml_gtk_entry_set_overwrite_mode"
  external set_max_length: [>`gtkentry] obj -> int -> unit = "ml_gtk_entry_set_max_length"
  external set_invisible_char: [>`gtkentry] obj -> int32 -> unit = "ml_gtk_entry_set_invisible_char"
  external set_inner_border: [>`gtkentry] obj -> [>`gtkborder] obj option -> unit = "ml_gtk_entry_set_inner_border"
  external set_has_frame: [>`gtkentry] obj -> bool -> unit = "ml_gtk_entry_set_has_frame"
  external set_cursor_hadjustment: [>`gtkentry] obj -> [>`gtkadjustment] obj -> unit = "ml_gtk_entry_set_cursor_hadjustment"
  external set_completion: [>`gtkentry] obj -> [>`gtkentrycompletion] obj option -> unit = "ml_gtk_entry_set_completion"
  external set_buffer: [>`gtkentry] obj -> [>`gtkentrybuffer] obj -> unit = "ml_gtk_entry_set_buffer"
  external set_activates_default: [>`gtkentry] obj -> bool -> unit = "ml_gtk_entry_set_activates_default"
  external reset_im_context: [>`gtkentry] obj -> unit = "ml_gtk_entry_reset_im_context"
  external progress_pulse: [>`gtkentry] obj -> unit = "ml_gtk_entry_progress_pulse"
  external layout_index_to_text_index: [>`gtkentry] obj -> int -> int = "ml_gtk_entry_layout_index_to_text_index"
  external im_context_filter_keypress: [>`gtkentry] obj -> [>`gdkeventkey] obj -> bool = "ml_gtk_entry_im_context_filter_keypress"
  external get_width_chars: [>`gtkentry] obj -> int = "ml_gtk_entry_get_width_chars"
  external get_visibility: [>`gtkentry] obj -> bool = "ml_gtk_entry_get_visibility"
  external get_text_length: [>`gtkentry] obj -> int = "ml_gtk_entry_get_text_length"
  external get_text: [>`gtkentry] obj -> string = "ml_gtk_entry_get_text"
  external get_progress_pulse_step: [>`gtkentry] obj -> float = "ml_gtk_entry_get_progress_pulse_step"
  external get_progress_fraction: [>`gtkentry] obj -> float = "ml_gtk_entry_get_progress_fraction"
  external get_overwrite_mode: [>`gtkentry] obj -> bool = "ml_gtk_entry_get_overwrite_mode"
  external get_max_length: [>`gtkentry] obj -> int = "ml_gtk_entry_get_max_length"
  external get_layout: [>`gtkentry] obj -> [<`pangolayout] obj = "ml_gtk_entry_get_layout"
  external get_invisible_char: [>`gtkentry] obj -> int32 = "ml_gtk_entry_get_invisible_char"
  external get_inner_border: [>`gtkentry] obj -> [<`gtkborder] obj = "ml_gtk_entry_get_inner_border"
  external get_icon_at_pos: [>`gtkentry] obj -> int -> int -> int = "ml_gtk_entry_get_icon_at_pos"
  external get_has_frame: [>`gtkentry] obj -> bool = "ml_gtk_entry_get_has_frame"
  external get_cursor_hadjustment: [>`gtkentry] obj -> [<`gtkadjustment] obj = "ml_gtk_entry_get_cursor_hadjustment"
  external get_current_icon_drag_source: [>`gtkentry] obj -> int = "ml_gtk_entry_get_current_icon_drag_source"
  external get_completion: [>`gtkentry] obj -> [<`gtkentrycompletion] obj = "ml_gtk_entry_get_completion"
  external get_buffer: [>`gtkentry] obj -> [<`gtkentrybuffer] obj = "ml_gtk_entry_get_buffer"
  external get_activates_default: [>`gtkentry] obj -> bool = "ml_gtk_entry_get_activates_default"
  end
module EditableInterface = struct
  end
module DrawingAreaClass = struct
  end
module DrawingArea = struct
  end
module DialogPrivate = struct
  end
module DialogClass = struct
  end
module Dialog = struct
  external set_response_sensitive: [>`gtkdialog] obj -> int -> bool -> unit = "ml_gtk_dialog_set_response_sensitive"
  external set_default_response: [>`gtkdialog] obj -> int -> unit = "ml_gtk_dialog_set_default_response"
  external run: [>`gtkdialog] obj -> int = "ml_gtk_dialog_run"
  external response: [>`gtkdialog] obj -> int -> unit = "ml_gtk_dialog_response"
  external get_widget_for_response: [>`gtkdialog] obj -> int -> [<`gtkwidget] obj = "ml_gtk_dialog_get_widget_for_response"
  external get_response_for_widget: [>`gtkdialog] obj -> [>`gtkwidget] obj -> int = "ml_gtk_dialog_get_response_for_widget"
  external get_content_area: [>`gtkdialog] obj -> [<`gtkwidget] obj = "ml_gtk_dialog_get_content_area"
  external get_action_area: [>`gtkdialog] obj -> [<`gtkwidget] obj = "ml_gtk_dialog_get_action_area"
  external add_button: [>`gtkdialog] obj -> string -> int -> [<`gtkwidget] obj = "ml_gtk_dialog_add_button"
  external add_action_widget: [>`gtkdialog] obj -> [>`gtkwidget] obj -> int -> unit = "ml_gtk_dialog_add_action_widget"
  end
module CssProviderClass = struct
  end
module CssProvider = struct
  external get_named: string -> string option -> [<`gtkcssprovider] obj = "ml_gtk_css_provider_get_named"
  external get_default: unit -> [<`gtkcssprovider] obj = "ml_gtk_css_provider_get_default"
  end
module ContainerPrivate = struct
  end
module ContainerClass = struct
  external install_child_property: [>`gtkcontainerclass] obj -> int -> [>`gparamspec] obj -> unit = "ml_gtk_container_class_install_child_property"
  external handle_border_width: [>`gtkcontainerclass] obj -> unit = "ml_gtk_container_class_handle_border_width"
  external find_child_property: [>`gtkcontainerclass] obj -> string -> [<`gparamspec] obj = "ml_gtk_container_class_find_child_property"
  end
module Container = struct
  external unset_focus_chain: [>`gtkcontainer] obj -> unit = "ml_gtk_container_unset_focus_chain"
  external set_reallocate_redraws: [>`gtkcontainer] obj -> bool -> unit = "ml_gtk_container_set_reallocate_redraws"
  external set_focus_vadjustment: [>`gtkcontainer] obj -> [>`gtkadjustment] obj -> unit = "ml_gtk_container_set_focus_vadjustment"
  external set_focus_hadjustment: [>`gtkcontainer] obj -> [>`gtkadjustment] obj -> unit = "ml_gtk_container_set_focus_hadjustment"
  external set_focus_child: [>`gtkcontainer] obj -> [>`gtkwidget] obj option -> unit = "ml_gtk_container_set_focus_child"
  external set_focus_chain: [>`gtkcontainer] obj -> [>`glist] obj -> unit = "ml_gtk_container_set_focus_chain"
  external set_border_width: [>`gtkcontainer] obj -> int -> unit = "ml_gtk_container_set_border_width"
  external resize_children: [>`gtkcontainer] obj -> unit = "ml_gtk_container_resize_children"
  external remove: [>`gtkcontainer] obj -> [>`gtkwidget] obj -> unit = "ml_gtk_container_remove"
  external propagate_draw: [>`gtkcontainer] obj -> [>`gtkwidget] obj -> [>`cairo_t] obj -> unit = "ml_gtk_container_propagate_draw"
  external get_path_for_child: [>`gtkcontainer] obj -> [>`gtkwidget] obj -> [<`gtkwidgetpath] obj = "ml_gtk_container_get_path_for_child"
  external get_focus_vadjustment: [>`gtkcontainer] obj -> [<`gtkadjustment] obj = "ml_gtk_container_get_focus_vadjustment"
  external get_focus_hadjustment: [>`gtkcontainer] obj -> [<`gtkadjustment] obj = "ml_gtk_container_get_focus_hadjustment"
  external get_focus_child: [>`gtkcontainer] obj -> [<`gtkwidget] obj = "ml_gtk_container_get_focus_child"
  external get_children: [>`gtkcontainer] obj -> [<`glist] obj = "ml_gtk_container_get_children"
  external get_border_width: [>`gtkcontainer] obj -> int = "ml_gtk_container_get_border_width"
  external child_type: [>`gtkcontainer] obj -> int = "ml_gtk_container_child_type"
  external child_set_property: [>`gtkcontainer] obj -> [>`gtkwidget] obj -> string -> [>`gvalue] obj -> unit = "ml_gtk_container_child_set_property"
  external child_get_property: [>`gtkcontainer] obj -> [>`gtkwidget] obj -> string -> [>`gvalue] obj -> unit = "ml_gtk_container_child_get_property"
  external check_resize: [>`gtkcontainer] obj -> unit = "ml_gtk_container_check_resize"
  external add: [>`gtkcontainer] obj -> [>`gtkwidget] obj -> unit = "ml_gtk_container_add"
  end
module ComboBoxTextPrivate = struct
  end
module ComboBoxTextClass = struct
  end
module ComboBoxText = struct
  external remove_all: [>`gtkcomboboxtext] obj -> unit = "ml_gtk_combo_box_text_remove_all"
  external remove: [>`gtkcomboboxtext] obj -> int -> unit = "ml_gtk_combo_box_text_remove"
  external prepend_text: [>`gtkcomboboxtext] obj -> string -> unit = "ml_gtk_combo_box_text_prepend_text"
  external prepend: [>`gtkcomboboxtext] obj -> string option -> string -> unit = "ml_gtk_combo_box_text_prepend"
  external insert_text: [>`gtkcomboboxtext] obj -> int -> string -> unit = "ml_gtk_combo_box_text_insert_text"
  external insert: [>`gtkcomboboxtext] obj -> int -> string option -> string -> unit = "ml_gtk_combo_box_text_insert"
  external get_active_text: [>`gtkcomboboxtext] obj -> string = "ml_gtk_combo_box_text_get_active_text"
  external append_text: [>`gtkcomboboxtext] obj -> string -> unit = "ml_gtk_combo_box_text_append_text"
  external append: [>`gtkcomboboxtext] obj -> string option -> string -> unit = "ml_gtk_combo_box_text_append"
  end
module ComboBoxPrivate = struct
  end
module ComboBoxClass = struct
  end
module ComboBox = struct
  external set_wrap_width: [>`gtkcombobox] obj -> int -> unit = "ml_gtk_combo_box_set_wrap_width"
  external set_title: [>`gtkcombobox] obj -> string -> unit = "ml_gtk_combo_box_set_title"
  external set_row_span_column: [>`gtkcombobox] obj -> int -> unit = "ml_gtk_combo_box_set_row_span_column"
  external set_popup_fixed_width: [>`gtkcombobox] obj -> bool -> unit = "ml_gtk_combo_box_set_popup_fixed_width"
  external set_id_column: [>`gtkcombobox] obj -> int -> unit = "ml_gtk_combo_box_set_id_column"
  external set_focus_on_click: [>`gtkcombobox] obj -> bool -> unit = "ml_gtk_combo_box_set_focus_on_click"
  external set_entry_text_column: [>`gtkcombobox] obj -> int -> unit = "ml_gtk_combo_box_set_entry_text_column"
  external set_column_span_column: [>`gtkcombobox] obj -> int -> unit = "ml_gtk_combo_box_set_column_span_column"
  external set_add_tearoffs: [>`gtkcombobox] obj -> bool -> unit = "ml_gtk_combo_box_set_add_tearoffs"
  external set_active_iter: [>`gtkcombobox] obj -> [>`gtktreeiter] obj option -> unit = "ml_gtk_combo_box_set_active_iter"
  external set_active_id: [>`gtkcombobox] obj -> string -> unit = "ml_gtk_combo_box_set_active_id"
  external set_active: [>`gtkcombobox] obj -> int -> unit = "ml_gtk_combo_box_set_active"
  external popup_for_device: [>`gtkcombobox] obj -> [>`gdkdevice] obj -> unit = "ml_gtk_combo_box_popup_for_device"
  external popup: [>`gtkcombobox] obj -> unit = "ml_gtk_combo_box_popup"
  external popdown: [>`gtkcombobox] obj -> unit = "ml_gtk_combo_box_popdown"
  external get_wrap_width: [>`gtkcombobox] obj -> int = "ml_gtk_combo_box_get_wrap_width"
  external get_title: [>`gtkcombobox] obj -> string = "ml_gtk_combo_box_get_title"
  external get_row_span_column: [>`gtkcombobox] obj -> int = "ml_gtk_combo_box_get_row_span_column"
  external get_popup_fixed_width: [>`gtkcombobox] obj -> bool = "ml_gtk_combo_box_get_popup_fixed_width"
  external get_popup_accessible: [>`gtkcombobox] obj -> [<`atkobject] obj = "ml_gtk_combo_box_get_popup_accessible"
  external get_id_column: [>`gtkcombobox] obj -> int = "ml_gtk_combo_box_get_id_column"
  external get_has_entry: [>`gtkcombobox] obj -> bool = "ml_gtk_combo_box_get_has_entry"
  external get_focus_on_click: [>`gtkcombobox] obj -> bool = "ml_gtk_combo_box_get_focus_on_click"
  external get_entry_text_column: [>`gtkcombobox] obj -> int = "ml_gtk_combo_box_get_entry_text_column"
  external get_column_span_column: [>`gtkcombobox] obj -> int = "ml_gtk_combo_box_get_column_span_column"
  external get_add_tearoffs: [>`gtkcombobox] obj -> bool = "ml_gtk_combo_box_get_add_tearoffs"
  external get_active_id: [>`gtkcombobox] obj -> string = "ml_gtk_combo_box_get_active_id"
  external get_active: [>`gtkcombobox] obj -> int = "ml_gtk_combo_box_get_active"
  end
module ColorSelectionPrivate = struct
  end
module ColorSelectionDialogPrivate = struct
  end
module ColorSelectionDialogClass = struct
  end
module ColorSelectionDialog = struct
  external get_color_selection: [>`gtkcolorselectiondialog] obj -> [<`gtkwidget] obj = "ml_gtk_color_selection_dialog_get_color_selection"
  end
module ColorSelectionClass = struct
  end
module ColorSelection = struct
  external set_previous_rgba: [>`gtkcolorselection] obj -> [>`gdkrgba] obj -> unit = "ml_gtk_color_selection_set_previous_rgba"
  external set_previous_color: [>`gtkcolorselection] obj -> [>`gdkcolor] obj -> unit = "ml_gtk_color_selection_set_previous_color"
  external set_previous_alpha: [>`gtkcolorselection] obj -> int -> unit = "ml_gtk_color_selection_set_previous_alpha"
  external set_has_palette: [>`gtkcolorselection] obj -> bool -> unit = "ml_gtk_color_selection_set_has_palette"
  external set_has_opacity_control: [>`gtkcolorselection] obj -> bool -> unit = "ml_gtk_color_selection_set_has_opacity_control"
  external set_current_rgba: [>`gtkcolorselection] obj -> [>`gdkrgba] obj -> unit = "ml_gtk_color_selection_set_current_rgba"
  external set_current_color: [>`gtkcolorselection] obj -> [>`gdkcolor] obj -> unit = "ml_gtk_color_selection_set_current_color"
  external set_current_alpha: [>`gtkcolorselection] obj -> int -> unit = "ml_gtk_color_selection_set_current_alpha"
  external is_adjusting: [>`gtkcolorselection] obj -> bool = "ml_gtk_color_selection_is_adjusting"
  external get_previous_alpha: [>`gtkcolorselection] obj -> int = "ml_gtk_color_selection_get_previous_alpha"
  external get_has_palette: [>`gtkcolorselection] obj -> bool = "ml_gtk_color_selection_get_has_palette"
  external get_has_opacity_control: [>`gtkcolorselection] obj -> bool = "ml_gtk_color_selection_get_has_opacity_control"
  external get_current_alpha: [>`gtkcolorselection] obj -> int = "ml_gtk_color_selection_get_current_alpha"
  end
module ColorButtonPrivate = struct
  end
module ColorButtonClass = struct
  end
module ColorButton = struct
  external set_use_alpha: [>`gtkcolorbutton] obj -> bool -> unit = "ml_gtk_color_button_set_use_alpha"
  external set_title: [>`gtkcolorbutton] obj -> string -> unit = "ml_gtk_color_button_set_title"
  external set_rgba: [>`gtkcolorbutton] obj -> [>`gdkrgba] obj -> unit = "ml_gtk_color_button_set_rgba"
  external set_color: [>`gtkcolorbutton] obj -> [>`gdkcolor] obj -> unit = "ml_gtk_color_button_set_color"
  external set_alpha: [>`gtkcolorbutton] obj -> int -> unit = "ml_gtk_color_button_set_alpha"
  external get_use_alpha: [>`gtkcolorbutton] obj -> bool = "ml_gtk_color_button_get_use_alpha"
  external get_title: [>`gtkcolorbutton] obj -> string = "ml_gtk_color_button_get_title"
  external get_alpha: [>`gtkcolorbutton] obj -> int = "ml_gtk_color_button_get_alpha"
  end
module Clipboard = struct
  external wait_is_uris_available: [>`gtkclipboard] obj -> bool = "ml_gtk_clipboard_wait_is_uris_available"
  external wait_is_text_available: [>`gtkclipboard] obj -> bool = "ml_gtk_clipboard_wait_is_text_available"
  external wait_is_rich_text_available: [>`gtkclipboard] obj -> [>`gtktextbuffer] obj -> bool = "ml_gtk_clipboard_wait_is_rich_text_available"
  external wait_is_image_available: [>`gtkclipboard] obj -> bool = "ml_gtk_clipboard_wait_is_image_available"
  external wait_for_text: [>`gtkclipboard] obj -> string = "ml_gtk_clipboard_wait_for_text"
  external wait_for_image: [>`gtkclipboard] obj -> [<`gdkpixbuf] obj = "ml_gtk_clipboard_wait_for_image"
  external store: [>`gtkclipboard] obj -> unit = "ml_gtk_clipboard_store"
  external set_text: [>`gtkclipboard] obj -> string -> int -> unit = "ml_gtk_clipboard_set_text"
  external set_image: [>`gtkclipboard] obj -> [>`gdkpixbuf] obj -> unit = "ml_gtk_clipboard_set_image"
  external get_display: [>`gtkclipboard] obj -> [<`gdkdisplay] obj = "ml_gtk_clipboard_get_display"
  external clear: [>`gtkclipboard] obj -> unit = "ml_gtk_clipboard_clear"
  end
module CheckMenuItemPrivate = struct
  end
module CheckMenuItemClass = struct
  end
module CheckMenuItem = struct
  external toggled: [>`gtkcheckmenuitem] obj -> unit = "ml_gtk_check_menu_item_toggled"
  external set_inconsistent: [>`gtkcheckmenuitem] obj -> bool -> unit = "ml_gtk_check_menu_item_set_inconsistent"
  external set_draw_as_radio: [>`gtkcheckmenuitem] obj -> bool -> unit = "ml_gtk_check_menu_item_set_draw_as_radio"
  external set_active: [>`gtkcheckmenuitem] obj -> bool -> unit = "ml_gtk_check_menu_item_set_active"
  external get_inconsistent: [>`gtkcheckmenuitem] obj -> bool = "ml_gtk_check_menu_item_get_inconsistent"
  external get_draw_as_radio: [>`gtkcheckmenuitem] obj -> bool = "ml_gtk_check_menu_item_get_draw_as_radio"
  external get_active: [>`gtkcheckmenuitem] obj -> bool = "ml_gtk_check_menu_item_get_active"
  end
module CheckButtonClass = struct
  end
module CheckButton = struct
  end
module CellViewPrivate = struct
  end
module CellViewClass = struct
  end
module CellView = struct
  external set_fit_model: [>`gtkcellview] obj -> bool -> unit = "ml_gtk_cell_view_set_fit_model"
  external set_draw_sensitive: [>`gtkcellview] obj -> bool -> unit = "ml_gtk_cell_view_set_draw_sensitive"
  external set_displayed_row: [>`gtkcellview] obj -> [>`gtktreepath] obj option -> unit = "ml_gtk_cell_view_set_displayed_row"
  external set_background_rgba: [>`gtkcellview] obj -> [>`gdkrgba] obj -> unit = "ml_gtk_cell_view_set_background_rgba"
  external set_background_color: [>`gtkcellview] obj -> [>`gdkcolor] obj -> unit = "ml_gtk_cell_view_set_background_color"
  external get_fit_model: [>`gtkcellview] obj -> bool = "ml_gtk_cell_view_get_fit_model"
  external get_draw_sensitive: [>`gtkcellview] obj -> bool = "ml_gtk_cell_view_get_draw_sensitive"
  external get_displayed_row: [>`gtkcellview] obj -> [<`gtktreepath] obj = "ml_gtk_cell_view_get_displayed_row"
  end
module CellRendererTogglePrivate = struct
  end
module CellRendererToggleClass = struct
  end
module CellRendererToggle = struct
  external set_radio: [>`gtkcellrenderertoggle] obj -> bool -> unit = "ml_gtk_cell_renderer_toggle_set_radio"
  external set_active: [>`gtkcellrenderertoggle] obj -> bool -> unit = "ml_gtk_cell_renderer_toggle_set_active"
  external set_activatable: [>`gtkcellrenderertoggle] obj -> bool -> unit = "ml_gtk_cell_renderer_toggle_set_activatable"
  external get_radio: [>`gtkcellrenderertoggle] obj -> bool = "ml_gtk_cell_renderer_toggle_get_radio"
  external get_active: [>`gtkcellrenderertoggle] obj -> bool = "ml_gtk_cell_renderer_toggle_get_active"
  external get_activatable: [>`gtkcellrenderertoggle] obj -> bool = "ml_gtk_cell_renderer_toggle_get_activatable"
  end
module CellRendererTextPrivate = struct
  end
module CellRendererTextClass = struct
  end
module CellRendererText = struct
  external set_fixed_height_from_font: [>`gtkcellrenderertext] obj -> int -> unit = "ml_gtk_cell_renderer_text_set_fixed_height_from_font"
  end
module CellRendererSpinnerPrivate = struct
  end
module CellRendererSpinnerClass = struct
  end
module CellRendererSpinner = struct
  end
module CellRendererSpinPrivate = struct
  end
module CellRendererSpinClass = struct
  end
module CellRendererSpin = struct
  end
module CellRendererProgressPrivate = struct
  end
module CellRendererProgressClass = struct
  end
module CellRendererProgress = struct
  end
module CellRendererPrivate = struct
  end
module CellRendererPixbufPrivate = struct
  end
module CellRendererPixbufClass = struct
  end
module CellRendererPixbuf = struct
  end
module CellRendererComboPrivate = struct
  end
module CellRendererComboClass = struct
  end
module CellRendererCombo = struct
  end
module CellRendererClass = struct
  end
module CellRendererAccelPrivate = struct
  end
module CellRendererAccelClass = struct
  end
module CellRendererAccel = struct
  end
module CellRenderer = struct
  external stop_editing: [>`gtkcellrenderer] obj -> bool -> unit = "ml_gtk_cell_renderer_stop_editing"
  external set_visible: [>`gtkcellrenderer] obj -> bool -> unit = "ml_gtk_cell_renderer_set_visible"
  external set_sensitive: [>`gtkcellrenderer] obj -> bool -> unit = "ml_gtk_cell_renderer_set_sensitive"
  external set_padding: [>`gtkcellrenderer] obj -> int -> int -> unit = "ml_gtk_cell_renderer_set_padding"
  external set_fixed_size: [>`gtkcellrenderer] obj -> int -> int -> unit = "ml_gtk_cell_renderer_set_fixed_size"
  external is_activatable: [>`gtkcellrenderer] obj -> bool = "ml_gtk_cell_renderer_is_activatable"
  external get_visible: [>`gtkcellrenderer] obj -> bool = "ml_gtk_cell_renderer_get_visible"
  external get_sensitive: [>`gtkcellrenderer] obj -> bool = "ml_gtk_cell_renderer_get_sensitive"
  end
module CellLayoutIface = struct
  end
module CellEditableIface = struct
  end
module CellAreaPrivate = struct
  end
module CellAreaContextPrivate = struct
  end
module CellAreaContextClass = struct
  end
module CellAreaContext = struct
  external reset: [>`gtkcellareacontext] obj -> unit = "ml_gtk_cell_area_context_reset"
  external push_preferred_width: [>`gtkcellareacontext] obj -> int -> int -> unit = "ml_gtk_cell_area_context_push_preferred_width"
  external push_preferred_height: [>`gtkcellareacontext] obj -> int -> int -> unit = "ml_gtk_cell_area_context_push_preferred_height"
  external get_area: [>`gtkcellareacontext] obj -> [<`gtkcellarea] obj = "ml_gtk_cell_area_context_get_area"
  external allocate: [>`gtkcellareacontext] obj -> int -> int -> unit = "ml_gtk_cell_area_context_allocate"
  end
module CellAreaClass = struct
  external install_cell_property: [>`gtkcellareaclass] obj -> int -> [>`gparamspec] obj -> unit = "ml_gtk_cell_area_class_install_cell_property"
  external find_cell_property: [>`gtkcellareaclass] obj -> string -> [<`gparamspec] obj = "ml_gtk_cell_area_class_find_cell_property"
  end
module CellAreaBoxPrivate = struct
  end
module CellAreaBoxClass = struct
  end
module CellAreaBox = struct
  external set_spacing: [>`gtkcellareabox] obj -> int -> unit = "ml_gtk_cell_area_box_set_spacing"
  external pack_start: [>`gtkcellareabox] obj -> [>`gtkcellrenderer] obj -> bool -> bool -> bool -> unit = "ml_gtk_cell_area_box_pack_start"
  external pack_end: [>`gtkcellareabox] obj -> [>`gtkcellrenderer] obj -> bool -> bool -> bool -> unit = "ml_gtk_cell_area_box_pack_end"
  external get_spacing: [>`gtkcellareabox] obj -> int = "ml_gtk_cell_area_box_get_spacing"
  end
module CellArea = struct
  external stop_editing: [>`gtkcellarea] obj -> bool -> unit = "ml_gtk_cell_area_stop_editing"
  external set_focus_cell: [>`gtkcellarea] obj -> [>`gtkcellrenderer] obj -> unit = "ml_gtk_cell_area_set_focus_cell"
  external remove_focus_sibling: [>`gtkcellarea] obj -> [>`gtkcellrenderer] obj -> [>`gtkcellrenderer] obj -> unit = "ml_gtk_cell_area_remove_focus_sibling"
  external remove: [>`gtkcellarea] obj -> [>`gtkcellrenderer] obj -> unit = "ml_gtk_cell_area_remove"
  external is_focus_sibling: [>`gtkcellarea] obj -> [>`gtkcellrenderer] obj -> [>`gtkcellrenderer] obj -> bool = "ml_gtk_cell_area_is_focus_sibling"
  external is_activatable: [>`gtkcellarea] obj -> bool = "ml_gtk_cell_area_is_activatable"
  external has_renderer: [>`gtkcellarea] obj -> [>`gtkcellrenderer] obj -> bool = "ml_gtk_cell_area_has_renderer"
  external get_focus_siblings: [>`gtkcellarea] obj -> [>`gtkcellrenderer] obj -> [<`glist] obj = "ml_gtk_cell_area_get_focus_siblings"
  external get_focus_from_sibling: [>`gtkcellarea] obj -> [>`gtkcellrenderer] obj -> [<`gtkcellrenderer] obj = "ml_gtk_cell_area_get_focus_from_sibling"
  external get_focus_cell: [>`gtkcellarea] obj -> [<`gtkcellrenderer] obj = "ml_gtk_cell_area_get_focus_cell"
  external get_edited_cell: [>`gtkcellarea] obj -> [<`gtkcellrenderer] obj = "ml_gtk_cell_area_get_edited_cell"
  external get_current_path_string: [>`gtkcellarea] obj -> string = "ml_gtk_cell_area_get_current_path_string"
  external create_context: [>`gtkcellarea] obj -> [<`gtkcellareacontext] obj = "ml_gtk_cell_area_create_context"
  external copy_context: [>`gtkcellarea] obj -> [>`gtkcellareacontext] obj -> [<`gtkcellareacontext] obj = "ml_gtk_cell_area_copy_context"
  external cell_set_property: [>`gtkcellarea] obj -> [>`gtkcellrenderer] obj -> string -> [>`gvalue] obj -> unit = "ml_gtk_cell_area_cell_set_property"
  external cell_get_property: [>`gtkcellarea] obj -> [>`gtkcellrenderer] obj -> string -> [>`gvalue] obj -> unit = "ml_gtk_cell_area_cell_get_property"
  external attribute_disconnect: [>`gtkcellarea] obj -> [>`gtkcellrenderer] obj -> string -> unit = "ml_gtk_cell_area_attribute_disconnect"
  external attribute_connect: [>`gtkcellarea] obj -> [>`gtkcellrenderer] obj -> string -> int -> unit = "ml_gtk_cell_area_attribute_connect"
  external add_focus_sibling: [>`gtkcellarea] obj -> [>`gtkcellrenderer] obj -> [>`gtkcellrenderer] obj -> unit = "ml_gtk_cell_area_add_focus_sibling"
  external add: [>`gtkcellarea] obj -> [>`gtkcellrenderer] obj -> unit = "ml_gtk_cell_area_add"
  end
module CalendarPrivate = struct
  end
module CalendarClass = struct
  end
module Calendar = struct
  external unmark_day: [>`gtkcalendar] obj -> int -> unit = "ml_gtk_calendar_unmark_day"
  external set_detail_width_chars: [>`gtkcalendar] obj -> int -> unit = "ml_gtk_calendar_set_detail_width_chars"
  external set_detail_height_rows: [>`gtkcalendar] obj -> int -> unit = "ml_gtk_calendar_set_detail_height_rows"
  external select_month: [>`gtkcalendar] obj -> int -> int -> unit = "ml_gtk_calendar_select_month"
  external select_day: [>`gtkcalendar] obj -> int -> unit = "ml_gtk_calendar_select_day"
  external mark_day: [>`gtkcalendar] obj -> int -> unit = "ml_gtk_calendar_mark_day"
  external get_detail_width_chars: [>`gtkcalendar] obj -> int = "ml_gtk_calendar_get_detail_width_chars"
  external get_detail_height_rows: [>`gtkcalendar] obj -> int = "ml_gtk_calendar_get_detail_height_rows"
  external get_day_is_marked: [>`gtkcalendar] obj -> int -> bool = "ml_gtk_calendar_get_day_is_marked"
  external clear_marks: [>`gtkcalendar] obj -> unit = "ml_gtk_calendar_clear_marks"
  end
module ButtonPrivate = struct
  end
module ButtonClass = struct
  end
module ButtonBoxPrivate = struct
  end
module ButtonBoxClass = struct
  end
module ButtonBox = struct
  external set_child_secondary: [>`gtkbuttonbox] obj -> [>`gtkwidget] obj -> bool -> unit = "ml_gtk_button_box_set_child_secondary"
  external get_child_secondary: [>`gtkbuttonbox] obj -> [>`gtkwidget] obj -> bool = "ml_gtk_button_box_get_child_secondary"
  end
module Button = struct
  external set_use_underline: [>`gtkbutton] obj -> bool -> unit = "ml_gtk_button_set_use_underline"
  external set_use_stock: [>`gtkbutton] obj -> bool -> unit = "ml_gtk_button_set_use_stock"
  external set_label: [>`gtkbutton] obj -> string -> unit = "ml_gtk_button_set_label"
  external set_image: [>`gtkbutton] obj -> [>`gtkwidget] obj -> unit = "ml_gtk_button_set_image"
  external set_focus_on_click: [>`gtkbutton] obj -> bool -> unit = "ml_gtk_button_set_focus_on_click"
  external released: [>`gtkbutton] obj -> unit = "ml_gtk_button_released"
  external pressed: [>`gtkbutton] obj -> unit = "ml_gtk_button_pressed"
  external leave: [>`gtkbutton] obj -> unit = "ml_gtk_button_leave"
  external get_use_underline: [>`gtkbutton] obj -> bool = "ml_gtk_button_get_use_underline"
  external get_use_stock: [>`gtkbutton] obj -> bool = "ml_gtk_button_get_use_stock"
  external get_label: [>`gtkbutton] obj -> string = "ml_gtk_button_get_label"
  external get_image: [>`gtkbutton] obj -> [<`gtkwidget] obj = "ml_gtk_button_get_image"
  external get_focus_on_click: [>`gtkbutton] obj -> bool = "ml_gtk_button_get_focus_on_click"
  external get_event_window: [>`gtkbutton] obj -> [<`gdkwindow] obj = "ml_gtk_button_get_event_window"
  external enter: [>`gtkbutton] obj -> unit = "ml_gtk_button_enter"
  external clicked: [>`gtkbutton] obj -> unit = "ml_gtk_button_clicked"
  end
module BuilderPrivate = struct
  end
module BuilderClass = struct
  end
module Builder = struct
  external set_translation_domain: [>`gtkbuilder] obj -> string option -> unit = "ml_gtk_builder_set_translation_domain"
  external get_type_from_name: [>`gtkbuilder] obj -> string -> int = "ml_gtk_builder_get_type_from_name"
  external get_translation_domain: [>`gtkbuilder] obj -> string = "ml_gtk_builder_get_translation_domain"
  external get_objects: [>`gtkbuilder] obj -> [<`gslist] obj = "ml_gtk_builder_get_objects"
  end
module BuildableIface = struct
  end
module BoxPrivate = struct
  end
module BoxClass = struct
  end
module Box = struct
  external set_spacing: [>`gtkbox] obj -> int -> unit = "ml_gtk_box_set_spacing"
  external set_homogeneous: [>`gtkbox] obj -> bool -> unit = "ml_gtk_box_set_homogeneous"
  external reorder_child: [>`gtkbox] obj -> [>`gtkwidget] obj -> int -> unit = "ml_gtk_box_reorder_child"
  external pack_start: [>`gtkbox] obj -> [>`gtkwidget] obj -> bool -> bool -> int -> unit = "ml_gtk_box_pack_start"
  external pack_end: [>`gtkbox] obj -> [>`gtkwidget] obj -> bool -> bool -> int -> unit = "ml_gtk_box_pack_end"
  external get_spacing: [>`gtkbox] obj -> int = "ml_gtk_box_get_spacing"
  external get_homogeneous: [>`gtkbox] obj -> bool = "ml_gtk_box_get_homogeneous"
  end
module Border = struct
  external free: [>`gtkborder] obj -> unit = "ml_gtk_border_free"
  external copy: [>`gtkborder] obj -> [<`gtkborder] obj = "ml_gtk_border_copy"
  end
module BindingSignal = struct
  end
module BindingSet = struct
  end
module BindingEntry = struct
  end
module BindingArg = struct
  end
module BinPrivate = struct
  end
module BinClass = struct
  end
module Bin = struct
  external get_child: [>`gtkbin] obj -> [<`gtkwidget] obj = "ml_gtk_bin_get_child"
  end
module AssistantPrivate = struct
  end
module AssistantClass = struct
  end
module Assistant = struct
  external update_buttons_state: [>`gtkassistant] obj -> unit = "ml_gtk_assistant_update_buttons_state"
  external set_page_title: [>`gtkassistant] obj -> [>`gtkwidget] obj -> string -> unit = "ml_gtk_assistant_set_page_title"
  external set_page_side_image: [>`gtkassistant] obj -> [>`gtkwidget] obj -> [>`gdkpixbuf] obj option -> unit = "ml_gtk_assistant_set_page_side_image"
  external set_page_header_image: [>`gtkassistant] obj -> [>`gtkwidget] obj -> [>`gdkpixbuf] obj option -> unit = "ml_gtk_assistant_set_page_header_image"
  external set_page_complete: [>`gtkassistant] obj -> [>`gtkwidget] obj -> bool -> unit = "ml_gtk_assistant_set_page_complete"
  external set_current_page: [>`gtkassistant] obj -> int -> unit = "ml_gtk_assistant_set_current_page"
  external remove_action_widget: [>`gtkassistant] obj -> [>`gtkwidget] obj -> unit = "ml_gtk_assistant_remove_action_widget"
  external previous_page: [>`gtkassistant] obj -> unit = "ml_gtk_assistant_previous_page"
  external prepend_page: [>`gtkassistant] obj -> [>`gtkwidget] obj -> int = "ml_gtk_assistant_prepend_page"
  external next_page: [>`gtkassistant] obj -> unit = "ml_gtk_assistant_next_page"
  external insert_page: [>`gtkassistant] obj -> [>`gtkwidget] obj -> int -> int = "ml_gtk_assistant_insert_page"
  external get_page_title: [>`gtkassistant] obj -> [>`gtkwidget] obj -> string = "ml_gtk_assistant_get_page_title"
  external get_page_side_image: [>`gtkassistant] obj -> [>`gtkwidget] obj -> [<`gdkpixbuf] obj = "ml_gtk_assistant_get_page_side_image"
  external get_page_header_image: [>`gtkassistant] obj -> [>`gtkwidget] obj -> [<`gdkpixbuf] obj = "ml_gtk_assistant_get_page_header_image"
  external get_page_complete: [>`gtkassistant] obj -> [>`gtkwidget] obj -> bool = "ml_gtk_assistant_get_page_complete"
  external get_nth_page: [>`gtkassistant] obj -> int -> [<`gtkwidget] obj = "ml_gtk_assistant_get_nth_page"
  external get_n_pages: [>`gtkassistant] obj -> int = "ml_gtk_assistant_get_n_pages"
  external get_current_page: [>`gtkassistant] obj -> int = "ml_gtk_assistant_get_current_page"
  external commit: [>`gtkassistant] obj -> unit = "ml_gtk_assistant_commit"
  external append_page: [>`gtkassistant] obj -> [>`gtkwidget] obj -> int = "ml_gtk_assistant_append_page"
  external add_action_widget: [>`gtkassistant] obj -> [>`gtkwidget] obj -> unit = "ml_gtk_assistant_add_action_widget"
  end
module AspectFramePrivate = struct
  end
module AspectFrameClass = struct
  end
module AspectFrame = struct
  end
module ArrowPrivate = struct
  end
module ArrowClass = struct
  end
module Arrow = struct
  end
module ApplicationPrivate = struct
  end
module ApplicationClass = struct
  end
module Application = struct
  external remove_window: [>`gtkapplication] obj -> [>`gtkwindow] obj -> unit = "ml_gtk_application_remove_window"
  external get_windows: [>`gtkapplication] obj -> [<`glist] obj = "ml_gtk_application_get_windows"
  external add_window: [>`gtkapplication] obj -> [>`gtkwindow] obj -> unit = "ml_gtk_application_add_window"
  end
module AppChooserWidgetPrivate = struct
  end
module AppChooserWidgetClass = struct
  end
module AppChooserWidget = struct
  external set_show_recommended: [>`gtkappchooserwidget] obj -> bool -> unit = "ml_gtk_app_chooser_widget_set_show_recommended"
  external set_show_other: [>`gtkappchooserwidget] obj -> bool -> unit = "ml_gtk_app_chooser_widget_set_show_other"
  external set_show_fallback: [>`gtkappchooserwidget] obj -> bool -> unit = "ml_gtk_app_chooser_widget_set_show_fallback"
  external set_show_default: [>`gtkappchooserwidget] obj -> bool -> unit = "ml_gtk_app_chooser_widget_set_show_default"
  external set_show_all: [>`gtkappchooserwidget] obj -> bool -> unit = "ml_gtk_app_chooser_widget_set_show_all"
  external set_default_text: [>`gtkappchooserwidget] obj -> string -> unit = "ml_gtk_app_chooser_widget_set_default_text"
  external get_show_recommended: [>`gtkappchooserwidget] obj -> bool = "ml_gtk_app_chooser_widget_get_show_recommended"
  external get_show_other: [>`gtkappchooserwidget] obj -> bool = "ml_gtk_app_chooser_widget_get_show_other"
  external get_show_fallback: [>`gtkappchooserwidget] obj -> bool = "ml_gtk_app_chooser_widget_get_show_fallback"
  external get_show_default: [>`gtkappchooserwidget] obj -> bool = "ml_gtk_app_chooser_widget_get_show_default"
  external get_show_all: [>`gtkappchooserwidget] obj -> bool = "ml_gtk_app_chooser_widget_get_show_all"
  external get_default_text: [>`gtkappchooserwidget] obj -> string = "ml_gtk_app_chooser_widget_get_default_text"
  end
module AppChooserDialogPrivate = struct
  end
module AppChooserDialogClass = struct
  end
module AppChooserDialog = struct
  external set_heading: [>`gtkappchooserdialog] obj -> string -> unit = "ml_gtk_app_chooser_dialog_set_heading"
  external get_widget: [>`gtkappchooserdialog] obj -> [<`gtkwidget] obj = "ml_gtk_app_chooser_dialog_get_widget"
  external get_heading: [>`gtkappchooserdialog] obj -> string = "ml_gtk_app_chooser_dialog_get_heading"
  end
module AppChooserButtonPrivate = struct
  end
module AppChooserButtonClass = struct
  end
module AppChooserButton = struct
  external set_show_dialog_item: [>`gtkappchooserbutton] obj -> bool -> unit = "ml_gtk_app_chooser_button_set_show_dialog_item"
  external set_heading: [>`gtkappchooserbutton] obj -> string -> unit = "ml_gtk_app_chooser_button_set_heading"
  external set_active_custom_item: [>`gtkappchooserbutton] obj -> string -> unit = "ml_gtk_app_chooser_button_set_active_custom_item"
  external get_show_dialog_item: [>`gtkappchooserbutton] obj -> bool = "ml_gtk_app_chooser_button_get_show_dialog_item"
  external get_heading: [>`gtkappchooserbutton] obj -> string = "ml_gtk_app_chooser_button_get_heading"
  external append_separator: [>`gtkappchooserbutton] obj -> unit = "ml_gtk_app_chooser_button_append_separator"
  end
module AlignmentPrivate = struct
  end
module AlignmentClass = struct
  end
module Alignment = struct
  external set_padding: [>`gtkalignment] obj -> int -> int -> int -> int -> unit = "ml_gtk_alignment_set_padding"
  end
module AdjustmentPrivate = struct
  end
module AdjustmentClass = struct
  end
module Adjustment = struct
  external value_changed: [>`gtkadjustment] obj -> unit = "ml_gtk_adjustment_value_changed"
  external set_value: [>`gtkadjustment] obj -> float -> unit = "ml_gtk_adjustment_set_value"
  external set_upper: [>`gtkadjustment] obj -> float -> unit = "ml_gtk_adjustment_set_upper"
  external set_step_increment: [>`gtkadjustment] obj -> float -> unit = "ml_gtk_adjustment_set_step_increment"
  external set_page_size: [>`gtkadjustment] obj -> float -> unit = "ml_gtk_adjustment_set_page_size"
  external set_page_increment: [>`gtkadjustment] obj -> float -> unit = "ml_gtk_adjustment_set_page_increment"
  external set_lower: [>`gtkadjustment] obj -> float -> unit = "ml_gtk_adjustment_set_lower"
  external get_value: [>`gtkadjustment] obj -> float = "ml_gtk_adjustment_get_value"
  external get_upper: [>`gtkadjustment] obj -> float = "ml_gtk_adjustment_get_upper"
  external get_step_increment: [>`gtkadjustment] obj -> float = "ml_gtk_adjustment_get_step_increment"
  external get_page_size: [>`gtkadjustment] obj -> float = "ml_gtk_adjustment_get_page_size"
  external get_page_increment: [>`gtkadjustment] obj -> float = "ml_gtk_adjustment_get_page_increment"
  external get_lower: [>`gtkadjustment] obj -> float = "ml_gtk_adjustment_get_lower"
  external configure: [>`gtkadjustment] obj -> float -> float -> float -> float -> float -> float -> unit = "ml_gtk_adjustment_configure"
  external clamp_page: [>`gtkadjustment] obj -> float -> float -> unit = "ml_gtk_adjustment_clamp_page"
  external changed: [>`gtkadjustment] obj -> unit = "ml_gtk_adjustment_changed"
  end
module ActivatableIface = struct
  end
module ActionPrivate = struct
  end
module ActionGroupPrivate = struct
  end
module ActionGroupClass = struct
  end
module ActionGroup = struct
  external translate_string: [>`gtkactiongroup] obj -> string -> string = "ml_gtk_action_group_translate_string"
  external set_visible: [>`gtkactiongroup] obj -> bool -> unit = "ml_gtk_action_group_set_visible"
  external set_translation_domain: [>`gtkactiongroup] obj -> string -> unit = "ml_gtk_action_group_set_translation_domain"
  external set_sensitive: [>`gtkactiongroup] obj -> bool -> unit = "ml_gtk_action_group_set_sensitive"
  external remove_action: [>`gtkactiongroup] obj -> [>`gtkaction] obj -> unit = "ml_gtk_action_group_remove_action"
  external list_actions: [>`gtkactiongroup] obj -> [<`glist] obj = "ml_gtk_action_group_list_actions"
  external get_visible: [>`gtkactiongroup] obj -> bool = "ml_gtk_action_group_get_visible"
  external get_sensitive: [>`gtkactiongroup] obj -> bool = "ml_gtk_action_group_get_sensitive"
  external get_name: [>`gtkactiongroup] obj -> string = "ml_gtk_action_group_get_name"
  external get_action: [>`gtkactiongroup] obj -> string -> [<`gtkaction] obj = "ml_gtk_action_group_get_action"
  external add_action_with_accel: [>`gtkactiongroup] obj -> [>`gtkaction] obj -> string option -> unit = "ml_gtk_action_group_add_action_with_accel"
  external add_action: [>`gtkactiongroup] obj -> [>`gtkaction] obj -> unit = "ml_gtk_action_group_add_action"
  end
module ActionEntry = struct
  end
module ActionClass = struct
  end
module Action = struct
  external unblock_activate: [>`gtkaction] obj -> unit = "ml_gtk_action_unblock_activate"
  external set_visible_vertical: [>`gtkaction] obj -> bool -> unit = "ml_gtk_action_set_visible_vertical"
  external set_visible_horizontal: [>`gtkaction] obj -> bool -> unit = "ml_gtk_action_set_visible_horizontal"
  external set_visible: [>`gtkaction] obj -> bool -> unit = "ml_gtk_action_set_visible"
  external set_tooltip: [>`gtkaction] obj -> string -> unit = "ml_gtk_action_set_tooltip"
  external set_stock_id: [>`gtkaction] obj -> string -> unit = "ml_gtk_action_set_stock_id"
  external set_short_label: [>`gtkaction] obj -> string -> unit = "ml_gtk_action_set_short_label"
  external set_sensitive: [>`gtkaction] obj -> bool -> unit = "ml_gtk_action_set_sensitive"
  external set_label: [>`gtkaction] obj -> string -> unit = "ml_gtk_action_set_label"
  external set_is_important: [>`gtkaction] obj -> bool -> unit = "ml_gtk_action_set_is_important"
  external set_icon_name: [>`gtkaction] obj -> string -> unit = "ml_gtk_action_set_icon_name"
  external set_always_show_image: [>`gtkaction] obj -> bool -> unit = "ml_gtk_action_set_always_show_image"
  external set_accel_path: [>`gtkaction] obj -> string -> unit = "ml_gtk_action_set_accel_path"
  external set_accel_group: [>`gtkaction] obj -> [>`gtkaccelgroup] obj option -> unit = "ml_gtk_action_set_accel_group"
  external is_visible: [>`gtkaction] obj -> bool = "ml_gtk_action_is_visible"
  external is_sensitive: [>`gtkaction] obj -> bool = "ml_gtk_action_is_sensitive"
  external get_visible_vertical: [>`gtkaction] obj -> bool = "ml_gtk_action_get_visible_vertical"
  external get_visible_horizontal: [>`gtkaction] obj -> bool = "ml_gtk_action_get_visible_horizontal"
  external get_visible: [>`gtkaction] obj -> bool = "ml_gtk_action_get_visible"
  external get_tooltip: [>`gtkaction] obj -> string = "ml_gtk_action_get_tooltip"
  external get_stock_id: [>`gtkaction] obj -> string = "ml_gtk_action_get_stock_id"
  external get_short_label: [>`gtkaction] obj -> string = "ml_gtk_action_get_short_label"
  external get_sensitive: [>`gtkaction] obj -> bool = "ml_gtk_action_get_sensitive"
  external get_proxies: [>`gtkaction] obj -> [<`gslist] obj = "ml_gtk_action_get_proxies"
  external get_name: [>`gtkaction] obj -> string = "ml_gtk_action_get_name"
  external get_label: [>`gtkaction] obj -> string = "ml_gtk_action_get_label"
  external get_is_important: [>`gtkaction] obj -> bool = "ml_gtk_action_get_is_important"
  external get_icon_name: [>`gtkaction] obj -> string = "ml_gtk_action_get_icon_name"
  external get_always_show_image: [>`gtkaction] obj -> bool = "ml_gtk_action_get_always_show_image"
  external get_accel_path: [>`gtkaction] obj -> string = "ml_gtk_action_get_accel_path"
  external get_accel_closure: [>`gtkaction] obj -> [<`gclosure] obj = "ml_gtk_action_get_accel_closure"
  external disconnect_accelerator: [>`gtkaction] obj -> unit = "ml_gtk_action_disconnect_accelerator"
  external create_tool_item: [>`gtkaction] obj -> [<`gtkwidget] obj = "ml_gtk_action_create_tool_item"
  external create_menu_item: [>`gtkaction] obj -> [<`gtkwidget] obj = "ml_gtk_action_create_menu_item"
  external create_menu: [>`gtkaction] obj -> [<`gtkwidget] obj = "ml_gtk_action_create_menu"
  external connect_accelerator: [>`gtkaction] obj -> unit = "ml_gtk_action_connect_accelerator"
  external block_activate: [>`gtkaction] obj -> unit = "ml_gtk_action_block_activate"
  external activate: [>`gtkaction] obj -> unit = "ml_gtk_action_activate"
  end
module AccessiblePrivate = struct
  end
module AccessibleClass = struct
  end
module Accessible = struct
  external set_widget: [>`gtkaccessible] obj -> [>`gtkwidget] obj -> unit = "ml_gtk_accessible_set_widget"
  external get_widget: [>`gtkaccessible] obj -> [<`gtkwidget] obj = "ml_gtk_accessible_get_widget"
  external connect_widget_destroyed: [>`gtkaccessible] obj -> unit = "ml_gtk_accessible_connect_widget_destroyed"
  end
module AccelMapClass = struct
  end
module AccelMap = struct
  external unlock_path: string -> unit = "ml_gtk_accel_map_unlock_path"
  external save_fd: int -> unit = "ml_gtk_accel_map_save_fd"
  external lock_path: string -> unit = "ml_gtk_accel_map_lock_path"
  external load_scanner: [>`gscanner] obj -> unit = "ml_gtk_accel_map_load_scanner"
  external load_fd: int -> unit = "ml_gtk_accel_map_load_fd"
  external get: unit -> [<`gtkaccelmap] obj = "ml_gtk_accel_map_get"
  external add_filter: string -> unit = "ml_gtk_accel_map_add_filter"
  end
module AccelLabelPrivate = struct
  end
module AccelLabelClass = struct
  end
module AccelLabel = struct
  external set_accel_widget: [>`gtkaccellabel] obj -> [>`gtkwidget] obj -> unit = "ml_gtk_accel_label_set_accel_widget"
  external set_accel_closure: [>`gtkaccellabel] obj -> [>`gclosure] obj -> unit = "ml_gtk_accel_label_set_accel_closure"
  external refetch: [>`gtkaccellabel] obj -> bool = "ml_gtk_accel_label_refetch"
  external get_accel_width: [>`gtkaccellabel] obj -> int = "ml_gtk_accel_label_get_accel_width"
  external get_accel_widget: [>`gtkaccellabel] obj -> [<`gtkwidget] obj = "ml_gtk_accel_label_get_accel_widget"
  end
module AccelKey = struct
  end
module AccelGroupPrivate = struct
  end
module AccelGroupEntry = struct
  end
module AccelGroupClass = struct
  end
module AccelGroup = struct
  external unlock: [>`gtkaccelgroup] obj -> unit = "ml_gtk_accel_group_unlock"
  external lock: [>`gtkaccelgroup] obj -> unit = "ml_gtk_accel_group_lock"
  external get_is_locked: [>`gtkaccelgroup] obj -> bool = "ml_gtk_accel_group_get_is_locked"
  external disconnect: [>`gtkaccelgroup] obj -> [>`gclosure] obj option -> bool = "ml_gtk_accel_group_disconnect"
  external connect_by_path: [>`gtkaccelgroup] obj -> string -> [>`gclosure] obj -> unit = "ml_gtk_accel_group_connect_by_path"
  external from_accel_closure: [>`gclosure] obj -> [<`gtkaccelgroup] obj = "ml_gtk_accel_group_from_accel_closure"
  end
module AboutDialogPrivate = struct
  end
module AboutDialogClass = struct
  end
module AboutDialog = struct
  external set_wrap_license: [>`gtkaboutdialog] obj -> bool -> unit = "ml_gtk_about_dialog_set_wrap_license"
  external set_website_label: [>`gtkaboutdialog] obj -> string -> unit = "ml_gtk_about_dialog_set_website_label"
  external set_website: [>`gtkaboutdialog] obj -> string option -> unit = "ml_gtk_about_dialog_set_website"
  external set_version: [>`gtkaboutdialog] obj -> string option -> unit = "ml_gtk_about_dialog_set_version"
  external set_translator_credits: [>`gtkaboutdialog] obj -> string option -> unit = "ml_gtk_about_dialog_set_translator_credits"
  external set_program_name: [>`gtkaboutdialog] obj -> string -> unit = "ml_gtk_about_dialog_set_program_name"
  external set_logo_icon_name: [>`gtkaboutdialog] obj -> string option -> unit = "ml_gtk_about_dialog_set_logo_icon_name"
  external set_logo: [>`gtkaboutdialog] obj -> [>`gdkpixbuf] obj option -> unit = "ml_gtk_about_dialog_set_logo"
  external set_license: [>`gtkaboutdialog] obj -> string option -> unit = "ml_gtk_about_dialog_set_license"
  external set_copyright: [>`gtkaboutdialog] obj -> string -> unit = "ml_gtk_about_dialog_set_copyright"
  external set_comments: [>`gtkaboutdialog] obj -> string option -> unit = "ml_gtk_about_dialog_set_comments"
  external get_wrap_license: [>`gtkaboutdialog] obj -> bool = "ml_gtk_about_dialog_get_wrap_license"
  external get_website_label: [>`gtkaboutdialog] obj -> string = "ml_gtk_about_dialog_get_website_label"
  external get_website: [>`gtkaboutdialog] obj -> string = "ml_gtk_about_dialog_get_website"
  external get_version: [>`gtkaboutdialog] obj -> string = "ml_gtk_about_dialog_get_version"
  external get_translator_credits: [>`gtkaboutdialog] obj -> string = "ml_gtk_about_dialog_get_translator_credits"
  external get_program_name: [>`gtkaboutdialog] obj -> string = "ml_gtk_about_dialog_get_program_name"
  external get_logo_icon_name: [>`gtkaboutdialog] obj -> string = "ml_gtk_about_dialog_get_logo_icon_name"
  external get_logo: [>`gtkaboutdialog] obj -> [<`gdkpixbuf] obj = "ml_gtk_about_dialog_get_logo"
  external get_license: [>`gtkaboutdialog] obj -> string = "ml_gtk_about_dialog_get_license"
  external get_copyright: [>`gtkaboutdialog] obj -> string = "ml_gtk_about_dialog_get_copyright"
  external get_comments: [>`gtkaboutdialog] obj -> string = "ml_gtk_about_dialog_get_comments"
  end
(* Global functions *)
external gtk_true: unit -> bool = "ml_gtk_true"
external test_text_set: [>`gtkwidget] obj -> string -> unit = "ml_gtk_test_text_set"
external test_text_get: [>`gtkwidget] obj -> string = "ml_gtk_test_text_get"
external test_spin_button_click: [>`gtkspinbutton] obj -> int -> bool -> bool = "ml_gtk_test_spin_button_click"
external test_slider_set_perc: [>`gtkwidget] obj -> float -> unit = "ml_gtk_test_slider_set_perc"
external test_slider_get_value: [>`gtkwidget] obj -> float = "ml_gtk_test_slider_get_value"
external test_register_all_types: unit -> unit = "ml_gtk_test_register_all_types"
external test_find_widget: [>`gtkwidget] obj -> string -> int -> [<`gtkwidget] obj = "ml_gtk_test_find_widget"
external test_find_sibling: [>`gtkwidget] obj -> int -> [<`gtkwidget] obj = "ml_gtk_test_find_sibling"
external test_find_label: [>`gtkwidget] obj -> string -> [<`gtkwidget] obj = "ml_gtk_test_find_label"
external test_create_simple_window: string -> string -> [<`gtkwidget] obj = "ml_gtk_test_create_simple_window"
external stock_list_ids: unit -> [<`gslist] obj = "ml_gtk_stock_list_ids"
external set_debug_flags: int -> unit = "ml_gtk_set_debug_flags"
external selection_remove_all: [>`gtkwidget] obj -> unit = "ml_gtk_selection_remove_all"
external render_option: [>`gtkstylecontext] obj -> [>`cairo_t] obj -> float -> float -> float -> float -> unit = "ml_gtk_render_option"
external render_line: [>`gtkstylecontext] obj -> [>`cairo_t] obj -> float -> float -> float -> float -> unit = "ml_gtk_render_line"
external render_layout: [>`gtkstylecontext] obj -> [>`cairo_t] obj -> float -> float -> [>`pangolayout] obj -> unit = "ml_gtk_render_layout"
external render_handle: [>`gtkstylecontext] obj -> [>`cairo_t] obj -> float -> float -> float -> float -> unit = "ml_gtk_render_handle"
external render_frame: [>`gtkstylecontext] obj -> [>`cairo_t] obj -> float -> float -> float -> float -> unit = "ml_gtk_render_frame"
external render_focus: [>`gtkstylecontext] obj -> [>`cairo_t] obj -> float -> float -> float -> float -> unit = "ml_gtk_render_focus"
external render_expander: [>`gtkstylecontext] obj -> [>`cairo_t] obj -> float -> float -> float -> float -> unit = "ml_gtk_render_expander"
external render_check: [>`gtkstylecontext] obj -> [>`cairo_t] obj -> float -> float -> float -> float -> unit = "ml_gtk_render_check"
external render_background: [>`gtkstylecontext] obj -> [>`cairo_t] obj -> float -> float -> float -> float -> unit = "ml_gtk_render_background"
external render_arrow: [>`gtkstylecontext] obj -> [>`cairo_t] obj -> float -> float -> float -> float -> unit = "ml_gtk_render_arrow"
external render_activity: [>`gtkstylecontext] obj -> [>`cairo_t] obj -> float -> float -> float -> float -> unit = "ml_gtk_render_activity"
external recent_manager_error_quark: unit -> int32 = "ml_gtk_recent_manager_error_quark"
external recent_chooser_error_quark: unit -> int32 = "ml_gtk_recent_chooser_error_quark"
external rc_scanner_new: unit -> [<`gscanner] obj = "ml_gtk_rc_scanner_new"
external rc_reset_styles: [>`gtksettings] obj -> unit = "ml_gtk_rc_reset_styles"
external rc_reparse_all_for_settings: [>`gtksettings] obj -> bool -> bool = "ml_gtk_rc_reparse_all_for_settings"
external rc_reparse_all: unit -> bool = "ml_gtk_rc_reparse_all"
external rc_property_parse_requisition: [>`gparamspec] obj -> [>`gstring] obj -> [>`gvalue] obj -> bool = "ml_gtk_rc_property_parse_requisition"
external rc_property_parse_flags: [>`gparamspec] obj -> [>`gstring] obj -> [>`gvalue] obj -> bool = "ml_gtk_rc_property_parse_flags"
external rc_property_parse_enum: [>`gparamspec] obj -> [>`gstring] obj -> [>`gvalue] obj -> bool = "ml_gtk_rc_property_parse_enum"
external rc_property_parse_color: [>`gparamspec] obj -> [>`gstring] obj -> [>`gvalue] obj -> bool = "ml_gtk_rc_property_parse_color"
external rc_property_parse_border: [>`gparamspec] obj -> [>`gstring] obj -> [>`gvalue] obj -> bool = "ml_gtk_rc_property_parse_border"
external rc_parse_string: string -> unit = "ml_gtk_rc_parse_string"
external rc_parse: string -> unit = "ml_gtk_rc_parse"
external rc_get_theme_dir: unit -> string = "ml_gtk_rc_get_theme_dir"
external rc_get_style_by_paths: [>`gtksettings] obj -> string option -> string option -> int -> [<`gtkstyle] obj = "ml_gtk_rc_get_style_by_paths"
external rc_get_style: [>`gtkwidget] obj -> [<`gtkstyle] obj = "ml_gtk_rc_get_style"
external print_run_page_setup_dialog: [>`gtkwindow] obj option -> [>`gtkpagesetup] obj option -> [>`gtkprintsettings] obj -> [<`gtkpagesetup] obj = "ml_gtk_print_run_page_setup_dialog"
external print_error_quark: unit -> int32 = "ml_gtk_print_error_quark"
external paper_size_get_paper_sizes: bool -> [<`glist] obj = "ml_gtk_paper_size_get_paper_sizes"
external paper_size_get_default: unit -> string = "ml_gtk_paper_size_get_default"
external main_quit: unit -> unit = "ml_gtk_main_quit"
external main_level: unit -> int = "ml_gtk_main_level"
external main_iteration_do: bool -> bool = "ml_gtk_main_iteration_do"
external main_iteration: unit -> bool = "ml_gtk_main_iteration"
external main: unit -> unit = "ml_gtk_main"
external key_snooper_remove: int -> unit = "ml_gtk_key_snooper_remove"
external icon_theme_error_quark: unit -> int32 = "ml_gtk_icon_theme_error_quark"
external grab_get_current: unit -> [<`gtkwidget] obj = "ml_gtk_grab_get_current"
external get_option_group: bool -> [<`goptiongroup] obj = "ml_gtk_get_option_group"
external get_minor_version: unit -> int = "ml_gtk_get_minor_version"
external get_micro_version: unit -> int = "ml_gtk_get_micro_version"
external get_major_version: unit -> int = "ml_gtk_get_major_version"
external get_interface_age: unit -> int = "ml_gtk_get_interface_age"
external get_default_language: unit -> [<`pangolanguage] obj = "ml_gtk_get_default_language"
external get_debug_flags: unit -> int = "ml_gtk_get_debug_flags"
external get_current_event_time: unit -> int32 = "ml_gtk_get_current_event_time"
external get_current_event_device: unit -> [<`gdkdevice] obj = "ml_gtk_get_current_event_device"
external get_binary_age: unit -> int = "ml_gtk_get_binary_age"
external file_chooser_error_quark: unit -> int32 = "ml_gtk_file_chooser_error_quark"
external gtk_false: unit -> bool = "ml_gtk_false"
external events_pending: unit -> bool = "ml_gtk_events_pending"
external drag_set_icon_widget: [>`gdkdragcontext] obj -> [>`gtkwidget] obj -> int -> int -> unit = "ml_gtk_drag_set_icon_widget"
external drag_set_icon_surface: [>`gdkdragcontext] obj -> [>`cairo_surface_t] obj -> unit = "ml_gtk_drag_set_icon_surface"
external drag_set_icon_stock: [>`gdkdragcontext] obj -> string -> int -> int -> unit = "ml_gtk_drag_set_icon_stock"
external drag_set_icon_pixbuf: [>`gdkdragcontext] obj -> [>`gdkpixbuf] obj -> int -> int -> unit = "ml_gtk_drag_set_icon_pixbuf"
external drag_set_icon_name: [>`gdkdragcontext] obj -> string -> int -> int -> unit = "ml_gtk_drag_set_icon_name"
external drag_set_icon_default: [>`gdkdragcontext] obj -> unit = "ml_gtk_drag_set_icon_default"
external drag_get_source_widget: [>`gdkdragcontext] obj -> [<`gtkwidget] obj = "ml_gtk_drag_get_source_widget"
external drag_finish: [>`gdkdragcontext] obj -> bool -> bool -> int32 -> unit = "ml_gtk_drag_finish"
external distribute_natural_allocation: int -> int -> [>`gtkrequestedsize] obj -> int = "ml_gtk_distribute_natural_allocation"
external disable_setlocale: unit -> unit = "ml_gtk_disable_setlocale"
external device_grab_remove: [>`gtkwidget] obj -> [>`gdkdevice] obj -> unit = "ml_gtk_device_grab_remove"
external device_grab_add: [>`gtkwidget] obj -> [>`gdkdevice] obj -> bool -> unit = "ml_gtk_device_grab_add"
external css_provider_error_quark: unit -> int32 = "ml_gtk_css_provider_error_quark"
external check_version: int -> int -> int -> string = "ml_gtk_check_version"
external cairo_transform_to_window: [>`cairo_t] obj -> [>`gtkwidget] obj -> [>`gdkwindow] obj -> unit = "ml_gtk_cairo_transform_to_window"
external cairo_should_draw_window: [>`cairo_t] obj -> [>`gdkwindow] obj -> bool = "ml_gtk_cairo_should_draw_window"
external builder_error_quark: unit -> int32 = "ml_gtk_builder_error_quark"
external binding_set_new: string -> [<`gtkbindingset] obj = "ml_gtk_binding_set_new"
external binding_set_find: string -> [<`gtkbindingset] obj = "ml_gtk_binding_set_find"
external alternative_dialog_button_order: [>`gdkscreen] obj option -> bool = "ml_gtk_alternative_dialog_button_order"
(* End of global functions *)

