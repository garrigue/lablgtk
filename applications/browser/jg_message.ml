(*************************************************************************)
(*                                                                       *)
(*                Objective Caml LablTk library                          *)
(*                                                                       *)
(*            Jacques Garrigue, Kyoto University RIMS                    *)
(*                                                                       *)
(*   Copyright 1999 Institut National de Recherche en Informatique et    *)
(*   en Automatique and Kyoto University.  All rights reserved.          *)
(*   This file is distributed under the terms of the GNU Library         *)
(*   General Public License, with the special exception on linking       *)
(*   described in file ../../../LICENSE.                                 *)
(*                                                                       *)
(*************************************************************************)

(* $Id$ *)

open StdLabels

(*
class formatted ~parent ~width ~maxheight ~minheight =
  val parent = (parent : Widget.any Widget.widget)
  val width = width
  val maxheight = maxheight
  val minheight = minheight
  val tw = Text.create ~parent ~width ~wrap:`Word
  val fof = Format.get_formatter_output_functions ()
  method parent = parent
  method init =
    pack [tw] ~side:`Left ~fill:`Both ~expand:true;
    Format.print_flush ();
    Format.set_margin (width - 2);
    Format.set_formatter_output_functions ~out:(Jg_text.output tw)
      ~flush:(fun () -> ())
  method finish =
    Format.print_flush ();
    Format.set_formatter_output_functions ~out:(fst fof) ~flush:(snd fof);
    let `Linechar (l, _) = Text.index tw ~index:(tposend 1) in
    Text.configure tw ~height:(max minheight (min l maxheight));
    if l > 5 then
    pack [Jg_text.add_scrollbar tw] ~before:tw ~side:`Right ~fill:`Y
end
*)

let formatted ~title ?on ?(ppf = Format.std_formatter)
  ?(width=60) ?(maxheight=10) ?(minheight=0) () =
  let frame =
    match on with
      Some frame ->
        (frame :> GContainer.container)
    | None ->
        let tl = GWindow.window ~title () in
        (GPack.hbox ~packing:tl#add () :> GContainer.container)
  in
  let sw =
    GBin.scrolled_window ~hpolicy:`AUTOMATIC ~vpolicy:`AUTOMATIC
      ~packing:frame#add () in
  let tw = GText.view ~packing:sw#add ()  in
  Format.pp_print_flush ppf ();
  Format.pp_set_margin ppf (width - 2);
  let fof,fff = Format.pp_get_formatter_output_functions ppf () in
  Format.pp_set_formatter_output_functions ppf
    (fun buf pos len -> tw#buffer#insert (String.sub buf ~pos ~len))
    ignore;
  tw,
  begin fun () ->
    Format.pp_print_flush ppf ();
    Format.pp_set_formatter_output_functions ppf fof fff;
  end

let ask ~title ?master ?(no=true) ?(cancel=true) text =
  let tl = GWindow.dialog ~title ~modal:true () in
  Gaux.may tl#set_transient_for master;
  GMisc.label ~text ~packing:tl#vbox#add ~xpad:20 ~ypad:10
    ~width:250 ~justify:`LEFT ~line_wrap:true ~xalign:0. ();
  let r = ref `Cancel in
  let mkbutton label ~callback =
    let b = GButton.button ~label ~packing:tl#action_area#add () in
    ignore (b#connect#clicked ~callback)
  in
  mkbutton (if no || cancel then "Yes" else "Dismiss")
    ~callback:(fun () -> r := `Yes; tl#destroy ());
  if no then mkbutton "No" ~callback:(fun () -> r := `No; tl#destroy ());
  if cancel then
    mkbutton "Cancel" ~callback:(fun () -> r := `Cancel; tl#destroy ());
  tl#connect#destroy ~callback:GMain.quit;
  GMain.main ();
  !r

let info ~title ?master text =
  ignore (ask ~title ?master ~no:false ~cancel:false text)
