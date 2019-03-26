OBJS := $(patsubst %.c,%.o,$(wildcard $(SRCDIR)/*.c zlibwrapper/*.c))

CPPFLAGS += -I$(SRCDIR)/../lib -I$(SRCDIR)/../lib/common

LIB = libzlibwrapper.a

$(LIB) : $(OBJS)
	$(AR) cr $@ $^

clean :
	$(RM) -f $(LIB) $(OBJS)