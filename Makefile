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
#*    Compilers (Gambit, Bigloo) and CPython                           */
#*    -------------------------------------------------------------    */
#*    "make compilers" downloads the pinned GitHub releases below,     */
#*    checks them against their pinned SHA-256, and builds and         */
#*    installs them in $(DEPSDIR). ./configure uses them by default.   */
#*    To use local installations instead, see the GSI, GSC, BIGLOO and */
#*    PYTHON variables documented in README.md. CPython is needed      */
#*    because the Zipi front end (pysexp) and the test suite require   */
#*    CPython 3.9.                                                     */
#*---------------------------------------------------------------------*/
# Pinned releases
GAMBIT_VERSION		= 4.9.8
BIGLOO_VERSION		= 4.7b
PYTHON_VERSION		= 3.9.25

# The Gambit and CPython releases are GitHub's source archives of the
# release tags (the Gambit tree contains the C files generated for the
# release). The Bigloo release is the tarball attached to the GitHub
# release, which contains the bootstrapped C files, so no Bigloo is needed
# to build it (unlike the Bigloo git repository).
GAMBIT_URL		= https://github.com/gambit/gambit/archive/refs/tags/v$(GAMBIT_VERSION).tar.gz
BIGLOO_URL		= https://github.com/manuel-serrano/bigloo/releases/download/v$(BIGLOO_VERSION)/bigloo-$(BIGLOO_VERSION).tar.gz
PYTHON_URL		= https://github.com/python/cpython/archive/refs/tags/v$(PYTHON_VERSION).tar.gz

# SHA-256 of the release tarballs. When a checksum is empty, the
# tarball is not checked and its checksum is printed so that it can be
# pinned here.
GAMBIT_SHA256		= 0ec19b755dbda6c540e9e60b7235d801f26f40c2f211ddfb729b756218bcc873
BIGLOO_SHA256		= c65dd791d88d1a69d0a87b6dbe7a2c41d88289e6443354eb117c67451e44aab6
PYTHON_SHA256		=

GAMBIT_CONFIGURE_FLAGS	= --enable-single-host
BIGLOO_CONFIGURE_FLAGS	= --jvm=no --disable-gstreamer
PYTHON_CONFIGURE_FLAGS	= --without-ensurepip

# Where the compilers are built and installed
# (the dependency directory of ./configure --dependencies-dir, if any)
DEPSDIR			= $(or $(BUILDDEPDIR),$(CURDIR)/dependencies)
DEPSSRCDIR		= $(CURDIR)/build-dependencies/src
GAMBIT_PREFIX		= $(DEPSDIR)/gambit-$(GAMBIT_VERSION)
BIGLOO_PREFIX		= $(DEPSDIR)/bigloo-$(BIGLOO_VERSION)
PYTHON_PREFIX		= $(DEPSDIR)/cpython-$(PYTHON_VERSION)

DEPSJOBS		:= $(shell nproc 2> /dev/null || sysctl -n hw.ncpu 2> /dev/null || echo 1)
SHA256SUM		:= $(shell command -v sha256sum > /dev/null 2>&1 && echo sha256sum || echo "shasum -a 256")

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

# fetch-release,name,url,sha256: download the tarball of a release into
# $(DEPSSRCDIR)/name.tar.gz (unless already there), check its SHA-256, and
# extract it in the empty directory $(DEPSSRCDIR)/name
define fetch-release
	mkdir -p $(DEPSSRCDIR)
	cd $(DEPSSRCDIR) && \
	  if [ "$(3) " != " " ] && [ -f $(1).tar.gz ] && \
	     ! echo "$(3)  $(1).tar.gz" | $(SHA256SUM) -c --status 2> /dev/null; then \
	    rm -f $(1).tar.gz; \
	  fi && \
	  if [ ! -f $(1).tar.gz ]; then \
	    echo "*** downloading $(2)"; \
	    curl -fsSL --retry 3 -o $(1).tar.gz.tmp "$(2)" && mv $(1).tar.gz.tmp $(1).tar.gz; \
	  fi && \
	  if [ "$(3) " != " " ]; then \
	    echo "$(3)  $(1).tar.gz" | $(SHA256SUM) -c; \
	  else \
	    echo "*** WARNING: $(1).tar.gz is not checked, its SHA-256 is:"; \
	    $(SHA256SUM) $(1).tar.gz; \
	  fi && \
	  rm -rf $(1) && mkdir $(1) && \
	  tar xzf $(1).tar.gz -C $(1) --strip-components=1
endef

$(GAMBIT_PREFIX)/.built:
	@echo "*** Building Gambit $(GAMBIT_VERSION) in $(GAMBIT_PREFIX)"
	$(call fetch-release,gambit-$(GAMBIT_VERSION),$(GAMBIT_URL),$(GAMBIT_SHA256))
	cd $(DEPSSRCDIR)/gambit-$(GAMBIT_VERSION) && \
	  ./configure --prefix=$(GAMBIT_PREFIX) $(GAMBIT_CONFIGURE_FLAGS) && \
	  $(MAKE) -j$(DEPSJOBS) && \
	  $(MAKE) -j$(DEPSJOBS) modules && \
	  $(MAKE) install
	rm -rf $(DEPSSRCDIR)/gambit-$(GAMBIT_VERSION)
	$(GAMBIT_PREFIX)/bin/gsi -e '(println (##system-version-string))'
	touch $@

$(BIGLOO_PREFIX)/.built:
	@echo "*** Building Bigloo $(BIGLOO_VERSION) in $(BIGLOO_PREFIX)"
	$(call fetch-release,bigloo-$(BIGLOO_VERSION),$(BIGLOO_URL),$(BIGLOO_SHA256))
	cd $(DEPSSRCDIR)/bigloo-$(BIGLOO_VERSION) && \
	  ./configure --prefix=$(BIGLOO_PREFIX) $(BIGLOO_CONFIGURE_FLAGS) && \
	  $(MAKE) -j$(DEPSJOBS) && \
	  $(MAKE) install-sans-docs
	rm -rf $(DEPSSRCDIR)/bigloo-$(BIGLOO_VERSION)
	$(BIGLOO_PREFIX)/bin/bigloo -version
	touch $@

$(PYTHON_PREFIX)/.built:
	@echo "*** Building CPython $(PYTHON_VERSION) in $(PYTHON_PREFIX)"
	$(call fetch-release,cpython-$(PYTHON_VERSION),$(PYTHON_URL),$(PYTHON_SHA256))
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
