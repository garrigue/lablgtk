(**************************************************************************)
(*                Lablgtk                                                 *)
(*                                                                        *)
(*    This program is free software; you can redistribute it              *)
(*    and/or modify it under the terms of the GNU Library General         *)
(*    Public License as published by the Free Software Foundation         *)
(*    version 2, with the exception described in file COPYING which       *)
(*    comes with the library.                                             *)
(*                                                                        *)
(*    This program is distributed in the hope that it will be useful,     *)
(*    but WITHOUT ANY WARRANTY; without even the implied warranty of      *)
(*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the       *)
(*    GNU Library General Public License for more details.                *)
(*                                                                        *)
(*    You should have received a copy of the GNU Library General          *)
(*    Public License along with this program; if not, write to the        *)
(*    Free Software Foundation, Inc., 59 Temple Place, Suite 330,         *)
(*    Boston, MA 02111-1307  USA                                          *)
(*                                                                        *)
(*                                                                        *)
(**************************************************************************)

let base_uri =
  ref "http://developer.gnome.org/doc/API/2.0"
let _ = 
  Odoc_args.add_option
    ("-base-uri", Arg.String ((:=) base_uri), 
     "base URI of the GTK/GNOME documentation")

let may ov f = 
  match ov with
  | None -> ()
  | Some v -> f v

(* ocamldoc generates tons of <link> tags. This seriously inflates the
   size of the HTML pages so here we redefine the function to only define the
   'Start' 'next' and 'Up' links. *)
let make_prepare_header style index module_list =
  fun b ?(nav=None) ?(comments=[]) t ->
    let link l dest =
      Printf.bprintf b "<link rel=\"%s\" href=\"%s\">\n" l dest in
    let link_file l dest =
      link l (fst (Odoc_html.Naming.html_files dest)) in
    Buffer.add_string b "<head>\n" ;
    Buffer.add_string b style ;
    link "Start" index ;
    may nav
      (fun (pre_opt, post_opt, name) ->
	may pre_opt  (link_file "previous") ;
	may post_opt (link_file "next") ;
	match Odoc_info.Name.father name with
	| "" -> link "Up" index
	| s  -> link_file "Up" s
      ) ;
    Printf.bprintf b "<title>%s</title>\n</head>\n" t

let gtkdoc = function
  | Odoc_info.Raw name :: _ ->
      begin match Str.split (Str.regexp "[ \t]+") name with
      | dir :: widget :: _ ->
	  Printf.sprintf
	    "<small>GTK documentation:&nbsp;\
               <a href=\"%s/%s/%s.html\">%s</a>\
             </small>"
	    !base_uri dir widget widget
      | _ -> failwith "bad @gtkdoc format"
      end
  | _ -> failwith "bad @gtkdoc format"

open Odoc_info.Value
open Odoc_info.Module

IFDEF OCAML_400
THEN
module Generator (G : Odoc_html.Html_generator) =
struct
class html =
  object (self)
    inherit G.html as super

    method prepare_header module_list =
      header <-
        make_prepare_header style self#index module_list

    method html_of_class b ?complete ?with_link c =
      super#html_of_class b ?complete ?with_link c ;
      Buffer.add_string b "<br>"

    initializer
      tag_functions <- ("gtkdoc", gtkdoc) :: tag_functions 
  end
end

let _ = 
  Odoc_args.extend_html_generator 
    (module Generator : Odoc_gen.Html_functor)

ELSE

class gtkdoc =
  object (self)
    inherit Odoc_html.html as super

    method html_of_value b v =
      v.val_code <- None ;
      super#html_of_value b v

    method html_of_attribute b a =
      a.att_value.val_code <- None ;
      super#html_of_attribute b a

    method html_of_method b m =
      m.met_value.val_code <- None ;
      super#html_of_method b m 

    method generate_for_module pre post modu =
      modu.m_code <- None ;
      super#generate_for_module pre post modu

    method prepare_header module_list =
      header <-
        make_prepare_header style self#index module_list

    method html_of_class b ?complete ?with_link c =
      super#html_of_class b ?complete ?with_link c ;
      Buffer.add_string b "<br>"

    initializer
      tag_functions <- ("gtkdoc", gtkdoc) :: tag_functions 
  end

let _ = 
  Odoc_info.Args.set_doc_generator 
    (Some (new gtkdoc :> Odoc_info.Args.doc_generator))

END
