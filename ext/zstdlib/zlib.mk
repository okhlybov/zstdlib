VPATH := $(SRCDIR)

SRCS := $(foreach dir,$(VPATH),$(wildcard $(dir)/*.c))
OBJS := $(patsubst %.c,%.o,$(foreach file,$(SRCS),$(notdir $(file))))

CPPFLAGS += -I$(SRCDIR)

LIB = ../libz.a

$(LIB) : $(OBJS)
	$(AR) cr $@ $^

clean :
	$(RM) -f $(LIB) $(OBJS)