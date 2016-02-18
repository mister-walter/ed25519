
CC := clang-3.6 -std=c11
C_OPTS := -I src/ -fPIC
BUILDDIR := build
SRCDIR := src
BINDIR := bin

all: test

fe.o:
	$(CC) -o $(BUILDDIR)/fe.o -c $(SRCDIR)/fe.c $(C_OPTS)

ge.o:
	$(CC) -o $(BUILDDIR)/ge.o -c $(SRCDIR)/ge.c $(C_OPTS)

keypair.o:
	$(CC) -o $(BUILDDIR)/keypair.o -c $(SRCDIR)/keypair.c $(C_OPTS)

add_scalar.o:
	$(CC) -o $(BUILDDIR)/add_scalar.o -c $(SRCDIR)/add_scalar.c $(C_OPTS)

sc.o:
	$(CC) -o $(BUILDDIR)/sc.o -c $(SRCDIR)/sc.c $(C_OPTS)

seed.o:
	$(CC) -o $(BUILDDIR)/seed.o -c $(SRCDIR)/seed.c $(C_OPTS)

sha512.o:
	$(CC) -o $(BUILDDIR)/sha512.o -c $(SRCDIR)/sha512.c $(C_OPTS)

sign.o:
	$(CC) -o $(BUILDDIR)/sign.o -c $(SRCDIR)/sign.c $(C_OPTS)

verify.o:
	$(CC) -o $(BUILDDIR)/verify.o -c $(SRCDIR)/verify.c $(C_OPTS)

key_exchange.o:
	$(CC) -o $(BUILDDIR)/key_exchange.o -c $(SRCDIR)/key_exchange.c $(C_OPTS)

test: fe.o ge.o keypair.o add_scalar.o sc.o seed.o sha512.o sign.o verify.o key_exchange.o
	$(CC) -o $(BINDIR)/test test.c $(BUILDDIR)/fe.o $(BUILDDIR)/ge.o $(BUILDDIR)/keypair.o $(BUILDDIR)/add_scalar.o $(BUILDDIR)/sc.o $(BUILDDIR)/seed.o $(BUILDDIR)/sha512.o $(BUILDDIR)/sign.o $(BUILDDIR)/verify.o $(BUILDDIR)/key_exchange.o -I src/ -I build/

library: fe.o ge.o keypair.o add_scalar.o sc.o seed.o sha512.o sign.o verify.o key_exchange.o
	$(CC) -shared -Wl,-soname,ed25519.so.1 -o $(BUILDDIR)/ed25519.so.1 $(BUILDDIR)/*.o

install: library
	cp $(BUILDDIR)/ed25519.so.1 /usr/lib/
	cp $(SRCDIR)/ed25519.h /usr/include/

clean: 
	rm -f $(BINDIR)/*
	rm -f $(BUILDDIR)/*
