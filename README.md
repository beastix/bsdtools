This repository contains a set of tools ported from BSD to Linux (specifically Beastix).

In order to build them you will need a working beastix bootstrap, the build system assumes it will find a built Beastix bootstrap at ../beastix/bootstrap/tools.
Should your Beastix bootstrap live somewhere else, please edit the root Makefile and update the path.

You can then build the tools by issuing the following command:
	
	make build-bsdtools

