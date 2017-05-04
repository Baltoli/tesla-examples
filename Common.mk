# These TESLA-specific variables can be overridden at the command line if your
# TESLA installation is set up differently.
TESLA ?= $(TESLA_ROOT)/bin/tesla
TESLA_CC ?= $(TESLA_ROOT)/bin/clang
TESLA_INC ?= $(TESLA_ROOT)/include
TESLA_LIB ?= $(TESLA_ROOT)/lib
TESLA_LINK ?= $(TESLA_ROOT)/bin/llvm-link

%.tesla : %.c
	$(TESLA) analyse $(abspath $<) -o $@ -- -I$(TESLA_INC) $(CFLAGS)

%.bc : %.c
	$(TESLA_CC) -emit-llvm -I$(TESLA_INC) $(CFLAGS) -O0 -c $(abspath $<) -o $@

define link
$(1) : $(2)
	$(TESLA_LINK) $(2) -o $(1)
endef

define cat
$(1) : $(2)
	$(TESLA) cat $(2) -o $(1)
endef

define instrument
$(1) : $(2) $(3)
	$(TESLA) instrument -tesla-manifest $(3) $(abspath $(2)) -o $(1)
endef

define compile
$(1) : $(2)
	$(TESLA_CC) $(CFLAGS) -L$(TESLA_LIB) -ltesla $(2) -o $(1)
endef

define static
$(1) : $(2) $(3)
	$(TESLA) static -mc -print-counter $(2) $(3) -o $(1)
endef

clean::
	rm -f *.tesla *.manifest *.bc
