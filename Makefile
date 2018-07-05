VERSION = 0.0.1
N = libsysemul
N0 = $(N)0
URL = http://$(DEPLOY_KEY):@robert.lavavps.lt:21182
DEB_BUILD_ARCH ?= $(shell dpkg-architecture -qDEB_BUILD_ARCH)
_DISTRIB_VERSION ?= $(shell ./os-version.sh)
DISTRIB_VERSION := $(_DISTRIB_VERSION)

all:
	$(MAKE) -C src all

install:
	$(MAKE) -C src install

clean:
	$(MAKE) -C src clean

ci-all:
	$(MAKE) build_before
	$(MAKE) pkg-build
	$(MAKE) pkg-upload
	$(MAKE) pkg-test

build_before:
	$(MAKE) pkg-dependencies-install

pkg-dependencies-install:
	apt-get update -qq
	apt-get install -y dpkg-dev fakeroot lintian
	apt-get install -y debhelper
	apt-get install -y gcc-multilib curl

pkg-build:
	cd dist/`./os-version.sh` && dpkg-buildpackage -us -uc

pkg-upload: F=dist/$(N0)_$(VERSION)~$(DISTRIB_VERSION)_$(DEB_BUILD_ARCH).deb
pkg-upload:
	# hide DEPLOY_KEY
	@echo Uploading $(F)
	@curl $(URL)/$(N)/$(CI_BUILD_ID)/$(F) -F img=@$(F)
	md5sum $(F)

test:
	./test-00.sh

pkg-test: test
	lintian -EviIL +pedantic dist/$(N)_$(VERSION)~$(DISTRIB_VERSION)_$(DEB_BUILD_ARCH).changes

.PHONY: all install clean build_before pkg-dependencies-install pkg-build pkg-upload pkg-test test

# aliases
distclean: clean

.PHONY: distclean
