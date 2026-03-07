TARGET			:= uppertst

CSRCS			:= $(TARGET).c

LDFLAGS			:= -L../03_libupper/bin -lupper

VPATH			:= ../

include ../../prj_native.mk

run_alt: $(OUTPUT)
	LD_LIBRARY_PATH=../03_libupper/bin $<

.PHONY: run_alt
