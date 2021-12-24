(* $Id$ *)

(* Check that all external statements differ in a .ml or .mli file *)

open StdLabels

(*** Objective Caml simplified lexer ***)

type token =
    Ident of string
  | Num of int
  | Sym of char
  | String of string
  | Char of string
  | EOF

let rec implode l =
  let s = String.create (List.length l) in
  let i = ref 0 in List.iter l ~f:(fun c -> s.[!i] <- c; incr i); s

let rec skip tok (strm__ : _ Stream.t) =
  match Stream.peek strm__ with
    Some tok' ->
      Stream.junk strm__; let s = strm__ in if tok <> tok' then skip tok s
  | _ -> raise Stream.Failure

let rec star ~acc p (strm__ : _ Stream.t) =
  match try Some (p strm__) with Stream.Failure -> None with
    Some x -> let s = strm__ in star ~acc:(x :: acc) p s
  | _ -> List.rev acc

let alphanum (strm__ : _ Stream.t) =
  match Stream.peek strm__ with
    Some ('A'..'Z' | 'a'..'z' | '0'..'9' | '\'' | '_' as c) ->
      Stream.junk strm__; c
  | _ -> raise Stream.Failure

let num (strm__ : _ Stream.t) =
  match Stream.peek strm__ with
    Some ('0'..'9' | '_' as c) -> Stream.junk strm__; c
  | _ -> raise Stream.Failure

let escaped (strm__ : _ Stream.t) =
  match Stream.peek strm__ with
    Some ('0'..'9' as c1) ->
      Stream.junk strm__;
      begin match Stream.peek strm__ with
        Some ('0'..'9' as c2) ->
          Stream.junk strm__;
          begin match Stream.peek strm__ with
            Some ('0'..'9' as c3) -> Stream.junk strm__; [c1; c2; c3]
          | _ -> raise (Stream.Error "")
          end
      | _ -> raise (Stream.Error "")
      end
  | Some c -> Stream.junk strm__; [c]
  | _ -> raise Stream.Failure

let char (strm__ : _ Stream.t) =
  match Stream.peek strm__ with
    Some '\\' ->
      Stream.junk strm__;
      let l =
        try escaped strm__ with Stream.Failure -> raise (Stream.Error "")
      in
      begin match Stream.peek strm__ with
        Some '\'' -> Stream.junk strm__; implode ('\\' :: l)
      | _ -> raise (Stream.Error "")
      end
  | Some c ->
      Stream.junk strm__;
      begin match Stream.peek strm__ with
        Some '\'' -> Stream.junk strm__; String.make 1 c
      | _ -> raise (Stream.Error "")
      end
  | _ -> raise Stream.Failure

let rec string ~acc (strm__ : _ Stream.t) =
  match Stream.peek strm__ with
    Some '"' -> Stream.junk strm__; implode (List.rev acc)
  | Some '\'' ->
      Stream.junk strm__;
      let l =
        try escaped strm__ with Stream.Failure -> raise (Stream.Error "")
      in
      let s = strm__ in string ~acc:(List.rev_append l ('\'' :: acc)) s
  | Some c -> Stream.junk strm__; let s = strm__ in string ~acc:(c :: acc) s
  | _ -> raise Stream.Failure

let rec token (strm__ : _ Stream.t) =
  match Stream.peek strm__ with
    Some ('A'..'Z' | 'a'..'z' | '_' as c) ->
      Stream.junk strm__;
      let l =
        try star alphanum ~acc:[c] strm__ with
          Stream.Failure -> raise (Stream.Error "")
      in
      Ident (implode l)
  | Some ('0'..'9' as c) ->
      Stream.junk strm__;
      let l =
        try star ~acc:[c] num strm__ with
          Stream.Failure -> raise (Stream.Error "")
      in
      Num (int_of_string (implode l))
  | Some '(' ->
      Stream.junk strm__;
      (try may_comment strm__ with Stream.Failure -> raise (Stream.Error ""))
  | Some '\'' ->
      Stream.junk strm__;
      let s = strm__ in (try Char (char s) with _ -> token s)
  | Some '"' ->
      Stream.junk strm__;
      let s =
        try string ~acc:[] strm__ with
          Stream.Failure -> raise (Stream.Error "")
      in
      String s
  | Some (' ' | '\n' | '\r' | '\t') -> Stream.junk strm__; token strm__
  | Some c -> Stream.junk strm__; Sym c
  | _ -> raise End_of_file
and may_comment (strm__ : _ Stream.t) =
  match Stream.peek strm__ with
    Some '*' ->
      Stream.junk strm__;
      let s = strm__ in
      let s' = lexer s in skip (Sym '*') s'; may_close_comment s'
  | _ -> Sym '('
and may_close_comment (strm__ : _ Stream.t) =
  match Stream.peek strm__ with
    Some (Sym ')') ->
      Stream.junk strm__;
      begin match Stream.peek strm__ with
        Some tok -> Stream.junk strm__; tok
      | _ -> raise (Stream.Error "")
      end
  | _ -> let s = strm__ in skip (Sym '*') s; may_close_comment s
and lexer s =
  Stream.lcons (fun _ -> token s) (Stream.slazy (fun _ -> lexer s))



(**** The actual checker ***)

let defs = Hashtbl.create 13

let add impl name =
  try
    let name' = Hashtbl.find defs impl in
    Printf.eprintf "externals [%s] and [%s] have same implementation \"%s\"\n"
      name' name impl
  with Not_found -> Hashtbl.add defs impl name

let may_string (strm__ : _ Stream.t) =
  match Stream.peek strm__ with
    Some (String s) -> Stream.junk strm__; s
  | _ -> ""

let rec skip_type (strm__ : _ Stream.t) =
  match Stream.peek strm__ with
    Some (Sym '=') -> Stream.junk strm__; ()
  | Some (Sym '(') ->
      Stream.junk strm__;
      let _ =
        try skip (Sym ')') strm__ with
          Stream.Failure -> raise (Stream.Error "")
      in
      skip_type strm__
  | Some (Sym '[') ->
      Stream.junk strm__;
      let _ =
        try skip (Sym ']') strm__ with
          Stream.Failure -> raise (Stream.Error "")
      in
      skip_type strm__
  | Some _ -> Stream.junk strm__; skip_type strm__
  | _ -> raise Stream.Failure

let check_external (strm__ : _ Stream.t) =
  match Stream.peek strm__ with
    Some (Ident name) ->
      Stream.junk strm__;
      begin match Stream.peek strm__ with
        Some (Sym ':') ->
          Stream.junk strm__;
          let _ =
            try skip_type strm__ with
              Stream.Failure -> raise (Stream.Error "")
          in
          begin match Stream.peek strm__ with
            Some (String impl) ->
              Stream.junk strm__;
              let native1 =
                try may_string strm__ with
                  Stream.Failure -> raise (Stream.Error "")
              in
              let native2 =
                try may_string strm__ with
                  Stream.Failure -> raise (Stream.Error "")
              in
              if impl <> "" && impl.[0] <> '%' then add impl name;
              let native =
                match native1, native2 with
                  ("noalloc" | "float"), ("noalloc" | "float") -> ""
                | ("noalloc" | "float"), n -> n
                | n, _ -> n
              in
              if native <> "" then add native name
          | _ -> raise (Stream.Error "")
          end
      | _ -> raise (Stream.Error "")
      end
  | _ -> raise Stream.Failure

let check f =
  prerr_endline ("processing " ^ f);
  let ic = open_in f in
  let chars = Stream.of_channel ic in
  let s = lexer chars in
  try while true do skip (Ident "external") s; check_external s done with
    End_of_file -> ()
  | Stream.Error _ | Stream.Failure ->
      Printf.eprintf "Parse error in file `%s' before char %d\n" f
        (Stream.count chars);
      exit 2
  | exn ->
      Printf.eprintf "Exception %s in file `%s' before char %d\n"
        (Printexc.to_string exn) f (Stream.count chars);
      exit 2

let main () = Arg.parse [] check "usage: check_externals file.ml ..."

let () = Printexc.print main ()

