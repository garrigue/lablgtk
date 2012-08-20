all: unicode_table unicode_viewer

unicode_table: unicode_table.ml
	ocamlfind ocamlc -package lablgtk2 -linkpkg -o unicode_table $<
unicode_table.opt: unicode_table.ml
	ocamlfind ocamlopt -package lablgtk2 -linkpkg -o unicode_table $<

unicode_viewer: unicode_viewer.ml
	ocamlfind ocamlc -package lablgtk2 -linkpkg -o unicode_viewer $<
clean:
	rm *.cm* *.o unicode_viewer unicode_table

