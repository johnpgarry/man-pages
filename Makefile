# Do "make install" to copy the pages to their destination.
# Do "make gz" before "make install" if you use compressed source pages.
# Do "make remove" before "make gz" if you may have uncompressed
# source pages around.

MANDIR=/usr/man

example: remove gz install

remove:
	for i in man?; do for j in $$i/*; do rm -f $(MANDIR)/$$i/$$j; done; done

gz:
	for i in man?; do gzip $$i/*; done

install:
	for i in man?; do \
		install -d -m 755 $(MANDIR)/$$i; \
		install -m 644 $$i/* $(MANDIR)/$$i; \
	done
# remove pages from man2 that are now in man3
	for j in cfgetispeed cfgetospeed cfsetispeed cfsetospeed \
		tcdrain tcflow tcflush tcgetattr tcgetpgrp \
		tcsendbreak tcsetattr tcsetpgrp termios ;\
	do rm -f $(MANDIR)/man2/$$j.2; done
