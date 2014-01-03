# Toplevel makefile for LablGtk2

all opt doc install uninstall byte world old-install old-uninstall: config.make
all opt install uninstall byte clean depend world old-install old-uninstall:
	$(MAKE) -C src $@

preinstall:
	$(MAKE) -C src $@
	$(MAKE) -f Makefile.pre

htdocs/README.html: README
	asciidoc -o htdocs/README.html README || true

htdocs/tutorial.html: doc/tutorial/tutorial.txt
	asciidoc -o htdocs/tutorial.html doc/tutorial/tutorial.txt || true

tutorial-screens:
	cd doc/tutorial; \
	  awk -f extract_code_from_doc.awk < tutorial.txt; \
	  find . -name '*.ml' | while read file; do \
	    lablgtk2 $${file} & import -frame ../../htdocs/$${file%%.ml}.png; \
			optipng ../../htdocs/$${file%%.ml}.png; \
	  done

doc: htdocs/README.html htdocs/tutorial.html
	 $(MAKE) -C src $@

arch-clean:
	@rm -f config.status config.make config.cache config.log
	@rm -f \#*\# *~ aclocal.m4
	@rm -rf autom4te*.cache

configure: configure.in
	aclocal
	autoconf

config.make: config.make.in
	@echo config.make is not up to date. Execute ./configure first.
	@exit 2

.PHONY: all opt doc install byte world clean depend arch-clean headers

headers:
	find examples -name "*.ml" -exec headache -h header_examples {} \;
	find applications -name "*.ml" -exec headache -h header_apps {} \;
	find applications -name "*.mli" -exec headache -h header_apps {} \;
	find src -name "*.ml" -exec headache -h header {} \;
	find src -name "*.mli" -exec headache -h header {} \;
	find src -name "*.c" -exec headache -h header {} \;
	find src -name "*.h" -exec headache -h header {} \;
