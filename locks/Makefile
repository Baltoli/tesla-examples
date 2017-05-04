.DEFAULT_GOAL = all

include ../Common.mk

define build_example
$(call link,$(1).lto.bc,$(1).bc lock.bc mock.bc)
$(call cat,$(1).manifest,$(1).tesla lock.tesla mock.tesla)
$(call instrument,$(1).instr.bc,$(1).lto.bc,$(1).manifest)
$(call compile,$(1),$(1).instr.bc)
endef

define build_static_example
$(call static,$(1)_static.manifest,$(1).manifest,$(1).lto.bc)
$(call instrument,$(1)_static.instr.bc,$(1).lto.bc,$(1)_static.manifest)
$(call compile,$(1)_static,$(1)_static.instr.bc)
endef

names := address basic basic_indirect more_usage mult_acq \
  mult_rel no_acq no_acq_rel no_rel \
  one_acq other rel_before rel_before_indirect wrong

static_names = $(names:%=%_static)

$(foreach name,$(names),$(eval $(call build_example,$(name))))
$(foreach name,$(names),$(eval $(call build_static_example,$(name))))

all: $(names) $(static_names)

clean::
	rm -f $(names)
	rm -f $(static_names)
