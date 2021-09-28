(* Compile a list of variant tags into CPP defines *)

open! StdLabels

(* hash_variant, from ctype.ml *)

let hash_variant s =
  let accu = ref 0 in
  for i = 0 to String.length s - 1 do
    accu := 223 * !accu + Char.code s.[i]
  done;
  (* reduce to 31 bits *)
  accu := !accu land (1 lsl 31 - 1);
  (* make it signed for 64 bits architectures *)
  if !accu > 0x3FFFFFFF then !accu - (1 lsl 31) else !accu

let camlize id =
  let b = Buffer.create (String.length id + 4) in
  for i = 0 to String.length id - 1 do
    if id.[i] >= 'A' && id.[i] <= 'Z' then begin
      if i > 0 then Buffer.add_char b '_';
      Buffer.add_char b (Char.lowercase_ascii id.[i])
    end
    else Buffer.add_char b id.[i]
  done;
  Buffer.contents b

type token = Varcc_lexer.token =
  | Ident of string
  | String of string
  | Type
  | Equal
  | Lbracket
  | Rbracket
  | Grave
  | Bar
  | EOF

let next_token = Varcc_lexer.next_token
let token_pp = Varcc_lexer.token_pp

module Tokens = struct
  type t = {
    mutable lookahead : token option;
    lexbuf : Lexing.lexbuf;
  }
  let make lexbuf = { lookahead = None; lexbuf }

  let peek t = match t.lookahead with
    | Some token -> token
    | None ->
      let token = next_token t.lexbuf in
      t.lookahead <- Some token;
      token

  let next t = match t.lookahead with
    | Some token -> t.lookahead <- None; token
    | None -> next_token t.lexbuf

  let position t = Lexing.(t.lexbuf.lex_curr_pos)
end

type tokens = Tokens.t
let peek = Tokens.peek
let next = Tokens.next
let drop tokens = ignore @@ next tokens

exception Parse_error of token
exception Fatal_parse_error of string * token

[@@@warning "-4-8"]
let _ =
  [ Printexc.register_printer
      (function Parse_error t -> Some (Format.asprintf "Unexpected token: %a" token_pp t))
  ; Printexc.register_printer
      (function Fatal_parse_error (message, token) -> Some (Format.asprintf "%s: %a" message token_pp token))
  ]

let require ?(message = "Bad token") parser tokens =
  try
    parser tokens
  with Parse_error t -> raise @@ Fatal_parse_error (message, t)

(* Some primitive parses for working with tokens, which allow us to reduce
   the use of [peek], [next] and [drop]
*)
let string tokens = match peek tokens with
  | String str -> drop tokens; str
  | _ -> raise @@ Parse_error (peek tokens)
let ident tokens = match peek tokens with
  | Ident id -> drop tokens; id
  | _ -> raise @@ Parse_error (peek tokens)
let kwd tok tokens =
  if peek tokens = tok then drop tokens
  else raise @@ Parse_error (peek tokens)

let opt tok tokens =
  if peek tokens = tok then drop tokens else ()

(* Some higher order parsers, kinda *)
let may_parser parser def tokens =
  try
    parser tokens
  with Parse_error _ -> def

let rec star ?(acc = []) parser tokens =
  try
    let v = parser tokens in
    star ~acc: (v :: acc) parser tokens
  with Parse_error _ -> List.rev acc

(* var specific parser *)
let ident_list tokens =
  let parser tokens =
    kwd Grave tokens;
    let x = require ident tokens in
    let trans = may_parser string "" tokens in
    opt Bar tokens;
    (x, trans)
  in
  star parser tokens

let flag tokens =
  let is_flag = function
    | "public" | "private" | "noconv" | "flags" -> true
    | _ -> false
  in
  match peek tokens with
  | Ident id when is_flag id -> drop tokens; id
  | _ -> raise @@ Parse_error (peek tokens)

let protect tokens = match peek tokens with
  | Ident "protect" -> drop tokens; Some (require ident tokens)
  | _ -> None

let static = ref false

let may o f =
  match o with
  | Some v -> f v
  | None -> ()

open Printf

let hashes = Hashtbl.create 57

let all_convs = ref []
let package = ref ""
let pkgprefix = ref ""

let process_declaration ~hc ~cc ~flags ~guard ~mlname ~name ~prefix ~tags ~suffix =
  let oh x = fprintf hc x and oc x = fprintf cc x in
  let name = if name = "" then !pkgprefix ^ mlname else name in
  (* Output tag values to headers *)
  let first = ref true in
  List.iter tags ~f:
    begin fun (tag, _) ->
      let hash = hash_variant tag in
      try
     	  let tag' = Hashtbl.find hashes hash in
     	  if tag <> tag' then
     	    failwith (String.concat ~sep:" " ["Doublon tag:";tag;"and";tag'])
      with Not_found ->
     	  Hashtbl.add hashes hash tag;
        if !first then begin
          oh "/* %s : tags and macros */\n" name; first := false
        end;
     	  oh "#define MLTAG_%s\t((value)(%d*2+1))\n" tag hash;
    end;
  if List.mem "noconv" ~set:flags then () else
    (* compute C name *)
    let ctag tag trans =
      if trans <> "" then trans else
        let tag =
         	if tag.[0] = '_' then
         	  String.sub tag ~pos:1 ~len:(String.length tag -1)
         	else tag
        in
        match
         	if prefix = "" then None, ""
         	else
         	  Some (prefix.[String.length prefix - 1]),
         	  String.sub prefix ~pos:0 ~len:(String.length prefix - 1)
        with
         	Some '#', prefix ->
       	  prefix ^ String.uncapitalize_ascii tag ^ suffix
        |	Some '^', prefix ->
       	  prefix ^ String.uppercase_ascii tag ^ suffix
        |	_ ->
       	  prefix ^ tag ^ suffix
    and cname =
      String.capitalize_ascii name
    in
    all_convs := (name, mlname, tags, flags) :: !all_convs;
    let tags =
      List.sort tags ~cmp:
        (fun (tag1,_) (tag2,_) ->
           compare (hash_variant tag1) (hash_variant tag2))
    in
    (* Output table to code file *)
    oc "/* %s : conversion table */\n" name;
    let static =
      if !static && not (List.mem "public" ~set:flags) || List.mem "private" ~set:flags
      then "static " else "" in
    oc "%sconst lookup_info ml_table_%s[] = {\n" static name;
    may guard
      (fun m -> oc "#ifdef %s\n" m) ;
    oc "  { 0, %d },\n" (List.length tags);
    List.iter tags ~f:
      begin fun (tag,trans) ->
       	oc "  { MLTAG_%s, %s },\n" tag (ctag tag trans)
      end;
    may guard (fun m -> oc "#else\n  {0, 0 }\n#endif /* %s */\n" m) ;
    oc "};\n\n";
    (* Output macros to headers *)
    if not !first then oh "\n";
    if static = "" then oh "extern const lookup_info ml_table_%s[];\n" name;
    oh "#define Val_%s(data) ml_lookup_from_c (ml_table_%s, data)\n"
      name name;
    oh "#define %s_val(key) ml_lookup_to_c (ml_table_%s, key)\n\n"
      cname name

let declaration ~hc ~cc tokens = match peek tokens with
  (* type flag* guard? ident string? = string? [ |? (`ident |?)* ] string? *)
  | Type -> drop tokens;
    let flags = star flag tokens in
    let guard = require protect tokens in
    let mlname = require ident tokens in
    let name = may_parser string "" tokens in
    require kwd Equal tokens;
    let prefix = may_parser string "" tokens in
    require kwd Lbracket tokens;
    opt Bar tokens;
    let tags = ident_list tokens in
    require kwd Rbracket tokens;
    let suffix = may_parser string "" tokens in

    process_declaration ~hc ~cc ~flags ~guard ~mlname ~name ~prefix ~tags ~suffix

  | Ident "package" -> drop tokens;
    let str = require string tokens in
    package := str

  | Ident "prefix" -> drop tokens;
    let str = require string tokens in
    pkgprefix := str

  | EOF -> raise End_of_file

let process ic ~hc ~cc =
  all_convs := [];
  let tokens = Tokens.make @@ Lexing.from_channel ic in
  try
    while true do declaration ~hc ~cc tokens done
  with
  | End_of_file ->
    if !all_convs <> [] && !package <> "" then begin
      let oc x = fprintf cc x in
      oc "CAMLprim value ml_%s_get_tables ()\n{\n" (camlize !package);
      oc "  static const lookup_info *ml_lookup_tables[] = {\n";
      let convs = List.rev !all_convs in
      List.iter convs ~f:(fun (s,_,_,_) -> oc "    ml_table_%s,\n" s);
      oc "  };\n";
      (* When he have only one conversion, we must return it directly instead of       * an array that would be converted to a tuple *)
      if List.length convs = 1 then
        oc "  return (value)ml_lookup_tables[0];"
      else
        oc "  return (value)ml_lookup_tables;";
      oc "}\n";
      let mlc = open_out (!package ^ "Enums.ml") in
      let ppf = Format.formatter_of_out_channel mlc in
      let out fmt = Format.fprintf ppf fmt in
      out "(** %s enums *)\n@." !package ;
      out "@[";
      List.iter convs ~f:
        begin fun (_,name,tags,_) ->
          out "@[<hv 2>type %s =@ @[<hov>[ `%s" name (fst (List.hd tags));
          List.iter (List.tl tags) ~f:
            (fun (s,_) -> out "@ | `%s" s);
          out " ]@]@]@ "
        end;
      out "@]@.\n(**/**)\n@." ;
      out "@[<v2>module Conv = struct@ ";
      out "open Gpointer\n@ ";
      out "external _get_tables : unit ->@ ";
      let (_,name0,_,_) = List.hd convs in
      out "    %s variant_table@ " name0;
      List.iter (List.tl convs) ~f:
        (fun (_,s,_,_) -> out "  * %s variant_table@ " s);
      out "  = \"ml_%s_get_tables\"\n@ " (camlize !package);
      out "@[<hov 4>let %s_tbl" name0;
      List.iter (List.tl convs) ~f:(fun (_,s,_,_) -> out ",@ %s_tbl" s);
      out " = _get_tables ()@]\n";
      let enum =
        if List.length convs > 10 then begin
          out "@ let _make_enum = Gobject.Data.enum";
          "_make_enum"
        end else "Gobject.Data.enum"
      in
      List.iter convs ~f:
        begin fun (_,s,_,flags) ->
          let conv =
            if List.mem "flags" ~set:flags then "Gobject.Data.flags" else enum in
          out "@ let %s = %s %s_tbl" s conv s
        end;
      out "@]@.end@.";
      close_out mlc
    end
  | exn ->
    failwith
      (Printf.sprintf "Parsing error \"%s\" at character %d on input stream"
         (Printexc.to_string exn) (Tokens.position tokens))


let main () =
  let inputs = ref [] in
  let header = ref "" in
  let code = ref "" in
  Arg.parse
    [ "-h", Arg.String ((:=) header), "file to output macros (file.h)";
      "-c", Arg.String ((:=) code),
      "file to output conversion tables (file.c)";
      "-static", Arg.Set static, "do not export conversion tables" ]
    (fun s -> inputs := s :: !inputs)
    "usage: varcc [options] file.var";
  let inputs = List.rev !inputs in
  begin match inputs with
  | [] ->
    if !header = "" then header := "a.h";
    if !code = "" then code := "a.c"
  | ip :: _ ->
    let rad =
      if Filename.check_suffix ip ".var" then Filename.chop_extension ip
      else ip in
    if !header = "" then header := rad ^ ".h";
    if !code = "" then code := rad ^ ".c"
  end;
  let hc = open_out !header and cc = open_out !code in
  if inputs = [] then process stdin ~hc ~cc else begin
    List.iter inputs ~f:
      begin fun file ->
        let ic = open_in file in
        try process ic ~hc ~cc; close_in ic
        with exn -> close_in ic; prerr_endline ("Error in " ^ file); raise exn
      end
  end;
  close_out hc; close_out cc


let _ = Printexc.print main ()
