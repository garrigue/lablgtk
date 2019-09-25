(* File: pango2.ml
   Originally part of library ocaml-pango by Christophe Troestler under name
      rendering.ml
   Ported to lablgtk3 and changed to create output on GtkWindow by
      Claudio Sacerdoti Coen

   Copyright (C) 2009

     Christophe Troestler <Christophe.Troestler@umons.ac.be>
     WWW: http://math.umh.ac.be/an/software/

   This library is free software; you can redistribute it and/or modify
   it under the terms of the GNU Lesser General Public License version 3 or
   later as published by the Free Software Foundation, with the special
   exception on linking described in the file LICENSE.

   This library is distributed in the hope that it will be useful, but
   WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the file
   LICENSE for more details. *)

(* Based on https://cairographics.org/cookbook/pycairo_pango/ *)


let expose drawing_area cr =
  let allocation = drawing_area#misc#allocation in
  let width = float allocation.Gtk.width in
  let height = float allocation.Gtk.height in
  (* Draw a background rectangle: *)
  Cairo.rectangle cr 0. 0. ~w:width ~h:height;
  Cairo.set_source_rgb cr 1. 1. 1.;
  Cairo.fill cr;
  (* Get font families: *)
  let font_map = Cairo_pango.Font_map.get_default() in

  Cairo.translate cr 50. 25.;
  let pc = Cairo_pango.Font_map.create_context font_map in
  let layout = Pango.Layout.create pc in
  let fontname = if Array.length Sys.argv >= 2 then Sys.argv.(1) else "Sans" in
  let font = Pango.Font.from_string fontname in
  Pango.Layout.set_font_description layout font;
  Pango.Layout.set_text layout "Hello world こんにちは世界";
  Cairo.set_source_rgb cr 0. 0. 0.;
  Cairo_pango.update_layout cr layout;
  Cairo_pango.show_layout cr layout;
  true

let () =
  let _ = GMain.init () in
  let w = GWindow.window ~title:"Pango demo2" ~width:500 ~height:400 () in
  ignore(w#connect#destroy ~callback:GMain.quit);

  let d = GMisc.drawing_area ~packing:w#add () in
  ignore(d#misc#connect#draw ~callback:(expose d));

  w#show();
  GMain.main()
