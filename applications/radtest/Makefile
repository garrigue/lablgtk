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

GTKLIBS = -L/usr/lib -L/usr/X11R6/lib -lgtk -lgdk -rdynamic -lgmodule -lglib -ldl -lXi -lXext -lX11 -lm

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
MLOBJS = xpm_window.cmo property.cmo widget.cmo treew.cmo

radtest: $(MLOBJS)
	$(LINKER) -o radtest -custom -cclib "-L../.. \
		-llablgtk $(GTKLIBS)" \
		stdclass.cma lablgtk.cma $(MLOBJS)
clean:
	rm -f *.cm* radtest

.depend:
	olabldep *.ml *.mli > .depend


include .depend
