(* File: pango1.ml
   Originally part of library ocaml-pango by Christophe Troestler under name
      pango_demo.ml
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

open Cairo

let two_pi = 2. *. acos(-1.)

(* Based on the example given at
   https://developer.gnome.org/pango/stable/pango-Cairo-Rendering.html *)
let draw_text radius (cr: context) =
  let n_words = 10 in
  let font = "Sans Bold 26" in
  Cairo.translate cr radius radius;
  let layout = new GPango.layout (Cairo_pango.create_layout cr) in
  layout#set_text "Text";
  let desc = GPango.font_description_from_string font in
  layout#set_font_description desc;
  (* Draw the layout [n_words] times in a circle. *)
  for i = 1 to n_words do
    let angle = two_pi *. float i /. float n_words in
    Cairo.save cr;
    let red = (1. +. cos(angle -. two_pi /. 6.)) /. 2. in
    Cairo.set_source_rgb cr red 0. (1. -. red);
    Cairo.rotate cr angle;
    (* Inform Pango to re-layout the text with the new transformation. *)
    Cairo_pango.update_layout cr layout#as_layout;
    let width, _height = layout#get_size in
    Cairo.move_to cr (-. (float width /. float Pango.scale) /. 2.) (-. radius);
    Cairo_pango.show_layout cr layout#as_layout;
    Cairo.restore cr;
  done

let expose drawing_area cr =
  let allocation = drawing_area#misc#allocation in
  let width = float allocation.Gtk.width in
  let height = float allocation.Gtk.height in
  let radius = min width height /. 2. in
  Cairo.set_source_rgb cr 1. 1. 1.;
  Cairo.paint cr;
  draw_text radius cr;
  true

let () =
  let _ = GMain.init () in
  let w = GWindow.window ~title:"Pango demo1" ~width:500 ~height:400 () in
  ignore(w#connect#destroy ~callback:GMain.quit);

  let d = GMisc.drawing_area ~packing:w#add () in
  ignore(d#misc#connect#draw ~callback:(expose d));

  w#show();
  GMain.main()
