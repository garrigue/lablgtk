(* $Id$ *)

open Xml_lexer

let parse_header lexbuf =
  begin match token lexbuf with Tag ("?xml",_,true) -> ()
  | _ -> failwith "no XML header" end;
  begin match token lexbuf with Tag ("gtk-interface",_,_) -> ()
  | _ -> failwith "no GTK-interface declaration" end

let parse_field lexbuf ~tag =
  let b = Buffer.create 80 and first = ref true in
  while match token lexbuf with
    Chars s ->
      if not !first then Buffer.add_char b '\n' else first := false;
      Buffer.add_string b s;
      true
  | Endtag tag' when tag = tag' ->
      false
  | _ ->
      failwith "bad field"
  do () done;
  Buffer.contents b

type wtree = { wclass: string; wname: string; wchildren: wtree list }

let rec parse_widget lexbuf =
  let wclass = ref None and wname = ref None and widgets = ref [] in
  while match token lexbuf with
    Tag ("class",_,false) ->
      wclass := Some (parse_field lexbuf ~tag:"class"); true
  | Tag ("name",_,false) ->
      wname := Some (parse_field lexbuf ~tag:"name"); true
  | Tag ("widget",_,false) ->
      widgets := parse_widget lexbuf :: !widgets; true
  | Tag (tag,_,closed) ->
      if not closed then while token lexbuf <> Endtag tag do () done; true
  | Endtag "widget" ->
      false
  | Chars _ ->
      true
  | Endtag _ | EOF ->
      failwith "bad XML syntax"
  do () done;
  match !wclass, !wname with
  | Some wclass, Some wname ->
      {wclass = wclass; wname = wname; wchildren = List.rev !widgets}
  | Some wclass, None ->
      failwith ("no name for widget of class " ^ wclass)
  | None, Some wname ->
      failwith ("no class for widget " ^ wname)
  | None, None ->
      failwith "empty widget"

let classes = ref [
  "GtkWidget", ("GtkBase.Widget", "GObj.widget");
  "GtkContainer", ("GtkBase.Container", "GContainer.container");
  "GtkWindow", ("GtkWindow.Window", "GWindow.window");
  "GtkBox", ("GtkPack.Box", "GPack.box");
  "GtkHBox", ("GtkPack.Box", "GPack.box");
  "GtkVBox", ("GtkPack.Box", "GPack.box");
  "GtkMenuBar", ("GtkMenu.MenuBar", "GMenu.menu_shell");
  "GtkMenuItem", ("GtkMenu.MenuItem", "GMenu.menu_item");
  "GtkScrolledWindow", ("GtkBin.ScrolledWindow", "GBin.scrolled_window");
] 

let rec output_widget w =
  let (modul, clas) = List.assoc w.wclass !classes in
  Printf.printf "  method %s = new %s\n" w.wname clas;
  Printf.printf "    (%s.cast (Glade.get_widget xml ~name:\"%s\")\n"
    modul w.wname;
  List.iter ~f:output_widget w.wchildren

let parse_body lexbuf =
  match token lexbuf with
    Tag("project", _, closed) ->
      if not closed then while token lexbuf <> Endtag "project" do () done
  | Tag("widget", _, false) ->
      let wtree = parse_widget lexbuf in
      output_widget wtree
  | _ ->
      ()
