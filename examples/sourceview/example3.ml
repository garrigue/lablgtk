(**************************************************************************)
(*    Lablgtk - Examples                                                  *)
(*                                                                        *)
(*    This code is in the public domain.                                  *)
(*    You may freely copy parts of it in your application.                *)
(*                                                                        *)
(**************************************************************************)

(* Compile with
   dune build test2.exe
   Run with
   ../../_build/default/examples/sourceview/test2.exe
*)

open Printf

let locale = GtkMain.Main.init ()

let lang_mime_type = "text/x-ocaml"
let lang_name = "ocaml"
let use_mime_type = true
let font_name = "Monospace 10"

let print_lang lang = prerr_endline (sprintf "language: %s" lang#name)

let print_lang_ids language_manager =
  let i = ref 0 in
  prerr_endline "language_ids:";
  List.iter
    (fun id -> incr i;
      match language_manager#language id with
      | Some lang ->
        let name = lang#name in
        let section = lang#section in
        prerr_endline
          (sprintf "%d: %s %s (%s)" !i id name section)
      | None -> ())
    language_manager#language_ids

let print_style_schemes mgr =
  let i = ref 0 in
  prerr_endline "style schemes:";
  List.iter (fun id ->
      incr i;
      match mgr#style_scheme id with
      | Some scm ->
        prerr_endline
          (sprintf "%d: %s %s" !i id scm#description)
      | None -> ())
    mgr#style_scheme_ids

let () =
  let win = GWindow.window ~title:"LablGtkSourceView test" () in
  let scrolled_win = GBin.scrolled_window
      ~hpolicy: `AUTOMATIC ~vpolicy: `AUTOMATIC
      ~packing:win#add ()
  in
  let source_view =
    GSourceView3.source_view
      ~auto_indent:true
      ~insert_spaces_instead_of_tabs:true ~tab_width:2
      ~show_line_numbers:true
      ~right_margin_position:80 ~show_right_margin:true
      (* ~smart_home_end:true *)
      ~packing:scrolled_win#add ~height:500 ~width:650
      ()
  in

  let language_manager = GSourceView3.source_language_manager ~default:true in

  let lang =
    if use_mime_type then
      (match language_manager#guess_language ~content_type:lang_mime_type () with
       | Some x -> x
       | None -> failwith (sprintf "no language for %s" lang_mime_type))
    else
      (match language_manager#language lang_name with
       | Some x -> x
       | None -> failwith (sprintf "can't load %s" lang_name))
  in

  print_lang_ids language_manager;
  print_lang lang;

  let style_scheme_manager =
    GSourceView3.source_style_scheme_manager ~default:true
  in

  print_style_schemes style_scheme_manager;

  let text =
    let ic = open_in "example3.ml" in
    let size = in_channel_length ic in
    let buf = Bytes.create size in
    really_input ic buf 0 size;
    close_in ic;
    buf
  in
  source_view#misc#modify_font_by_name font_name;
  source_view#source_buffer#set_highlight_matching_brackets true;
  source_view#source_buffer#set_language (Some lang);
  source_view#source_buffer#set_highlight_syntax true;

  source_view#set_smart_home_end `AFTER;
  if source_view#smart_home_end <> `AFTER then failwith "regret";

  source_view#set_draw_spaces [`SPACE; `NEWLINE];

  List.iter
    (function
      | `SPACE -> print_string " space"
      | `TAB -> print_string " tab"
      | `NEWLINE -> print_string " newline"
      | `NBSP -> print_string " nbsp"
      | `LEADING -> print_string "leading"
      | `TEXT -> print_string "text"
      | `TRAILING -> print_string "trailing")
    source_view#draw_spaces;
  print_newline ();

  ignore (win#connect#destroy (fun _ -> GMain.quit ()));
  ignore (source_view#connect#undo (fun _ -> prerr_endline "undo"));

  source_view#source_buffer#begin_not_undoable_action ();
  source_view#source_buffer#set_text (Bytes.to_string text);
  source_view#source_buffer#end_not_undoable_action ();

  win#show ();
  GMain.Main.main ()
