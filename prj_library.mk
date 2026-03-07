PRJ_LIBRARY_MK_FILE	:= $(realpath $(lastword $(MAKEFILE_LIST)))
PRJ_LIBRARY_MK_DIR	:= $(shell dirname $(PRJ_LIBRARY_MK_FILE))

I_HDD00			:= $(HOME)/iHDD00
MK_RACCOON_DIR		:= $(I_HDD00)/08.PROJECT/mk-raccoon

CFLAGS			+= -Wextra
CFLAGS			+= -Wno-unused-parameter
CFLAGS			+= -Wno-unused-result

OPT			?= s

include $(MK_RACCOON_DIR)/gcc_library.mk
# include $(MK_RACCOON_DIR)/llvm_library.mk
