(* $Id$ *)
(* Check that all external statements differ in a .ml or .mli file *)
open StdLabels
  
(*** Objective Caml simplified lexer ***)
type token =
  | Ident of string
  | Num of int
  | Sym of char
  | String of string
  | Char of string
  | EOF

let rec implode l =
  let s = String.create (List.length l) in
  let i = ref 0 in (List.iter l ~f: (fun c -> (s.[!i] <- c; incr i)); s)
  
let rec skip tok (__strm : _ Stream.t) =
  match Stream.peek __strm with
  | Some tok' ->
      (Stream.junk __strm;
       let s = __strm in if tok <> tok' then skip tok s else ())
  | _ -> raise Stream.Failure
  
let rec star ~acc p (__strm : _ Stream.t) =
  match try Some (p __strm) with | Stream.Failure -> None with
  | Some x -> let s = __strm in star ~acc: (x :: acc) p s
  | _ -> List.rev acc
  
let alphanum (__strm : _ Stream.t) =
  match Stream.peek __strm with
  | Some (('A' .. 'Z' | 'a' .. 'z' | '0' .. '9' | '\'' | '_' as c)) ->
      (Stream.junk __strm; c)
  | _ -> raise Stream.Failure
  
let num (__strm : _ Stream.t) =
  match Stream.peek __strm with
  | Some (('0' .. '9' | '_' as c)) -> (Stream.junk __strm; c)
  | _ -> raise Stream.Failure
  
let escaped (__strm : _ Stream.t) =
  match Stream.peek __strm with
  | Some (('0' .. '9' as c1)) ->
      (Stream.junk __strm;
       (match Stream.peek __strm with
        | Some (('0' .. '9' as c2)) ->
            (Stream.junk __strm;
             (match Stream.peek __strm with
              | Some (('0' .. '9' as c3)) ->
                  (Stream.junk __strm; [ c1; c2; c3 ])
              | _ -> raise (Stream.Error "")))
        | _ -> raise (Stream.Error "")))
  | Some c -> (Stream.junk __strm; [ c ])
  | _ -> raise Stream.Failure
  
let char (__strm : _ Stream.t) =
  match Stream.peek __strm with
  | Some '\\' ->
      (Stream.junk __strm;
       let l =
         (try escaped __strm with | Stream.Failure -> raise (Stream.Error ""))
       in
         (match Stream.peek __strm with
          | Some '\'' -> (Stream.junk __strm; implode ('\\' :: l))
          | _ -> raise (Stream.Error "")))
  | Some c ->
      (Stream.junk __strm;
       (match Stream.peek __strm with
        | Some '\'' -> (Stream.junk __strm; String.make 1 c)
        | _ -> raise (Stream.Error "")))
  | _ -> raise Stream.Failure
  
let rec string ~acc (__strm : _ Stream.t) =
  match Stream.peek __strm with
  | Some '"' -> (Stream.junk __strm; implode (List.rev acc))
  | Some '\'' ->
      (Stream.junk __strm;
       let l =
         (try escaped __strm with | Stream.Failure -> raise (Stream.Error "")) in
       let s = __strm in string ~acc: (List.rev_append l ('\'' :: acc)) s)
  | Some c ->
      (Stream.junk __strm; let s = __strm in string ~acc: (c :: acc) s)
  | _ -> raise Stream.Failure
  
let rec token (__strm : _ Stream.t) =
  match Stream.peek __strm with
  | Some (('A' .. 'Z' | 'a' .. 'z' | '_' as c)) ->
      (Stream.junk __strm;
       let l =
         (try star alphanum ~acc: [ c ] __strm
          with | Stream.Failure -> raise (Stream.Error ""))
       in Ident (implode l))
  | Some (('0' .. '9' as c)) ->
      (Stream.junk __strm;
       let l =
         (try star ~acc: [ c ] num __strm
          with | Stream.Failure -> raise (Stream.Error ""))
       in Num (int_of_string (implode l)))
  | Some '(' ->
      (Stream.junk __strm;
       (try may_comment __strm
        with | Stream.Failure -> raise (Stream.Error "")))
  | Some '\'' ->
      (Stream.junk __strm;
       let s = __strm in (try Char (char s) with | _ -> token s))
  | (* skip type variables... *) Some '"' ->
      (Stream.junk __strm;
       let s =
         (try string ~acc: [] __strm
          with | Stream.Failure -> raise (Stream.Error ""))
       in String s)
  | Some (' ' | '\n' | '\r' | '\t') -> (Stream.junk __strm; token __strm)
  | Some c -> (Stream.junk __strm; Sym c)
  | _ -> raise End_of_file
and may_comment (__strm : _ Stream.t) =
  match Stream.peek __strm with
  | Some '*' ->
      (Stream.junk __strm;
       let s = __strm in
       let s' = lexer s in (skip (Sym '*') s'; may_close_comment s'))
  | _ -> Sym '('
and may_close_comment (__strm : _ Stream.t) =
  match Stream.peek __strm with
  | Some (Sym ')') ->
      (Stream.junk __strm;
       (match Stream.peek __strm with
        | Some tok -> (Stream.junk __strm; tok)
        | _ -> raise (Stream.Error "")))
  | _ -> let s = __strm in (skip (Sym '*') s; may_close_comment s)
and lexer s =
  Stream.lcons (fun _ -> token s) (Stream.slazy (fun _ -> lexer s))
  
(**** The actual checker ***)
let defs = Hashtbl.create 13
  
let add impl name =
  try
    let name' = Hashtbl.find defs impl
    in
      Printf.eprintf
        "externals [%s] and [%s] have same implementation \"%s\"\n" name'
        name impl
  with | Not_found -> Hashtbl.add defs impl name
  
let may_string (__strm : _ Stream.t) =
  match Stream.peek __strm with
  | Some (String s) -> (Stream.junk __strm; s)
  | _ -> ""
  
let rec skip_type (__strm : _ Stream.t) =
  match Stream.peek __strm with
  | Some (Sym '=') -> (Stream.junk __strm; ())
  | Some (Sym '(') ->
      (Stream.junk __strm;
       let _ =
         (try skip (Sym ')') __strm
          with | Stream.Failure -> raise (Stream.Error ""))
       in skip_type __strm)
  | Some (Sym '[') ->
      (Stream.junk __strm;
       let _ =
         (try skip (Sym ']') __strm
          with | Stream.Failure -> raise (Stream.Error ""))
       in skip_type __strm)
  | Some _ -> (Stream.junk __strm; skip_type __strm)
  | _ -> raise Stream.Failure
  
let check_external (__strm : _ Stream.t) =
  match Stream.peek __strm with
  | Some (Ident name) ->
      (Stream.junk __strm;
       (match Stream.peek __strm with
        | Some (Sym ':') ->
            (Stream.junk __strm;
             let _ =
               (try skip_type __strm
                with | Stream.Failure -> raise (Stream.Error ""))
             in
               (match Stream.peek __strm with
                | Some (String impl) ->
                    (Stream.junk __strm;
                     let native1 =
                       (try may_string __strm
                        with | Stream.Failure -> raise (Stream.Error "")) in
                     let native2 =
                       (try may_string __strm
                        with | Stream.Failure -> raise (Stream.Error ""))
                     in
                       (if (impl <> "") && (impl.[0] <> '%')
                        then add impl name
                        else ();
                        let native =
                          (match (native1, native2) with
                           | (("noalloc" | "float"), ("noalloc" | "float"))
                               -> ""
                           | (("noalloc" | "float"), n) -> n
                           | (n, _) -> n)
                        in if native <> "" then add native name else ()))
                | _ -> raise (Stream.Error "")))
        | _ -> raise (Stream.Error "")))
  | _ -> raise Stream.Failure
  
let check f =
  (prerr_endline ("processing " ^ f);
   let ic = open_in f in
   let chars = Stream.of_channel ic in
   let s = lexer chars
   in
     try while true do skip (Ident "external") s; check_external s done
     with | End_of_file -> ()
     | Stream.Error _ | Stream.Failure ->
         (Printf.eprintf "Parse error in file `%s' before char %d\n" f
            (Stream.count chars);
          exit 2)
     | exn ->
         (Printf.eprintf "Exception %s in file `%s' before char %d\n"
            (Printexc.to_string exn) f (Stream.count chars);
          exit 2))
  
let main () = Arg.parse [] check "usage: check_externals file.ml ..."
  
let () = Printexc.print main ()
  

