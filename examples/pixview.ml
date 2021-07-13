(**************************************************************************)
(*    Lablgtk - Examples                                                  *)
(*                                                                        *)
(*    This code is in the public domain.                                  *)
(*    You may freely copy parts of it in your application.                *)
(*                                                                        *)
(**************************************************************************)

(* $Id$ *)

(* An image viewer, supporting all formats allowed by GdkPixbuf *)

if Array.length Sys.argv < 2 then begin
    Printf.eprintf "usage : %s <file>\n" Sys.argv.(0);
    exit 2
  end;;

let file = Sys.argv.(1)
let pb =
  try
    match String.lowercase_ascii (Filename.extension file) with
    | "svg" -> Rsvg2.render_from_file file
    | _ -> GdkPixbuf.from_file file
  with GdkPixbuf.GdkPixbufError(_,msg) as exn ->
    let d = GWindow.message_dialog ~message:msg ~message_type:`ERROR
        ~buttons:GWindow.Buttons.close ~show:true () in
    d#run ();
    raise exn

let () =
  GMain.init ();
  let width = GdkPixbuf.get_width pb in
  let height = GdkPixbuf.get_height pb in
  let w = GWindow.window ~width ~height ~title:file () in
  w#connect#destroy GMain.quit;
  let image = GMisc.image ~pixbuf:pb () in
  w#add image#coerce ;
  w#show ();
  GMain.main ()

