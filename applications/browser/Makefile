# $Id$
# Makefile for lablgtk.

all: browser

CAMLC = ocamlc
CAMLOPT = ocamlopt
COMPILER = $(CAMLC) $(MLFLAGS) -w s -warn-error A -c
LINKER = $(CAMLC) $(MLFLAGS)
COMPOPT = $(CAMLOPT) $(MLFLAGS) -w s -c
LINKOPT = $(CAMLOPT) $(MLFLAGS)

RANLIB = ranlib

include ../../config.make

MLFLAGS = -I ../../src -I +compiler-libs
ifdef DEBUG
MLFLAGS += -custom -g -ccopt -g #-cclib -lcamlrund
endif

# Rules
.SUFFIXES: .ml .mli .cmo .cmi .cmx .c .o .var .h .opt .def
.ml.cmo:
	$(COMPILER) $<
.mli.cmi:
	$(COMPILER) $<
.ml.cmx:
	$(COMPOPT) $<

# Targets
MLOBJS =  list2.cmo jg_memo.cmo jg_message.cmo file.cmo \
	lexical.cmo searchid.cmo searchpos.cmo \
	shell.cmo editor.cmo

browser: $(MLOBJS)
	$(LINKER) -o $@	ocamlcommon.cma str.cma unix.cma \
	    lablgtk.cma	$(MLOBJS)

clean:
	rm -f *.cm* browser

.depend:
	ocamldep *.ml *.mli > .depend

include .depend
