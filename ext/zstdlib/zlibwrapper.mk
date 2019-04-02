SUBDIRS := $(SRCDIR) $(SRCDIR)/../../zlibwrapper
SRCS := $(foreach dir,$(SUBDIRS),$(wildcard $(dir)/*.c))
OBJS := $(foreach obj,$(patsubst %.c,%.o,$(SRCS)),$(notdir $(obj)))

VPATH := $(SUBDIRS)

CPPFLAGS += -I$(SRCDIR)/../lib -I$(SRCDIR)/../lib/common

LIB = libzlibwrapper.a

$(LIB) : $(OBJS)
	$(AR) cr $@ $^

clean :
	$(RM) -f $(LIB) $(OBJS)