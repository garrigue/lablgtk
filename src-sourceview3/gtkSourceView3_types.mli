(**************************************************************************)
(*                Lablgtk                                                 *)
(*                                                                        *)
(*    This program is free software; you can redistribute it              *)
(*    and/or modify it under the terms of the GNU Library General         *)
(*    Public License as published by the Free Software Foundation         *)
(*    version 2, with the exception described in file COPYING which       *)
(*    comes with the library.                                             *)
(*                                                                        *)
(*    This program is distributed in the hope that it will be useful,     *)
(*    but WITHOUT ANY WARRANTY; without even the implied warranty of      *)
(*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the       *)
(*    GNU Library General Public License for more details.                *)
(*                                                                        *)
(*    You should have received a copy of the GNU Library General          *)
(*    Public License along with this program; if not, write to the        *)
(*    Free Software Foundation, Inc., 59 Temple Place, Suite 330,         *)
(*    Boston, MA 02111-1307  USA                                          *)
(*                                                                        *)
(*                                                                        *)
(**************************************************************************)

(*
 * lablgtksourceview, OCaml binding for the GtkSourceView text widget
 *
 * Copyright (C) 2005  Stefano Zacchiroli <zack@cs.unibo.it>
 *
 * This library is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation; either version 2.1 of the
 * License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
 * USA
 *)

type source_style_scheme = [`sourcestylescheme]
type source_style_scheme_manager = [`sourcestyleschememanager]
type source_completion_info = [ Gtk.window | `sourcecompletioninfo ]
type source_completion_provider = [ `sourcecompletionprovider ]
type source_completion_proposal = [ `sourcecompletionproposal ]
type source_completion_activation = [ `sourcecompletionactivation ]
type source_completion_context = [ `sourcecompletioncontext ]
type source_completion = [ `sourcecompletion ]
type source_view = [ Gtk.text_view | `sourceview ]
type source_mark = [ `sourcemark ]
type source_mark_attributes = [ `sourcemarkattributes ]
type source_buffer = [`textbuffer|`sourcebuffer]
type source_language = [`sourcelanguage]
type source_language_manager = [`sourcelanguagemanager]
type source_undo_manager = [`sourceundomanager]
