# $Id$
# Makefile for lablgtk.

all: radtest

CAMLC = olablc
CAMLOPT = olablopt
COMPILER = $(CAMLC) $(MLFLAGS) -c
LINKER = $(CAMLC) $(MLFLAGS)
COMPOPT = $(CAMLOPT) $(MLFLAGS) -c
LINKOPT = $(CAMLOPT) $(MLFLAGS)

TOPLEVEL = olablmktop $(MLFLAGS)
RANLIB = ranlib

include ../../config.make

MLFLAGS = -I ../..

ifdef DEBUG
CFLAGS = -g $(GTKCFLAGS)
LDFLAGS = $(GTKLIBS) -lcamlrund
MLFLAGS += -g
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

# Targets
MLOBJS = xpm_window.cmo property.cmo treew.cmo

radtest: $(MLOBJS)  libtree2.a gtree2.cma
	$(LINKER) -o radtest -custom -cclib "-L../.. -L. \
		-llablgtk -ltree2 $(GTKLIBS)" \
		stdclass.cma lablgtk.cma gtree2.cma $(MLOBJS)

libtree2.a: gtktree2.o gtktreeitem2.o ml_gtk2.o
	ar rc $@ gtktree2.o gtktreeitem2.o ml_gtk2.o
	$(RANLIB) $@

gtree2.cma: gtkTree2.cmo gTree2.cmo
	$(LINKER) -a -o $@ gtkTree2.cmo gTree2.cmo

clean:
	rm -f *.cm* *.o *.a radtest

.depend:
	olabldep *.ml *.mli > .depend

include .depend
