module C = Configurator.V1

(* XXX: Use `die` *)
let error str =
  Format.eprintf "configure error: %s.@\n%!" str;
  exit 1

let require_opt ~message v =
  match v with
  | None ->
    error message
  | Some v ->
    v

let query_pkg p ~package =
  require_opt ~message:(package ^ " not found") C.Pkg_config.(query p ~package)

let gen_pkg p ~package =
  let c_g = query_pkg p ~package in
  C.Flags.write_sexp ("cflag-" ^ package ^ ".sexp") c_g.C.Pkg_config.cflags;
  C.Flags.write_sexp ("clink-" ^ package ^ ".sexp") c_g.C.Pkg_config.libs

let pkg = ref ""

let main t =
  let p = require_opt ~message:"pkg_config not installed" C.Pkg_config.(get t) in
  gen_pkg p ~package:!pkg

let _ =
  let args = ["-pkg", Arg.String (fun s -> pkg := s), "package"] in
  C.main ~args ~name:"lablgtk2" main
