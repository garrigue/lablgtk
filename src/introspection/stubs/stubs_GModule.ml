type -'a obj

module Module = struct
  external name: [>`gmodule] obj -> string = "ml_g_module_name"
  external make_resident: [>`gmodule] obj -> unit = "ml_g_module_make_resident"
  external close: [>`gmodule] obj -> bool = "ml_g_module_close"
  end
(* Global functions *)
external module_supported: unit -> bool = "ml_g_module_supported"
external module_error: unit -> string = "ml_g_module_error"
external module_build_path: string -> string -> string = "ml_g_module_build_path"
(* End of global functions *)

