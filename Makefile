CZMQDIR := /next/home/mah/src/czmq-sappo

CFLAGS := -g -std=c11  \
	`pkg-config --cflags libczmq python`
LDFLAGS := -g `pkg-config --libs libczmq python`

all: clean test ztrie.so
clean:
	rm -f test ztrie.so *.o  cyztrie.c

test: test.c
	cc $(CFLAGS) test.c  $(LDFLAGS) -lpthread -luuid -o test


ztrie.so: ztrie.pxd ztrie.pyx
	cython -o  ztrie.c  ztrie.pyx
	cc -fPIC -c $(CFLAGS) ztrie.c  $(LDFLAGS)
	cc  ztrie.o  $(LDFLAGS)  -shared -o ztrie.so
