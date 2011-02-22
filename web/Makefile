SCP=scp
LOGIN=zoggy
DEST=forge.ocamlcore.org:/home/groups/lablgtk/htdocs/
DOCDEST=$(DEST)refdoc/

FILES= \
	changes.txt \
	changes2.txt \
	gtk-logo-half.gif \
	index.html \
	install-win32.txt \
	lablgtk.txt \
	lablgtk2.txt

install:
	$(SCP) $(FILES) $(LOGIN)@$(DEST)

installdoc:
	$(SCP) ../doc/html/* $(LOGIN)@$(DOCDEST)