# Makefile for lablgtk. $Id$

all: config.make .depend var2conv var2def lablgtk

config.make:
	echo GTKCFLAGS=`gtk-config --cflags` > config.make
	echo GTKLIBS=`gtk-config --libs` >> config.make

include config.make

COMPILER = olablc $(MLFLAGS) -c
LINKER = olablc $(MLFLAGS)
TOPLEVEL = olablmktop $(MLFLAGS)
RANLIB = ranlib

CFLAGS = $(GTKCFLAGS) #-DGTK_NO_CHECK_CASTS
LDFLAGS = $(GTKLIBS)

THFLAGS = -thread
THLIBS = unix.cma threads.cma
THLDFLAGS = -lthreads -lunix

#CCOMPILER = cc -c -I/usr/local/lib/olabl $(CFLAGS)
CCOMPILER = olablc -c -ccopt "$(CFLAGS)"

# Rules
.SUFFIXES: .ml .mli .cmo .cmi .cmx .c .o .var .h .opt .def
.c.o:
	$(CCOMPILER) $<
.ml.cmo:
	$(COMPILER) $<
.mli.cmi:
	$(COMPILER) $<
.var.h:
	./var2def < $< > $@
.var.c:
	./var2conv < $< > $@

# Targets
COBJS = ml_gtk.o ml_gdk.o ml_glib.o
MLOBJS = misc.cmo glib.cmo gdk.cmo gtk.cmo

lablgtk: liblablgtk.a lablgtk.cma
	$(TOPLEVEL) -o $@ -custom -cclib "-L. -llablgtk $(LDFLAGS)" lablgtk.cma

liblablgtk.a: $(COBJS)
	ar rc $@ $(COBJS)
	$(RANLIB) $@

lablgtk.cma: $(MLOBJS)
	$(LINKER) -a -o $@ $(MLOBJS)

gtkThread.cmo: gtkThread.ml
	$(COMPILER) $(THFLAGS) gtkThread.ml

lablgtk_t: liblablgtk.a lablgtk.cma gtkThread.cmo
	$(TOPLEVEL) $(THFLAGS) -thread -o $@ -custom \
		-cclib "-L. -llablgtk $(LDFLAGS) $(THLDFLAGS)" \
		$(THLIBS) lablgtk.cma gtkThread.cmo

var2conv: var2conv.cmo
	olablc -o $@ var2conv.cmo

var2def: var2def.cmo
	olablc -o $@ var2def.cmo

clean:
	rm -f *.cm* *.o *.a *_tags.[ch] var2conv var2def lablgtk

.depend:
	olabldep *.ml *.mli > .depend

depend:
	olabldep *.ml *.mli > .depend

ml_gtk.o: gtk_tags.c gtk_tags.h ml_gtk.h ml_gdk.h wrappers.h
ml_gdk.o: gdk_tags.c gdk_tags.h ml_gdk.h wrappers.h

include .depend
