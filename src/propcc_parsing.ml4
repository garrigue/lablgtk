(* -*- caml -*- *)
(* $Id$ *)

open StdLabels
open MoreLabels

let caml_keywords = ["type","kind"; "class","classe"; "list", "liste"]
let caml_modules = ["List", "Liste"]

let is_not_uppercase = function
  | 'A' .. 'Z' -> false
  | _ -> true
let camlize id =
  let b = Buffer.create (String.length id + 4) in
  for i = 0 to String.length id - 1 do
    match id.[i] with
    | 'A' .. 'Z' as c ->
        if i > 0 && 
          (is_not_uppercase id.[i-1] || 
          (i < String.length id - 1 && is_not_uppercase id.[i+1]))
        then Buffer.add_char b '_' ;
        Buffer.add_char b (Char.lowercase c)
    | '-' ->
        Buffer.add_char b '_'
    | c ->
        Buffer.add_char b c
  done;
  let s = Buffer.contents b in
  try List.assoc s caml_keywords with Not_found -> s

let camlizeM s =
  try List.assoc s caml_modules with Not_found -> s

let check_suffix s suff =
  let len1 = String.length s and len2 = String.length suff in
  len1 > len2 && String.sub s (len1-len2) len2 = suff

(* Arity of a caml type. Doesn't handle object types... *)
let arity s =
  let parens = ref 0 and arity = ref 0 in
  for i = 0 to String.length s - 1 do
    if s.[i] = '(' || s.[i] = '[' then incr parens else
    if s.[i] = ')' || s.[i] = ']' then decr parens else
    if !parens = 0 && s.[i] = '-' && s.[i+1] = '>' then incr arity
  done;
  if !parens <> 0 then failwith ("bad type : " ^ s);
  !arity

let rec min_labelled = function
  | [] -> []
  | a :: l ->
      let l = min_labelled l in
      if l = [] && a = "" then [] else a::l


(* The real data *)
let conversions = Hashtbl.create 17

let enums = [
  "Gtk", "GtkEnums",
  [ "Justification"; "ArrowType"; "ShadowType"; "ResizeMode";
    "ReliefStyle"; "ImageType"; "WindowType"; "WindowPosition";
    "ButtonsType"; "MessageType"; "ButtonBoxStyle"; "PositionType";
    "Orientation"; "ToolbarStyle"; "IconSize"; "PolicyType";
    "CornerType"; "SelectionMode"; "SortType"; "WrapMode";
    "SpinButtonUpdatePolicy"; "UpdateType"; "ProgressBarStyle";
    "ProgressBarOrientation"; "CellRendererMode"; "CellRendererAccelMode";
    "TreeViewColumnSizing"; "SortType"; "TextDirection"; "SizeGroupMode";
    (* in signals *)
    "MovementStep"; "ScrollType"; "MenuDirectionType"; "DeleteType";
    "StateType";
    (* for canvas *)
    "AnchorType"; "DirectionType"; 
  ];
  "Gdk", "GdkEnums",
  [ "ExtensionMode"; "WindowTypeHint"; "EventMask";
    (* for canvas *)
    "CapStyle"; "JoinStyle"; "LineStyle"];
  "Pango", "PangoEnums",
  [ "Stretch"; "Style"; "Underline"; "Variant"; "EllipsizeMode" ];
  (* GtkSourceView *)
  "Gtk","SourceView2Enums",
  ["SourceSmartHomeEndType"; "SourceDrawSpacesFlags"]
]

(* These types must be registered with g_boxed_register! *)
let boxeds = [
  "Gdk", ["Color"; "Font";];
  "Pango", ["FontDescription";];
  "Gtk", ["IconSet";"SelectionData";"TextIter";"TreePath"; "TreeIter";];
]

let classes = [
  "Gdk", [ "Image"; "Pixmap"; "Bitmap"; "Screen"; "DragContext";];
  "Gtk", [ "Style"; "TreeStore"; "TreeModel"; "TreeModelFilter"; "Tooltip" ]
]

let specials = [
  "GtkWidget", "GObj.conv_widget";
  "GtkWidget_opt", "GObj.conv_widget_option";
  "GtkAdjustment", "GData.conv_adjustment";
  "GtkAdjustment_opt", "GData.conv_adjustment_option";
]

let add_pointer conv gtk name =
  Hashtbl.add conversions gtk
    (Printf.sprintf "(%s : %s data_conv)" conv name);
  Hashtbl.add conversions (gtk ^ "_opt")
    (Printf.sprintf "(%s_option : %s option data_conv)" conv name)

let add_object = add_pointer "gobject"
let add_boxed = add_pointer "unsafe_pointer" (* the type is not used *)

let () =
  List.iter ~f:(fun t -> Hashtbl.add conversions ("g"^t) t)
    [ "boolean"; "char"; "uchar"; "int"; "uint"; "long"; "ulong";
      "int32"; "uint32"; "int64"; "uint64"; "float"; "double" ];
  List.iter ~f:(fun (gtype,conv) -> Hashtbl.add conversions gtype conv)
    [ "gchararray", "string";
      "gchararray_opt", "string_option";
      "string", "string"; "bool", "boolean"; "int", "int";
      "int32", "int32"; "float", "float";
    ];
  List.iter enums ~f:(fun (pre, modu, l) ->
    List.iter l ~f:
      begin fun name ->
        Hashtbl.add conversions (pre ^ name)
          (Printf.sprintf "%s.%s_conv" modu (camlize name))
      end);
  List.iter boxeds ~f:(fun (pre, l) ->
    List.iter l ~f:(fun name -> add_boxed (pre^name) (pre^"."^camlize name)));
  List.iter classes ~f:(fun (pre,l) ->
    List.iter l ~f:(fun t -> add_object (pre^t) (pre^"."^camlize t)));
  add_object "GObject" "unit obj";
  add_object "GtkWidget" "Gtk.widget obj"

open Genlex

let lexer = make_lexer ["{"; "}"; ":"; "/"; "("; ")";"->";"method";"signal"]

let rec star ?(acc=[]) p = parser
    [< x = p ; s >] -> star ~acc:(x::acc) p s
  | [< >] -> List.rev acc

let may_token tok s =
  if Stream.peek s = Some tok then Stream.junk s

let ident = parser [< ' Ident id >] -> id

let string = parser [< ' String s >] -> s

let may_colon p def = parser
  | [< ' Kwd":"; s >] -> p s
  | [< >] -> def

let may_string def = parser
    [< ' String s >] -> s
  | [< >] -> def

let may_name s = parser
    [< ' Kwd"("; ' Ident id; ' Kwd")" >] -> id
  | [< >] -> (camlize s)

let next_attr = parser
    [< ' Kwd"/"; ' Ident id; ids = star ~acc:[id] ident >] ->
      String.concat ~sep:"" ids

let attributes =
  ["Read";"Write";"Construct";"ConstructOnly";"NoSet";"Set";
   "NoWrap";"Wrap";"NoGet";"VSet";"NoVSet"]

let label_type2 id = parser
  | [< ' Kwd":"; ' Ident ty >] -> (id,ty)
  | [< >] -> ("",id)
let label_type = parser
    [< ' Ident id ; lty = label_type2 id >] -> lty

type marshal =
    Function of string | Types of (string list * string list * string)

let return_type (l,types) = parser
    [< ' Kwd"->"; ' Ident ret >] -> Types (l, types, ret)
  | [< >] -> Types (l, types, "")

let marshaller = parser
  | [< ' String s >] -> Function s
  | [< ' Kwd":"; types = star label_type; s >] ->
      return_type (List.split types) s
  | [< >] -> Types ([], [], "")

let simple_attr = parser [< ' Kwd"/"; ' Ident s >] -> s

let field = parser
    [< ' String name; mlname = may_name name; ' Ident gtype; ' Kwd":";
       ' Ident attr0; attrs = star ~acc:[attr0] next_attr >] ->
         if not (List.for_all attrs ~f:(List.mem ~set:attributes)) then
           raise (Stream.Error "bad attribute");
         `Prop (name, mlname, gtype, attrs)
  | [< ' Kwd"method"; ' Ident name; ty = may_colon string "unit";
       attrs = star simple_attr >] ->
         if not (List.for_all attrs ~f:(List.mem ~set:["Wrap"])) then
           raise (Stream.Error "bad attribute");
         `Method (name, ty, attrs)
  | [< ' Kwd"signal"; ' Ident name; m = marshaller; l = star simple_attr >] ->
      if not (List.for_all l ~f:(List.mem ~set:["Wrap";"NoWrap"])) then
        raise (Stream.Error "bad attribute");
      `Signal (name, m, l)

let split_fields l =
  List.fold_right l ~init:([],[],[]) ~f:
    (fun field (props,meths,sigs) -> match field with
      `Prop p   -> (p::props,meths,sigs)
    | `Method m -> (props,m::meths,sigs)
    | `Signal s -> (props,meths,s::sigs))

let verb_braces = ref 0

let rec verbatim buf = parser
  | [< ''}' ; s >] ->
      if !verb_braces = 0 then Buffer.contents buf else begin
        decr verb_braces; Buffer.add_char buf '}'; verbatim buf s;
      end
  | [< ''{'; s >] ->
      Buffer.add_char buf '{'; incr verb_braces; verbatim buf s
  | [< ''\\' ; 'c ; s >] ->
      if c <> '}' && c <> '{' then Buffer.add_char buf '\\';
      Buffer.add_char buf c; verbatim buf s
  | [< 'c ; s >] -> Buffer.add_char buf c; verbatim buf s

let read_pair = parser
  | [< ' Ident cls ; data = may_string (camlize cls) >] -> (cls,data)

let qualifier = parser
  | [< ' Ident id ; data = may_string "" >] -> (id,data)

let prefix = ref ""
let tagprefix = ref ""
let decls = ref []
let headers = ref []
let oheaders = ref []
let checks = ref false
let class_qualifiers =
  ["abstract";"notype";"hv";"set";"wrap";"wrapset";"vset";"tag";"wrapsig";
   "type";"gobject";]

let process_phrase ~chars = parser
    [< ' Ident"class"; ' Ident name; gtk_name = may_string (!prefix ^ name);
       attrs = star qualifier; parent = may_colon ident "";
       ' Kwd"{"; fields = star field; ' Kwd"}" >] ->
         if List.exists attrs ~f:
             (fun (x,_) -> not (List.mem x class_qualifiers))
         then raise (Stream.Error "bad qualifier");
         let attrs = ("parent",parent) :: attrs in
         let attrs =
           if parent = "GObject" then ("gobject","")::attrs else attrs in
         let props, meths, sigs = split_fields fields in
         decls := (name, gtk_name, attrs, props, meths, sigs) :: !decls
  | [< ' Ident"header"; ' Kwd"{" >] ->
      let h = verbatim (Buffer.create 1000) chars in
      headers := !headers @ [h]
  | [< ' Ident"oheader"; ' Kwd"{" >] ->
      let h = verbatim (Buffer.create 1000) chars in
      oheaders := !oheaders @ [h]
  | [< ' Ident"prefix"; ' String id >] ->
      prefix := id
  | [< ' Ident"tagprefix"; ' String id >] ->
      tagprefix := id
  | [< ' Ident"conversions"; pre1 = may_string ""; pre2 = may_string pre1;
       ' Kwd"{"; l = star read_pair; ' Kwd"}" >] ->
      List.iter l ~f:(fun (k,d) ->
        Hashtbl.add conversions (pre1^k) (if pre2="" then d else pre2^"."^d))
  | [< ' Ident"classes"; ' Kwd"{"; l = star read_pair; ' Kwd"}" >] ->
      List.iter l ~f:(fun (k,d) -> add_object k d)
  | [< ' Ident"boxed"; ' Kwd"{"; l = star read_pair; ' Kwd"}" >] ->
      List.iter l ~f:(fun (k,d) -> add_boxed k d)
  | [< ' _ >] ->
      raise (Stream.Error "")
  | [< >] ->
      raise End_of_file

