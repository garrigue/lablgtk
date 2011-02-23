type -'a obj

module ValueArray = struct
  external remove: [>`gvaluearray] obj -> int -> [<`gvaluearray] obj = "ml_g_value_array_remove"
  external prepend: [>`gvaluearray] obj -> [>`gvalue] obj option -> [<`gvaluearray] obj = "ml_g_value_array_prepend"
  external insert: [>`gvaluearray] obj -> int -> [>`gvalue] obj option -> [<`gvaluearray] obj = "ml_g_value_array_insert"
  external get_nth: [>`gvaluearray] obj -> int -> [<`gvalue] obj = "ml_g_value_array_get_nth"
  external free: [>`gvaluearray] obj -> unit = "ml_g_value_array_free"
  external copy: [>`gvaluearray] obj -> [<`gvaluearray] obj = "ml_g_value_array_copy"
  external append: [>`gvaluearray] obj -> [>`gvalue] obj option -> [<`gvaluearray] obj = "ml_g_value_array_append"
  end
module Value = struct
  external unset: [>`gvalue] obj -> unit = "ml_g_value_unset"
  external transform: [>`gvalue] obj -> [>`gvalue] obj -> bool = "ml_g_value_transform"
  external take_variant: [>`gvalue] obj -> [>`gvariant] obj -> unit = "ml_g_value_take_variant"
  external take_string: [>`gvalue] obj -> string -> unit = "ml_g_value_take_string"
  external take_param: [>`gvalue] obj -> [>`gparamspec] obj -> unit = "ml_g_value_take_param"
  external set_variant: [>`gvalue] obj -> [>`gvariant] obj -> unit = "ml_g_value_set_variant"
  external set_ulong: [>`gvalue] obj -> float -> unit = "ml_g_value_set_ulong"
  external set_uint64: [>`gvalue] obj -> int64 -> unit = "ml_g_value_set_uint64"
  external set_uint: [>`gvalue] obj -> int -> unit = "ml_g_value_set_uint"
  external set_uchar: [>`gvalue] obj -> int -> unit = "ml_g_value_set_uchar"
  external set_string_take_ownership: [>`gvalue] obj -> string -> unit = "ml_g_value_set_string_take_ownership"
  external set_string: [>`gvalue] obj -> string -> unit = "ml_g_value_set_string"
  external set_static_string: [>`gvalue] obj -> string -> unit = "ml_g_value_set_static_string"
  external set_param_take_ownership: [>`gvalue] obj -> [>`gparamspec] obj -> unit = "ml_g_value_set_param_take_ownership"
  external set_param: [>`gvalue] obj -> [>`gparamspec] obj -> unit = "ml_g_value_set_param"
  external set_long: [>`gvalue] obj -> float -> unit = "ml_g_value_set_long"
  external set_int64: [>`gvalue] obj -> int64 -> unit = "ml_g_value_set_int64"
  external set_int: [>`gvalue] obj -> int -> unit = "ml_g_value_set_int"
  external set_gtype: [>`gvalue] obj -> int -> unit = "ml_g_value_set_gtype"
  external set_flags: [>`gvalue] obj -> int -> unit = "ml_g_value_set_flags"
  external set_enum: [>`gvalue] obj -> int -> unit = "ml_g_value_set_enum"
  external set_double: [>`gvalue] obj -> float -> unit = "ml_g_value_set_double"
  external set_char: [>`gvalue] obj -> int -> unit = "ml_g_value_set_char"
  external set_boolean: [>`gvalue] obj -> bool -> unit = "ml_g_value_set_boolean"
  external reset: [>`gvalue] obj -> [<`gvalue] obj = "ml_g_value_reset"
  external init: [>`gvalue] obj -> int -> [<`gvalue] obj = "ml_g_value_init"
  external get_variant: [>`gvalue] obj -> [<`gvariant] obj = "ml_g_value_get_variant"
  external get_ulong: [>`gvalue] obj -> float = "ml_g_value_get_ulong"
  external get_uint64: [>`gvalue] obj -> int64 = "ml_g_value_get_uint64"
  external get_uint: [>`gvalue] obj -> int = "ml_g_value_get_uint"
  external get_uchar: [>`gvalue] obj -> int = "ml_g_value_get_uchar"
  external get_string: [>`gvalue] obj -> string = "ml_g_value_get_string"
  external get_param: [>`gvalue] obj -> [<`gparamspec] obj = "ml_g_value_get_param"
  external get_long: [>`gvalue] obj -> float = "ml_g_value_get_long"
  external get_int64: [>`gvalue] obj -> int64 = "ml_g_value_get_int64"
  external get_int: [>`gvalue] obj -> int = "ml_g_value_get_int"
  external get_gtype: [>`gvalue] obj -> int = "ml_g_value_get_gtype"
  external get_flags: [>`gvalue] obj -> int = "ml_g_value_get_flags"
  external get_enum: [>`gvalue] obj -> int = "ml_g_value_get_enum"
  external get_double: [>`gvalue] obj -> float = "ml_g_value_get_double"
  external get_char: [>`gvalue] obj -> int = "ml_g_value_get_char"
  external get_boolean: [>`gvalue] obj -> bool = "ml_g_value_get_boolean"
  external fits_pointer: [>`gvalue] obj -> bool = "ml_g_value_fits_pointer"
  external dup_variant: [>`gvalue] obj -> [<`gvariant] obj = "ml_g_value_dup_variant"
  external dup_string: [>`gvalue] obj -> string = "ml_g_value_dup_string"
  external dup_param: [>`gvalue] obj -> [<`gparamspec] obj = "ml_g_value_dup_param"
  external copy: [>`gvalue] obj -> [>`gvalue] obj -> unit = "ml_g_value_copy"
  end
module TypeValueTable = struct
  end
module TypeQuery = struct
  end
module TypePluginClass = struct
  end
module TypeModuleClass = struct
  end
module TypeModule = struct
  external use: [>`gtypemodule] obj -> bool = "ml_g_type_module_use"
  external unuse: [>`gtypemodule] obj -> unit = "ml_g_type_module_unuse"
  external set_name: [>`gtypemodule] obj -> string -> unit = "ml_g_type_module_set_name"
  external register_flags: [>`gtypemodule] obj -> string -> [>`gflagsvalue] obj -> int = "ml_g_type_module_register_flags"
  external register_enum: [>`gtypemodule] obj -> string -> [>`genumvalue] obj -> int = "ml_g_type_module_register_enum"
  external add_interface: [>`gtypemodule] obj -> int -> int -> [>`ginterfaceinfo] obj -> unit = "ml_g_type_module_add_interface"
  end
module TypeInterface = struct
  end
module TypeInstance = struct
  end
module TypeInfo = struct
  end
module TypeFundamentalInfo = struct
  end
module TypeClass = struct
  external unref_uncached: [>`gtypeclass] obj -> unit = "ml_g_type_class_unref_uncached"
  external unref: [>`gtypeclass] obj -> unit = "ml_g_type_class_unref"
  end
module SignalQuery = struct
  end
module SignalInvocationHint = struct
  end
module Parameter = struct
  end
module ParamSpecVariant = struct
  end
module ParamSpecValueArray = struct
  end
module ParamSpecUnichar = struct
  end
module ParamSpecULong = struct
  end
module ParamSpecUInt64 = struct
  end
module ParamSpecUInt = struct
  end
module ParamSpecUChar = struct
  end
module ParamSpecTypeInfo = struct
  end
module ParamSpecString = struct
  end
module ParamSpecPool = struct
  external remove: [>`gparamspecpool] obj -> [>`gparamspec] obj -> unit = "ml_g_param_spec_pool_remove"
  external lookup: [>`gparamspecpool] obj -> string -> int -> bool -> [<`gparamspec] obj = "ml_g_param_spec_pool_lookup"
  external list_owned: [>`gparamspecpool] obj -> int -> [<`glist] obj = "ml_g_param_spec_pool_list_owned"
  external insert: [>`gparamspecpool] obj -> [>`gparamspec] obj -> int -> unit = "ml_g_param_spec_pool_insert"
  end
module ParamSpecPointer = struct
  end
module ParamSpecParam = struct
  end
module ParamSpecOverride = struct
  end
module ParamSpecObject = struct
  end
module ParamSpecLong = struct
  end
module ParamSpecInt64 = struct
  end
module ParamSpecInt = struct
  end
module ParamSpecGType = struct
  end
module ParamSpecFloat = struct
  end
module ParamSpecFlags = struct
  end
module ParamSpecEnum = struct
  end
module ParamSpecDouble = struct
  end
module ParamSpecClass = struct
  end
module ParamSpecChar = struct
  end
module ParamSpecBoxed = struct
  end
module ParamSpecBoolean = struct
  end
module ParamSpec = struct
  external unref: [>`gparamspec] obj -> unit = "ml_g_param_spec_unref"
  external sink: [>`gparamspec] obj -> unit = "ml_g_param_spec_sink"
  external ref_sink: [>`gparamspec] obj -> [<`gparamspec] obj = "ml_g_param_spec_ref_sink"
  external ref: [>`gparamspec] obj -> [<`gparamspec] obj = "ml_g_param_spec_ref"
  external get_redirect_target: [>`gparamspec] obj -> [<`gparamspec] obj = "ml_g_param_spec_get_redirect_target"
  external get_nick: [>`gparamspec] obj -> string = "ml_g_param_spec_get_nick"
  external get_name: [>`gparamspec] obj -> string = "ml_g_param_spec_get_name"
  external get_blurb: [>`gparamspec] obj -> string = "ml_g_param_spec_get_blurb"
  end
module ObjectConstructParam = struct
  end
module ObjectClass = struct
  external override_property: [>`gobjectclass] obj -> int -> string -> unit = "ml_g_object_class_override_property"
  external install_property: [>`gobjectclass] obj -> int -> [>`gparamspec] obj -> unit = "ml_g_object_class_install_property"
  external find_property: [>`gobjectclass] obj -> string -> [<`gparamspec] obj = "ml_g_object_class_find_property"
  end
module Object = struct
  end
module InterfaceInfo = struct
  end
module InitiallyUnownedClass = struct
  end
module InitiallyUnowned = struct
  external type_init: unit -> unit = "ml_g_object_type_init"
  end
module FlagsValue = struct
  end
module FlagsClass = struct
  end
module EnumValue = struct
  end
module EnumClass = struct
  end
module ClosureNotifyData = struct
  end
module Closure = struct
  external unref: [>`gclosure] obj -> unit = "ml_g_closure_unref"
  external sink: [>`gclosure] obj -> unit = "ml_g_closure_sink"
  external ref: [>`gclosure] obj -> [<`gclosure] obj = "ml_g_closure_ref"
  external invalidate: [>`gclosure] obj -> unit = "ml_g_closure_invalidate"
  end
module CClosure = struct
  end
module Binding = struct
  external get_target_property: [>`gbinding] obj -> string = "ml_g_binding_get_target_property"
  external get_source_property: [>`gbinding] obj -> string = "ml_g_binding_get_source_property"
  end
(* Global functions *)
external variant_type_get_gtype: unit -> int = "ml_g_variant_type_get_gtype"
external variant_get_gtype: unit -> int = "ml_g_variant_get_gtype"
external value_types_init: unit -> unit = "ml_g_value_types_init"
external value_type_transformable: int -> int -> bool = "ml_g_value_type_transformable"
external value_type_compatible: int -> int -> bool = "ml_g_value_type_compatible"
external value_transforms_init: unit -> unit = "ml_g_value_transforms_init"
external value_c_init: unit -> unit = "ml_g_value_c_init"
external type_value_table_peek: int -> [<`gtypevaluetable] obj = "ml_g_type_value_table_peek"
external type_test_flags: int -> int -> bool = "ml_g_type_test_flags"
external type_qname: int -> int32 = "ml_g_type_qname"
external type_parent: int -> int = "ml_g_type_parent"
external type_next_base: int -> int -> int = "ml_g_type_next_base"
external type_name_from_instance: [>`gtypeinstance] obj -> string = "ml_g_type_name_from_instance"
external type_name_from_class: [>`gtypeclass] obj -> string = "ml_g_type_name_from_class"
external type_name: int -> string = "ml_g_type_name"
external type_is_a: int -> int -> bool = "ml_g_type_is_a"
external type_interface_add_prerequisite: int -> int -> unit = "ml_g_type_interface_add_prerequisite"
external type_init: unit -> unit = "ml_g_type_init"
external type_fundamental_next: unit -> int = "ml_g_type_fundamental_next"
external type_fundamental: int -> int = "ml_g_type_fundamental"
external type_from_name: string -> int = "ml_g_type_from_name"
external type_free_instance: [>`gtypeinstance] obj -> unit = "ml_g_type_free_instance"
external type_depth: int -> int = "ml_g_type_depth"
external type_create_instance: int -> [<`gtypeinstance] obj = "ml_g_type_create_instance"
external type_check_value_holds: [>`gvalue] obj -> int -> bool = "ml_g_type_check_value_holds"
external type_check_value: [>`gvalue] obj -> bool = "ml_g_type_check_value"
external type_check_is_value_type: int -> bool = "ml_g_type_check_is_value_type"
external type_check_instance_is_a: [>`gtypeinstance] obj -> int -> bool = "ml_g_type_check_instance_is_a"
external type_check_instance_cast: [>`gtypeinstance] obj -> int -> [<`gtypeinstance] obj = "ml_g_type_check_instance_cast"
external type_check_instance: [>`gtypeinstance] obj -> bool = "ml_g_type_check_instance"
external type_check_class_is_a: [>`gtypeclass] obj -> int -> bool = "ml_g_type_check_class_is_a"
external type_check_class_cast: [>`gtypeclass] obj -> int -> [<`gtypeclass] obj = "ml_g_type_check_class_cast"
external type_add_interface_static: int -> int -> [>`ginterfaceinfo] obj -> unit = "ml_g_type_add_interface_static"
external type_add_class_private: int -> int -> unit = "ml_g_type_add_class_private"
external strv_get_type: unit -> int = "ml_g_strv_get_type"
external strdup_value_contents: [>`gvalue] obj -> string = "ml_g_strdup_value_contents"
external source_set_dummy_callback: [>`gsource] obj -> unit = "ml_g_source_set_dummy_callback"
external source_set_closure: [>`gsource] obj -> [>`gclosure] obj -> unit = "ml_g_source_set_closure"
external signal_type_cclosure_new: int -> int -> [<`gclosure] obj = "ml_g_signal_type_cclosure_new"
external signal_remove_emission_hook: int -> float -> unit = "ml_g_signal_remove_emission_hook"
external signal_query: int -> [>`gsignalquery] obj -> unit = "ml_g_signal_query"
external signal_override_class_closure: int -> int -> [>`gclosure] obj -> unit = "ml_g_signal_override_class_closure"
external signal_name: int -> string = "ml_g_signal_name"
external signal_lookup: string -> int -> int = "ml_g_signal_lookup"
external signal_init: unit -> unit = "ml_g_signal_init"
external signal_emitv: [>`gvalue] obj -> int -> int32 -> [>`gvalue] obj -> unit = "ml_g_signal_emitv"
external signal_chain_from_overridden: [>`gvalue] obj -> [>`gvalue] obj -> unit = "ml_g_signal_chain_from_overridden"
external pointer_type_register_static: string -> int = "ml_g_pointer_type_register_static"
external param_values_cmp: [>`gparamspec] obj -> [>`gvalue] obj -> [>`gvalue] obj -> int = "ml_g_param_values_cmp"
external param_value_validate: [>`gparamspec] obj -> [>`gvalue] obj -> bool = "ml_g_param_value_validate"
external param_value_set_default: [>`gparamspec] obj -> [>`gvalue] obj -> unit = "ml_g_param_value_set_default"
external param_value_defaults: [>`gparamspec] obj -> [>`gvalue] obj -> bool = "ml_g_param_value_defaults"
external param_value_convert: [>`gparamspec] obj -> [>`gvalue] obj -> [>`gvalue] obj -> bool -> bool = "ml_g_param_value_convert"
external param_type_register_static: string -> [>`gparamspectypeinfo] obj -> int = "ml_g_param_type_register_static"
external param_type_init: unit -> unit = "ml_g_param_type_init"
external param_spec_types_init: unit -> unit = "ml_g_param_spec_types_init"
external param_spec_pool_new: bool -> [<`gparamspecpool] obj = "ml_g_param_spec_pool_new"
external param_spec_override: string -> [>`gparamspec] obj -> [<`gparamspec] obj = "ml_g_param_spec_override"
external object_get_type: unit -> int = "ml_g_object_get_type"
external gtype_get_type: unit -> int = "ml_g_gtype_get_type"
external flags_register_static: string -> [>`gflagsvalue] obj -> int = "ml_g_flags_register_static"
external flags_get_value_by_nick: [>`gflagsclass] obj -> string -> [<`gflagsvalue] obj = "ml_g_flags_get_value_by_nick"
external flags_get_value_by_name: [>`gflagsclass] obj -> string -> [<`gflagsvalue] obj = "ml_g_flags_get_value_by_name"
external flags_get_first_value: [>`gflagsclass] obj -> int -> [<`gflagsvalue] obj = "ml_g_flags_get_first_value"
external flags_complete_type_info: int -> [>`gtypeinfo] obj -> [>`gflagsvalue] obj -> unit = "ml_g_flags_complete_type_info"
external enum_types_init: unit -> unit = "ml_g_enum_types_init"
external enum_register_static: string -> [>`genumvalue] obj -> int = "ml_g_enum_register_static"
external enum_get_value_by_nick: [>`genumclass] obj -> string -> [<`genumvalue] obj = "ml_g_enum_get_value_by_nick"
external enum_get_value_by_name: [>`genumclass] obj -> string -> [<`genumvalue] obj = "ml_g_enum_get_value_by_name"
external enum_get_value: [>`genumclass] obj -> int -> [<`genumvalue] obj = "ml_g_enum_get_value"
external enum_complete_type_info: int -> [>`gtypeinfo] obj -> [>`genumvalue] obj -> unit = "ml_g_enum_complete_type_info"
external boxed_type_init: unit -> unit = "ml_g_boxed_type_init"
(* End of global functions *)

