PWD        != pwd
BOOTSTRAP  := ${PWD}/../beastix/bootstrap/tools
CC         := ${BOOTSTRAP}/bin/x86_64-unknown-linux-musl-gcc
CCFLAGS    :=  -I${PWD}/obj/bsdtools/_install/include/ -I${BOOTSTRAP}/include -nostdinc
BINTARGETS := obj/bsdtools/cat obj/bsdtools/echo obj/bsdtools/ls obj/bsdtools/sync obj/bsdtools/ln obj/bsdtools/mkdir

libutil: lib/bsd_libutil/humanize_number.c lib/bsd_libutil/strmode.c lib/bsd_libutil/user_from_uid.c lib/bsd_libutil/setmode.c lib/bsd_libutil/libutil.h

obj/bsdtools/cat: bin/cat/cat.c
	${CC} ${CCFLAGS} $< -o $@

obj/bsdtools/echo: bin/echo/echo.c
	${CC} ${CCFLAGS} $< -o $@

obj/bsdtools/sync: bin/sync/sync.c
	${CC} ${CCFLAGS} $< -o $@

obj/bsdtools/pwd: bin/pwd/pwd.c
	${CC} ${CCFLAGS} $< -o $@

obj/bsdtools/ln: bin/ln/ln.c
	${CC} ${CCFLAGS} $< -o $@

obj/bsdtools/mkdir: libutil bin/mkdir/mkdir.c
	mkdir obj/bsdtools/mkdir.build
	${CC} ${CCFLAGS} -c bin/mkdir/mkdir.c         -o obj/bsdtools/mkdir.build/mkdir.o
	${CC} ${CCFLAGS} -c lib/bsd_libutil/setmode.c -o obj/bsdtools/mkdir.build/setmode.o
	${CC} ${CCFLAGS} obj/bsdtools/mkdir.build/setmode.o obj/bsdtools/mkdir.build/mkdir.o -o obj/bsdtools/mkdir
	rm -rf obj/bsdtools/mkdir.build

obj/bsdtools/ls: bin/ls/util.c bin/ls/ls.c bin/ls/cmp.c  bin/ls/print.c libutil
	mkdir obj/bsdtools/ls.build
	${CC} ${CCFLAGS} -c bin/ls/util.c                     -o obj/bsdtools/ls.build/util.o
	${CC} ${CCFLAGS} -c bin/ls/cmp.c                      -o obj/bsdtools/ls.build/cmp.o
	${CC} ${CCFLAGS} -c bin/ls/print.c                    -o obj/bsdtools/ls.build/print.o
	${CC} ${CCFLAGS} -c bin/ls/ls.c                       -o obj/bsdtools/ls.build/ls.o
	${CC} ${CCFLAGS} -c lib/bsd_libutil/humanize_number.c -o obj/bsdtools/ls.build/humanize_number.o
	${CC} ${CCFLAGS} -c lib/bsd_libutil/strmode.c         -o obj/bsdtools/ls.build/strmode.o
	${CC} ${CCFLAGS} -c lib/bsd_libutil/user_from_uid.c   -o obj/bsdtools/ls.build/user_from_uid.o
	${CC} ${CCFLAGS} obj/bsdtools/ls.build/util.o obj/bsdtools/ls.build/cmp.o obj/bsdtools/ls.build/humanize_number.o obj/bsdtools/ls.build/strmode.o obj/bsdtools/ls.build/user_from_uid.o obj/bsdtools/ls.build/print.o obj/bsdtools/ls.build/ls.o -o $@
	rm -rf obj/bsdtools/ls.build

obj/bsdtools/chmod:

obj/bsdtools/cp:

obj/bsdtools/csh:

obj/bsdtools/date:

obj/bsdtools/dd:

obj/bsdtools/df:

obj/bsdtools/domainname:

obj/bsdtools/ed:

obj/bsdtools/expr:

obj/bsdtools/hostname:

obj/bsdtools/kill:

obj/bsdtools/mv:

obj/bsdtools/pkill:

obj/bsdtools/ps:

obj/bsdtools/pwait:
obj/bsdtools/realpath:

obj/bsdtools/rm:

obj/bsdtools/rmdir:

obj/bsdtools/sh:

obj/bsdtools/sleep:

obj/bsdtools/stty:

obj/bsdtools/test:

obj/bsdtools/uuidgen:

bsdheaders: include/
	cp -Rv include obj/bsdtools/_install/include
	cp -Rv lib/bsd_libutil/*.h obj/bsdtools/_install/include/

build-binaries: bsdheaders ${BINTARGETS}

build-bsdtools: build-binaries

clean-binaries:
	rm -rf obj/bsdtools/*.build
	rm -f obj/bsdtools/cat
	rm -f obj/bsdtools/echo
	rm -f obj/bsdtools/ls

install-bsdtools: build-bsdtools
	rm -rf obj/bsdtools/_install/bin
	mkdir obj/bsdtools/_install/bin
	cp -v ${BINTARGETS} obj/bsdtools/_install/bin

clean-headers:
	rm -rf obj/bsdtools/_install/include

clean-bsdtools: clean-binaries clean-headers
	
