# $Id$
# Makefile for lablgtk.

TARGETS = var2conv var2def lablgtktop lablgtktop_t lablgtkrun lablgtk

all: $(TARGETS)

opt: lablgtkopt

configure:
	@rm -f config.make .depend
	@$(MAKE) -s nothing 2> /dev/null

nothing:

CAMLC = ocamlc
CAMLOPT = ocamlopt
COMPILER = $(CAMLC) $(MLFLAGS) -w s -labels -c
LINKER = $(CAMLC) $(MLFLAGS)
COMPOPT = $(CAMLOPT) $(MLFLAGS) -w s -labels -c
LINKOPT = $(CAMLOPT) $(MLFLAGS)

TOPLEVEL = ocamlmktop $(MLFLAGS)
RANLIB = ranlib

include config.make

INSTALLDIR = $(OCAMLLIB)/lablgtk
LABLGLDIR = $(OCAMLLIB)/lablGL
INSTALLBINDIR = /sansho/opt/ocaml3/bin

ifdef DEBUG
CFLAGS = -g $(GTKCFLAGS)
DBLINK = -cclib -lcamlrund
MLFLAGS = -g
else
CFLAGS = -O -DGTK_NO_CHECK_CASTS -DGTK_DISABLE_COMPAT_H $(GTKCFLAGS)
endif

THFLAGS = -thread
THLIBS = unix.cma threads.cma

ifdef USE_CC
CCOMPILER = $(CC) -c -I$(OCAMLLIB) $(CFLAGS)
else
CCOMPILER = ocamlc -c -ccopt "$(CFLAGS)"
endif

ifdef USE_GL
MLFLAGS += -I $(LABLGLDIR)
GLLINK = -I $(LABLGLDIR) lablgl.cma -cclib -lgtkgl
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
INITOBJS = gtkInit.cmo
ALLOBJS = $(MLOBJS) $(THOBJS) $(INITOBJS)

lablgtktop: liblablgtk.a lablgtk.cma $(INITOBJS)
	$(TOPLEVEL) -custom -o $@ unix.cma str.cma $(GLLINK) \
		-ccopt -L. lablgtk.cma $(INITOBJS)

lablgtktop_t: liblablgtk.a lablgtk.cma $(THOBJS) $(INITOBJS)
	$(TOPLEVEL) -custom $(THFLAGS) -o $@ $(THLIBS) str.cma $(GLLINK) \
	   -ccopt -L. lablgtk.cma $(THOBJS) $(INITOBJS)

lablgtk: Makefile config.make lablgtk.in
	sed -e "s|@INSTALLDIR@|$(INSTALLDIR)|g" \
	    -e "s|@LABLGLDIR@|$(LABLGLDIR)|g" \
	    -e "s|@OCAMLLIB@|$(OCAMLLIB)|g" \
	    < lablgtk.in > $@
	chmod 755 $@

lablgtkrun: liblablgtk.a lablgtk.cma
	$(LINKER) -o $@ -make-runtime unix.cma str.cma $(GLLINK) \
		-ccopt -L. lablgtk.cma

lablgtkopt: liblablgtk.a lablgtk.cmxa

install:
	if test -d $(INSTALLDIR); then : ; else mkdir -p $(INSTALLDIR); fi
	cp $(ALLOBJS:.cmo=.cmi) $(INSTALLDIR)
	cp lablgtk.cma $(THOBJS) $(INITOBJS) $(INSTALLDIR)
	cp liblablgtk.a $(OCAMLLIB) || cp liblablgtk.a $(INSTALLDIR)
	cp lablgtktop  lablgtktop_t $(INSTALLDIR)
	cp lablgtk lablgtkrun $(INSTALLBINDIR)
	if test -f lablgtk.cmxa; then cp lablgtk.cmxa $(INSTALLDIR); fi

liblablgtk.a: $(COBJS)
	ar rc $@ $(COBJS)
	$(RANLIB) $@

lablgtk.cma: $(MLOBJS)
	$(LINKER) -a -o $@ $(MLOBJS) \
	  -cclib -llablgtk $(GTKLIBS)

lablgtk.cmxa: $(MLOBJS:.cmo=.cmx)
	$(LINKOPT) -a -o $@ $(MLOBJS:.cmo=.cmx) \
	  -cclib -llablgtk $(GTKLIBS)

gtkThread.cmo: gtkThread.ml
	$(COMPILER) $(THFLAGS) gtkThread.ml

threadObj.cmo: threadObj.ml
	$(COMPILER) $(THFLAGS) threadObj.ml

gtkThread.cmx: gtkThread.ml
	$(COMPOPT) $(THFLAGS) gtkThread.ml

threadObj.cmx: threadObj.ml
	$(COMPOPT) $(THFLAGS) threadObj.ml

var2conv: var2conv.cmo
	$(LINKER) -o $@ var2conv.cmo
	rm -f *_tags.c

var2def: var2def.cmo
	$(LINKER) -o $@ var2def.cmo
	rm -f *_tags.h

clean:
	rm -f *.cm* *.o *.a *_tags.[ch] $(TARGETS)

.depend:
	ocamldep *.ml *.mli > .depend

config.make:
	ocamlc -v | grep "^Standard" | sed "s/.*: */OCAMLLIB=/" > config.make
	echo GTKCFLAGS=`gtk-config --cflags` >> config.make
	echo GTKLIBS=`gtk-config --libs` | \
	  sed -e 's/-l/-cclib &/g' -e 's/-[LWr]/-ccopt &/g' >> config.make
	echo USE_GL=$(USE_GL) >> config.make
	echo USE_CC=$(USE_CC) >> config.make

ml_gtk.o: gtk_tags.c gtk_tags.h ml_gtk.h ml_gdk.h wrappers.h
ml_gdk.o: gdk_tags.c gdk_tags.h ml_gdk.h wrappers.h
ml_gtkgl.o: gtkgl_tags.c gtkgl_tags.h ml_gtk.h ml_gdk.h wrappers.h

include .depend
