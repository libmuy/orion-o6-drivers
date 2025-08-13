ifeq ($(shell dpkg-vendor --derives-from Ubuntu && echo yes),yes)
	# Ubuntu: no runit
	dhflags += --without runit
endif
