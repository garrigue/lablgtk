# $Id$
# Makefile for lablgtk.

COMPILER = $(CAMLC) $(MLFLAGS) $(MLBYTEFLAGS) -w s -c
LINKER = $(CAMLC) $(MLFLAGS) $(MLBYTEFLAGS)
COMPOPT = $(CAMLOPT) $(MLFLAGS) -w s -c
LINKOPT = $(CAMLOPT) $(MLFLAGS)
LIBRARIAN = $(CAMLMKLIB) -verbose
TOPLEVEL = $(CAMLMKTOP) $(MLFLAGS)
CAMLP4 = $(CAMLP4O) pr_o.cmo
MKLIB = lib /nologo /debugtype:CV /out:
MKDLL = link /nologo /dll "`$(CAMLC) -where`/ocamlrun.lib" "$(GTKLIBPATH)" /out:
CONFIG = ../config.make

# protect against missing definitions
BINDIR = ""
LIBDIR = ""
INSTALLDIR = $(LIBDIR)/lablgtk2
DLLDIR = $(LIBDIR)/stublibs

include $(CONFIG)

TARGETS = varcc$(XE) lablgtktop$(XE) lablgtk2$(XB)

all: byte
world: byte $(CAMLBEST)

MLLIBS = lablgtk.cma
CLIBS = liblablgtk2$(XA)
#MLLINK = unix.cma str.cma

GTKCFLAGS += -DLOG_DOMAIN=\"LablGTK\"

ifdef DEBUG
CFLAGS = -g $(GTKCFLAGS)
CUSTOM = -custom
#MLLINK += -cclib -lcamlrund
MLBYTEFLAGS = -g
else
CFLAGS = -O -DG_DISABLE_ASSERT -DG_DISABLE_CAST_CHECKS $(GTKCFLAGS)
endif

ifeq ($(THREADS_LIB),system)
THFLAGS = -thread
else
THFLAGS = -vmthread
CUSTOM = -custom
endif
THLINK = unix.cma threads.cma

ifdef USE_CC
CCOMPILER = $(CC) -c -I$(LIBDIR) $(CFLAGS)
else
CCOMPILER = $(CAMLC) -c -ccopt "$(CFLAGS)"
endif

ifdef USE_GL
MLFLAGS += -I $(LABLGLDIR)
MLLINK += lablgl.cma
MLLIBS += lablgtkgl.cma
CLIBS += liblablgtkgl2$(XA)
GLMLOBJS = glGtk.cmo
GLCOBJS = ml_gtkgl$(XO)
endif

#ifdef USE_GNOME
#MLLIBS += lablgnome.cma
#CLIBS += liblablgnome$(XA)
#GNOMEMLOBJS = gtkXmHTML.cmo gHtml.cmo
#GNOMECOBJS = ml_gtkxmhtml$(XO)
#endif

ifdef USE_GLADE
MLLIBS += lablglade.cma
CLIBS += liblablglade2$(XA)
GLADEMLOBJS = glade.cmo
GLADECOBJS = ml_glade$(XO)
TARGETS += lablgladecc$(XE)
endif

ifdef USE_GNOMECANVAS
MLLIBS += lablgnomecanvas.cma
CLIBS += liblablgnomecanvas$(XA)
GNOMECANVASMLOBJS = gnomeCanvas.cmo gnoCanvas.cmo
GNOMECANVASCOBJS = ml_gnomecanvas$(XO)
endif

ifdef USE_GNOMEUI
MLLIBS += lablgnomeui.cma
CLIBS += liblablgnomeui$(XA)
GNOMEUIMLOBJS = gnomeDruid.cmo gnoDruid.cmo
GNOMEUICOBJS = ml_gnomedruid$(XO)
endif

ifdef USE_PANEL
MLLIBS += lablpanel.cma
CLIBS += liblablpanel$(XA)
PANELMLOBJS = panel.cmo
PANELCOBJS = ml_panel$(XO)
endif

ifdef USE_RSVG
MLLIBS += lablrsvg.cma
CLIBS += liblablrsvg$(XA)
RSVGMLOBJS = rsvg.cmo
RSVGCOBJS = ml_rsvg$(XO)
$(RSVGCOBJS) : CFLAGS+=$(HAVE_SVGZ)
endif

ifdef USE_GTKSPELL
MLLIBS += lablgtkspell.cma
CLIBS += liblablgtkspell$(XA)
GTKSPELLMLOBJS = gtkSpell.cmo
GTKSPELLCOBJS = ml_gtkspell$(XO)
endif

# Rules
.SUFFIXES: .ml .mli .cmo .cmi .cmx .c $(XO) .d$(XO) .var .h .opt .def .ml4
.c$(XO):
	$(CCOMPILER) $<
.c.d.obj:
	$(COMPILER) -verbose -ccopt "/MD -DCAML_DLL /Fo$@ $(CFLAGS)" $<
.ml.cmo:
	$(COMPILER) $<
.mli.cmi:
	$(COMPILER) $<
.ml.cmx:
	$(COMPOPT) $<
.ml4.cmo:
	$(CAMLC) -c -pp "$(CAMLP4O) -impl" -impl $<
#.ml4.ml:
#	$(CAMLP4) -impl $< -o $@

%_tags.h %_tags.c %Enums.ml: %_tags.var varcc$(XE)
	./varcc $<

%Props.ml o%Props.ml: %.props propcc$(XE)
	./propcc $<

# Files
GTKOBJS =  ml_gtk$(XO) ml_pango$(XO) ml_gtkaction$(XO) \
	ml_gtkbin$(XO) ml_gtkbroken$(XO) ml_gtkbutton$(XO) \
	ml_gtkedit$(XO) ml_gtkfile$(XO) ml_gtklist$(XO) \
	ml_gtkmenu$(XO) ml_gtkmisc$(XO) \
	ml_gtkpack$(XO) ml_gtkrange$(XO) ml_gtkstock$(XO) \
	ml_gtktext$(XO) ml_gtktree$(XO)
COBJS = ml_gdkpixbuf$(XO) ml_gdk$(XO) ml_glib$(XO) ml_gobject$(XO) \
	ml_gpointer$(XO) ml_gvaluecaml$(XO) wrappers$(XO) $(GTKOBJS)
GTKPROPS = gtkBase.props gtkBin.props gtkButton.props gtkEdit.props \
	gtkList.props gtkMenu.props gtkMisc.props gtkPack.props \
	gtkRange.props gtkText.props gtkTree.props gtkFile.props \
	gtkAction.props gtkBroken.props
MLOBJS1 =  gaux.cmo gpointer.cmo glib.cmo gobject.cmo
ENUMOBJS = gdkEnums.cmo pangoEnums.cmo gtkEnums.cmo
MLOBJS2 = pango.cmo gdk.cmo gdkEvent.cmo gdkKeysyms.cmo gdkPixbuf.cmo \
	gtk.cmo gtkSignal.cmo gtkStock.cmo gtkObject.cmo
MLOBJS3 = gtkData.cmo gtkBase.cmo gtkPack.cmo gtkButton.cmo \
	gtkMenu.cmo gtkMisc.cmo gtkWindow.cmo gtkList.cmo \
	gtkBin.cmo gtkEdit.cmo gtkRange.cmo gtkText.cmo gtkTree.cmo \
	gtkFile.cmo gtkMain.cmo gtkBroken.cmo \
	gPango.cmo gDraw.cmo gObj.cmo gData.cmo gMain.cmo
MLOBJS4 = gContainer.cmo gPack.cmo gButton.cmo gText.cmo \
	gMenu.cmo gMisc.cmo gTree.cmo gList.cmo gFile.cmo gWindow.cmo \
	gBin.cmo gEdit.cmo gRange.cmo gAction.cmo gBroken.cmo \
	gUtil.cmo gToolbox.cmo
MLOBJS =  $(MLOBJS1) $(ENUMOBJS) $(MLOBJS2) $(GTKPROPS:.props=Props.cmo) \
	$(MLOBJS3) $(GTKPROPS:%.props=o%Props.cmo) $(MLOBJS4)
MLXOBJS = $(MLOBJS1) $(ENUMOBJS) $(MLOBJS2) $(MLOBJS3) $(MLOBJS4)
THOBJS = gtkThread.cmo
INITOBJS = gtkInit.cmo
THINITOBJS = gtkThInit.cmo
ALLOBJS = $(MLXOBJS) $(GLMLOBJS) $(GNOMEMLOBJS) $(GLADEMLOBJS) \
	$(RSVGMLOBJS) $(GNOMECANVASMLOBJS) $(GNOMEUIMLOBJS) $(PANELMLOBJS) $(GTKSPELLMLOBJS) \
	$(INITOBJS)
ALLTHOBJS = $(THOBJS) $(THINITOBJS)
PROPOBJS = $(GTKPROPS:%.props=%Props.cmo) $(GTKPROPS:%.props=o%Props.cmo)

# Targets
byte: $(TARGETS) $(INITOBJS)
opt:  $(TARGETS) lablgtkopt

depend: $(ENUMOBJS:.cmo=.ml) $(PROPOBJS:.cmo=.ml)
	ocamldep $(ALLOBJS:.cmo=.ml) $(PROPOBJS:.cmo=.ml) $(ALLTHOBJS:.cmo=.ml) *.mli > .depend

ifeq ($(THREADS_LIB),no)
lablgtktop$(XE): $(MLLIBS)
	$(TOPLEVEL) $(CUSTOM) -o $@ $(MLLINK) -I . $(MLLIBS)
else
lablgtktop$(XE): $(MLLIBS) $(ALLTHOBJS)
	$(TOPLEVEL) $(THFLAGS) $(CUSTOM) -o $@ $(THLINK) $(MLLINK) \
	   -I . $(MLLIBS) $(THOBJS)
endif

lablgtk2: Makefile $(CONFIG) lablgtk2.in
	sed -e "s|@INSTALLDIR@|$(INSTALLDIR)|g" \
	    -e "s|@LABLGLDIR@|$(LABLGLDIR)|g" \
	    -e "s|@LIBDIR@|$(LIBDIR)|g" \
	    -e "s|@MLLIBS@|$(MLLINK) $(MLLIBS)|g" \
	    -e "s|@INITOBJS@|$(INITOBJS)|g" \
	    -e "s|@THOBJS@|$(THOBJS)|g" \
	    -e "s|@THINITOBJS@|$(THINITOBJS)|g" \
	    -e "s|@USEDLL@|$(HAS_DLL_SUPPORT)|g" \
	    -e "s|@THREADS_LIB@|$(THREADS_LIB)|g" \
	    < lablgtk2.in > $@
	chmod 755 $@

lablgtk2.bat: lablgtk2.bat.in
	cp lablgtk2.bat.in lablgtk2.bat

lablgtkopt:: $(MLLIBS:.cma=.cmxa) $(INITOBJS:.cmo=.cmx)
ifeq ($(THREADS_LIB),system)
lablgtkopt:: $(THOBJS:.cmo=.cmx)
endif

lablgladecc$(XE): xml_lexer.cmo lablgladecc.cmo
	$(LINKER) -o $@ xml_lexer.cmo lablgladecc.cmo

testcc$(XE): lablgladecc$(XE) lablgtktop
	./lablgladecc -test > testcc.ml
	./lablgtktop testcc.ml
	rm -f testcc.ml

install:
	mkdir -p "$(INSTALLDIR)" "$(BINDIR)" "$(DLLDIR)"
	cp $(ALLOBJS:.cmo=.cmi) $(THOBJS:.cmo=.cmi) "$(INSTALLDIR)"
	cp -p *.mli "$(INSTALLDIR)"
	cp -p $(ALLOBJS:.cmo=.ml) $(ALLTHOBJS:.cmo=.ml) "$(INSTALLDIR)"
	cp $(MLLIBS) $(THOBJS) $(INITOBJS) $(THINITOBJS) "$(INSTALLDIR)"
	cp $(CLIBS) "$(INSTALLDIR)"
	cd "$(INSTALLDIR)" && $(RANLIB) $(CLIBS)
	cp varcc$(XE) propcc$(XE) "$(INSTALLDIR)"
	if test $(THREADS_LIB) != system || test $(HAS_DLL_SUPPORT) != yes; \
	   then cp lablgtktop$(XE) "$(INSTALLDIR)"; \
	fi
	cp -p *.h "$(INSTALLDIR)"
	@if test -f lablgtk.cmxa; then $(MAKE) installopt; fi
	@if test -f dlllablgtk2$(XS); then $(MAKE) installdll; fi
	cp lablgtk2$(XB) "$(BINDIR)"
	if test -f lablgladecc$(XE); then \
	   cp lablgladecc$(XE) "$(BINDIR)/lablgladecc2$(XE)"; fi

installdll:
	cp $(CLIBS:lib%$(XA)=dll%$(XS)) "$(DLLDIR)" || \
	   echo "Couldn't install dlls in default location: $(DLLDIR)"

installopt:
	cp $(MLLIBS:.cma=.cmxa) $(MLLIBS:.cma=$(XA)) "$(INSTALLDIR)"
	cd "$(INSTALLDIR)" && $(RANLIB) $(MLLIBS:.cma=$(XA))
	cp $(ALLOBJS:.cmo=.cmx) "$(INSTALLDIR)"
	cp $(INITOBJS:.cmo=$(XO)) "$(INSTALLDIR)"
	if test -f gtkThread.cmx; then \
	   cp $(THOBJS:.cmo=.cmx) $(THOBJS:.cmo=$(XO)) "$(INSTALLDIR)"; fi

ifeq ($(TOOLCHAIN),msvc)
liblablgtk2$(XA): $(COBJS)
	$(MKLIB)$@ $(COBJS)
dlllablgtk2.dll: $(COBJS:$(XO)=.d$(XO))
	$(MKDLL)$@ $(COBJS:$(XO)=.d$(XO)) $(GTKLIBS) $(OCAMLDLL)
lablgtk.cma: liblablgtk2$(XA) dlllablgtk2.dll $(MLOBJS) $(CONFIG)
	$(LINKER) -a -o $@ $(MLOBJS) \
	  -cclib -llablgtk2 -dllib -llablgtk2 \
	  -cclib "$(GTKLIBS)"
lablgtk.cmxa: liblablgtk2$(XA) $(MLOBJS:.cmo=.cmx) $(CONFIG)
	$(LINKOPT) -a -o $@  $(MLOBJS:.cmo=.cmx) -cclib -llablgtk2 \
	  -cclib "$(GTKLIBS)"
else
liblablgtk2$(XA): $(COBJS)
	$(LIBRARIAN) -o lablgtk2 $(COBJS) $(GTKLIBS)
lablgtk.cma: liblablgtk2$(XA) $(MLOBJS)
	$(LIBRARIAN) -o lablgtk -oc lablgtk2 $(MLOBJS) $(GTKLIBS)
lablgtk.cmxa: liblablgtk2$(XA) $(MLOBJS:.cmo=.cmx)
	$(LIBRARIAN) -o lablgtk -oc lablgtk2 $(MLOBJS:.cmo=.cmx) $(GTKLIBS)
endif

liblablgtkgl2$(XA): $(GLCOBJS)
	$(LIBRARIAN) -o lablgtkgl2 $(GLCOBJS) \
	    $(GTKGLLIBS)
lablgtkgl.cma: liblablgtkgl2$(XA) $(GLMLOBJS)
	$(LIBRARIAN) -o lablgtkgl -oc lablgtkgl2 $(GLMLOBJS) \
	    $(GTKGLLIBS)
lablgtkgl.cmxa: liblablgtkgl2$(XA) $(GLMLOBJS:.cmo=.cmx)
	$(LIBRARIAN) -o lablgtkgl -oc lablgtkgl2 $(GLMLOBJS:.cmo=.cmx) \
	    $(GTKGLLIBS)

#liblablgnome$(XA): $(GNOMECOBJS)
#	$(LIBRARIAN) -o lablgnome $(GNOMECOBJS) $(GNOMELIBS)
#lablgnome.cma: liblablgnome$(XA) $(GNOMEMLOBJS)
#	$(LIBRARIAN) -o lablgnome $(GNOMEMLOBJS) $(GNOMELIBS)
#lablgnome.cmxa: liblablgnome$(XA) $(GNOMEMLOBJS:.cmo=.cmx)
#	$(LIBRARIAN) -o lablgnome $(GNOMEMLOBJS:.cmo=.cmx) $(GNOMELIBS)

ifeq ($(TOOLCHAIN),msvc)
liblablglade2$(XA): $(GLADECOBJS)
	$(MKLIB)$@ $(GLADECOBJS)
dlllablglade2.dll: $(GLADECOBJS:$(XO)=.d$(XO))
	$(MKDLL)$@ $(GLADECOBJS:$(XO)=.d$(XO)) dlllablgtk2.lib $(GLADELIBS) $(GTKLIBS) $(OCAMLDLL)
lablglade.cma: liblablglade2$(XA) dlllablglade2.dll $(GLADEMLOBJS) $(CONFIG)
	$(LINKER) -a -o $@ $(GLADEMLOBJS) \
	  -cclib -llablglade2 -dllib -llablglade2 \
	  -cclib "$(GLADELIBS)"
lablglade.cmxa: liblablglade2$(XA) $(GLADEMLOBJS:.cmo=.cmx) $(CONFIG)
	$(LINKOPT) -a -o $@  $(GLADEMLOBJS:.cmo=.cmx) -cclib -llablglade2 \
	  -cclib "$(GLADELIBS)"
else
liblablglade2$(XA): $(GLADECOBJS)
	$(LIBRARIAN) -o lablglade2 $(GLADECOBJS) $(GLADELIBS)
lablglade.cma: liblablglade2$(XA) $(GLADEMLOBJS)
	$(LIBRARIAN) -o lablglade -oc lablglade2 $(GLADEMLOBJS) $(GLADELIBS)
lablglade.cmxa: liblablglade2$(XA) $(GLADEMLOBJS:.cmo=.cmx)
	$(LIBRARIAN) -o lablglade -oc lablglade2 \
	    $(GLADEMLOBJS:.cmo=.cmx) $(GLADELIBS)
endif

liblablrsvg$(XA): $(RSVGCOBJS)
	$(LIBRARIAN) -o lablrsvg $(RSVGCOBJS) $(RSVGLIBS)
lablrsvg.cma: liblablrsvg$(XA) $(RSVGMLOBJS)
	$(LIBRARIAN) -o lablrsvg -oc lablrsvg $(RSVGMLOBJS) $(RSVGLIBS)
lablrsvg.cmxa: liblablrsvg$(XA) $(RSVGMLOBJS:.cmo=.cmx)
	$(LIBRARIAN) -o lablrsvg -oc lablrsvg \
	    $(RSVGMLOBJS:.cmo=.cmx) $(RSVGLIBS)

liblablgnomecanvas$(XA): $(GNOMECANVASCOBJS)
	$(LIBRARIAN) -o lablgnomecanvas $(GNOMECANVASCOBJS) $(GNOMECANVASLIBS)
lablgnomecanvas.cma: liblablgnomecanvas$(XA) $(GNOMECANVASMLOBJS)
	$(LIBRARIAN) -o lablgnomecanvas $(GNOMECANVASMLOBJS) $(GNOMECANVASLIBS)
lablgnomecanvas.cmxa: liblablgnomecanvas$(XA) $(GNOMECANVASMLOBJS:.cmo=.cmx)
	$(LIBRARIAN) -o lablgnomecanvas \
	    $(GNOMECANVASMLOBJS:.cmo=.cmx) $(GNOMECANVASLIBS)
# gnoCanvas.cmo: COMPILER+= -i

liblablgnomeui$(XA): $(GNOMEUICOBJS)
	$(LIBRARIAN) -o lablgnomeui $(GNOMEUICOBJS) $(GNOMEUILIBS)
lablgnomeui.cma: liblablgnomeui$(XA) $(GNOMEUIMLOBJS)
	$(LIBRARIAN) -o lablgnomeui $(GNOMEUIMLOBJS) $(GNOMEUILIBS)
lablgnomeui.cmxa: liblablgnomeui$(XA) $(GNOMEUIMLOBJS:.cmo=.cmx)
	$(LIBRARIAN) -o lablgnomeui \
	    $(GNOMEUIMLOBJS:.cmo=.cmx) $(GNOMEUILIBS)
# gnoDruid.cmo: COMPILER+= -i

liblablpanel$(XA): $(PANELCOBJS)
	$(LIBRARIAN) -o lablpanel $(PANELCOBJS) $(PANELLIBS)
lablpanel.cma: liblablpanel$(XA) $(PANELMLOBJS)
	$(LIBRARIAN) -o lablpanel $(PANELMLOBJS) $(PANELLIBS)
lablpanel.cmxa: liblablpanel$(XA) $(PANELMLOBJS:.cmo=.cmx)
	$(LIBRARIAN) -o lablpanel \
	    $(PANELMLOBJS:.cmo=.cmx) $(PANELLIBS)

liblablgtkspell$(XA): $(GTKSPELLCOBJS)
	$(LIBRARIAN) -o lablgtkspell $(GTKSPELLCOBJS) $(GTKSPELLLIBS)
lablgtkspell.cma: liblablgtkspell$(XA) $(GTKSPELLMLOBJS)
	$(LIBRARIAN) -o lablgtkspell $(GTKSPELLMLOBJS) $(GTKSPELLLIBS)
lablgtkspell.cmxa: liblablgtkspell$(XA) $(GTKSPELLMLOBJS:.cmo=.cmx)
	$(LIBRARIAN) -o lablgtkspell \
	    $(GTKSPELLMLOBJS:.cmo=.cmx) $(GTKSPELLLIBS)

gtkThread.cmo: gtkThread.ml
	$(COMPILER) $(THFLAGS) gtkThread.ml

gtkThread.cmi: gtkThread.mli
	$(COMPILER) $(THFLAGS) gtkThread.mli

gtkThread.cmx: gtkThread.ml
	$(COMPOPT) $(THFLAGS) gtkThread.ml

xml_lexer.ml: xml_lexer.mll
	$(CAMLLEX) xml_lexer.mll
xml_lexer.cmo xml_lexer.cmx : xml_lexer.cmi

varcc$(XE): varcc.cmo
	$(LINKER) -o $@ $<
	rm -f *_tags.h *_tags.c

propcc$(XE): propcc.cmo
	$(LINKER) -o $@ $<

check_externals$(XE): check_externals.cmo
	$(LINKER) -o $@ $<

clean:
	rm -f *.cm* *.o *.a *.so *.exe *.obj *.lib *.dll *_tags.[ch] \
	  $(TARGETS) varcc.ml xml_lexer.ml \
	  propcc$(XE) check_externals$(XE) check_externals.ml propcc.ml \
	  *Enums.ml *Props.ml
	rm -f \#*\# *~


DOCFILES =  gaux.ml gpointer.mli glib.mli gobject.mli \
        gdkEnums.ml pangoEnums.ml gtkEnums.ml \
        gdk.mli gdkEvent.ml gdkPixbuf.mli \
        gtk.ml pango.ml gtkSignal.mli gtkObject.ml \
        $(GTKPROPS:%.props=%Props.ml) \
        gtkStock.ml gtkData.ml gtkBase.ml gtkPack.ml gtkButton.ml \
        gtkMenu.ml gtkMisc.ml gtkWindow.ml gtkList.ml \
        gtkEdit.ml gtkRange.ml gtkText.ml gtkTree.ml \
        gtkFile.ml gtkMain.ml \
        gPango.ml gDraw.mli \
        gObj.mli gMain.mli gData.mli gContainer.mli gBin.mli gPack.mli gButton.mli \
        gText.mli \
        gMenu.mli gMisc.mli gTree.mli gFile.mli gList.mli gWindow.mli \
        gEdit.mli gRange.mli gAction.mli gUtil.mli gToolbox.mli gBroken.mli
ifdef USE_GLADE
DOCFILES += glade.mli xml_lexer.mli
endif
ifdef USE_GL
DOCFILES += glGtk.mli
endif
ifdef USE_RSVG
DOCFILES += rsvg.mli
endif
ifdef USE_GNOMECANVAS
DOCFILES += gnomeCanvas.ml gnoCanvas.mli
endif
ifdef USE_GNOMEUI
DOCFILES += gnomeDruid.ml gnoDruid.mli
endif
ifdef USE_PANEL
DOCFILES += panel.mli
endif
ifdef USE_GTKSPELL
DOCFILES += gtkSpell.mli
endif

OCAMLDOC = ocamldoc
lablgtk$(XO)doc : $(DOCFILES) $(ALLOBJS)
	$(OCAMLDOC) -dump $@ -v $(if $(LABLGLDIR),-I $(LABLGLDIR)) $(DOCFILES)
gtkdoc.cmo : gtkdoc.ml
	$(CAMLC) -I +ocamldoc -pp "$(CAMLP4O) pa_macro.cmo $(ODOC_DEF)" -c $<
DOCDIR=../doc
DOC_URI=file:///usr/share/gtk-doc/html
DOC_BASE_URI=$(if $(DOC_URI),-base-uri $(DOC_URI))
doc : lablgtk$(XO)doc gtkdoc.cmo
	mkdir -p $(DOCDIR)/html
	$(OCAMLDOC) -g ./gtkdoc.cmo $(DOC_BASE_URI) -v -t LablGTK -d $(DOCDIR)/html -load $<
doc_texi : lablgtk$(XO)doc
	$(OCAMLDOC) -texi -v -t LablGTK -o $(DOCDIR)/lablgtk2.texi -load $<

$(GTKOBJS): pango_tags.h gtk_tags.h ml_gtk.h gdk_tags.h ml_gdk.h \
	    ml_gobject.h ml_glib.h wrappers.h
$(GNOMEUICOBJS) : gnomeui_tags.h
$(PANELCOBJS) : panel_tags.h
ml_glib$(XO): glib_tags.h ml_glib.h wrappers.h
ml_gobject$(XO): gobject_tags.h ml_gvaluecaml.h wrappers.h
ml_gvaluecaml$(XO): ml_gobject.h wrappers.h
ml_gdk$(XO): gdk_tags.h ml_gdk.h ml_gpointer.h \
	pango_tags.h ml_pango.h wrappers.h
ml_gtk$(XO) ml_gtktext$(XO): ml_pango.h
ml_gtkgl$(XO): gtkgl_tags.h ml_gtk.h ml_gdk.h wrappers.h
ml_gtkxmhtml$(XO): gtkxmhtml_tags.h ml_gtk.h ml_gdk.h wrappers.h
ml_gpointer$(XO): ml_gpointer.h
ml_gdkpixbuf$(XO): gdkpixbuf_tags.h ml_gdk.h gdk_tags.h \
	wrappers.h ml_gpointer.h
ml_pango$(XO): pango_tags.h ml_pango.h
ml_rsvg$(XO): ml_gobject.h ml_gdkpixbuf.h wrappers.h
ml_gnomecanvas$(XO): ml_gtk.h ml_gobject.h wrappers.h
ml_gnomedruid$(XO): ml_gtk.h ml_gobject.h wrappers.h
ml_panel$(XO): ml_gtk.h ml_gobject.h wrappers.h
varcc.cmo: varcc.ml4

include .depend
