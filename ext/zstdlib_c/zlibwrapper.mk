VPATH := $(SRCDIR)

SRCS := $(foreach dir,$(VPATH),$(wildcard $(dir)/*.c))
OBJS := $(patsubst %.c,%.o,$(foreach file,$(SRCS),$(notdir $(file))))

CPPFLAGS += -I$(SRCDIR)/../lib -I$(SRCDIR)/../lib/common

LIB = ../libzlibwrapper.a

$(LIB) : $(OBJS)
	$(AR) cr $@ $^

clean :
	$(RM) -f $(LIB) $(OBJS)