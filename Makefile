PWD        != pwd
BOOTSTRAP  := ${PWD}/../beastix/bootstrap/tools
CC         := ${BOOTSTRAP}/bin/x86_64-unknown-linux-musl-gcc
CCFLAGS    := -I${PWD}/obj/bsdtools/_install/include/ -I${BOOTSTRAP}/include -nostdinc

LIBUTIL_OBJECTS :=  obj/bsdtools/bsd_libutil/humanize_number.o \
                    obj/bsdtools/bsd_libutil/strmode.o \
                    obj/bsdtools/bsd_libutil/user_from_uid.o \
                    obj/bsdtools/bsd_libutil/setmode.o \
                    obj/bsdtools/bsd_libutil/arc4random.o \
                    obj/bsdtools/bsd_libutil/progname.o \
                    obj/bsdtools/bsd_libutil/expand_number.o \
                    obj/bsdtools/bsd_libutil/parsedate.o

BINTARGETS := obj/bsdtools/bin/cat \
              obj/bsdtools/bin/cat \
              obj/bsdtools/bin/chmod \
              obj/bsdtools/bin/cp \
              obj/bsdtools/bin/date \
              obj/bsdtools/bin/domainname \
              obj/bsdtools/bin/echo \
              obj/bsdtools/bin/ed \
              obj/bsdtools/bin/hostname \
              obj/bsdtools/bin/ln \
              obj/bsdtools/bin/ls \
              obj/bsdtools/bin/mkdir \
              obj/bsdtools/bin/mv \
              obj/bsdtools/bin/pwd \
              obj/bsdtools/bin/realpath \
              obj/bsdtools/bin/rm \
              obj/bsdtools/bin/rmdir \
              obj/bsdtools/bin/sleep \
              obj/bsdtools/bin/sync

USRBINTARGETS := obj/bsdtools/usr.bin/asa \
                 obj/bsdtools/usr.bin/apply \
                 obj/bsdtools/usr.bin/banner \
                 obj/bsdtools/usr.bin/basename \
                 obj/bsdtools/usr.bin/c89 \
                 obj/bsdtools/usr.bin/c99 \
                 obj/bsdtools/usr.bin/cksum \
                 obj/bsdtools/usr.bin/colrm \
                 obj/bsdtools/usr.bin/column \
                 obj/bsdtools/usr.bin/comm \
                 obj/bsdtools/usr.bin/dirname \
                 obj/bsdtools/usr.bin/env \
                 obj/bsdtools/usr.bin/expand \
                 obj/bsdtools/usr.bin/false \
                 obj/bsdtools/usr.bin/fold \
                 obj/bsdtools/usr.bin/fsync \
                 obj/bsdtools/usr.bin/getopt \
                 obj/bsdtools/usr.bin/head \
                 obj/bsdtools/usr.bin/jot \
                 obj/bsdtools/usr.bin/lam \
                 obj/bsdtools/usr.bin/logname \
                 obj/bsdtools/usr.bin/mkfifo \
                 obj/bsdtools/usr.bin/mkstr \
                 obj/bsdtools/usr.bin/nice \
                 obj/bsdtools/usr.bin/nohup \
                 obj/bsdtools/usr.bin/paste \
                 obj/bsdtools/usr.bin/pathchk \
                 obj/bsdtools/usr.bin/perror \
                 obj/bsdtools/usr.bin/printenv \
                 obj/bsdtools/usr.bin/printf \
                 obj/bsdtools/usr.bin/renice \
                 obj/bsdtools/usr.bin/seq \
                 obj/bsdtools/usr.bin/true \
                 obj/bsdtools/usr.bin/truncate \
                 obj/bsdtools/usr.bin/tty \
                 obj/bsdtools/usr.bin/unexpand \
                 obj/bsdtools/usr.bin/unifdef \
                 obj/bsdtools/usr.bin/what \
                 obj/bsdtools/usr.bin/which \
                 obj/bsdtools/usr.bin/xstr \
                 obj/bsdtools/usr.bin/yes


LIBTARGETS := obj/bsdtools/bsd_libutil/libutil.a

lib/bsd_libutil/%.c: lib/bsd_libutil/libutil.h

lib/bsd_libutil/parsedata.c: lib/bsd_libutil/parsedata.y
	bison $^ -o $@

obj/bsdtools/bsd_libutil/%.o: lib/bsd_libutil/%.c
	${CC} ${CCFLAGS} -c $< -o $@


obj/bsdtools/bsd_libutil/libutil.a: ${LIBUTIL_OBJECTS}
	ar rcs $@ $^

obj/bsdtools/bin/%: bin/%/*.c obj/bsdtools/bsd_libutil/libutil.a
	${CC} ${CCFLAGS} $^ -o $@

obj/bsdtools/usr.bin/%: usr.bin/%/*.c obj/bsdtools/bsd_libutil/libutil.a
	${CC} ${CCFLAGS} $^ -o $@

bsdheaders: include/
	cp -Rv include obj/bsdtools/_install/include
	cp -Rv lib/bsd_libutil/*.h obj/bsdtools/_install/include/

build-bsdtools-binaries: bsdheaders ${BINTARGETS} ${USRBINTARGETS}

build-bsdtools-libraries: ${LIBTARGETS}

build-bsdtools: build-bsdtools-binaries build-bsdtools-libraries

clean-bsdtools-binaries:
	rm -f ${BINTARGETS}
	rm -f obj/bsdtools/_install/bin/*
	rm -f obj/bsdtools/_install/usr/bin/*

install-bsdtools: build-bsdtools
	rm -rf obj/bsdtools/_install/bin
	rm -rf obj/bsdtools/_install/usr/bin/
	mkdir obj/bsdtools/_install/bin
	mkdir -p obj/bsdtools/_install/usr/bin
	cp -v ${BINTARGETS} obj/bsdtools/_install/bin
	cp -v ${USRBINTARGETS} obj/bsdtools/_install/usr/bin
	rm -rf obj/bsdtools/_install/lib
	mkdir obj/bsdtools/_install/lib
	cp -v ${LIBTARGETS} obj/bsdtools/_install/lib

clean-bsdtools-libraries:
	rm obj/bsdtools/bsd_libutil/*

clean-bsdtools-headers:
	rm -rf obj/bsdtools/_install/include

clean-bsdtools: clean-bsdtools-binaries clean-bsdtools-headers clean-bsdtools-libraries
	
