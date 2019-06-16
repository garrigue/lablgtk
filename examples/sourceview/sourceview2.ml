(**************************************************************************)
(*    Lablgtk - Examples                                                  *)
(*                                                                        *)
(*    This code is in the public domain.                                  *)
(*    You may freely copy parts of it in your application.                *)
(*                                                                        *)
(**************************************************************************)
(* #require "lablgtksourceview2.gtksourceview2";; *)

let provider =
  let open GSourceView2 in
  let provider_ref = ref None in
  let provided_list = ["toto"; "titi"; "tata"] in
  let do_provider () = match !provider_ref with None -> assert false | Some x -> x in
  let populate context =
    let ctx = new source_completion_context context in
    let item s = source_completion_item ~label:s ~text:s () in
    let proposal s = (item s :> source_completion_proposal) in
    let proposals = List.map proposal provided_list in
    ctx#add_proposals (do_provider ()) proposals true
  in
  let info_widget provider =
    let label = GMisc.label ~text:"toto" () in
    Some (label#coerce#as_widget)
  in
  let provider =
    let provider = {
      provider_name = "default";
      provider_icon = Some (GdkPixbuf.create 60 60 ());
      provider_populate = populate;
      provider_activation = [];
      provider_match = (fun _ -> true);
      provider_info_widget = info_widget;
      provider_update_info = (fun _ _ -> ());
      provider_start_iter = (fun _ _ _ -> false);
      provider_activate_proposal = (fun _ _ -> false);
      provider_interactive_delay = 0;
      provider_priority = 0;
    } in
    GSourceView2.source_completion_provider provider
  in
  provider_ref := (Some provider);
  provider

module C = GSourceView2

let window = GWindow.window ~width:400 ~height:400 ()
let box = GPack.vbox ~packing:window#add ()
let button = GButton.button ~label:"Click" ~packing:(box#pack) ()
let v = GSourceView2.source_view ~packing:(box#pack ~expand:true) ()
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
