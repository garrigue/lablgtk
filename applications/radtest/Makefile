# $Id$
# Makefile for lablgtk.

include ../../config.make

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
MLOBJS = property.cmo widget.cmo treew.cmo

radtest: $(MLOBJS)
	$(LINKER) -o radtest -custom -cclib "-L../.. \
		-llablgtk $(GTKLIBS)" \
		stdclass.cma lablgtk.cma $(MLOBJS)
clean:
	rm -f *.cm* radtest

.depend:
	olabldep *.ml *.mli > .depend


include .depend
