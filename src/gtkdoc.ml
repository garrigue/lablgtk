
let base_uri =
  ref "http://developer.gnome.org/doc/API/2.0"

let may ov f = 
  match ov with
  | None -> ()
  | Some v -> f v

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

class gtkdoc =
  object (self)
    inherit Odoc_html.html

    method prepare_header module_list =
      header <-
IFDEF OCAML_308 
THEN
        make_prepare_header style self#index module_list
ELSE
    	let b = Buffer.create 1024 in
    	fun ?nav ?comments t ->
    	  Buffer.clear b ;
    	  make_prepare_header style index module_list b ?nav ?comments t ;
    	  Buffer.contents b
END

    initializer
      tag_functions <- ("gtkdoc", gtkdoc) :: tag_functions 
  end

let _ = 
  Odoc_info.Args.add_option
    ("-base-uri", Arg.String ((:=) base_uri), 
     "base URI of the GTK/GNOME documentation") ;
  Odoc_info.Args.set_doc_generator 
    (Some (new gtkdoc :> Odoc_info.Args.doc_generator))
