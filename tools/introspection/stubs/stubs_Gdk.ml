type -'a obj

module WindowRedirect = struct
  end
module WindowClass = struct
  end
module WindowAttr = struct
  end
module Window = struct
  external withdraw: [>`gdkwindow] obj -> unit = "ml_gdk_window_withdraw"
  external unstick: [>`gdkwindow] obj -> unit = "ml_gdk_window_unstick"
  external unmaximize: [>`gdkwindow] obj -> unit = "ml_gdk_window_unmaximize"
  external unfullscreen: [>`gdkwindow] obj -> unit = "ml_gdk_window_unfullscreen"
  external thaw_updates: [>`gdkwindow] obj -> unit = "ml_gdk_window_thaw_updates"
  external thaw_toplevel_updates_libgtk_only: [>`gdkwindow] obj -> unit = "ml_gdk_window_thaw_toplevel_updates_libgtk_only"
  external stick: [>`gdkwindow] obj -> unit = "ml_gdk_window_stick"
  external show_unraised: [>`gdkwindow] obj -> unit = "ml_gdk_window_show_unraised"
  external show: [>`gdkwindow] obj -> unit = "ml_gdk_window_show"
  external shape_combine_region: [>`gdkwindow] obj -> [>`cairo_region_t] obj -> int -> int -> unit = "ml_gdk_window_shape_combine_region"
  external set_urgency_hint: [>`gdkwindow] obj -> bool -> unit = "ml_gdk_window_set_urgency_hint"
  external set_transient_for: [>`gdkwindow] obj -> [>`gdkwindow] obj -> unit = "ml_gdk_window_set_transient_for"
  external set_title: [>`gdkwindow] obj -> string -> unit = "ml_gdk_window_set_title"
  external set_support_multidevice: [>`gdkwindow] obj -> bool -> unit = "ml_gdk_window_set_support_multidevice"
  external set_static_gravities: [>`gdkwindow] obj -> bool -> bool = "ml_gdk_window_set_static_gravities"
  external set_startup_id: [>`gdkwindow] obj -> string -> unit = "ml_gdk_window_set_startup_id"
  external set_skip_taskbar_hint: [>`gdkwindow] obj -> bool -> unit = "ml_gdk_window_set_skip_taskbar_hint"
  external set_skip_pager_hint: [>`gdkwindow] obj -> bool -> unit = "ml_gdk_window_set_skip_pager_hint"
  external set_role: [>`gdkwindow] obj -> string -> unit = "ml_gdk_window_set_role"
  external set_override_redirect: [>`gdkwindow] obj -> bool -> unit = "ml_gdk_window_set_override_redirect"
  external set_opacity: [>`gdkwindow] obj -> float -> unit = "ml_gdk_window_set_opacity"
  external set_modal_hint: [>`gdkwindow] obj -> bool -> unit = "ml_gdk_window_set_modal_hint"
  external set_keep_below: [>`gdkwindow] obj -> bool -> unit = "ml_gdk_window_set_keep_below"
  external set_keep_above: [>`gdkwindow] obj -> bool -> unit = "ml_gdk_window_set_keep_above"
  external set_icon_name: [>`gdkwindow] obj -> string -> unit = "ml_gdk_window_set_icon_name"
  external set_icon_list: [>`gdkwindow] obj -> [>`glist] obj -> unit = "ml_gdk_window_set_icon_list"
  external set_group: [>`gdkwindow] obj -> [>`gdkwindow] obj -> unit = "ml_gdk_window_set_group"
  external set_focus_on_map: [>`gdkwindow] obj -> bool -> unit = "ml_gdk_window_set_focus_on_map"
  external set_device_cursor: [>`gdkwindow] obj -> [>`gdkdevice] obj -> [>`gdkcursor] obj -> unit = "ml_gdk_window_set_device_cursor"
  external set_cursor: [>`gdkwindow] obj -> [>`gdkcursor] obj option -> unit = "ml_gdk_window_set_cursor"
  external set_composited: [>`gdkwindow] obj -> bool -> unit = "ml_gdk_window_set_composited"
  external set_child_shapes: [>`gdkwindow] obj -> unit = "ml_gdk_window_set_child_shapes"
  external set_child_input_shapes: [>`gdkwindow] obj -> unit = "ml_gdk_window_set_child_input_shapes"
  external set_background_rgba: [>`gdkwindow] obj -> [>`gdkrgba] obj -> unit = "ml_gdk_window_set_background_rgba"
  external set_background_pattern: [>`gdkwindow] obj -> [>`cairo_pattern_t] obj option -> unit = "ml_gdk_window_set_background_pattern"
  external set_background: [>`gdkwindow] obj -> [>`gdkcolor] obj -> unit = "ml_gdk_window_set_background"
  external set_accept_focus: [>`gdkwindow] obj -> bool -> unit = "ml_gdk_window_set_accept_focus"
  external scroll: [>`gdkwindow] obj -> int -> int -> unit = "ml_gdk_window_scroll"
  external restack: [>`gdkwindow] obj -> [>`gdkwindow] obj option -> bool -> unit = "ml_gdk_window_restack"
  external resize: [>`gdkwindow] obj -> int -> int -> unit = "ml_gdk_window_resize"
  external reparent: [>`gdkwindow] obj -> [>`gdkwindow] obj -> int -> int -> unit = "ml_gdk_window_reparent"
  external register_dnd: [>`gdkwindow] obj -> unit = "ml_gdk_window_register_dnd"
  external raise: [>`gdkwindow] obj -> unit = "ml_gdk_window_raise"
  external process_updates: [>`gdkwindow] obj -> bool -> unit = "ml_gdk_window_process_updates"
  external peek_children: [>`gdkwindow] obj -> [<`glist] obj = "ml_gdk_window_peek_children"
  external move_resize: [>`gdkwindow] obj -> int -> int -> int -> int -> unit = "ml_gdk_window_move_resize"
  external move_region: [>`gdkwindow] obj -> [>`cairo_region_t] obj -> int -> int -> unit = "ml_gdk_window_move_region"
  external move: [>`gdkwindow] obj -> int -> int -> unit = "ml_gdk_window_move"
  external merge_child_shapes: [>`gdkwindow] obj -> unit = "ml_gdk_window_merge_child_shapes"
  external merge_child_input_shapes: [>`gdkwindow] obj -> unit = "ml_gdk_window_merge_child_input_shapes"
  external maximize: [>`gdkwindow] obj -> unit = "ml_gdk_window_maximize"
  external lower: [>`gdkwindow] obj -> unit = "ml_gdk_window_lower"
  external is_visible: [>`gdkwindow] obj -> bool = "ml_gdk_window_is_visible"
  external is_viewable: [>`gdkwindow] obj -> bool = "ml_gdk_window_is_viewable"
  external is_shaped: [>`gdkwindow] obj -> bool = "ml_gdk_window_is_shaped"
  external is_input_only: [>`gdkwindow] obj -> bool = "ml_gdk_window_is_input_only"
  external is_destroyed: [>`gdkwindow] obj -> bool = "ml_gdk_window_is_destroyed"
  external invalidate_region: [>`gdkwindow] obj -> [>`cairo_region_t] obj -> bool -> unit = "ml_gdk_window_invalidate_region"
  external input_shape_combine_region: [>`gdkwindow] obj -> [>`cairo_region_t] obj -> int -> int -> unit = "ml_gdk_window_input_shape_combine_region"
  external iconify: [>`gdkwindow] obj -> unit = "ml_gdk_window_iconify"
  external hide: [>`gdkwindow] obj -> unit = "ml_gdk_window_hide"
  external has_native: [>`gdkwindow] obj -> bool = "ml_gdk_window_has_native"
  external get_width: [>`gdkwindow] obj -> int = "ml_gdk_window_get_width"
  external get_visual: [>`gdkwindow] obj -> [<`gdkvisual] obj = "ml_gdk_window_get_visual"
  external get_visible_region: [>`gdkwindow] obj -> [<`cairo_region_t] obj = "ml_gdk_window_get_visible_region"
  external get_update_area: [>`gdkwindow] obj -> [<`cairo_region_t] obj = "ml_gdk_window_get_update_area"
  external get_toplevel: [>`gdkwindow] obj -> [<`gdkwindow] obj = "ml_gdk_window_get_toplevel"
  external get_support_multidevice: [>`gdkwindow] obj -> bool = "ml_gdk_window_get_support_multidevice"
  external get_screen: [>`gdkwindow] obj -> [<`gdkscreen] obj = "ml_gdk_window_get_screen"
  external get_parent: [>`gdkwindow] obj -> [<`gdkwindow] obj = "ml_gdk_window_get_parent"
  external get_modal_hint: [>`gdkwindow] obj -> bool = "ml_gdk_window_get_modal_hint"
  external get_height: [>`gdkwindow] obj -> int = "ml_gdk_window_get_height"
  external get_group: [>`gdkwindow] obj -> [<`gdkwindow] obj = "ml_gdk_window_get_group"
  external get_focus_on_map: [>`gdkwindow] obj -> bool = "ml_gdk_window_get_focus_on_map"
  external get_effective_toplevel: [>`gdkwindow] obj -> [<`gdkwindow] obj = "ml_gdk_window_get_effective_toplevel"
  external get_effective_parent: [>`gdkwindow] obj -> [<`gdkwindow] obj = "ml_gdk_window_get_effective_parent"
  external get_display: [>`gdkwindow] obj -> [<`gdkdisplay] obj = "ml_gdk_window_get_display"
  external get_device_cursor: [>`gdkwindow] obj -> [>`gdkdevice] obj -> [<`gdkcursor] obj = "ml_gdk_window_get_device_cursor"
  external get_cursor: [>`gdkwindow] obj -> [<`gdkcursor] obj = "ml_gdk_window_get_cursor"
  external get_composited: [>`gdkwindow] obj -> bool = "ml_gdk_window_get_composited"
  external get_clip_region: [>`gdkwindow] obj -> [<`cairo_region_t] obj = "ml_gdk_window_get_clip_region"
  external get_children: [>`gdkwindow] obj -> [<`glist] obj = "ml_gdk_window_get_children"
  external get_background_pattern: [>`gdkwindow] obj -> [<`cairo_pattern_t] obj = "ml_gdk_window_get_background_pattern"
  external get_accept_focus: [>`gdkwindow] obj -> bool = "ml_gdk_window_get_accept_focus"
  external geometry_changed: [>`gdkwindow] obj -> unit = "ml_gdk_window_geometry_changed"
  external fullscreen: [>`gdkwindow] obj -> unit = "ml_gdk_window_fullscreen"
  external freeze_updates: [>`gdkwindow] obj -> unit = "ml_gdk_window_freeze_updates"
  external freeze_toplevel_updates_libgtk_only: [>`gdkwindow] obj -> unit = "ml_gdk_window_freeze_toplevel_updates_libgtk_only"
  external focus: [>`gdkwindow] obj -> int32 -> unit = "ml_gdk_window_focus"
  external flush: [>`gdkwindow] obj -> unit = "ml_gdk_window_flush"
  external ensure_native: [>`gdkwindow] obj -> bool = "ml_gdk_window_ensure_native"
  external end_paint: [>`gdkwindow] obj -> unit = "ml_gdk_window_end_paint"
  external enable_synchronized_configure: [>`gdkwindow] obj -> unit = "ml_gdk_window_enable_synchronized_configure"
  external destroy_notify: [>`gdkwindow] obj -> unit = "ml_gdk_window_destroy_notify"
  external destroy: [>`gdkwindow] obj -> unit = "ml_gdk_window_destroy"
  external deiconify: [>`gdkwindow] obj -> unit = "ml_gdk_window_deiconify"
  external configure_finished: [>`gdkwindow] obj -> unit = "ml_gdk_window_configure_finished"
  external begin_paint_region: [>`gdkwindow] obj -> [>`cairo_region_t] obj -> unit = "ml_gdk_window_begin_paint_region"
  external begin_move_drag: [>`gdkwindow] obj -> int -> int -> int -> int32 -> unit = "ml_gdk_window_begin_move_drag"
  external beep: [>`gdkwindow] obj -> unit = "ml_gdk_window_beep"
  external set_debug_updates: bool -> unit = "ml_gdk_window_set_debug_updates"
  external process_all_updates: unit -> unit = "ml_gdk_window_process_all_updates"
  end
module Visual = struct
  external get_screen: [>`gdkvisual] obj -> [<`gdkscreen] obj = "ml_gdk_visual_get_screen"
  external get_depth: [>`gdkvisual] obj -> int = "ml_gdk_visual_get_depth"
  external get_colormap_size: [>`gdkvisual] obj -> int = "ml_gdk_visual_get_colormap_size"
  external get_bits_per_rgb: [>`gdkvisual] obj -> int = "ml_gdk_visual_get_bits_per_rgb"
  external get_system: unit -> [<`gdkvisual] obj = "ml_gdk_visual_get_system"
  external get_best_with_depth: int -> [<`gdkvisual] obj = "ml_gdk_visual_get_best_with_depth"
  external get_best_depth: unit -> int = "ml_gdk_visual_get_best_depth"
  external get_best: unit -> [<`gdkvisual] obj = "ml_gdk_visual_get_best"
  end
module TimeCoord = struct
  end
module Screen = struct
  external set_resolution: [>`gdkscreen] obj -> float -> unit = "ml_gdk_screen_set_resolution"
  external set_font_options: [>`gdkscreen] obj -> [>`cairo_font_options_t] obj option -> unit = "ml_gdk_screen_set_font_options"
  external make_display_name: [>`gdkscreen] obj -> string = "ml_gdk_screen_make_display_name"
  external list_visuals: [>`gdkscreen] obj -> [<`glist] obj = "ml_gdk_screen_list_visuals"
  external is_composited: [>`gdkscreen] obj -> bool = "ml_gdk_screen_is_composited"
  external get_window_stack: [>`gdkscreen] obj -> [<`glist] obj = "ml_gdk_screen_get_window_stack"
  external get_width_mm: [>`gdkscreen] obj -> int = "ml_gdk_screen_get_width_mm"
  external get_width: [>`gdkscreen] obj -> int = "ml_gdk_screen_get_width"
  external get_toplevel_windows: [>`gdkscreen] obj -> [<`glist] obj = "ml_gdk_screen_get_toplevel_windows"
  external get_system_visual: [>`gdkscreen] obj -> [<`gdkvisual] obj = "ml_gdk_screen_get_system_visual"
  external get_setting: [>`gdkscreen] obj -> string -> [>`gvalue] obj -> bool = "ml_gdk_screen_get_setting"
  external get_root_window: [>`gdkscreen] obj -> [<`gdkwindow] obj = "ml_gdk_screen_get_root_window"
  external get_rgba_visual: [>`gdkscreen] obj -> [<`gdkvisual] obj = "ml_gdk_screen_get_rgba_visual"
  external get_resolution: [>`gdkscreen] obj -> float = "ml_gdk_screen_get_resolution"
  external get_primary_monitor: [>`gdkscreen] obj -> int = "ml_gdk_screen_get_primary_monitor"
  external get_number: [>`gdkscreen] obj -> int = "ml_gdk_screen_get_number"
  external get_n_monitors: [>`gdkscreen] obj -> int = "ml_gdk_screen_get_n_monitors"
  external get_monitor_width_mm: [>`gdkscreen] obj -> int -> int = "ml_gdk_screen_get_monitor_width_mm"
  external get_monitor_plug_name: [>`gdkscreen] obj -> int -> string = "ml_gdk_screen_get_monitor_plug_name"
  external get_monitor_height_mm: [>`gdkscreen] obj -> int -> int = "ml_gdk_screen_get_monitor_height_mm"
  external get_monitor_at_window: [>`gdkscreen] obj -> [>`gdkwindow] obj -> int = "ml_gdk_screen_get_monitor_at_window"
  external get_monitor_at_point: [>`gdkscreen] obj -> int -> int -> int = "ml_gdk_screen_get_monitor_at_point"
  external get_height_mm: [>`gdkscreen] obj -> int = "ml_gdk_screen_get_height_mm"
  external get_height: [>`gdkscreen] obj -> int = "ml_gdk_screen_get_height"
  external get_font_options: [>`gdkscreen] obj -> [<`cairo_font_options_t] obj = "ml_gdk_screen_get_font_options"
  external get_display: [>`gdkscreen] obj -> [<`gdkdisplay] obj = "ml_gdk_screen_get_display"
  external get_active_window: [>`gdkscreen] obj -> [<`gdkwindow] obj = "ml_gdk_screen_get_active_window"
  external width_mm: unit -> int = "ml_gdk_screen_width_mm"
  external width: unit -> int = "ml_gdk_screen_width"
  external height_mm: unit -> int = "ml_gdk_screen_height_mm"
  external height: unit -> int = "ml_gdk_screen_height"
  external get_default: unit -> [<`gdkscreen] obj = "ml_gdk_screen_get_default"
  end
module RGBA = struct
  external to_string: [>`gdkrgba] obj -> string = "ml_gdk_rgba_to_string"
  external parse: [>`gdkrgba] obj -> string -> bool = "ml_gdk_rgba_parse"
  external hash: [>`gdkrgba] obj -> int = "ml_gdk_rgba_hash"
  external free: [>`gdkrgba] obj -> unit = "ml_gdk_rgba_free"
  external copy: [>`gdkrgba] obj -> [<`gdkrgba] obj = "ml_gdk_rgba_copy"
  end
module Point = struct
  end
module KeymapKey = struct
  end
module Keymap = struct
  external lookup_key: [>`gdkkeymap] obj -> [>`gdkkeymapkey] obj -> int = "ml_gdk_keymap_lookup_key"
  external have_bidi_layouts: [>`gdkkeymap] obj -> bool = "ml_gdk_keymap_have_bidi_layouts"
  external get_num_lock_state: [>`gdkkeymap] obj -> bool = "ml_gdk_keymap_get_num_lock_state"
  external get_caps_lock_state: [>`gdkkeymap] obj -> bool = "ml_gdk_keymap_get_caps_lock_state"
  external get_for_display: [>`gdkdisplay] obj -> [<`gdkkeymap] obj = "ml_gdk_keymap_get_for_display"
  external get_default: unit -> [<`gdkkeymap] obj = "ml_gdk_keymap_get_default"
  end
module Geometry = struct
  end
module EventWindowState = struct
  end
module EventVisibility = struct
  end
module EventSetting = struct
  end
module EventSelection = struct
  end
module EventScroll = struct
  end
module EventProximity = struct
  end
module EventProperty = struct
  end
module EventOwnerChange = struct
  end
module EventMotion = struct
  end
module EventKey = struct
  end
module EventGrabBroken = struct
  end
module EventFocus = struct
  end
module EventExpose = struct
  end
module EventDND = struct
  end
module EventCrossing = struct
  end
module EventConfigure = struct
  end
module EventButton = struct
  end
module EventAny = struct
  end
module DragContext = struct
  external set_device: [>`gdkdragcontext] obj -> [>`gdkdevice] obj -> unit = "ml_gdk_drag_context_set_device"
  external list_targets: [>`gdkdragcontext] obj -> [<`glist] obj = "ml_gdk_drag_context_list_targets"
  external get_source_window: [>`gdkdragcontext] obj -> [<`gdkwindow] obj = "ml_gdk_drag_context_get_source_window"
  external get_device: [>`gdkdragcontext] obj -> [<`gdkdevice] obj = "ml_gdk_drag_context_get_device"
  external get_dest_window: [>`gdkdragcontext] obj -> [<`gdkwindow] obj = "ml_gdk_drag_context_get_dest_window"
  end
module DisplayManager = struct
  external set_default_display: [>`gdkdisplaymanager] obj -> [>`gdkdisplay] obj -> unit = "ml_gdk_display_manager_set_default_display"
  external open_display: [>`gdkdisplaymanager] obj -> string -> [<`gdkdisplay] obj = "ml_gdk_display_manager_open_display"
  external list_displays: [>`gdkdisplaymanager] obj -> [<`gslist] obj = "ml_gdk_display_manager_list_displays"
  external get_default_display: [>`gdkdisplaymanager] obj -> [<`gdkdisplay] obj = "ml_gdk_display_manager_get_default_display"
  external get: unit -> [<`gdkdisplaymanager] obj = "ml_gdk_display_manager_get"
  end
module Display = struct
  external warp_pointer: [>`gdkdisplay] obj -> [>`gdkscreen] obj -> int -> int -> unit = "ml_gdk_display_warp_pointer"
  external sync: [>`gdkdisplay] obj -> unit = "ml_gdk_display_sync"
  external supports_shapes: [>`gdkdisplay] obj -> bool = "ml_gdk_display_supports_shapes"
  external supports_selection_notification: [>`gdkdisplay] obj -> bool = "ml_gdk_display_supports_selection_notification"
  external supports_input_shapes: [>`gdkdisplay] obj -> bool = "ml_gdk_display_supports_input_shapes"
  external supports_cursor_color: [>`gdkdisplay] obj -> bool = "ml_gdk_display_supports_cursor_color"
  external supports_cursor_alpha: [>`gdkdisplay] obj -> bool = "ml_gdk_display_supports_cursor_alpha"
  external supports_composite: [>`gdkdisplay] obj -> bool = "ml_gdk_display_supports_composite"
  external supports_clipboard_persistence: [>`gdkdisplay] obj -> bool = "ml_gdk_display_supports_clipboard_persistence"
  external set_double_click_time: [>`gdkdisplay] obj -> int -> unit = "ml_gdk_display_set_double_click_time"
  external set_double_click_distance: [>`gdkdisplay] obj -> int -> unit = "ml_gdk_display_set_double_click_distance"
  external pointer_ungrab: [>`gdkdisplay] obj -> int32 -> unit = "ml_gdk_display_pointer_ungrab"
  external pointer_is_grabbed: [>`gdkdisplay] obj -> bool = "ml_gdk_display_pointer_is_grabbed"
  external notify_startup_complete: [>`gdkdisplay] obj -> string -> unit = "ml_gdk_display_notify_startup_complete"
  external list_devices: [>`gdkdisplay] obj -> [<`glist] obj = "ml_gdk_display_list_devices"
  external keyboard_ungrab: [>`gdkdisplay] obj -> int32 -> unit = "ml_gdk_display_keyboard_ungrab"
  external is_closed: [>`gdkdisplay] obj -> bool = "ml_gdk_display_is_closed"
  external has_pending: [>`gdkdisplay] obj -> bool = "ml_gdk_display_has_pending"
  external get_screen: [>`gdkdisplay] obj -> int -> [<`gdkscreen] obj = "ml_gdk_display_get_screen"
  external get_name: [>`gdkdisplay] obj -> string = "ml_gdk_display_get_name"
  external get_n_screens: [>`gdkdisplay] obj -> int = "ml_gdk_display_get_n_screens"
  external get_device_manager: [>`gdkdisplay] obj -> [<`gdkdevicemanager] obj = "ml_gdk_display_get_device_manager"
  external get_default_screen: [>`gdkdisplay] obj -> [<`gdkscreen] obj = "ml_gdk_display_get_default_screen"
  external get_default_group: [>`gdkdisplay] obj -> [<`gdkwindow] obj = "ml_gdk_display_get_default_group"
  external get_default_cursor_size: [>`gdkdisplay] obj -> int = "ml_gdk_display_get_default_cursor_size"
  external get_app_launch_context: [>`gdkdisplay] obj -> [<`gdkapplaunchcontext] obj = "ml_gdk_display_get_app_launch_context"
  external flush: [>`gdkdisplay] obj -> unit = "ml_gdk_display_flush"
  external device_is_grabbed: [>`gdkdisplay] obj -> [>`gdkdevice] obj -> bool = "ml_gdk_display_device_is_grabbed"
  external close: [>`gdkdisplay] obj -> unit = "ml_gdk_display_close"
  external beep: [>`gdkdisplay] obj -> unit = "ml_gdk_display_beep"
  external open_default_libgtk_only: unit -> [<`gdkdisplay] obj = "ml_gdk_display_open_default_libgtk_only"
  external gdk_display_open: string -> [<`gdkdisplay] obj = "ml_gdk_display_open"
  external get_default: unit -> [<`gdkdisplay] obj = "ml_gdk_display_get_default"
  end
module DeviceManager = struct
  external get_display: [>`gdkdevicemanager] obj -> [<`gdkdisplay] obj = "ml_gdk_device_manager_get_display"
  external get_client_pointer: [>`gdkdevicemanager] obj -> [<`gdkdevice] obj = "ml_gdk_device_manager_get_client_pointer"
  end
module Device = struct
  external warp: [>`gdkdevice] obj -> [>`gdkscreen] obj -> int -> int -> unit = "ml_gdk_device_warp"
  external ungrab: [>`gdkdevice] obj -> int32 -> unit = "ml_gdk_device_ungrab"
  external list_slave_devices: [>`gdkdevice] obj -> [<`glist] obj = "ml_gdk_device_list_slave_devices"
  external list_axes: [>`gdkdevice] obj -> [<`glist] obj = "ml_gdk_device_list_axes"
  external get_name: [>`gdkdevice] obj -> string = "ml_gdk_device_get_name"
  external get_n_keys: [>`gdkdevice] obj -> int = "ml_gdk_device_get_n_keys"
  external get_n_axes: [>`gdkdevice] obj -> int = "ml_gdk_device_get_n_axes"
  external get_has_cursor: [>`gdkdevice] obj -> bool = "ml_gdk_device_get_has_cursor"
  external get_display: [>`gdkdevice] obj -> [<`gdkdisplay] obj = "ml_gdk_device_get_display"
  external get_associated_device: [>`gdkdevice] obj -> [<`gdkdevice] obj = "ml_gdk_device_get_associated_device"
  end
module Cursor = struct
  external unref: [>`gdkcursor] obj -> unit = "ml_gdk_cursor_unref"
  external ref: [>`gdkcursor] obj -> [<`gdkcursor] obj = "ml_gdk_cursor_ref"
  external get_image: [>`gdkcursor] obj -> [<`gdkpixbuf] obj = "ml_gdk_cursor_get_image"
  external get_display: [>`gdkcursor] obj -> [<`gdkdisplay] obj = "ml_gdk_cursor_get_display"
  end
module Color = struct
  external to_string: [>`gdkcolor] obj -> string = "ml_gdk_color_to_string"
  external hash: [>`gdkcolor] obj -> int = "ml_gdk_color_hash"
  external free: [>`gdkcolor] obj -> unit = "ml_gdk_color_free"
  external equal: [>`gdkcolor] obj -> [>`gdkcolor] obj -> bool = "ml_gdk_color_equal"
  external copy: [>`gdkcolor] obj -> [<`gdkcolor] obj = "ml_gdk_color_copy"
  end
module Atom = struct
  end
module AppLaunchContext = struct
  external set_timestamp: [>`gdkapplaunchcontext] obj -> int32 -> unit = "ml_gdk_app_launch_context_set_timestamp"
  external set_screen: [>`gdkapplaunchcontext] obj -> [>`gdkscreen] obj -> unit = "ml_gdk_app_launch_context_set_screen"
  external set_icon_name: [>`gdkapplaunchcontext] obj -> string option -> unit = "ml_gdk_app_launch_context_set_icon_name"
  external set_display: [>`gdkapplaunchcontext] obj -> [>`gdkdisplay] obj -> unit = "ml_gdk_app_launch_context_set_display"
  external set_desktop: [>`gdkapplaunchcontext] obj -> int -> unit = "ml_gdk_app_launch_context_set_desktop"
  end
(* Global functions *)
external utf8_to_string_target: string -> string = "ml_gdk_utf8_to_string_target"
external unicode_to_keyval: int32 -> int = "ml_gdk_unicode_to_keyval"
external threads_leave: unit -> unit = "ml_gdk_threads_leave"
external threads_init: unit -> unit = "ml_gdk_threads_init"
external threads_enter: unit -> unit = "ml_gdk_threads_enter"
external test_render_sync: [>`gdkwindow] obj -> unit = "ml_gdk_test_render_sync"
external setting_get: string -> [>`gvalue] obj -> bool = "ml_gdk_setting_get"
external set_show_events: bool -> unit = "ml_gdk_set_show_events"
external set_program_class: string -> unit = "ml_gdk_set_program_class"
external set_double_click_time: int -> unit = "ml_gdk_set_double_click_time"
external rectangle_get_type: unit -> int = "ml_gdk_rectangle_get_type"
external pre_parse_libgtk_only: unit -> unit = "ml_gdk_pre_parse_libgtk_only"
external pointer_ungrab: int32 -> unit = "ml_gdk_pointer_ungrab"
external pointer_is_grabbed: unit -> bool = "ml_gdk_pointer_is_grabbed"
external pixbuf_get_from_window: [>`gdkwindow] obj -> int -> int -> int -> int -> [<`gdkpixbuf] obj = "ml_gdk_pixbuf_get_from_window"
external pixbuf_get_from_surface: [>`cairo_surface_t] obj -> int -> int -> int -> int -> [<`gdkpixbuf] obj = "ml_gdk_pixbuf_get_from_surface"
external pango_context_get_for_screen: [>`gdkscreen] obj -> [<`pangocontext] obj = "ml_gdk_pango_context_get_for_screen"
external pango_context_get: unit -> [<`pangocontext] obj = "ml_gdk_pango_context_get"
external offscreen_window_set_embedder: [>`gdkwindow] obj -> [>`gdkwindow] obj -> unit = "ml_gdk_offscreen_window_set_embedder"
external offscreen_window_get_surface: [>`gdkwindow] obj -> [<`cairo_surface_t] obj = "ml_gdk_offscreen_window_get_surface"
external offscreen_window_get_embedder: [>`gdkwindow] obj -> [<`gdkwindow] obj = "ml_gdk_offscreen_window_get_embedder"
external notify_startup_complete_with_id: string -> unit = "ml_gdk_notify_startup_complete_with_id"
external notify_startup_complete: unit -> unit = "ml_gdk_notify_startup_complete"
external list_visuals: unit -> [<`glist] obj = "ml_gdk_list_visuals"
external keyval_to_upper: int -> int = "ml_gdk_keyval_to_upper"
external keyval_to_unicode: int -> int32 = "ml_gdk_keyval_to_unicode"
external keyval_to_lower: int -> int = "ml_gdk_keyval_to_lower"
external keyval_name: int -> string = "ml_gdk_keyval_name"
external keyval_is_upper: int -> bool = "ml_gdk_keyval_is_upper"
external keyval_is_lower: int -> bool = "ml_gdk_keyval_is_lower"
external keyval_from_name: string -> int = "ml_gdk_keyval_from_name"
external keyboard_ungrab: int32 -> unit = "ml_gdk_keyboard_ungrab"
external get_show_events: unit -> bool = "ml_gdk_get_show_events"
external get_program_class: unit -> string = "ml_gdk_get_program_class"
external get_display_arg_name: unit -> string = "ml_gdk_get_display_arg_name"
external get_display: unit -> string = "ml_gdk_get_display"
external get_default_root_window: unit -> [<`gdkwindow] obj = "ml_gdk_get_default_root_window"
external flush: unit -> unit = "ml_gdk_flush"
external events_pending: unit -> bool = "ml_gdk_events_pending"
external event_request_motions: [>`gdkeventmotion] obj -> unit = "ml_gdk_event_request_motions"
external error_trap_push: unit -> unit = "ml_gdk_error_trap_push"
external error_trap_pop_ignored: unit -> unit = "ml_gdk_error_trap_pop_ignored"
external error_trap_pop: unit -> int = "ml_gdk_error_trap_pop"
external drop_reply: [>`gdkdragcontext] obj -> bool -> int32 -> unit = "ml_gdk_drop_reply"
external drop_finish: [>`gdkdragcontext] obj -> bool -> int32 -> unit = "ml_gdk_drop_finish"
external drag_drop_succeeded: [>`gdkdragcontext] obj -> bool = "ml_gdk_drag_drop_succeeded"
external drag_drop: [>`gdkdragcontext] obj -> int32 -> unit = "ml_gdk_drag_drop"
external drag_begin_for_device: [>`gdkwindow] obj -> [>`gdkdevice] obj -> [>`glist] obj -> [<`gdkdragcontext] obj = "ml_gdk_drag_begin_for_device"
external drag_begin: [>`gdkwindow] obj -> [>`glist] obj -> [<`gdkdragcontext] obj = "ml_gdk_drag_begin"
external drag_abort: [>`gdkdragcontext] obj -> int32 -> unit = "ml_gdk_drag_abort"
external disable_multidevice: unit -> unit = "ml_gdk_disable_multidevice"
external cairo_set_source_window: [>`cairo_t] obj -> [>`gdkwindow] obj -> float -> float -> unit = "ml_gdk_cairo_set_source_window"
external cairo_set_source_rgba: [>`cairo_t] obj -> [>`gdkrgba] obj -> unit = "ml_gdk_cairo_set_source_rgba"
external cairo_set_source_pixbuf: [>`cairo_t] obj -> [>`gdkpixbuf] obj -> float -> float -> unit = "ml_gdk_cairo_set_source_pixbuf"
external cairo_set_source_color: [>`cairo_t] obj -> [>`gdkcolor] obj -> unit = "ml_gdk_cairo_set_source_color"
external cairo_region_create_from_surface: [>`cairo_surface_t] obj -> [<`cairo_region_t] obj = "ml_gdk_cairo_region_create_from_surface"
external cairo_region: [>`cairo_t] obj -> [>`cairo_region_t] obj -> unit = "ml_gdk_cairo_region"
external cairo_create: [>`gdkwindow] obj -> [<`cairo_t] obj = "ml_gdk_cairo_create"
external beep: unit -> unit = "ml_gdk_beep"
external add_option_entries_libgtk_only: [>`goptiongroup] obj -> unit = "ml_gdk_add_option_entries_libgtk_only"
(* End of global functions *)

