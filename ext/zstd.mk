OBJS := $(patsubst %.c,%.o,$(wildcard $(SRCDIR)/common/*.c) $(wildcard $(SRCDIR)/compress/*.c) $(wildcard $(SRCDIR)/decompress/*.c))

CPPFLAGS += -I$(SRCDIR) -I$(SRCDIR)/common

LIB = libzstd.a

$(LIB) : $(OBJS)
	$(AR) cr $@ $^

clean :
	$(RM) -f $(LIB) $(OBJS)