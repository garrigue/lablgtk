type -'a obj

module TabArray = struct
  external resize: [>`pangotabarray] obj -> int -> unit = "ml_pango_tab_array_resize"
  external get_size: [>`pangotabarray] obj -> int = "ml_pango_tab_array_get_size"
  external get_positions_in_pixels: [>`pangotabarray] obj -> bool = "ml_pango_tab_array_get_positions_in_pixels"
  external free: [>`pangotabarray] obj -> unit = "ml_pango_tab_array_free"
  external copy: [>`pangotabarray] obj -> [<`pangotabarray] obj = "ml_pango_tab_array_copy"
  end
module ScriptIter = struct
  external next: [>`pangoscriptiter] obj -> bool = "ml_pango_script_iter_next"
  external free: [>`pangoscriptiter] obj -> unit = "ml_pango_script_iter_free"
  external new: string -> int -> [<`pangoscriptiter] obj = "ml_pango_script_iter_new"
  end
module Renderer = struct
  external set_matrix: [>`pangorenderer] obj -> [>`pangomatrix] obj option -> unit = "ml_pango_renderer_set_matrix"
  external get_matrix: [>`pangorenderer] obj -> [<`pangomatrix] obj = "ml_pango_renderer_get_matrix"
  external get_layout_line: [>`pangorenderer] obj -> [<`pangolayoutline] obj = "ml_pango_renderer_get_layout_line"
  external get_layout: [>`pangorenderer] obj -> [<`pangolayout] obj = "ml_pango_renderer_get_layout"
  external draw_layout_line: [>`pangorenderer] obj -> [>`pangolayoutline] obj -> int -> int -> unit = "ml_pango_renderer_draw_layout_line"
  external draw_layout: [>`pangorenderer] obj -> [>`pangolayout] obj -> int -> int -> unit = "ml_pango_renderer_draw_layout"
  external draw_glyphs: [>`pangorenderer] obj -> [>`pangofont] obj -> [>`pangoglyphstring] obj -> int -> int -> unit = "ml_pango_renderer_draw_glyphs"
  external draw_glyph_item: [>`pangorenderer] obj -> string option -> [>`pangoglyphitem] obj -> int -> int -> unit = "ml_pango_renderer_draw_glyph_item"
  external draw_glyph: [>`pangorenderer] obj -> [>`pangofont] obj -> int32 -> float -> float -> unit = "ml_pango_renderer_draw_glyph"
  external draw_error_underline: [>`pangorenderer] obj -> int -> int -> int -> int -> unit = "ml_pango_renderer_draw_error_underline"
  external deactivate: [>`pangorenderer] obj -> unit = "ml_pango_renderer_deactivate"
  external activate: [>`pangorenderer] obj -> unit = "ml_pango_renderer_activate"
  end
module Matrix = struct
  external translate: [>`pangomatrix] obj -> float -> float -> unit = "ml_pango_matrix_translate"
  external scale: [>`pangomatrix] obj -> float -> float -> unit = "ml_pango_matrix_scale"
  external rotate: [>`pangomatrix] obj -> float -> unit = "ml_pango_matrix_rotate"
  external get_font_scale_factor: [>`pangomatrix] obj -> float = "ml_pango_matrix_get_font_scale_factor"
  external free: [>`pangomatrix] obj -> unit = "ml_pango_matrix_free"
  external copy: [>`pangomatrix] obj -> [<`pangomatrix] obj = "ml_pango_matrix_copy"
  external concat: [>`pangomatrix] obj -> [>`pangomatrix] obj -> unit = "ml_pango_matrix_concat"
  end
module LayoutLine = struct
  external unref: [>`pangolayoutline] obj -> unit = "ml_pango_layout_line_unref"
  external ref_: [>`pangolayoutline] obj -> [<`pangolayoutline] obj = "ml_pango_layout_line_ref"
  end
module LayoutIter = struct
  external next_run: [>`pangolayoutiter] obj -> bool = "ml_pango_layout_iter_next_run"
  external next_line: [>`pangolayoutiter] obj -> bool = "ml_pango_layout_iter_next_line"
  external next_cluster: [>`pangolayoutiter] obj -> bool = "ml_pango_layout_iter_next_cluster"
  external next_char: [>`pangolayoutiter] obj -> bool = "ml_pango_layout_iter_next_char"
  external get_line_readonly: [>`pangolayoutiter] obj -> [<`pangolayoutline] obj = "ml_pango_layout_iter_get_line_readonly"
  external get_line: [>`pangolayoutiter] obj -> [<`pangolayoutline] obj = "ml_pango_layout_iter_get_line"
  external get_layout: [>`pangolayoutiter] obj -> [<`pangolayout] obj = "ml_pango_layout_iter_get_layout"
  external get_index: [>`pangolayoutiter] obj -> int = "ml_pango_layout_iter_get_index"
  external get_char_extents: [>`pangolayoutiter] obj -> [>`pangorectangle] obj -> unit = "ml_pango_layout_iter_get_char_extents"
  external get_baseline: [>`pangolayoutiter] obj -> int = "ml_pango_layout_iter_get_baseline"
  external free: [>`pangolayoutiter] obj -> unit = "ml_pango_layout_iter_free"
  external copy: [>`pangolayoutiter] obj -> [<`pangolayoutiter] obj = "ml_pango_layout_iter_copy"
  external at_last_line: [>`pangolayoutiter] obj -> bool = "ml_pango_layout_iter_at_last_line"
  end
module Layout = struct
  external set_width: [>`pangolayout] obj -> int -> unit = "ml_pango_layout_set_width"
  external set_text: [>`pangolayout] obj -> string -> int -> unit = "ml_pango_layout_set_text"
  external set_tabs: [>`pangolayout] obj -> [>`pangotabarray] obj option -> unit = "ml_pango_layout_set_tabs"
  external set_spacing: [>`pangolayout] obj -> int -> unit = "ml_pango_layout_set_spacing"
  external set_single_paragraph_mode: [>`pangolayout] obj -> bool -> unit = "ml_pango_layout_set_single_paragraph_mode"
  external set_markup: [>`pangolayout] obj -> string -> int -> unit = "ml_pango_layout_set_markup"
  external set_justify: [>`pangolayout] obj -> bool -> unit = "ml_pango_layout_set_justify"
  external set_indent: [>`pangolayout] obj -> int -> unit = "ml_pango_layout_set_indent"
  external set_height: [>`pangolayout] obj -> int -> unit = "ml_pango_layout_set_height"
  external set_font_description: [>`pangolayout] obj -> [>`pangofontdescription] obj option -> unit = "ml_pango_layout_set_font_description"
  external set_auto_dir: [>`pangolayout] obj -> bool -> unit = "ml_pango_layout_set_auto_dir"
  external is_wrapped: [>`pangolayout] obj -> bool = "ml_pango_layout_is_wrapped"
  external is_ellipsized: [>`pangolayout] obj -> bool = "ml_pango_layout_is_ellipsized"
  external get_width: [>`pangolayout] obj -> int = "ml_pango_layout_get_width"
  external get_unknown_glyphs_count: [>`pangolayout] obj -> int = "ml_pango_layout_get_unknown_glyphs_count"
  external get_text: [>`pangolayout] obj -> string = "ml_pango_layout_get_text"
  external get_tabs: [>`pangolayout] obj -> [<`pangotabarray] obj = "ml_pango_layout_get_tabs"
  external get_spacing: [>`pangolayout] obj -> int = "ml_pango_layout_get_spacing"
  external get_single_paragraph_mode: [>`pangolayout] obj -> bool = "ml_pango_layout_get_single_paragraph_mode"
  external get_lines_readonly: [>`pangolayout] obj -> [<`gslist] obj = "ml_pango_layout_get_lines_readonly"
  external get_lines: [>`pangolayout] obj -> [<`gslist] obj = "ml_pango_layout_get_lines"
  external get_line_readonly: [>`pangolayout] obj -> int -> [<`pangolayoutline] obj = "ml_pango_layout_get_line_readonly"
  external get_line_count: [>`pangolayout] obj -> int = "ml_pango_layout_get_line_count"
  external get_line: [>`pangolayout] obj -> int -> [<`pangolayoutline] obj = "ml_pango_layout_get_line"
  external get_justify: [>`pangolayout] obj -> bool = "ml_pango_layout_get_justify"
  external get_iter: [>`pangolayout] obj -> [<`pangolayoutiter] obj = "ml_pango_layout_get_iter"
  external get_indent: [>`pangolayout] obj -> int = "ml_pango_layout_get_indent"
  external get_height: [>`pangolayout] obj -> int = "ml_pango_layout_get_height"
  external get_font_description: [>`pangolayout] obj -> [<`pangofontdescription] obj = "ml_pango_layout_get_font_description"
  external get_context: [>`pangolayout] obj -> [<`pangocontext] obj = "ml_pango_layout_get_context"
  external get_character_count: [>`pangolayout] obj -> int = "ml_pango_layout_get_character_count"
  external get_baseline: [>`pangolayout] obj -> int = "ml_pango_layout_get_baseline"
  external get_auto_dir: [>`pangolayout] obj -> bool = "ml_pango_layout_get_auto_dir"
  external get_attributes: [>`pangolayout] obj -> [<`pangoattrlist] obj = "ml_pango_layout_get_attributes"
  external copy: [>`pangolayout] obj -> [<`pangolayout] obj = "ml_pango_layout_copy"
  external context_changed: [>`pangolayout] obj -> unit = "ml_pango_layout_context_changed"
  end
module Language = struct
  external to_string: [>`pangolanguage] obj -> string = "ml_pango_language_to_string"
  external matches: [>`pangolanguage] obj -> string -> bool = "ml_pango_language_matches"
  external get_sample_string: [>`pangolanguage] obj -> string = "ml_pango_language_get_sample_string"
  external get_default: unit -> [<`pangolanguage] obj = "ml_pango_language_get_default"
  external from_string: string option -> [<`pangolanguage] obj = "ml_pango_language_from_string"
  end
module Item = struct
  external split: [>`pangoitem] obj -> int -> int -> [<`pangoitem] obj = "ml_pango_item_split"
  external free: [>`pangoitem] obj -> unit = "ml_pango_item_free"
  external copy: [>`pangoitem] obj -> [<`pangoitem] obj = "ml_pango_item_copy"
  end
module GlyphString = struct
  external set_size: [>`pangoglyphstring] obj -> int -> unit = "ml_pango_glyph_string_set_size"
  external get_width: [>`pangoglyphstring] obj -> int = "ml_pango_glyph_string_get_width"
  external free: [>`pangoglyphstring] obj -> unit = "ml_pango_glyph_string_free"
  external extents_range: [>`pangoglyphstring] obj -> int -> int -> [>`pangofont] obj -> [>`pangorectangle] obj -> [>`pangorectangle] obj -> unit = "ml_pango_glyph_string_extents_range"
  external copy: [>`pangoglyphstring] obj -> [<`pangoglyphstring] obj = "ml_pango_glyph_string_copy"
  end
module GlyphItemIter = struct
  external prev_cluster: [>`pangoglyphitemiter] obj -> bool = "ml_pango_glyph_item_iter_prev_cluster"
  external next_cluster: [>`pangoglyphitemiter] obj -> bool = "ml_pango_glyph_item_iter_next_cluster"
  external init_start: [>`pangoglyphitemiter] obj -> [>`pangoglyphitem] obj -> string -> bool = "ml_pango_glyph_item_iter_init_start"
  external init_end: [>`pangoglyphitemiter] obj -> [>`pangoglyphitem] obj -> string -> bool = "ml_pango_glyph_item_iter_init_end"
  external free: [>`pangoglyphitemiter] obj -> unit = "ml_pango_glyph_item_iter_free"
  external copy: [>`pangoglyphitemiter] obj -> [<`pangoglyphitemiter] obj = "ml_pango_glyph_item_iter_copy"
  end
module GlyphItem = struct
  external split: [>`pangoglyphitem] obj -> string -> int -> [<`pangoglyphitem] obj = "ml_pango_glyph_item_split"
  external letter_space: [>`pangoglyphitem] obj -> string -> [>`pangologattr] obj -> int -> unit = "ml_pango_glyph_item_letter_space"
  external free: [>`pangoglyphitem] obj -> unit = "ml_pango_glyph_item_free"
  external copy: [>`pangoglyphitem] obj -> [<`pangoglyphitem] obj = "ml_pango_glyph_item_copy"
  external apply_attrs: [>`pangoglyphitem] obj -> string -> [>`pangoattrlist] obj -> [<`gslist] obj = "ml_pango_glyph_item_apply_attrs"
  end
module Fontset = struct
  external get_metrics: [>`pangofontset] obj -> [<`pangofontmetrics] obj = "ml_pango_fontset_get_metrics"
  external get_font: [>`pangofontset] obj -> int -> [<`pangofont] obj = "ml_pango_fontset_get_font"
  end
module FontMetrics = struct
  external unref: [>`pangofontmetrics] obj -> unit = "ml_pango_font_metrics_unref"
  external ref_: [>`pangofontmetrics] obj -> [<`pangofontmetrics] obj = "ml_pango_font_metrics_ref"
  external get_underline_thickness: [>`pangofontmetrics] obj -> int = "ml_pango_font_metrics_get_underline_thickness"
  external get_underline_position: [>`pangofontmetrics] obj -> int = "ml_pango_font_metrics_get_underline_position"
  external get_strikethrough_thickness: [>`pangofontmetrics] obj -> int = "ml_pango_font_metrics_get_strikethrough_thickness"
  external get_strikethrough_position: [>`pangofontmetrics] obj -> int = "ml_pango_font_metrics_get_strikethrough_position"
  external get_descent: [>`pangofontmetrics] obj -> int = "ml_pango_font_metrics_get_descent"
  external get_ascent: [>`pangofontmetrics] obj -> int = "ml_pango_font_metrics_get_ascent"
  external get_approximate_digit_width: [>`pangofontmetrics] obj -> int = "ml_pango_font_metrics_get_approximate_digit_width"
  external get_approximate_char_width: [>`pangofontmetrics] obj -> int = "ml_pango_font_metrics_get_approximate_char_width"
  end
module FontMap = struct
  external load_fontset: [>`pangofontmap] obj -> [>`pangocontext] obj -> [>`pangofontdescription] obj -> [>`pangolanguage] obj -> [<`pangofontset] obj = "ml_pango_font_map_load_fontset"
  external load_font: [>`pangofontmap] obj -> [>`pangocontext] obj -> [>`pangofontdescription] obj -> [<`pangofont] obj = "ml_pango_font_map_load_font"
  external create_context: [>`pangofontmap] obj -> [<`pangocontext] obj = "ml_pango_font_map_create_context"
  end
module FontFamily = struct
  external is_monospace: [>`pangofontfamily] obj -> bool = "ml_pango_font_family_is_monospace"
  external get_name: [>`pangofontfamily] obj -> string = "ml_pango_font_family_get_name"
  end
module FontFace = struct
  external is_synthesized: [>`pangofontface] obj -> bool = "ml_pango_font_face_is_synthesized"
  external get_face_name: [>`pangofontface] obj -> string = "ml_pango_font_face_get_face_name"
  external describe: [>`pangofontface] obj -> [<`pangofontdescription] obj = "ml_pango_font_face_describe"
  end
module FontDescription = struct
  external to_string: [>`pangofontdescription] obj -> string = "ml_pango_font_description_to_string"
  external to_filename: [>`pangofontdescription] obj -> string = "ml_pango_font_description_to_filename"
  external set_size: [>`pangofontdescription] obj -> int -> unit = "ml_pango_font_description_set_size"
  external set_family_static: [>`pangofontdescription] obj -> string -> unit = "ml_pango_font_description_set_family_static"
  external set_family: [>`pangofontdescription] obj -> string -> unit = "ml_pango_font_description_set_family"
  external set_absolute_size: [>`pangofontdescription] obj -> float -> unit = "ml_pango_font_description_set_absolute_size"
  external merge_static: [>`pangofontdescription] obj -> [>`pangofontdescription] obj -> bool -> unit = "ml_pango_font_description_merge_static"
  external merge: [>`pangofontdescription] obj -> [>`pangofontdescription] obj option -> bool -> unit = "ml_pango_font_description_merge"
  external hash: [>`pangofontdescription] obj -> int = "ml_pango_font_description_hash"
  external get_size_is_absolute: [>`pangofontdescription] obj -> bool = "ml_pango_font_description_get_size_is_absolute"
  external get_size: [>`pangofontdescription] obj -> int = "ml_pango_font_description_get_size"
  external get_family: [>`pangofontdescription] obj -> string = "ml_pango_font_description_get_family"
  external free: [>`pangofontdescription] obj -> unit = "ml_pango_font_description_free"
  external equal: [>`pangofontdescription] obj -> [>`pangofontdescription] obj -> bool = "ml_pango_font_description_equal"
  external copy_static: [>`pangofontdescription] obj -> [<`pangofontdescription] obj = "ml_pango_font_description_copy_static"
  external copy: [>`pangofontdescription] obj -> [<`pangofontdescription] obj = "ml_pango_font_description_copy"
  external better_match: [>`pangofontdescription] obj -> [>`pangofontdescription] obj option -> [>`pangofontdescription] obj -> bool = "ml_pango_font_description_better_match"
  external from_string: string -> [<`pangofontdescription] obj = "ml_pango_font_description_from_string"
  end
module Font = struct
  external get_metrics: [>`pangofont] obj -> [>`pangolanguage] obj option -> [<`pangofontmetrics] obj = "ml_pango_font_get_metrics"
  external get_font_map: [>`pangofont] obj -> [<`pangofontmap] obj = "ml_pango_font_get_font_map"
  external get_coverage: [>`pangofont] obj -> [>`pangolanguage] obj -> [<`pangocoverage] obj = "ml_pango_font_get_coverage"
  external find_shaper: [>`pangofont] obj -> [>`pangolanguage] obj -> int32 -> [<`pangoengineshape] obj = "ml_pango_font_find_shaper"
  external describe_with_absolute_size: [>`pangofont] obj -> [<`pangofontdescription] obj = "ml_pango_font_describe_with_absolute_size"
  external describe: [>`pangofont] obj -> [<`pangofontdescription] obj = "ml_pango_font_describe"
  end
module Coverage = struct
  external unref: [>`pangocoverage] obj -> unit = "ml_pango_coverage_unref"
  external ref_: [>`pangocoverage] obj -> [<`pangocoverage] obj = "ml_pango_coverage_ref"
  external max: [>`pangocoverage] obj -> [>`pangocoverage] obj -> unit = "ml_pango_coverage_max"
  external copy: [>`pangocoverage] obj -> [<`pangocoverage] obj = "ml_pango_coverage_copy"
  external new: unit -> [<`pangocoverage] obj = "ml_pango_coverage_new"
  external from_bytes: string -> int -> [<`pangocoverage] obj = "ml_pango_coverage_from_bytes"
  end
module Context = struct
  external set_matrix: [>`pangocontext] obj -> [>`pangomatrix] obj option -> unit = "ml_pango_context_set_matrix"
  external set_language: [>`pangocontext] obj -> [>`pangolanguage] obj -> unit = "ml_pango_context_set_language"
  external set_font_map: [>`pangocontext] obj -> [>`pangofontmap] obj -> unit = "ml_pango_context_set_font_map"
  external set_font_description: [>`pangocontext] obj -> [>`pangofontdescription] obj -> unit = "ml_pango_context_set_font_description"
  external load_fontset: [>`pangocontext] obj -> [>`pangofontdescription] obj -> [>`pangolanguage] obj -> [<`pangofontset] obj = "ml_pango_context_load_fontset"
  external load_font: [>`pangocontext] obj -> [>`pangofontdescription] obj -> [<`pangofont] obj = "ml_pango_context_load_font"
  external get_metrics: [>`pangocontext] obj -> [>`pangofontdescription] obj option -> [>`pangolanguage] obj option -> [<`pangofontmetrics] obj = "ml_pango_context_get_metrics"
  external get_matrix: [>`pangocontext] obj -> [<`pangomatrix] obj = "ml_pango_context_get_matrix"
  external get_language: [>`pangocontext] obj -> [<`pangolanguage] obj = "ml_pango_context_get_language"
  external get_font_map: [>`pangocontext] obj -> [<`pangofontmap] obj = "ml_pango_context_get_font_map"
  external get_font_description: [>`pangocontext] obj -> [<`pangofontdescription] obj = "ml_pango_context_get_font_description"
  end
module Color = struct
  external to_string: [>`pangocolor] obj -> string = "ml_pango_color_to_string"
  external parse: [>`pangocolor] obj -> string -> bool = "ml_pango_color_parse"
  external free: [>`pangocolor] obj -> unit = "ml_pango_color_free"
  external copy: [>`pangocolor] obj -> [<`pangocolor] obj = "ml_pango_color_copy"
  end
module Attribute = struct
  external init: [>`pangoattribute] obj -> [>`pangoattrclass] obj -> unit = "ml_pango_attribute_init"
  external equal: [>`pangoattribute] obj -> [>`pangoattribute] obj -> bool = "ml_pango_attribute_equal"
  external destroy: [>`pangoattribute] obj -> unit = "ml_pango_attribute_destroy"
  external copy: [>`pangoattribute] obj -> [<`pangoattribute] obj = "ml_pango_attribute_copy"
  end
module AttrSize = struct
  external new_absolute: int -> [<`pangoattribute] obj = "ml_pango_attr_size_new_absolute"
  external new: int -> [<`pangoattribute] obj = "ml_pango_attr_size_new"
  end
module AttrShape = struct
  external new: [>`pangorectangle] obj -> [>`pangorectangle] obj -> [<`pangoattribute] obj = "ml_pango_attr_shape_new"
  end
module AttrList = struct
  external unref: [>`pangoattrlist] obj -> unit = "ml_pango_attr_list_unref"
  external splice: [>`pangoattrlist] obj -> [>`pangoattrlist] obj -> int -> int -> unit = "ml_pango_attr_list_splice"
  external ref_: [>`pangoattrlist] obj -> [<`pangoattrlist] obj = "ml_pango_attr_list_ref"
  external insert_before: [>`pangoattrlist] obj -> [>`pangoattribute] obj -> unit = "ml_pango_attr_list_insert_before"
  external insert: [>`pangoattrlist] obj -> [>`pangoattribute] obj -> unit = "ml_pango_attr_list_insert"
  external get_iterator: [>`pangoattrlist] obj -> [<`pangoattriterator] obj = "ml_pango_attr_list_get_iterator"
  external copy: [>`pangoattrlist] obj -> [<`pangoattrlist] obj = "ml_pango_attr_list_copy"
  external change: [>`pangoattrlist] obj -> [>`pangoattribute] obj -> unit = "ml_pango_attr_list_change"
  end
module AttrLanguage = struct
  external new: [>`pangolanguage] obj -> [<`pangoattribute] obj = "ml_pango_attr_language_new"
  end
module AttrIterator = struct
  external next: [>`pangoattriterator] obj -> bool = "ml_pango_attr_iterator_next"
  external get_attrs: [>`pangoattriterator] obj -> [<`gslist] obj = "ml_pango_attr_iterator_get_attrs"
  external destroy: [>`pangoattriterator] obj -> unit = "ml_pango_attr_iterator_destroy"
  external copy: [>`pangoattriterator] obj -> [<`pangoattriterator] obj = "ml_pango_attr_iterator_copy"
  end
module AttrFontDesc = struct
  external new: [>`pangofontdescription] obj -> [<`pangoattribute] obj = "ml_pango_attr_font_desc_new"
  end
(* Global functions *)
external version_string: unit -> string = "ml_pango_version_string"
external version_check: int -> int -> int -> string = "ml_pango_version_check"
external version: unit -> int = "ml_pango_version"
external units_to_double: int -> float = "ml_pango_units_to_double"
external units_from_double: float -> int = "ml_pango_units_from_double"
external trim_string: string -> string = "ml_pango_trim_string"
external shape: string -> int -> [>`pangoanalysis] obj -> [>`pangoglyphstring] obj -> unit = "ml_pango_shape"
external reorder_items: [>`glist] obj -> [<`glist] obj = "ml_pango_reorder_items"
external itemize: [>`pangocontext] obj -> string -> int -> int -> [>`pangoattrlist] obj -> [>`pangoattriterator] obj option -> [<`glist] obj = "ml_pango_itemize"
external is_zero_width: int32 -> bool = "ml_pango_is_zero_width"
external get_log_attrs: string -> int -> int -> [>`pangolanguage] obj -> [>`pangologattr] obj -> int -> unit = "ml_pango_get_log_attrs"
external extents_to_pixels: [>`pangorectangle] obj option -> [>`pangorectangle] obj option -> unit = "ml_pango_extents_to_pixels"
external break: string -> int -> [>`pangoanalysis] obj -> [>`pangologattr] obj -> int -> unit = "ml_pango_break"
external attr_underline_color_new: int -> int -> int -> [<`pangoattribute] obj = "ml_pango_attr_underline_color_new"
external attr_strikethrough_new: bool -> [<`pangoattribute] obj = "ml_pango_attr_strikethrough_new"
external attr_strikethrough_color_new: int -> int -> int -> [<`pangoattribute] obj = "ml_pango_attr_strikethrough_color_new"
external attr_scale_new: float -> [<`pangoattribute] obj = "ml_pango_attr_scale_new"
external attr_rise_new: int -> [<`pangoattribute] obj = "ml_pango_attr_rise_new"
external attr_letter_spacing_new: int -> [<`pangoattribute] obj = "ml_pango_attr_letter_spacing_new"
external attr_foreground_new: int -> int -> int -> [<`pangoattribute] obj = "ml_pango_attr_foreground_new"
external attr_family_new: string -> [<`pangoattribute] obj = "ml_pango_attr_family_new"
external attr_fallback_new: bool -> [<`pangoattribute] obj = "ml_pango_attr_fallback_new"
external attr_background_new: int -> int -> int -> [<`pangoattribute] obj = "ml_pango_attr_background_new"
(* End of global functions *)

