open Gtk
open GtkData
open Glade

module GbWidget = struct
  external gb_is_placeholder : [>widget] obj -> bool = "ml_gb_is_placeholder"
  external gb_widget_widget_data : [>widget] obj -> gb_widget_data = "ml_gb_widget_widget_data"

  external gb_widget_data_flags : gb_widget_data -> int = "ml_gb_widget_data_flags"
  external gb_widget_data_x : gb_widget_data -> int = "ml_gb_widget_data_x"
  external gb_widget_data_y : gb_widget_data -> int = "ml_gb_widget_data_y"
  external gb_widget_data_width : gb_widget_data -> int = "ml_gb_widget_data_width"
  external gb_widget_data_height : gb_widget_data -> int = "ml_gb_widget_data_height"
  external gb_widget_data_tooltip : gb_widget_data -> string = "ml_gb_widget_data_tooltip"
  external gb_widget_data_signals : gb_widget_data -> gb_signal list = "ml_gb_widget_data_signals"
  external gb_widget_data_accelerators : gb_widget_data -> gb_accelerator list = "ml_gb_widget_data_accelerators"
  external gb_widget_data_gbstyle : gb_widget_data -> gb_style = "ml_gb_widget_data_gbstyle"

  external gb_signal_name : gb_signal -> string = "ml_gb_signal_name"
  external gb_signal_handler : gb_signal -> string = "ml_gb_signal_handler"
  external gb_signal_object : gb_signal -> string = "ml_gb_signal_object"
  external gb_signal_after : gb_signal -> bool = "ml_gb_signal_after"
  external gb_signal_data : gb_signal -> string = "ml_gb_signal_data"

  external gb_style_name : gb_style -> string = "ml_gb_style_name"
  external gb_style_xlfd_fontname : gb_style -> string = "ml_gb_style_xlfd_fontname"
  external gb_style_style : gb_style -> style = "ml_gb_style_style"
  external gb_style_bg_pixmap_filenames : gb_style -> int -> string = "ml_gb_style_bg_pixmap_filenames"
  let gb_x_set = 1 lsl 7
  let gb_y_set = 1 lsl 8
  let gb_width_set = 1 lsl 9
  let gb_height_set = 1 lsl 10
  let is_flag_set flag bit = (flag land bit) != 0
end

