(**************************************************************************)
(*    Lablgtk - Examples                                                  *)
(*                                                                        *)
(*    This code is in the public domain.                                  *)
(*    You may freely copy parts of it in your application.                *)
(*                                                                        *)
(**************************************************************************)

(* Incompletely ported from the lablgtk2 example; it
   compiles but the completion provider does not work.

   Compile with
   dune build sourceview2.exe
   Run with
   ../../_build/default/examples/sourceview/sourceview2.exe
*)

let locale = GtkMain.Main.init ()

let provider =
  let open GSourceView3 in
  let provider_ref = ref None in
  let provided_list = ["toto"; "titi"; "tata"] in
  let do_provider () = match !provider_ref with None -> assert false | Some x -> x in
  let populate ctx =
    let item s = source_completion_item ~label:s ~text:s () in
    let proposal s = (item s :> source_completion_proposal) in
    let proposals = List.map proposal provided_list in
    ctx#add_proposals (do_provider ()) proposals true
  in
  let info_widget provider =
    let label = GMisc.label ~text:"toto" () in
    (* This does not compile, complaining that
     *   Type Gtk.widget Gobject.obj is not compatible with type GObj.widget

    Some (label#coerce#as_widget)
    *)
    None
  in
  let provider =
    let custom_provider : custom_completion_provider =
      object (self)
        method name = "default"
        method icon = Some (GdkPixbuf.create 60 60 ())
        method populate = populate
        method activation = []
        method matched = (fun _ -> true)
        method info_widget = info_widget
        method update_info = (fun _ _ -> ())
        method start_iter = (fun _ _ _ -> false)
        method activate_proposal = (fun _ _ -> false)
        method interactive_delay = 0
        method priority = 0
      end
    in
    GSourceView3.source_completion_provider custom_provider
  in
  provider_ref := (Some provider);
  provider

module C = GSourceView3

let window = GWindow.window ~width:400 ~height:400 ()
let box = GPack.vbox ~packing:window#add ()
let button = GButton.button ~label:"Click" ~packing:(box#pack) ()
let v = GSourceView3.source_view ~packing:(box#pack ~expand:true) ()
let cpl = v#completion
let _ = cpl#add_provider provider
let () = window#show ()
let cb () =
  let itr = v#buffer#start_iter in
  let ctx = cpl#create_context itr in
  ignore (cpl#show [provider] ctx)

let _ = button#connect#clicked cb

(* let _ = cpl#add_provider provider *)
(* let _ = Glib.Timeout.add 1000 (fun _ -> cpl#show [provider] ctx) *)
(*   let _ = completion#add_provider provider in *)

let () =
  GMain.Main.main ()
