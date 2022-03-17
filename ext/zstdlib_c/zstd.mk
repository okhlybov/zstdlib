VPATH := $(SRCDIR)/common $(SRCDIR)/compress $(SRCDIR)/decompress

CSRCS := $(foreach dir,$(VPATH),$(wildcard $(dir)/*.c))
SSRCS := $(foreach dir,$(VPATH),$(wildcard $(dir)/*.S))
OBJS := $(patsubst %.c,%.o,$(foreach file,$(CSRCS),$(notdir $(file)))) $(patsubst %.S,%.o,$(foreach file,$(SSRCS),$(notdir $(file))))

CPPFLAGS += -I$(SRCDIR) -I$(SRCDIR)/common

LIB = ../libzstd.a

$(LIB) : $(OBJS)
	$(AR) cr $@ $^

clean :
	$(RM) -f $(LIB) $(OBJS)