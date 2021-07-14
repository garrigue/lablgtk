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


type canvas = [Gtk.container | `oocanvas]
type item = [`oocanvasitem]
type item_model = [`oocanvasitemmodel]
type item_simple = [`oocanvasitemsimple]
type item_model_simple = [`oocanvasitemmodelsimple]
type style = [`oocanvasstyle]

type group = [item|`oocanvasgroup]
type ellipse = [item|`oocanvasellipse]
type grid = [item|`oocanvasgrid]
type image = [item|`oocanvasimage]
type path = [item|`oocanvaspath]
type polyline = [item|`oocanvaspolyline]
type rect = [item|`oocanvasrect]
type text = [item|`oocanvastext]
type widget = [item|`oocanvaswidget]
type table = [group|`oocanvastable]

type grou_pmodel = [`oocanvasgroupmodel]
type ellipse_model = [`oocanvasellipsemodel]
type grid_model = [`oocanvasgridmodel]
type image_model = [`oocanvasimagemodel]
type path_model = [`oocanvaspathmodel]
type polyline_model = [`oocanvaspolylinemodel]
type rect_model = [`oocanvasrectmodel]
type text_model = [`oocanvastextmodel]
type table_model = [`oocanvastablemodel]


