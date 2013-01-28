
OCAMLC=ocamlc
OPT=-g -dtypes
INCLUDES= -I `ocamlfind query xml-light`
LIBS=xml-light.cma str.cma
extract_stubs: extract_prototype.ml
	$(OCAMLC) $(OPT) $(INCLUDES) $(LIBS) -o $@ $^

test: extract_stubs
	./extract_stubs /usr/share/gir-1.0/Gtk-3.0.gir > LOG

check: test
	cd stubs ; ocamlc -c -ccopt '`pkg-config --cflags gtk+-3.0`' ml_stubs_Gtk.c
clean:
	rm -f extract_stubs *.annot extract_prototype.cm* ml_stubs.c stubs.ml
	$(MAKE) -C xml-light clean

xml-light/xml-light.cma:
	$(MAKE) -C xml-light

