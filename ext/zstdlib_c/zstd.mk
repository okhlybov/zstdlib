VPATH := $(SRCDIR)/common $(SRCDIR)/compress $(SRCDIR)/decompress

SRCS := $(foreach dir,$(VPATH),$(wildcard $(dir)/*.c))
OBJS := $(patsubst %.c,%.o,$(foreach file,$(SRCS),$(notdir $(file))))

CPPFLAGS += -I$(SRCDIR) -I$(SRCDIR)/common

LIB = ../libzstd.a

$(LIB) : $(OBJS)
	$(AR) cr $@ $^

clean :
	$(RM) -f $(LIB) $(OBJS)