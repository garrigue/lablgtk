(*  ------------------------------------------------------------------ 
    $Id$

    Copyright (c) 1999 Christian Lindig <lindig@ips.cs.tu-bs.de>. All
    rights reserved. See COPYING for details.
    ------------------------------------------------------------------ *)

open Pp                                 (* pretty printer *)
open Lc                                 (* lexer combinators *)
open Std                                (* << and >> *)
                                        

(*
 * xml abstract syntax
 *) 

type name	= string
type attribute	= name * name           (* name="value" *)
type pi         = name * string list    (* processing instruction *)

type element	= Eelement  of	    name * attribute list * element list
		| Eempty    of	    name * attribute list
		| Echunk    of	    string
                | Epi       of      pi 
                
type dtd_id     = DTDsys    of      string
                | DTDpub    of      string * string
               
(* 
 * dtd is incomplete - no markup type provided 
 *)
 
type dtd        = DTD       of      name * dtd_id option 

type xmldecl    = XMLDecl   of string            (* version *)
                             * bool option       (* standalone *)
                             * string option     (* encoding *) 

type prolog     = Prolog    of xmldecl option 
                             * dtd option 
                             * pi list 

type document   = XML       of prolog * element * pi list                

(* pretty printing functions for XML 
 *)

(* [ppList] formats a list by applying [f] to its members and seperates
 * members from each other using [sep]. No grouping.
 *)

let rec ppList sep f xs =
    let rec loop = function
        | []    -> empty
        | [x]   -> f x 
        | x::xs -> f x ^^ sep ^^ loop xs
    in loop xs

(* [ppString] prints a string embedded into quotes. If the string
 * itself contains double quotes single quotes are used and double quotes
 * otherwise.
 *)
 
let ppString str =
    let hasQuote str    = try  String.index str '"' >= 0
                          with Not_found -> false  in
    let quote           = if hasQuote str then text "'" else text "\"" 
    in
        quote ^^ text str ^^ quote

        
(* [ppAttribute] pretty prints a single attribute 
 *)
let ppAttribute (name,v) = text name ^^ text "=" ^^ ppString v

    
(* [ppAttributes] pretty prints a list of attributes 
 *)
let ppAttributes = function
    | []            -> empty 
    | attrs         -> agrp (nest 4 (  break 
                                    ^^ ppList break ppAttribute attrs
                                    )
                            )
      
(* [ppStart] prints a start tag including attributes 
 *)
let ppStart name attrs          = agrp (  text "<"  
                                       ^^ text name  
                                       ^^ ppAttributes attrs 
                                       ^^ text ">"
                                       )

(* [ppEnd] print an end tag 
 *)                                          
let ppEnd name                  = agrp (  text "</" 
                                       ^^ text name 
                                       ^^ text ">"
                                       )

(* [ppEmpty] prints an empty tag 
 *)
let ppEmpty name attrs          = agrp (  text "<" 
 	                               ^^ text name
 	                               ^^ ppAttributes attrs
 	                               ^^ text "/>"
                                       )

(* [ppPI] prints a processing instruction 
 *)
let ppPI (target,strs)  =
    agrp  (  text "<?" 
          ^^ text target 
          ^^ nest 4 (  break
                    ^^ fgrp (ppList break text strs)
                    )
          ^^ text "?>"
          )

(* [ppELements] prints a list of elements in a fgrp. 
 *) 


(* [ppJoin] joins a list of pretty printable documents using the
 * [^^] concatenation operator. *)

let ppJoin docs =
    let rec loop = function 
        | []    -> empty
        | [d]   -> d
        | d::ds -> d ^^ loop ds
    in
        loop docs 

(* [split] takes a string and splits it into word and whitespace. 
   Words are turned into pretty printable [text] and whitespace into
   [break]s.  A sequence of whitespace is turned into one [break] and
   thus whitespace is shrinked.

   [split] returns two pretty printable documents [doc,tail].  [doc]
   contains the all the words and whitespace of [str] up to the
   trailing whitespace in [str].  The trailing whitespace in [str] is
   returned separately as [tail] which is either [break] when [str]
   does end with whitespace or [empty] otherwise.  The reason for this
   is, that the trailing whitespace sometimes need some special
   treatment.  If this is not required [doc] and [tail] can simply be
   concatenated:  [doc ^^ tail] to get a pretty printable
   representation of [str].

   The implementation of [split] uses lexer combinators from the [Lc]
   module. See the documentation of [save] and [scan] there why List.rev
   is neccessary to get the right result.

   The split function is the right place to encode non printable
   characters for output.  This does not happen right now.
*)
   
let split str =
    let is_space c              = c = ' ' || c = '\n' 
                                          || c = '\r' || c = '\n'       in
    let space                   = some (satisfy is_space)               in
    let alpha                   = satisfy (fun c -> not (is_space c))   in
    let asText str start len    = text (String.sub str start len)       in
    let asBreak str start len   = break                                 in 
    let whitespace              = save asBreak space ||| succeed        in
    let word                    = whitespace *** save asText (some alpha) in
    let body,doc = scanFrom 0    str (many word)                        in
    let tail,_   = scanFrom body str (opt space *** eof)                in
        (ppJoin << List.rev) doc, if tail > 0 then break else empty

(* [ppElements] pretty prints a list of elements.  When the list ends
   with a chunk of character data and this chunk ends with trailing
   whitespace this whitespace is treated specially to achiev a nicer
   layout:  this whitespace is not part of the [nest] group like the
   rest of the elements.  This will lead to a nice indentation of the
   closing tag following this list of elements.  *)
   
let rec ppElements elems =
    let rec loop doc = function
        | []                    -> (doc, empty)
        | [Echunk(chunk)]       -> let cdoc, tail = split chunk in
                                        (doc ^^ cdoc, tail)
        | e::es                 -> loop (doc ^^ ppElement e) es
    in
        let doc, tail = loop empty elems        in
            fgrp (nest 4 doc) ^^ tail
                                         

(* [ppEelement] prints an element with all its sub elements 
 *)
and ppElement = function            
    | Echunk(chunk)                 -> let doc, tail = split chunk in
                                           doc ^^ tail
    | Eelement(name,attrs,elems)    -> agrp (  ppStart name attrs 
                                            ^^ ppElements elems 
                                            ^^ ppEnd name
                                            )
    | Eempty(name,attrs)            -> ppEmpty name attrs
    | Epi(target,str)               -> ppPI (target, str)


(* [ppXMLDecl] prints an <xml .. ?> declaration 
 *)
let ppXMLDecl (XMLDecl(v,sa_opt,enc_opt)) =
    agrp (  text "<?xml"
         ^^ nest 4 (  break
                   ^^ ppAttribute ("version",v)
                   ^^ ( match enc_opt with
                      | Some enc      -> break 
                                         ^^ ppAttribute ("encoding",enc)
                      | None          -> empty 
                      )
                   ^^ ( match sa_opt with
                      | Some true     ->  break 
                                          ^^ ppAttribute ("standalone","yes")
                      | Some false    ->  break 
                                          ^^ ppAttribute ("standalone","no")
                      | None          ->  empty
                      )
                  )
         ^^ text "?>"
         )

(*
 * [ppDTD] prints the document type declaration. Because the
 * [dtd] type is incomplete inline DTD declarations are not
 * supported.
 *)

let ppDTD (DTD(name,id_opt)) =
    agrp (text "<!DOCTYPE"
          ^^ nest 4 
            (   break
            ^^ text name
            ^^ ( match id_opt with
               | None -> 
                   empty
               | Some(DTDsys(path)) -> 
                   break
                   ^^ text "SYSTEM" 
                   ^^ break
                   ^^ ppString path
               | Some(DTDpub(name,url))->
                   break
                   ^^ text "PUBLIC"
                   ^^ break
                   ^^ ppString name
                   ^^ break
                   ^^ ppString url
               )
            ) 
          ^^ text ">") 
              
                  
(* [ppXMLProlog] prints the prolog of an XML document
 *)
let ppXMLProlog (Prolog(xmldecl,dtd,pis)) =
    ( match xmldecl with 
    | Some decl         -> ppXMLDecl decl
    | None              -> empty
    )
    ^^ break ^^
    ( match dtd with
    | Some(dtd)         -> ppDTD dtd
    | None              -> empty
    )
    ^^ break ^^
    vgrp (ppList break ppPI pis)

(* [xmldoc] prints a whole XML document into a [doc] data type which
 * then can be pretty printed using the [Pp] module.
 *)
let ppDoc (XML(prolog,element,pi's)) =
    agrp (  ppXMLProlog prolog ^^ break     
         ^^ ppElement element ^^ break 
         ^^ vgrp (ppList break ppPI pi's)
         ) 

