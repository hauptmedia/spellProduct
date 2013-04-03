.DEFAULT_GOAL := all

UNAME_S := $(shell uname -s)

.PHONY: localbuild
localbuild:
	#create a build using the build environment

.PHONY: linux-ia32
linux-ia32:
	echo build steps for building linux-ia32

.PHONY: linux-x64
linux-x64:
	#create the linux-x64 build using buildbot2
	ssh buildbot@buildbot2 "cd ~/workspace/spellengine && git pull && git submodule init && git submodule update"
	ssh buildbot@buildbot2 "/bin/bash --login -c \"cd ~/workspace/spellengine/modules/spellCore && make cli\""

	mkdir -p build/linux-x64
	scp -r buildbot@buildbot2:"~/workspace/spellengine/modules/spellCore/build/*" build/linux-x64

.PHONY: osx-ia32
osx-ia32:
	#create the osx-ia32 build using buildbot1
	ssh buildbot@buildbot1 "cd ~/workspace/spellengine && git pull && git submodule init && git submodule update"
	ssh buildbot@buildbot1 "/bin/bash --login -c \"cd ~/workspace/spellengine/modules/spellCore && make cli\""
	
	mkdir -p build/osx-ia32
	scp -r buildbot@buildbot1:"~/workspace/spellengine/modules/spellCore/build/*" build/osx-ia32

.PHONY: win-ia32
win-ia32:
	#create the win-ia32 build using buildbot3
	ssh buildbot@buildbot3 "cd ~/workspace/spellengine && git pull && git submodule init && git submodule update"
	ssh buildbot@buildbot3 "/bin/bash --login -c \"cd ~/workspace/spellengine/modules/spellCore && make cli\""
	
	mkdir -p build/win-ia32
	scp -r buildbot@buildbot3:"~/workspace/spellengine/modules/spellCore/build/*" build/win-ia32

.PHONY: clean
clean:
	rm -Rf build/*

all: clean linux-ia32 linux-x64 osx-ia32 win-ia32

