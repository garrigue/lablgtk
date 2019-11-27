module C = Configurator.V1

(* XXX: Use `die` *)
let error str =
  Format.eprintf "configure error: %s@\n%!" str;
  exit 1

module Option = struct
  let require ~message = function
    | None   -> error message
    | Some v -> v

  let cata ~f d = function
    | None -> d
    | Some x -> f x
end

(* This is a hack to detect gtk+-quartz *)
let platform_subst p ~package =
  match package with
  | "gtk+-3.0" ->
    (match C.Pkg_config.query p ~package:"gtk+-quartz-3.0" with
     | Some _ -> "gtk+-quartz-3.0", ["-DHAS_GTKQUARTZ"]
     | None -> package, [])
  | _ ->
    package, []

let query_pkg p ~package ~expr =
  match C.Pkg_config.query_expr_err p ~package ~expr with
  | Ok s -> s
  | Error e -> error e

let gen_pkg p ~package ~version =
  let file kind = kind ^ "-" ^ package ^ ".sexp" in
  let package, extra_flags = platform_subst p ~package in
  let expr =
    Option.cata ~f:(fun version -> Format.sprintf "%s >= %s" package version) "" version in
  let c_g = query_pkg p ~package ~expr in
  C.Flags.write_sexp (file "cflag") @@ c_g.C.Pkg_config.cflags @ extra_flags;
  C.Flags.write_sexp (file "clink") c_g.C.Pkg_config.libs

let pkg = ref ""
let version = ref None

let main t =
  let p = Option.require ~message:"pkg_config not installed" C.Pkg_config.(get t) in
  gen_pkg p ~package:!pkg ~version:!version

let _ =
  let args = [ "-pkg", Arg.String (fun s -> pkg := s), "package"
             ; "-version", Arg.String (fun v -> version := Some v), "version" ] in
  C.main ~args ~name:"lablgtk3" main
