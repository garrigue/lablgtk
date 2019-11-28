OCAMLC=ocamlc
OPT=-g -dtypes
INCLUDES= -I xml-light xml-light.cma 
GIRA=/usr/share/gir-1.0/Gtk-3.0.gir
GIR=Gtk-3.0

all: high check

extract_stubs: extract_prototype.ml xml-light/xml-light.cma
	$(OCAMLC) $(OPT) $(INCLUDES) -o $@ $^

test: extract_stubs
	./extract_stubs $(GIRA) > LOG

check: test
	cd stubs ; ocamlc -c -ccopt '`pkg-config --cflags gtk+-3.0`' ml_stubs_Gtk.c

clean:
	rm -f extract_stubs *.annot extract_prototype.cm* ml_stubs.c stubs.ml
	$(MAKE) -C xml-light clean

xml-light/xml-light.cma:
	$(MAKE) -C xml-light

################################################################


high: $(GIR).props propcc link
	./propcc $<
.PHONY: all

link: $(GIRA)
	ln -f -s $(GIRA) .

$(GIR).props: $(GIR).gir gir_to_props.xsl
	xsltproc -o $@ gir_to_props.xsl $<

#$(GIR): /usr/lib/x86_64-linux-gnu/girepository-1.0/Gtk-3.0.typelib
	#g-ir-generate -o $@ $<

propcc.ml: propcc.ml4
	camlp5o -impl $< -o $@

propcc.cmo: propcc.ml genlex.cmo
	ocamlc -c $<

genlex.cmo: genlex.ml
	ocamlc -c $<

propcc: propcc.cmo genlex.cmo
	ocamlc -o $@ genlex.cmo $<
