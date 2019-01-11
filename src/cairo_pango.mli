(* File: cairo_pango.mli

   Copyright (C) 2018-

     Christophe Troestler <Christophe.Troestler@umons.ac.be>
     WWW: http://math.umons.ac.be/an/software/

   This library is free software; you can redistribute it and/or modify
   it under the terms of the GNU Lesser General Public License version 3 or
   later as published by the Free Software Foundation, with the special
   exception on linking described in the file LICENSE.

   This library is distributed in the hope that it will be useful, but
   WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the file
   LICENSE for more details. *)

(** Interaction with Pango, a library for laying out and rendering of text. *)

(** Interacting with [Pango.font_map]. *)
module Font_map : sig
  type t = [`pangofontmap | `cairo] Gobject.obj
  (** A PangoCairoFontMap. *)

  val get_default : unit -> Pango.font_map
  (** [get_default()] gets a default Cairo fontmap to use with Cairo.
     The default Cairo fontmap can be changed by using {!set_default}.
     This can be used to change the Cairo font backend that the
     default fontmap uses for example.

     Note that the default fontmap is per-thread.  Each thread gets
     its own default fontmap.  In this way, Pango-Cairo can be used
     safely from multiple threads. *)

  val set_default : t -> unit
  (** [set_default fm] sets [fm] as the default fontmap to use with
       Cairo.  The default fontmap is per-thread. *)

  val create : unit -> Pango.font_map
  (** Creates a new fontmap; a fontmap is used to cache information
     about available fonts, and holds certain global parameters such
     as the resolution.  In most cases, you can use {!get_default}
     instead.

     Note that the type of the returned value will depend on the
     particular font backend Cairo was compiled to use.  You can
     override the type of backend returned by using an environment
     variable PANGOCAIRO_BACKEND.  Supported types, based on your
     build, are fc (fontconfig), win32, and coretext.  *)

  val create_for_font_type : Cairo.font_type -> Pango.font_map
  (** [create_for_font_type fonttype] creates a new fontmap object of
     the type suitable to be used with cairo font backend of type
     [fonttype].  In most cases one should simply use {!create}, or in
     fact in most of those cases, just use {!get_default}. *)

  val get_font_type : t -> Cairo.font_type
  (** Gets the type of Cairo font backend that fontmap uses. *)

  val set_resolution : t -> float -> unit
  (** Sets the resolution for the fontmap.  This is a scale factor
     between points specified in a [Pango.font_description] and Cairo
     units.  The default value is 96, meaning that a 10 point font
     will be 13 units high. (10 * 96. / 72. = 13.3). *)

  val get_resolution : t -> float
  (** Gets the resolution for the fontmap.  See {!set_resolution}. *)

  val create_context : Pango.font_map -> Pango.context
  (** [create_context fm] creates a Pango context connected to the
     fontmap [fm].  *)
end

type cairo_font = [`pangofont | `cairo] Gobject.obj

val get_scaled_font : cairo_font -> _ Cairo.Scaled_font.t

val set_resolution : Pango.context -> float -> unit
(** Sets the resolution for the context.  This is a scale factor
   between points specified in a [Pango.font_description] and Cairo
   units.  The default value is 96, meaning that a 10 point font will
   be 13 units high. (10 * 96. / 72. = 13.3). *)

val get_resolution : Pango.context -> float
(** Gets the resolution for the context. *)

val set_font_options : Pango.context -> Cairo.Font_options.t -> unit
(** [set_font_options cr options] sets the font options used when
   rendering text with [cr].  These options override any options that
   {!update_context} derives from the target surface. *)

val get_font_options : Pango.context -> Cairo.Font_options.t
(** Retrieves any font rendering options previously set with
   {!set_font_options}.  This function does not report options that
   are derived from the target surface by {!update_context}.  *)

val create_context : Cairo.context -> Pango.context
(** Creates a context object set up to match the current
   transformation and target surface of the Cairo context.  This
   context can then be used to create a layout using
   [Pango.Layout.create]. *)

val update_context : Cairo.context -> Pango.context -> unit
(** Updates a [Pango.context] previously created for use with Cairo to
   match the current transformation and target surface of a Cairo
   context.  If any layouts have been created for the context, it's
   necessary to call {!context_changed} on those layouts. *)

val create_layout : Cairo.context -> Pango.layout
(** [create_layout cr] creates a layout object set up to match the
   current transformation and target surface of the Cairo context [cr].
   This layout can then be used for text measurement with functions
   like [Pango.Layout.get_size] or drawing with functions like
   {!show_layout}.  If you change the transformation or target surface
   for [cr], you need to call {!update_layout}.  *)

val update_layout : Cairo.context -> Pango.layout -> unit
(** [update_layout cr layout] updates the private [Pango.context] of
   [layout] created with {!create_layout} to match the current
   transformation and target surface of a Cairo context [cr].  *)

val show_layout : Cairo.context -> Pango.layout -> unit
(** [show_layout cr layout] draws a [layout] in the specified cairo
   context [cr].  The top-left corner of [layout] will be drawn at the
   current point of the cairo context. *)

val show_error_underline :
  Cairo.context -> float -> float -> w:float -> h:float -> unit
(** [show_error_underline cr x y w h] draw a squiggly line in the
   cairo context [cr] that approximately covers the given rectangle in
   the style of an underline used to indicate a spelling error.  (The
   width [w] of the underline is rounded to an integer number of
   up/down segments and the resulting rectangle is centered in the
   original rectangle).  *)

val layout_path : Cairo.context -> Pango.layout -> unit
(** [layout_path cr layout] adds the text in a [layout] to the current
   path in [cr].  The top-left corner of the [layout] will be at the
   current point of the cairo context. *)

val error_underline_path :
  Cairo.context -> float -> float -> w:float -> h:float -> unit
(** [error_underline_path cr x y w h] add a squiggly line to the
   current path in the cairo context [cr] that approximately covers
   the given rectangle in the style of an underline used to indicate a
   spelling error.  (The width [w] of the underline is rounded to an
   integer number of up/down segments and the resulting rectangle is
   centered in the original rectangle). *)
