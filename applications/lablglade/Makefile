GLADETOPDIR = /usr/local/src/glade-0.4.1
GLADEDIR = $(GLADETOPDIR)/glade
LABLGTKDIR = ../..

all: var2conv var2def lablglade

configure:
	@rm -f config.make .depend
	@$(MAKE) nothing > /dev/null 2> /dev/null

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
MLFLAGS = -g -I $(LABLGTKDIR)
else
CFLAGS = -I$(GLADEDIR) -I$(LABLGTKDIR) -DGTK_NO_CHECK_CASTS -DGTK_DISABLE_COMPAT_H $(GTKCFLAGS)
LDFLAGS = $(GTKLIBS)
MLFLAGS = -I $(LABLGTKDIR)
endif

ifdef USE_CC
CCOMPILER = $(CC) -c -I$(LABLLIB) $(CFLAGS)
else
CCOMPILER = olablc -c -ccopt "$(CFLAGS)"
endif

ifdef USE_INTL
LDFLAGS += -L$(GLADETOPDIR)/intl -lintl
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
COBJS = ml_glade.o 

MLOBJS =gladeProject.cmo \
	gladeProjectView.cmo gProjectView.cmo \
	gladeProjectWindow.cmo gProjectWindow.cmo \
	gladeMisc.cmo gladeGbWidget.cmo \
	gladeProperty.cmo lglEditor.cmo gladeCallBack.cmo

lablglade: $(LABLGTKDIR)/liblablgtk.a $(LABLGTKDIR)/lablgtk.cma liblablglade.a lablglade.cma libglade/libglade.a
	$(TOPLEVEL) -o $@ -custom -cclib "-L$(GLADEDIR)/gbwidgets -Llibglade -L$(LABLGTKDIR) -L. -llablglade -llablgtk -lglade -lgbwidgets $(LDFLAGS)" $(LABLGTKDIR)/lablgtk.cma lablglade.cma

libglade/libglade.a: libglade/glade_project_window.h libglade/glade_project_window.c
	(cd libglade; make libglade.a)

liblablglade.a: $(COBJS) 
	ar rc $@ $(COBJS) 
	$(RANLIB) $@

lablglade.cma: $(MLOBJS)
	$(LINKER) -a -o $@ $(MLOBJS)



var2conv: $(LABLGTKDIR)/var2conv
	ln -s $(LABLGTKDIR)/var2conv

var2def: $(LABLGTKDIR)/var2def
	ln -s $(LABLGTKDIR)/var2def

clean:
	rm -f *.cm* *.o *.a *_tags.[ch] var2conv var2def lablglade
	(cd libglade; make clean)

.depend:
	olabldep *.ml *.mli > .depend

config.make:
	olablc -v | grep "^Standard" | sed "s/.*: */LABLLIB=/" > config.make
	echo GTKCFLAGS=`gtk-config --cflags` >> config.make
	echo GTKLIBS=`gtk-config --libs` >> config.make
	echo USE_CC=$(USE_CC) >> config.make
	echo USE_INTL=$(USE_INTL) >> config.make
	echo GLADETOPDIR=$(GLADETOPDIR) >> config.make

ml_glade.o: ml_glade.h 

include .depend
