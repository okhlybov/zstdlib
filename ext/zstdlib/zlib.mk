OBJS := $(patsubst %.c,%.o,$(wildcard $(SRCDIR)/*.c))

CPPFLAGS += -I$(SRCDIR)

LIB = libzlib.a

$(LIB) : $(OBJS)
	$(AR) cr $@ $^

clean :
	$(RM) -f $(LIB) $(OBJS)