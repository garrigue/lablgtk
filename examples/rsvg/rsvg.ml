

let zoom  = ref None
let dpi   = ref None
let fname = ref ""

let _ = 
  let cli_args = [
    ( "-zoom", Arg.Float (fun v -> zoom := Some v), "zoom factor" ) ;
    ( "-dpi" , Arg.Float (fun v -> dpi := Some v),  "") ] in
  let usg_msg = Printf.sprintf "usage: %s [options] <file>\n"
      (Filename.basename Sys.argv.(0)) in
  Arg.parse cli_args ((:=) fname) usg_msg ;
  if not (Sys.file_exists !fname)
  then begin
    Arg.usage cli_args usg_msg ; 
    exit 2 
  end

let pb =
  let size_cb = match !zoom with
  | None -> None
  | Some z -> Some (Rsvg.at_zoom z z) in
  Rsvg.render_from_file ?dpi:!dpi ?size_cb !fname

let width  = GdkPixbuf.get_width pb
let height = GdkPixbuf.get_height pb

let w = GWindow.window ~width ~height ~title:!fname ()
let i = GMisc.image ~packing:w#add ()

let () = 
  i#set_pixbuf pb ;
  w#connect#destroy GMain.quit;
  w#show ();
  GMain.main ()
