# $Id$
# Makefile for lablgtk.

all: var2conv var2def lablgtk

opt: lablgtkopt

configure:
	@rm -f config.make .depend
	@$(MAKE) -s nothing 2> /dev/null

nothing:

CAMLC = olablc
CAMLOPT = olablopt
COMPILER = $(CAMLC) $(MLFLAGS) -c
LINKER = $(CAMLC) $(MLFLAGS)
COMPOPT = $(CAMLOPT) $(MLFLAGS) -c
LINKOPT = $(CAMLOPT) $(MLFLAGS)

TOPLEVEL = olablmktop $(MLFLAGS)
RANLIB = ranlib

include config.make

ifdef DEBUG
CFLAGS = -g $(GTKCFLAGS)
LDFLAGS = $(GTKLIBS) -lcamlrund
MLFLAGS = -g
else
CFLAGS = -O -DGTK_NO_CHECK_CASTS -DGTK_DISABLE_COMPAT_H $(GTKCFLAGS)
LDFLAGS = $(GTKLIBS)
endif

THFLAGS = -thread
THLIBS = unix.cma threads.cma
THLDFLAGS = -lthreads -lunix

ifdef USE_CC
CCOMPILER = $(CC) -c -I$(LABLLIB) $(CFLAGS)
else
CCOMPILER = olablc -c -ccopt "$(CFLAGS)"
endif

ifdef USE_GL
MLFLAGS += -I $(LABLLIB)/lablGL
GLLINK = -I $(LABLLIB)/lablGL lablgl.cma \
	-cclib "-lgtkgl -L$(LABLLIB)/lablGL -llablgl -l$(MESA)GL -l$(MESA)GLU"
GLMLOBJS = glGtk.cmo
GLCOBJS = ml_gtkgl.o
endif

# Rules
.SUFFIXES: .ml .mli .cmo .cmi .cmx .c .o .var .h .opt .def
.c.o:
	$(CCOMPILER) $<
.ml.cmo:
	$(COMPILER) $<
.mli.cmi:
	$(COMPILER) $<
.ml.cmx:
	$(COMPOPT) $<
.var.h:
	./var2def < $< > $@
.var.c:
	./var2conv < $< > $@

# Targets
COBJS = ml_gtk.o ml_gdk.o ml_glib.o wrappers.o $(GLCOBJS)
OLDMLOBJS = misc.cmo glib.cmo gdk.cmo gtk.cmo gdkObj.cmo gtkObj.cmo gtkExt.cmo
MLOBJS = misc.cmo glib.cmo gdk.cmo gdkEvent.cmo gdkKeysyms.cmo \
	gtk.cmo gtkArgv.cmo gtkSignal.cmo \
	gtkData.cmo gtkBase.cmo gtkPack.cmo gtkButton.cmo \
	gtkMenu.cmo gtkMisc.cmo gtkWindow.cmo gtkTree.cmo gtkList.cmo \
	gtkFrame.cmo gtkEdit.cmo gtkRange.cmo gtkMain.cmo gtkNew.cmo \
	gdkObj.cmo \
	gObj.cmo gMain.cmo gData.cmo gContainer.cmo gPack.cmo gButton.cmo \
	gMenu.cmo gMisc.cmo gWindow.cmo gTree.cmo gList.cmo gFrame.cmo \
	gEdit.cmo gPix.cmo gRange.cmo gUtil.cmo $(GLMLOBJS)
THOBJS = gtkThread.cmo threadObj.cmo

lablgtk: liblablgtk.a lablgtk.cma
	$(TOPLEVEL) -o $@ -custom -cclib "-L. -llablgtk $(LDFLAGS)" \
		$(GLLINK) lablgtk.cma

lablgtkrun: liblablgtk.a lablgtk.cma
	$(LINKER) -o $@ -make-runtime $(GLLINK) lablgtk.cma \
		-cclib "-L. -llablgtk $(LDFLAGS)"

lablgtkopt: liblablgtk.a lablgtk.cmxa

liblablgtk.a: $(COBJS)
	ar rc $@ $(COBJS)
	$(RANLIB) $@

lablgtk.cma: $(MLOBJS)
	$(LINKER) -a -o $@ $(MLOBJS)

lablgtk.cmxa: $(MLOBJS:.cmo=.cmx)
	$(LINKOPT) -a -o $@ $(MLOBJS:.cmo=.cmx)

gtkThread.cmo: gtkThread.ml
	$(COMPILER) $(THFLAGS) gtkThread.ml

threadObj.cmo: threadObj.ml
	$(COMPILER) $(THFLAGS) threadObj.ml

gtkThread.cmx: gtkThread.ml
	$(COMPOPT) $(THFLAGS) gtkThread.ml

threadObj.cmx: threadObj.ml
	$(COMPOPT) $(THFLAGS) threadObj.ml

lablgtk_t: liblablgtk.a lablgtk.cma $(THOBJS)
	$(TOPLEVEL) $(THFLAGS) -o $@ -custom \
		-cclib "-L. -llablgtk $(LDFLAGS) $(THLDFLAGS)" \
		$(GLLINK) $(THLIBS) lablgtk.cma $(THOBJS)

var2conv: var2conv.cmo
	$(LINKER) -o $@ var2conv.cmo
	rm -f *_tags.c

var2def: var2def.cmo
	$(LINKER) -o $@ var2def.cmo
	rm -f *_tags.h

clean:
	rm -f *.cm* *.o *.a *_tags.[ch] var2conv var2def lablgtk lablgtk_t

.depend:
	olabldep *.ml *.mli > .depend

config.make:
	olablc -v | grep "^Standard" | sed "s/.*: */LABLLIB=/" > config.make
	echo GTKCFLAGS=`gtk-config --cflags` >> config.make
	echo GTKLIBS=`gtk-config --libs` >> config.make
	echo MESA=$(MESA) >> config.make
	echo USE_GL=$(USE_GL) >> config.make
	echo USE_CC=$(USE_CC) >> config.make

ml_gtk.o: gtk_tags.c gtk_tags.h ml_gtk.h ml_gdk.h wrappers.h
ml_gdk.o: gdk_tags.c gdk_tags.h ml_gdk.h wrappers.h
ml_gtkgl.o: gtkgl_tags.c gtkgl_tags.h ml_gtk.h ml_gdk.h wrappers.h

include .depend
