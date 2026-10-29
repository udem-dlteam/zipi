#*=====================================================================*/
#*    serrano/prgm/project/zipi/zipi/Makefile                          */
#*    -------------------------------------------------------------    */
#*    Author      :  Marc Feeley & Manuel Serrano                      */
#*    Creation    :  Sat Feb 19 12:25:16 2000                          */
#*    Last change :  Wed Aug 18 14:58:33 2021 (serrano)                */
#*    Copyright   :  2019-21 Marc Feeley & Manuel Serrano              */
#*    -------------------------------------------------------------    */
#*    The Makefile to build Zipi.                                      */
#*=====================================================================*/
.PHONY: do mkdir

do: build

#*---------------------------------------------------------------------*/
#*    Standard Bigloo configuration                                    */
#*---------------------------------------------------------------------*/
-include etc/Makefile.zipiconfig

#*---------------------------------------------------------------------*/
#*    Scheme compilers (Gambit and Bigloo)                             */
#*    -------------------------------------------------------------    */
#*    "make compilers" builds the pinned releases below from their     */
#*    GitHub repositories and installs them in $(DEPSDIR). ./configure */
#*    uses them by default. To use local installations instead, see   */
#*    the GSI, GSC, BIGLOO and PYTHON variables documented in README.  */
#*    CPython is also built because the Zipi front end (pysexp) and    */
#*    the test suite require CPython 3.9.                              */
#*---------------------------------------------------------------------*/
# Pinned releases (git tags of the GitHub repositories)
GAMBIT_VERSION		= v4.9.8
BIGLOO_VERSION		= v4.7b
PYTHON_VERSION		= v3.9.25

GAMBIT_GIT_URL		= https://github.com/gambit/gambit.git
BIGLOO_GIT_URL		= https://github.com/manuel-serrano/bigloo.git
PYTHON_GIT_URL		= https://github.com/python/cpython.git

GAMBIT_CONFIGURE_FLAGS	= --enable-single-host
BIGLOO_CONFIGURE_FLAGS	= --jvm=no --disable-gstreamer
PYTHON_CONFIGURE_FLAGS	= --without-ensurepip

# The Bigloo git repository does not contain the bootstrapped C files, so
# building it requires an installed Bigloo of the previous release (or a
# more recent one). When BIGLOO_BOOT_BINDIR is set to the bin directory of
# such an installation, that Bigloo is used. Otherwise, the Bigloo source
# release below (which contains the bootstrapped C files) is downloaded,
# checked against its pinned SHA-512, built and used.
BIGLOO_BOOT_BINDIR	=
BIGLOO_BOOT_VERSION	= 4.7a
BIGLOO_BOOT_SHA512	= 8516956472c6e390b5eaf9dee6bc804dc5f340bd75070d8146acc8d07050b49c0e0e35bdd7a46eb9877dd44eeca7ee7198c3cd51e22f5640a8d700cd4fe8603a
BIGLOO_BOOT_URLS	= \
  https://www-sop.inria.fr/indes/fp/Bigloo/download/bigloo-$(BIGLOO_BOOT_VERSION).tar.gz \
  https://cdn.netbsd.org/pub/pkgsrc/distfiles/bigloo-$(BIGLOO_BOOT_VERSION).tar.gz

# Where the compilers are built and installed
# (the dependency directory of ./configure --dependencies-dir, if any)
DEPSDIR			= $(or $(BUILDDEPDIR),$(CURDIR)/dependencies)
DEPSSRCDIR		= $(CURDIR)/build-dependencies/src
GAMBIT_PREFIX		= $(DEPSDIR)/gambit-$(GAMBIT_VERSION)
BIGLOO_PREFIX		= $(DEPSDIR)/bigloo-$(BIGLOO_VERSION)
PYTHON_PREFIX		= $(DEPSDIR)/cpython-$(PYTHON_VERSION)
BIGLOO_BOOT_PREFIX	= $(DEPSSRCDIR)/bigloo-boot-$(BIGLOO_BOOT_VERSION)

DEPSJOBS		:= $(shell nproc 2> /dev/null || sysctl -n hw.ncpu 2> /dev/null || echo 1)

.PHONY: compilers gambit bigloo python compilers-paths clean-compilers

compilers: gambit bigloo python

gambit: $(GAMBIT_PREFIX)/.built
bigloo: $(BIGLOO_PREFIX)/.built
python: $(PYTHON_PREFIX)/.built

# Shell assignments used by ./configure to locate the compilers
compilers-paths:
	@echo "deps_gambit_version=$(GAMBIT_VERSION)"
	@echo "deps_gambit_prefix=$(GAMBIT_PREFIX)"
	@echo "deps_bigloo_version=$(BIGLOO_VERSION)"
	@echo "deps_bigloo_prefix=$(BIGLOO_PREFIX)"
	@echo "deps_python_version=$(PYTHON_VERSION)"
	@echo "deps_python_prefix=$(PYTHON_PREFIX)"

$(GAMBIT_PREFIX)/.built:
	@echo "*** Building Gambit $(GAMBIT_VERSION) in $(GAMBIT_PREFIX)"
	mkdir -p $(DEPSSRCDIR)
	rm -rf $(DEPSSRCDIR)/gambit-$(GAMBIT_VERSION)
	git -c advice.detachedHead=false clone --depth 1 --branch $(GAMBIT_VERSION) \
	  $(GAMBIT_GIT_URL) $(DEPSSRCDIR)/gambit-$(GAMBIT_VERSION)
	cd $(DEPSSRCDIR)/gambit-$(GAMBIT_VERSION) && \
	  ./configure --prefix=$(GAMBIT_PREFIX) $(GAMBIT_CONFIGURE_FLAGS) && \
	  $(MAKE) -j$(DEPSJOBS) && \
	  $(MAKE) -j$(DEPSJOBS) modules && \
	  $(MAKE) install
	rm -rf $(DEPSSRCDIR)/gambit-$(GAMBIT_VERSION)
	$(GAMBIT_PREFIX)/bin/gsi -e '(println (##system-version-string))'
	touch $@

$(BIGLOO_PREFIX)/.built: $(if $(BIGLOO_BOOT_BINDIR),,$(BIGLOO_BOOT_PREFIX)/.built)
	@echo "*** Building Bigloo $(BIGLOO_VERSION) in $(BIGLOO_PREFIX)"
	mkdir -p $(DEPSSRCDIR)
	rm -rf $(DEPSSRCDIR)/bigloo-$(BIGLOO_VERSION)
	git -c advice.detachedHead=false clone --depth 1 --branch $(BIGLOO_VERSION) \
	  $(BIGLOO_GIT_URL) $(DEPSSRCDIR)/bigloo-$(BIGLOO_VERSION)
	cd $(DEPSSRCDIR)/bigloo-$(BIGLOO_VERSION) && \
	  boot=$(or $(BIGLOO_BOOT_BINDIR),$(BIGLOO_BOOT_PREFIX)/bin) && \
	  export PATH="$$boot:$$PATH" && \
	  BGLBUILDBINDIR=$$boot ./configure --prefix=$(BIGLOO_PREFIX) $(BIGLOO_CONFIGURE_FLAGS) && \
	  $(MAKE) hostboot BGLBUILDBINDIR=$$boot && \
	  $(MAKE) install-progs && \
	  $(MAKE) -j$(DEPSJOBS) cibootstrap CONFIGUREOPTS="--prefix=$(BIGLOO_PREFIX) $(BIGLOO_CONFIGURE_FLAGS)" && \
	  $(MAKE) install-sans-docs
	rm -rf $(DEPSSRCDIR)/bigloo-$(BIGLOO_VERSION)
	$(BIGLOO_PREFIX)/bin/bigloo -version
	touch $@

$(BIGLOO_BOOT_PREFIX)/.built:
	@echo "*** Building bootstrap Bigloo $(BIGLOO_BOOT_VERSION) in $(BIGLOO_BOOT_PREFIX)"
	mkdir -p $(DEPSSRCDIR)
	cd $(DEPSSRCDIR) && \
	  tarball=bigloo-$(BIGLOO_BOOT_VERSION).tar.gz && \
	  for url in $(BIGLOO_BOOT_URLS); do \
	    echo "$(BIGLOO_BOOT_SHA512)  $$tarball" | sha512sum -c --status 2> /dev/null && break; \
	    echo "*** downloading $$url"; \
	    curl -fsSL "$$url" -o $$tarball || rm -f $$tarball; \
	  done && \
	  echo "$(BIGLOO_BOOT_SHA512)  $$tarball" | sha512sum -c && \
	  rm -rf bigloo-$(BIGLOO_BOOT_VERSION) && \
	  tar xzf $$tarball && \
	  cd bigloo-$(BIGLOO_BOOT_VERSION) && \
	  ./configure --prefix=$(BIGLOO_BOOT_PREFIX) $(BIGLOO_CONFIGURE_FLAGS) && \
	  $(MAKE) -j$(DEPSJOBS) && \
	  $(MAKE) install-sans-docs
	rm -rf $(DEPSSRCDIR)/bigloo-$(BIGLOO_BOOT_VERSION)
	touch $@

$(PYTHON_PREFIX)/.built:
	@echo "*** Building CPython $(PYTHON_VERSION) in $(PYTHON_PREFIX)"
	mkdir -p $(DEPSSRCDIR)
	rm -rf $(DEPSSRCDIR)/cpython-$(PYTHON_VERSION)
	git -c advice.detachedHead=false clone --depth 1 --branch $(PYTHON_VERSION) \
	  $(PYTHON_GIT_URL) $(DEPSSRCDIR)/cpython-$(PYTHON_VERSION)
	cd $(DEPSSRCDIR)/cpython-$(PYTHON_VERSION) && \
	  ./configure --prefix=$(PYTHON_PREFIX) $(PYTHON_CONFIGURE_FLAGS) && \
	  $(MAKE) -j$(DEPSJOBS) && \
	  $(MAKE) install
	rm -rf $(DEPSSRCDIR)/cpython-$(PYTHON_VERSION)
	$(PYTHON_PREFIX)/bin/python3 --version
	touch $@

clean-compilers:
	rm -rf $(DEPSSRCDIR) $(GAMBIT_PREFIX) $(BIGLOO_PREFIX) $(PYTHON_PREFIX)


#*---------------------------------------------------------------------*/
#*    build                                                            */
#*---------------------------------------------------------------------*/
.PHONY: build clean distclean cleanall test test-gambit test-bigloo

# Local compilers can also be selected when building, e.g.,
#   make GSI=gsi GSC=gsc BIGLOO=bigloo PYTHON=python3.9
# which reconfigures Zipi with these tools before building it.
RECONFIGUREVARS = $(foreach v,GSI GSC BIGLOO PYTHON,\
  $(if $(filter command line,$(origin $(v))),$(v)=$($(v))))

.PHONY: reconfigure

reconfigure:
	./configure $(ZIPICONFIGUREARGS) $(RECONFIGUREVARS)

build: $(if $(strip $(RECONFIGUREVARS)),reconfigure)
	@if [ ! -f etc/Makefile.zipiconfig ]; then \
	  echo "*** Zipi is not configured, run ./configure first"; exit 1; \
	fi
	mkdir -p bin
	mkdir -p lib
	$(MAKE) -C pyc
	$(MAKE) -C zpc
	$(MAKE) -C stdlib
	$(MAKE) -C rts
	$(MAKE) -C zipi

#*---------------------------------------------------------------------*/
#*    install                                                          */
#*---------------------------------------------------------------------*/
install: install-unsafe

install-unsafe: zipi-dirs install-bin $(ZIPISYSTEMS:%=install.%)
	$(MAKE) -C pyc install
	$(MAKE) -C zpc install
	$(MAKE) -C stdlib install
	$(MAKE) -C rts install
	$(MAKE) -C zipi install
	$(MAKE) install.systems
	$(INSTALL) $(ZIPIBINDIR)/zipi $(INSTALLBINDIR)/zipi
	$(INSTALL) $(ZIPIBINDIR)/zipi $(INSTALLBINDIR)/zipi-$(PYTHONVERSION)

install-bin: zipi-dirs
	for file in zipi zipi.gambit zipi-compile-and-run.gambit zipi.bigloo zpc zpc.gambit pysexp_script.py; \
		do \
		cat $(BUILDBINDIR)/$$file.in \
			| sed -e "s|@RELEASE@|$(ZIPIRELEASE)|g" \
						-e "s|@DEFAULT_SCHEME_SYSTEM@|$(DEFAULT_SCHEME_SYSTEM)|g" \
						-e "s|@DATE@|$(ZIPIDATE)|g" \
						-e "s|@BRANCH@|$(ZIPIBRANCH)|g" \
						-e "s|@VERSION@|$(ZIPIVERSION)|g" \
						-e "s|@PYTHONVERSION@|$(PYTHONVERSION)|g" \
						-e "s|@SYSTEMS@|$(ZIPISYSTEMS)|g" \
						-e "s|@ZIPIBIN@|$(ZIPIBINDIR)|g" \
						-e "s|@ZIPIETC@|$(ZIPIETCDIR)|g" \
						-e "s|@ZIPIRTS@|$(ZIPIRTSDIR)|g" \
						-e "s|@BIGLOO@|$(BIGLOO)|g" \
						-e "s|@GAMBIT@|$(GAMBIT)|g" \
						-e "s|@GAMBITROOT@|$(GAMBITROOT)|g" \
						-e "s|@PYTHON@|$(PYTHON)|g" \
						-e "s|@ZIPICACHE@|$(ZIPICACHE)|g" \
						-e "s|@ZIPIROOT@|$(ZIPIROOT)|g" \
			> $(ZIPIBINDIR)/$$file; \
		chmod a+xr $(ZIPIBINDIR)/$$file; \
		done;
	rm -rf $(ZIPIBINDIR)/pysexp
	(cd $(BUILDBINDIR) && tar cf - pysexp | (cd $(ZIPIBINDIR) && tar xvf -))
	chmod -R a+rx $(ZIPIBINDIR)/pysexp

install.systems: $(ZIPISYSTEMS:%=install.system.%)

-include etc/Makefile.bigloo
-include etc/Makefile.gambit

-include Makefile.bigloo

zipi-dirs:
	mkdir -p $(ZIPIPREFIX)/bin
	mkdir -p $(ZIPIPREFIX)/lib
	if [ ! -d $(ZIPIBINDIR) ]; then \
    mkdir -p $(ZIPIBINDIR) && chmod $(MODDIR) $(ZIPIBINDIR); \
  fi
	if [ ! -d $(ZIPILIBDIR) ]; then \
    mkdir -p $(ZIPILIBDIR) && chmod $(MODDIR) $(ZIPILIBDIR); \
  fi
	if [ ! -d $(ZIPIETCDIR) ]; then \
	  mkdir -p $(ZIPIETCDIR) && chmod $(MODDIR) $(ZIPIETCDIR); \
  fi
	if [ ! -d $(ZIPIZPCDIR) ]; then \
	  mkdir -p $(ZIPIZPCDIR) && chmod $(MODDIR) $(ZIPIZPCDIR); \
  fi
	if [ ! -d $(ZIPILIBDIR)/zipi ]; then \
	  mkdir -p $(ZIPILIBDIR)/zipi && chmod $(MODDIR) $(ZIPILIBDIR)/zipi; \
  fi
	if [ ! -d $(ZIPISTDLIBDIR)/zipi ]; then \
	  mkdir -p $(ZIPISTDLIBDIR)/zipi && chmod $(MODDIR) $(ZIPISTDLIBDIR)/zipi; \
  fi


#*---------------------------------------------------------------------*/
#*    clean                                                            */
#*---------------------------------------------------------------------*/
clean:
	$(MAKE) -C pyc clean
	$(MAKE) -C zpc clean
	$(MAKE) -C rts clean
	$(MAKE) -C stdlib clean
	$(MAKE) -C zipi clean

distclean: clean
	$(MAKE) -C pyc distclean
	$(MAKE) -C zpc distclean
	$(MAKE) -C rts distclean
	$(MAKE) -C stdlib distclean
	$(MAKE) -C zipi distclean
	rm -rf lib
	rm -f etc/Makefile.zipiconfig
	rm -f bin/pysexp_script.py
	rm -rf bin/pysexp
	rm -f bin/zipi
	rm -f bin/zipi.bigloo
	rm -f bin/zipi.gambit
	rm -f bin/zpc
	rm -f bin/zpc.bigloo.sh
	rm -f bin/zpc.gambit
	rm -f bin/zipi-compile-and-run.gambit
	rm -f bin/zipi-compile-and-run.bigloo
	rm -f config.status

clean-dependencies:
	rm -rf $(DEPSDIR) $(DEPSSRCDIR)

cleanall: distclean

test:
	@cd tests; $(BUILDPYTHON) run.py --cpython $(BUILDPYTHON) --zipi $(BUILDBINDIR)/zipi

test-gambit:
	@cd tests; $(BUILDPYTHON) run.py --cpython $(BUILDPYTHON) --zipi $(BUILDBINDIR)/zipi.gambit

test-bigloo:
	@cd tests; $(BUILDPYTHON) run.py --cpython $(BUILDPYTHON) --zipi $(BUILDBINDIR)/zipi.bigloo

unittest:
	@cd unittest; make unittest

.PHONY: bench bench-gambit bench-bigloo

bench:
	@$(MAKE) --no-print-directory -C bench check

bench-gambit:
	@$(MAKE) --no-print-directory -C bench check system=$(BUILDBINDIR)/zipi.gambit

bench-bigloo:
	@$(MAKE) --no-print-directory -C bench check system=$(BUILDBINDIR)/zipi.bigloo
