# Do "make screen" first, if you want to protect already installed,
# more up-to-date manual pages than the ones included in this package.
# Do "make install" to copy the pages to their destination.
# Do "make gz" before "make install" if you use compressed source pages.

# FHS requires /usr/share/man
MANDIR=/usr/man

GZIP=gzip -9
BZIP2=bzip2 -9

all: screen remove gz install

allbz: screen remove bz2 install

screen:
	mkdir not_installed
	for i in man?/*; do \
		if [ $(MANDIR)/$$i -nt $$i ]; then \
			diff -q $(MANDIR)/$$i $$i > /dev/null 2>&1; \
			if [ $$? != 0 ]; then mv $$i not_installed; fi; \
		fi; \
	done

remove:
	rm -f $(MANDIR)/man2/modules.2 $(MANDIR)/man2/modules.2.gz
	rm -f $(MANDIR)/man3/exect.3 $(MANDIR)/man3/exect.3.gz
	for i in man?; do for j in $$i/*; do \
		rm -f $(MANDIR)/$$j $(MANDIR)/$$j.gz; done; done

gz:
	for i in man?; do $(GZIP) $$i/*; done

bz2:
	for i in man?; do $(BZIP2) $$i/*; done

install:
	for i in man?; do \
		install -d -m 755 $(MANDIR)/$$i; \
		install -m 644 $$i/* $(MANDIR)/$$i; \
	done
# someone might also want to look at /var/catman/cat2 or so ...
# a problem is that the location of cat pages varies a lot
