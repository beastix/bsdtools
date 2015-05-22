PWD       != pwd
BOOTSTRAP := ${PWD}/../beastix/bootstrap/tools
CC        := ${BOOTSTRAP}/bin/x86_64-unknown-linux-musl-gcc
CCFLAGS   := -Wall -v -I${PWD}/obj/bsdtools/_install/include/ -I${BOOTSTRAP}/include -nostdinc

obj/bsdtools/cat: bin/cat/cat.c
	${CC} ${CCFLAGS} $< -o $@

obj/bsdtools/echo: bin/echo/echo.c
	${CC} ${CCFLAGS} $< -o $@

obj/bsdtools/ls: bin/ls/ls.c
	${CC} ${CCFLAGS} $< -o $@

obj/bsdtools/chflags:

obj/bsdtools/chio:

obj/bsdtools/chmod:

obj/bsdtools/cp:

obj/bsdtools/csh:

obj/bsdtools/date:

obj/bsdtools/dd:

obj/bsdtools/df:

obj/bsdtools/domainname:

obj/bsdtools/ed:

obj/bsdtools/expr:

obj/bsdtools/getfacl:

obj/bsdtools/hostname:

obj/bsdtools/kenv:

obj/bsdtools/kill:

obj/bsdtools/ln:

obj/bsdtools/mkdir:

obj/bsdtools/mv:

obj/bsdtools/pax:

obj/bsdtools/pkill:

obj/bsdtools/ps:

obj/bsdtools/pwait:

obj/bsdtools/pwd:

obj/bsdtools/rcp:

obj/bsdtools/realpath:

obj/bsdtools/rm:

obj/bsdtools/rmail:

obj/bsdtools/rmdir:

obj/bsdtools/setfacl:

obj/bsdtools/sh:

obj/bsdtools/sleep:

obj/bsdtools/stty:

obj/bsdtools/sync:

obj/bsdtools/test:

obj/bsdtools/uuidgen:

bsdheaders: include/
	cp -Rv include obj/bsdtools/_install/include

build-binaries: bsdheaders obj/bsdtools/cat obj/bsdtools/echo obj/bsdtools/ls

build-bsdtools: build-binaries

clean-binaries:
	rm -f obj/bsdtools/cat
	rm -f obj/bsdtools/echo
	rm -f obj/bsdtools/ls

clean-headers:
	rm -rf obj/bsdtools/_install/include

clean-bsdtools: clean-binaries clean-headers
	
