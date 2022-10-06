(* -*- caml -*- *)
(* $Id$ *)
(* Compile a list of variant tags into CPP defines *)
open StdLabels
  
(* hash_variant, from ctype.ml *)
let hash_variant s =
  let accu = ref 0
  in
    (* reduce to 31 bits *)
    (for i = 0 to (String.length s) - 1 do
       accu := (223 * !accu) + (Char.code s.[i])
     done;
     accu := !accu land ((1 lsl 31) - 1);
     (* make it signed for 64 bits architectures *)
     if !accu > 0x3FFFFFFF then !accu - (1 lsl 31) else !accu)
  
let camlize id =
  let b = Buffer.create ((String.length id) + 4)
  in
    (for i = 0 to (String.length id) - 1 do
       if (id.[i] >= 'A') && (id.[i] <= 'Z')
       then
         (if i > 0 then Buffer.add_char b '_' else ();
          Buffer.add_char b (Char.lowercase_ascii id.[i]))
       else Buffer.add_char b id.[i]
     done;
     Buffer.contents b)
  
open Genlex
  
let lexer = make_lexer [ "type"; "="; "["; "]"; "`"; "|" ]
  
let may_string (__strm : _ Stream.t) =
  match Stream.peek __strm with
  | Some (String s) -> (Stream.junk __strm; s)
  | _ -> ""
  
let may_bar (__strm : _ Stream.t) =
  match Stream.peek __strm with
  | Some (Kwd "|") -> (Stream.junk __strm; ())
  | _ -> ()
  
let rec ident_list (__strm : _ Stream.t) =
  match Stream.peek __strm with
  | Some (Kwd "`") ->
      (Stream.junk __strm;
       (match Stream.peek __strm with
        | Some (Ident x) ->
            (Stream.junk __strm;
             let trans =
               (try may_string __strm
                with | Stream.Failure -> raise (Stream.Error "")) in
             let _ =
               (try may_bar __strm
                with | Stream.Failure -> raise (Stream.Error ""))
             in (x, trans) :: (ident_list __strm))
        | _ -> raise (Stream.Error "")))
  | _ -> []
  
let static = ref false
  
let rec star ?(acc = []) p (__strm : _ Stream.t) =
  match try Some (p __strm) with | Stream.Failure -> None with
  | Some x -> let s = __strm in star ~acc: (x :: acc) p s
  | _ -> List.rev acc
  
let flag (__strm : _ Stream.t) =
  match Stream.peek __strm with
  | Some (Ident (("public" | "private" | "noconv" | "flags" as s))) ->
      (Stream.junk __strm; s)
  | _ -> raise Stream.Failure
  
let protect (__strm : _ Stream.t) =
  match Stream.peek __strm with
  | Some (Ident "protect") ->
      (Stream.junk __strm;
       (match Stream.peek __strm with
        | Some (Ident m) -> (Stream.junk __strm; Some m)
        | _ -> raise (Stream.Error "")))
  | _ -> None
  
let may o f = match o with | Some v -> f v | None -> ()
  
open Printf
  
let hashes = Hashtbl.create 57
  
let all_convs = ref []
  
let package = ref ""
  
let pkgprefix = ref ""
  
let declaration ~hc ~cc (__strm : _ Stream.t) =
  match Stream.peek __strm with
  | Some (Kwd "type") ->
      (Stream.junk __strm;
       let flags =
         (try star flag __strm
          with | Stream.Failure -> raise (Stream.Error "")) in
       let guard =
         (try protect __strm with | Stream.Failure -> raise (Stream.Error ""))
       in
         (match Stream.peek __strm with
          | Some (Ident mlname) ->
              (Stream.junk __strm;
               let name =
                 (try may_string __strm
                  with | Stream.Failure -> raise (Stream.Error ""))
               in
                 (match Stream.peek __strm with
                  | Some (Kwd "=") ->
                      (Stream.junk __strm;
                       let prefix =
                         (try may_string __strm
                          with | Stream.Failure -> raise (Stream.Error ""))
                       in
                         (match Stream.peek __strm with
                          | Some (Kwd "[") ->
                              (Stream.junk __strm;
                               let _ =
                                 (try may_bar __strm
                                  with
                                  | Stream.Failure -> raise (Stream.Error "")) in
                               let tags =
                                 (try ident_list __strm
                                  with
                                  | Stream.Failure -> raise (Stream.Error ""))
                               in
                                 (match Stream.peek __strm with
                                  | Some (Kwd "]") ->
                                      (Stream.junk __strm;
                                       let suffix =
                                         (try may_string __strm
                                          with
                                          | Stream.Failure ->
                                              raise (Stream.Error "")) in
                                       let oh x = fprintf hc x
                                       and oc x = fprintf cc x in
                                       let name =
                                         if name = ""
                                         then !pkgprefix ^ mlname
                                         else name in
                                       (* Output tag values to headers *)
                                       let first = ref true
                                       in
                                         (List.iter tags
                                            ~f:
                                              (fun (tag, _) ->
                                                 let hash = hash_variant tag
                                                 in
                                                   try
                                                     let tag' =
                                                       Hashtbl.find hashes
                                                         hash
                                                     in
                                                       if tag <> tag'
                                                       then
                                                         failwith
                                                           (String.concat
                                                              ~sep: " "
                                                              [ "Doublon tag:";
                                                                tag; "and";
                                                                tag' ])
                                                       else ()
                                                   with
                                                   | Not_found ->
                                                       (Hashtbl.add hashes
                                                          hash tag;
                                                        if !first
                                                        then
                                                          (oh
                                                             "/* %s : tags and macros */\n"
                                                             name;
                                                           first := false)
                                                        else ();
                                                        oh
                                                          "#define MLTAG_%s\t((value)(%d*2+1))\n"
                                                          tag hash));
                                          if List.mem "noconv" ~set: flags
                                          then ()
                                          else (* compute C name *)
                                            (let ctag tag trans =
                                               if trans <> ""
                                               then trans
                                               else
                                                 (let tag =
                                                    if tag.[0] = '_'
                                                    then
                                                      String.sub tag 
                                                        ~pos: 1
                                                        ~len:
                                                          ((String.length tag)
                                                             - 1)
                                                    else tag
                                                  in
                                                    match if prefix = ""
                                                          then (None, "")
                                                          else
                                                            ((Some
                                                                prefix.
                                                                [
                                                                 (String.
                                                                    length
                                                                    prefix)
                                                                   - 1
                                                                ]),
                                                             (String.sub
                                                                prefix
                                                                ~pos: 0
                                                                ~len:
                                                                  ((String.
                                                                    length
                                                                    prefix) -
                                                                    1)))
                                                    with
                                                    | (Some '#', prefix) ->
                                                        prefix ^
                                                          ((String.
                                                              uncapitalize_ascii
                                                              tag)
                                                             ^ suffix)
                                                    | (Some '^', prefix) ->
                                                        prefix ^
                                                          ((String.
                                                              uppercase_ascii
                                                              tag)
                                                             ^ suffix)
                                                    | _ ->
                                                        prefix ^
                                                          (tag ^ suffix))
                                             and cname =
                                               String.capitalize_ascii name
                                             in
                                               (all_convs :=
                                                  (name, mlname, tags, flags) ::
                                                    !all_convs;
                                                let tags =
                                                  List.sort tags
                                                    ~cmp:
                                                      (fun (tag1, _)
                                                         (tag2, _) ->
                                                         compare
                                                           (hash_variant tag1)
                                                           (hash_variant tag2))
                                                in
                                                  (* Output table to code file *)
                                                  (oc
                                                     "/* %s : conversion table */\n"
                                                     name;
                                                   let static =
                                                     if
                                                       (!static &&
                                                          (not
                                                             (List.mem
                                                                "public"
                                                                ~set: flags)))
                                                         ||
                                                         (List.mem "private"
                                                            ~set: flags)
                                                     then "static "
                                                     else ""
                                                   in
                                                     (* Output macros to headers *)
                                                     (oc
                                                        "%sconst lookup_info ml_table_%s[] = {\n"
                                                        static name;
                                                      may guard
                                                        (fun m ->
                                                           oc "#ifdef %s\n" m);
                                                      oc "  { 0, %d },\n"
                                                        (List.length tags);
                                                      List.iter tags
                                                        ~f:
                                                          (fun (tag, trans)
                                                             ->
                                                             oc
                                                               "  { MLTAG_%s, %s },\n"
                                                               tag
                                                               (ctag tag
                                                                  trans));
                                                      may guard
                                                        (fun m ->
                                                           oc
                                                             "#else\n  {0, 0 }\n#endif /* %s */\n"
                                                             m);
                                                      oc "};\n\n";
                                                      if not !first
                                                      then oh "\n"
                                                      else ();
                                                      if static = ""
                                                      then
                                                        oh
                                                          "extern const lookup_info ml_table_%s[];\n"
                                                          name
                                                      else ();
                                                      oh
                                                        "#define Val_%s(data) ml_lookup_from_c (ml_table_%s, data)\n"
                                                        name name;
                                                      oh
                                                        "#define %s_val(key) ml_lookup_to_c (ml_table_%s, key)\n\n"
                                                        cname name))))))
                                  | _ -> raise (Stream.Error "")))
                          | _ -> raise (Stream.Error "")))
                  | _ -> raise (Stream.Error "")))
          | _ -> raise (Stream.Error "")))
  | Some (Ident "package") ->
      (Stream.junk __strm;
       (match Stream.peek __strm with
        | Some (String s) -> (Stream.junk __strm; package := s)
        | _ -> raise (Stream.Error "")))
  | Some (Ident "prefix") ->
      (Stream.junk __strm;
       (match Stream.peek __strm with
        | Some (String s) -> (Stream.junk __strm; pkgprefix := s)
        | _ -> raise (Stream.Error "")))
  | _ -> raise End_of_file
  
let process ic ~hc ~cc =
  (all_convs := [];
   let chars = Stream.of_channel ic in
   let s = lexer chars
   in
     try while true do declaration s ~hc ~cc done
     with
     | End_of_file ->
         if (!all_convs <> []) && (!package <> "")
         then
           (let oc x = fprintf cc x in
            let convs = List.rev !all_convs in
            let len = List.length convs
            in
              (* When we have only one conversion, we must return it directly instead
         of a one-value array that would be invalid as a tuple *)
              (oc "CAMLprim value ml_%s_get_tables ()\n{\n"
                 (camlize !package);
               oc "  CAMLparam0 ();\n";
               oc "  CAMLlocal1 (ml_lookup_tables);\n";
               oc "  ml_lookup_tables = caml_alloc_tuple(%d);\n" len;
               List.iteri convs
                 ~f:
                   (fun i (s, _, _, _) ->
                      oc
                        "  Field(ml_lookup_tables,%d) = Val_lookup_info(ml_table_%s);\n"
                        i s);
               if (List.length convs) = 1
               then oc "  CAMLreturn (Field(ml_lookup_tables,0));\n"
               else oc "  CAMLreturn (ml_lookup_tables);\n";
               oc "}\n";
               let mlc = open_out (!package ^ "Enums.ml") in
               let ppf = Format.formatter_of_out_channel mlc in
               let out fmt = Format.fprintf ppf fmt
               in
                 (out "(** %s enums *)\n\n" !package;
                  out "open Gpointer\n@.";
                  List.iter convs
                    ~f:
                      (fun (_, name, tags, _) ->
                         (out "@[<hv 2>type %s =@ @[<hov>[ `%s" name
                            (fst (List.hd tags));
                          List.iter (List.tl tags)
                            ~f: (fun (s, _) -> out "@ | `%s" s);
                          out " ]@]@]@."));
                  out "\n(**/**)\n";
                  out "\nexternal _get_tables : unit ->\n";
                  let (_, name0, _, _) = List.hd convs
                  in
                    (out "    %s variant_table\n" name0;
                     List.iter (List.tl convs)
                       ~f:
                         (fun (_, s, _, _) -> out "  * %s variant_table\n" s);
                     out "  = \"ml_%s_get_tables\"\n\n" (camlize !package);
                     out "@[<hov 4>let %s" name0;
                     List.iter (List.tl convs)
                       ~f: (fun (_, s, _, _) -> out ",@ %s" s);
                     out " = _get_tables ()@]\n@.";
                     let enum =
                       if (List.length convs) > 10
                       then
                         (out "let _make_enum = Gobject.Data.enum@.";
                          "_make_enum")
                       else "Gobject.Data.enum"
                     in
                       (List.iter convs
                          ~f:
                            (fun (_, s, _, flags) ->
                               let conv =
                                 if List.mem "flags" ~set: flags
                                 then "Gobject.Data.flags"
                                 else enum
                               in out "let %s_conv = %s %s@." s conv s);
                        close_out mlc)))))
         else ()
     | Stream.Error err ->
         failwith
           (Printf.sprintf
              "Parsing error \"%s\" at character %d on input stream" err
              (Stream.count chars)))
  
let main () =
  let inputs = ref [] in
  let header = ref "" in
  let code = ref ""
  in
    (Arg.parse
       [ ("-h", (Arg.String (( := ) header)),
          "file to output macros (file.h)");
         ("-c", (Arg.String (( := ) code)),
          "file to output conversion tables (file.c)");
         ("-static", (Arg.Set static), "do not export conversion tables") ]
       (fun s -> inputs := s :: !inputs) "usage: varcc [options] file.var";
     let inputs = List.rev !inputs
     in
       ((match inputs with
         | [] ->
             (if !header = "" then header := "a.h" else ();
              if !code = "" then code := "a.c" else ())
         | ip :: _ ->
             let rad =
               if Filename.check_suffix ip ".var"
               then Filename.chop_extension ip
               else ip
             in
               (if !header = "" then header := rad ^ ".h" else ();
                if !code = "" then code := rad ^ ".c" else ()));
        let hc = open_out !header
        and cc = open_out !code
        in
          (if inputs = []
           then process stdin ~hc ~cc
           else
             List.iter inputs
               ~f:
                 (fun file ->
                    let ic = open_in file
                    in
                      try (process ic ~hc ~cc; close_in ic)
                      with
                      | exn ->
                          (close_in ic;
                           prerr_endline ("Error in " ^ file);
                           raise exn));
           close_out hc;
           close_out cc)))
  
let _ = Printexc.print main ()
  

