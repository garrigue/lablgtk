# Makefile for lablgtk. $Id$

all: config.make .depend var2conv var2def lablgtk

config.make:
	echo GTKCFLAGS=`gtk-config --cflags` > config.make
	echo GTKLIBS=`gtk-config --libs` >> config.make

include config.make

COMPILER = olablc -c
LINKER = olablc
TOPLEVEL = olablmktop
RANLIB = ranlib
CFLAGS = $(GTKCFLAGS)
LDFLAGS = $(GTKLIBS)

# Rules
.SUFFIXES: .ml .mli .cmo .cmi .cmx .c .o .var .h .opt .def
.c.o:
	$(COMPILER) -ccopt "$(CFLAGS)" $<
.ml.cmo:
	$(COMPILER) $<
.mli.cmi:
	$(COMPILER) $<
.var.h:
	var2def < $< > $@
.var.c:
	var2conv < $< > $@

# Targets
COBJS = ml_gtk.o ml_gdk.o
MLOBJS = misc.cmo gdk.cmo gtk.cmo

lablgtk: liblablgtk.a lablgtk.cma
	$(TOPLEVEL) -o $@ -custom -cclib "$(LDFLAGS)" liblablgtk.a lablgtk.cma

liblablgtk.a: $(COBJS)
	ar rc $@ $(COBJS)
	$(RANLIB) $@

lablgtk.cma: $(MLOBJS)
	$(LINKER) -a -o $@ $(MLOBJS)

var2conv: var2conv.cmo
	olablc -o $@ var2conv.cmo

var2def: var2def.cmo
	olablc -o $@ var2def.cmo

.depend:
	olabldep *.ml *.mli > .depend

depend:
	olabldep *.ml *.mli > .depend

ml_gtk.o: gtk_tags.c gtk_tags.h ml_gtk.h wrappers.h

include .depend