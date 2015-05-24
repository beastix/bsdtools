PWD        != pwd
BOOTSTRAP  := ${PWD}/../beastix/bootstrap/tools
CC         := ${BOOTSTRAP}/bin/x86_64-unknown-linux-musl-gcc
CCFLAGS    :=  -I${PWD}/obj/bsdtools/_install/include/ -I${BOOTSTRAP}/include -nostdinc

BINTARGETS := obj/bsdtools/bin/cat \
              obj/bsdtools/bin/echo \
              obj/bsdtools/bin/ls \
              obj/bsdtools/bin/sync \
              obj/bsdtools/bin/ln \
              obj/bsdtools/bin/mkdir \
              obj/bsdtools/bin/chmod \
              obj/bsdtools/bin/cp \
              obj/bsdtools/bin/rm \
              obj/bsdtools/bin/rmdir \
              obj/bsdtools/bin/realpath \
              obj/bsdtools/bin/pwd \
              obj/bsdtools/bin/hostname

LIBTARGETS := obj/bsdtools/bsd_libutil/libutil.a

lib/bsd_libutil/%.c: lib/bsd_libutil/libutil.h

obj/bsdtools/bsd_libutil/%.o: lib/bsd_libutil/%.c
	${CC} ${CCFLAGS} -c $< -o $@

obj/bsdtools/bsd_libutil/libutil.a: obj/bsdtools/bsd_libutil/humanize_number.o obj/bsdtools/bsd_libutil/strmode.o obj/bsdtools/bsd_libutil/user_from_uid.o obj/bsdtools/bsd_libutil/setmode.o
	ar rcs $@ $^

obj/bsdtools/bin/%: bin/%/*.c obj/bsdtools/bsd_libutil/libutil.a
	${CC} ${CCFLAGS} $^ -o $@

obj/bsdtools/usr.bin/%: usr.bin/%/*.c
	${CC} ${CCFLAGS} $^ -o $@

bsdheaders: include/
	cp -Rv include obj/bsdtools/_install/include
	cp -Rv lib/bsd_libutil/*.h obj/bsdtools/_install/include/

build-bsdtools-binaries: bsdheaders ${BINTARGETS}

build-bsdtools-libraries: ${LIBTARGETS}

build-bsdtools: build-bsdtools-binaries build-bsdtools-libraries

clean-bsdtools-binaries:
	rm -f ${BINTARGETS}
	rm -f obj/bsdtools/_install/bin/*

install-bsdtools: build-bsdtools
	rm -rf obj/bsdtools/_install/bin
	mkdir obj/bsdtools/_install/bin
	cp -v ${BINTARGETS} obj/bsdtools/_install/bin
	mkdir obj/bsdtools/_install/lib
	cp -v ${LIBTARGETS} obj/bsdtools/_install/lib

clean-bsdtools-libraries:
	rm obj/bsdtools/bsd_libutil/*

clean-bsdtools-headers:
	rm -rf obj/bsdtools/_install/include

clean-bsdtools: clean-bsdtools-binaries clean-bsdtools-headers clean-bsdtools-libraries
	
