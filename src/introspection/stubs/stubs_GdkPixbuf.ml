type -'a obj

module Pixdata = struct
  end
module PixbufSimpleAnim = struct
  external set_loop: [>`gdkpixbufsimpleanim] obj -> bool -> unit = "ml_gdk_pixbuf_simple_anim_set_loop"
  external get_loop: [>`gdkpixbufsimpleanim] obj -> bool = "ml_gdk_pixbuf_simple_anim_get_loop"
  external add_frame: [>`gdkpixbufsimpleanim] obj -> [>`gdkpixbuf] obj -> unit = "ml_gdk_pixbuf_simple_anim_add_frame"
  end
module PixbufLoader = struct
  external set_size: [>`gdkpixbufloader] obj -> int -> int -> unit = "ml_gdk_pixbuf_loader_set_size"
  external get_pixbuf: [>`gdkpixbufloader] obj -> [<`gdkpixbuf] obj = "ml_gdk_pixbuf_loader_get_pixbuf"
  external get_format: [>`gdkpixbufloader] obj -> [<`gdkpixbufformat] obj = "ml_gdk_pixbuf_loader_get_format"
  external get_animation: [>`gdkpixbufloader] obj -> [<`gdkpixbufanimation] obj = "ml_gdk_pixbuf_loader_get_animation"
  end
module PixbufFormat = struct
  external set_disabled: [>`gdkpixbufformat] obj -> bool -> unit = "ml_gdk_pixbuf_format_set_disabled"
  external is_writable: [>`gdkpixbufformat] obj -> bool = "ml_gdk_pixbuf_format_is_writable"
  external is_scalable: [>`gdkpixbufformat] obj -> bool = "ml_gdk_pixbuf_format_is_scalable"
  external is_disabled: [>`gdkpixbufformat] obj -> bool = "ml_gdk_pixbuf_format_is_disabled"
  external get_name: [>`gdkpixbufformat] obj -> string = "ml_gdk_pixbuf_format_get_name"
  external get_license: [>`gdkpixbufformat] obj -> string = "ml_gdk_pixbuf_format_get_license"
  external get_description: [>`gdkpixbufformat] obj -> string = "ml_gdk_pixbuf_format_get_description"
  external free: [>`gdkpixbufformat] obj -> unit = "ml_gdk_pixbuf_format_free"
  external copy: [>`gdkpixbufformat] obj -> [<`gdkpixbufformat] obj = "ml_gdk_pixbuf_format_copy"
  end
module PixbufAnimationIter = struct
  external on_currently_loading_frame: [>`gdkpixbufanimationiter] obj -> bool = "ml_gdk_pixbuf_animation_iter_on_currently_loading_frame"
  external get_pixbuf: [>`gdkpixbufanimationiter] obj -> [<`gdkpixbuf] obj = "ml_gdk_pixbuf_animation_iter_get_pixbuf"
  external get_delay_time: [>`gdkpixbufanimationiter] obj -> int = "ml_gdk_pixbuf_animation_iter_get_delay_time"
  external advance: [>`gdkpixbufanimationiter] obj -> [>`gtimeval] obj -> bool = "ml_gdk_pixbuf_animation_iter_advance"
  end
module PixbufAnimation = struct
  external is_static_image: [>`gdkpixbufanimation] obj -> bool = "ml_gdk_pixbuf_animation_is_static_image"
  external get_width: [>`gdkpixbufanimation] obj -> int = "ml_gdk_pixbuf_animation_get_width"
  external get_static_image: [>`gdkpixbufanimation] obj -> [<`gdkpixbuf] obj = "ml_gdk_pixbuf_animation_get_static_image"
  external get_iter: [>`gdkpixbufanimation] obj -> [>`gtimeval] obj -> [<`gdkpixbufanimationiter] obj = "ml_gdk_pixbuf_animation_get_iter"
  external get_height: [>`gdkpixbufanimation] obj -> int = "ml_gdk_pixbuf_animation_get_height"
  end
module Pixbuf = struct
  external new_subpixbuf: [>`gdkpixbuf] obj -> int -> int -> int -> int -> [<`gdkpixbuf] obj = "ml_gdk_pixbuf_new_subpixbuf"
  external get_width: [>`gdkpixbuf] obj -> int = "ml_gdk_pixbuf_get_width"
  external get_rowstride: [>`gdkpixbuf] obj -> int = "ml_gdk_pixbuf_get_rowstride"
  external get_option: [>`gdkpixbuf] obj -> string -> string = "ml_gdk_pixbuf_get_option"
  external get_n_channels: [>`gdkpixbuf] obj -> int = "ml_gdk_pixbuf_get_n_channels"
  external get_height: [>`gdkpixbuf] obj -> int = "ml_gdk_pixbuf_get_height"
  external get_has_alpha: [>`gdkpixbuf] obj -> bool = "ml_gdk_pixbuf_get_has_alpha"
  external get_byte_length: [>`gdkpixbuf] obj -> int = "ml_gdk_pixbuf_get_byte_length"
  external get_bits_per_sample: [>`gdkpixbuf] obj -> int = "ml_gdk_pixbuf_get_bits_per_sample"
  external flip: [>`gdkpixbuf] obj -> bool -> [<`gdkpixbuf] obj = "ml_gdk_pixbuf_flip"
  external fill: [>`gdkpixbuf] obj -> int32 -> unit = "ml_gdk_pixbuf_fill"
  external copy_area: [>`gdkpixbuf] obj -> int -> int -> int -> int -> [>`gdkpixbuf] obj -> int -> int -> unit = "ml_gdk_pixbuf_copy_area"
  external copy: [>`gdkpixbuf] obj -> [<`gdkpixbuf] obj = "ml_gdk_pixbuf_copy"
  external apply_embedded_orientation: [>`gdkpixbuf] obj -> [<`gdkpixbuf] obj = "ml_gdk_pixbuf_apply_embedded_orientation"
  external add_alpha: [>`gdkpixbuf] obj -> bool -> int -> int -> int -> [<`gdkpixbuf] obj = "ml_gdk_pixbuf_add_alpha"
  external gettext: string -> string = "ml_gdk_pixbuf_gettext"
  external get_formats: unit -> [<`gslist] obj = "ml_gdk_pixbuf_get_formats"
  end
(* Global functions *)
(* End of global functions *)

