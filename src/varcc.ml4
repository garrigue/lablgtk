(* $Id$ *)

(* Compile a list of variant tags into CPP defines *) 

open StdLabels

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
      Buffer.add_char b (Char.lowercase id.[i])
    end
    else Buffer.add_char b id.[i]
  done;
  Buffer.contents b

open Genlex

let lexer = make_lexer ["type"; "="; "["; "]"; "`"; "|"]

let may_string = parser
    [< ' String s >] -> s
  | [< >] -> ""

let may_bar = parser
    [< ' Kwd "|" >] -> ()
  | [< >] -> ()

let rec ident_list = parser
    [< ' Kwd "`"; ' Ident x; trans = may_string; _ = may_bar; s >] ->
      (x, trans) :: ident_list s
  | [< >] -> []

let static = ref false
let may_public = parser
    [< ' Ident "public" >] -> true
  | [< ' Ident "private" >] -> false
  | [< >] -> not !static

let may_noconv = parser
    [< ' Ident "noconv" >] -> true
  | [< >] -> false

open Printf

let hashes = Hashtbl.create 57

let all_convs = ref []
let package = ref ""
let pkgprefix = ref ""

let declaration ~hc ~cc = parser
    [< ' Kwd "type"; public = may_public; noconv = may_noconv;
       ' Ident mlname; name = may_string; ' Kwd "="; prefix = may_string;
       ' Kwd "["; _ = may_bar; tags = ident_list; ' Kwd "]";
       suffix = may_string >] ->
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
	  oh "#define MLTAG_%s\tVal_int(%d)\n" tag hash;
      end;
    if noconv then () else
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
	  prefix ^ String.uncapitalize tag ^ suffix
      |	Some '^', prefix ->
	  prefix ^ String.uppercase tag ^ suffix
      |	_ ->
	  prefix ^ tag ^ suffix
    and cname =
      String.capitalize name
    in
    all_convs := (name, mlname, tags) :: !all_convs;
    let tags =
      List.sort tags ~cmp:
        (fun (tag1,_) (tag2,_) ->
          compare (hash_variant tag1) (hash_variant tag2))
    in
    (* Output table to code file *)
    oc "/* %s : conversion table */\n" name;
    let static = if not public then "static " else "" in
    oc "%slookup_info ml_table_%s[] = {\n" static name;
    oc "  { 0, %d },\n" (List.length tags);
    List.iter tags ~f:
      begin fun (tag,trans) ->
	oc "  { MLTAG_%s, %s },\n" tag (ctag tag trans)
      end;
    oc "};\n\n";
    (* Output macros to headers *)
    if not !first then oh "\n";
    if public then oh "extern lookup_info ml_table_%s[];\n" name;
    oh "#define Val_%s(data) ml_lookup_from_c (ml_table_%s, data)\n"
      name name;
    oh "#define %s_val(key) ml_lookup_to_c (ml_table_%s, key)\n\n"
      cname name;
  | [< ' Ident "package"; ' String s >] ->
      package := s
  | [< ' Ident "prefix"; ' String s >] ->
      pkgprefix := s
  | [< >] -> raise End_of_file


let process ic ~hc ~cc =  
  all_convs := [];
  let chars = Stream.of_channel ic in
  let s = lexer chars in
  try
    while true do declaration s ~hc ~cc done
  with End_of_file ->
    if !all_convs <> [] && !package <> "" then begin
      let oc x = fprintf cc x in
      oc "CAMLprim value ml_%s_get_tables ()\n{\n" (camlize !package);
      oc "  static lookup_info *ml_lookup_tables[] = {\n";
      let convs = List.rev !all_convs in
      List.iter convs ~f:(fun (s,_,_) -> oc "    ml_table_%s,\n" s);
      oc "  };\n";
      oc "  return (value)ml_lookup_tables;";
      oc "}\n";
      let mlc = open_out (!package ^ "Enums.ml") in
      let ppf = Format.formatter_of_out_channel mlc in
      let out fmt = Format.fprintf ppf fmt in
      out "open Gpointer\n@.";
      List.iter convs ~f:
        begin fun (_,name,tags) ->
          out "@[<hv 2>type %s =@ @[<hov>[ `%s" name (fst (List.hd tags));
          List.iter (List.tl tags) ~f:
            (fun (s,_) -> out "@ | `%s" s);
          out " ]@]@]@."
        end;
      out "\nexternal _get_tables : unit ->\n";
      let (_,name0,_) = List.hd convs in
      out "    %s variant_table\n" name0;
      List.iter (List.tl convs) ~f:
        (fun (_,s,_) -> out "  * %s variant_table\n" s);
      out "  = \"ml_%s_get_tables\"\n\n" (camlize !package);
      out "@[<hov 4>let %s" name0;
      List.iter (List.tl convs) ~f:(fun (_,s,_) -> out ",@ %s" s);
      out " = _get_tables ()@]@.";
      close_out mlc
    end
  | Stream.Error err ->
      failwith
        (Printf.sprintf "Parsing error \"%s\" at character %d on input stream"
           err (Stream.count chars))

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
  let chars = Stream.of_channel stdin in
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
