(* $Id$ *)

val top_widgets : GWindow.window list ref

type module_widgets =
    { mw_frame: GPack.box;
      mw_title: GMisc.label option;
      mw_buttons: GPack.box; }

val add_shown_module : Path.t -> widgets:module_widgets -> unit
val find_shown_module : Path.t -> module_widgets
val is_shown_module : Path.t -> bool
val default_frame : module_widgets option ref
val set_path : (Path.t -> sign:Types.signature -> unit) ref

val view_defined_ref : (Longident.t -> env:Env.t -> unit) ref
val editor_ref :
    (?file:string -> ?pos:int -> ?opendialog:bool -> unit -> unit) ref

val view_signature :
  ?title:string ->
  ?path:Path.t -> ?env:Env.t -> ?detach:bool -> Types.signature -> unit
val view_signature_item :
  Types.signature -> path:Path.t -> env:Env.t -> unit
val view_module_id : Longident.t -> env:Env.t -> unit
val view_type_id : Longident.t -> env:Env.t -> unit
val view_class_id : Longident.t -> env:Env.t -> unit
val view_cltype_id : Longident.t -> env:Env.t -> unit
val view_modtype_id : Longident.t -> env:Env.t -> unit
val view_type_decl : Path.t -> env:Env.t -> unit

type skind = [`Type|`Class|`Module|`Modtype]
val search_pos_signature :
    Parsetree.signature -> pos:int -> env:Env.t ->
    ((skind * Longident.t) * Env.t * Location.t) list
val view_decl : Longident.t -> kind:skind -> env:Env.t -> unit
val view_decl_menu :
    Longident.t -> kind:skind -> env:Env.t -> GMenu.menu

type fkind = [
    `Exp of
      [`Expr|`Pat|`Const|`Val of Path.t|`Var of Path.t|`New of Path.t]
        * Types.type_expr
  | `Class of Path.t * Types.class_type
  | `Module of Path.t * Types.module_type
]
val search_pos_structure :
    pos:int -> Typedtree.structure_item list ->
    (fkind * Env.t * Location.t) list
val view_type : fkind -> env:Env.t -> unit
val view_type_menu : fkind -> env:Env.t -> GMenu.menu

val parent_path : Path.t -> Path.t option
val string_of_path : Path.t -> string
val string_of_longident : Longident.t -> string
val lines_to_chars : int -> text:string -> int

