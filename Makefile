.PHONY: build build-all opam clean

build:
	dune build

# This also builds examples
build-all:
	dune build @all

# We first pin lablgtk3 as to avoid problems with parallel make
opam:
	opam pin add lablgtk3 . --kind=path -y
	opam install lablgtk3
	opam pin add lablgtk3-sourceview3 . --kind=path -y
	opam install lablgtk3-sourceview3
	opam pin add lablgtk3-gtkspell3 . --kind=path -y
	opam install lablgtk3-gtkspell3

clean:
	dune clean
