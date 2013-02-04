
include ../config.make

extract_stubs$(XE): xml.ml extract_stubs.ml
	$(OCAMLFIND) ocamlc -o $@ -package str,xmlm -linkpkg $^

clean:
	rm -f *.cm* extract_stubs$(XE)