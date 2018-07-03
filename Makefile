N=libsysemul
URL=http://$(DEPLOY_KEY):@robert.lavavps.lt:21182

all:

dependencies-install:
	apt-get update -qq
	apt-get install -y gcc-multilib curl

build_before:
	make dependencies-install

build: build_bin build_deploy

build_bin:
	$(MAKE) -C src

build_deploy:
	@echo Uploading...
	@curl $(URL)/$(N)/$(CI_BUILD_ID)/x86/libsysemul.so -F img=@src/x86/libsysemul.so
	@curl $(URL)/$(N)/$(CI_BUILD_ID)/x64/libsysemul.so -F img=@src/x64/libsysemul.so
	md5sum src/x86/libsysemul.so
	md5sum src/x64/libsysemul.so

test:
	./test.sh

.PHONY: all dependencies-install build_before build build_bin build_deploy test
