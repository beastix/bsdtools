BOOTSTRAP := `pwd`/../beastix/bootstrap/tools
CC        := ${BOOTSTRAP}/bin/x86_64-unknown-linux-musl-gcc
CCFLAGS   := -Iobj/bsdtools/_install/include/

obj/bsdtools/cat: bin/cat/cat.c
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

obj/bsdtools/echo:

obj/bsdtools/ed:

obj/bsdtools/expr:

obj/bsdtools/getfacl:

obj/bsdtools/hostname:

obj/bsdtools/kenv:

obj/bsdtools/kill:

obj/bsdtools/ln:

obj/bsdtools/ls:

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

build-binaries: bsdheaders obj/bsdtools/cat

build-bsdtools: build-binaries
