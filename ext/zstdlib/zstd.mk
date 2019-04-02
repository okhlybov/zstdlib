SUBDIRS := $(SRCDIR)/common $(SRCDIR)/compress $(SRCDIR)/decompress
SRCS := $(foreach dir,$(SUBDIRS),$(wildcard $(dir)/*.c))
OBJS := $(foreach obj,$(patsubst %.c,%.o,$(SRCS)),$(notdir $(obj)))

VPATH := $(SUBDIRS)

CPPFLAGS += -I$(SRCDIR) -I$(SRCDIR)/common

LIB = libzstd.a

$(LIB) : $(OBJS)
	$(AR) cr $@ $^

clean :
	$(RM) -f $(LIB) $(OBJS)