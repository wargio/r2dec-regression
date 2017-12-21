CC   := gcc

X86  := if if_else if_else_if_else while while_if

BINS := $(addprefix x86/, $(X86))
OBJS := $(addsuffix .o, $(BINS))

CFLAGS := -Wall
LDLIBS :=

all: $(OBJS) $(BINS)
	@echo "built."

clean:
	@rm -rf $(BINS) $(OBJS)

$(BINS): %: %.o
	$(CC) $(CFLAGS) -o $@ $< $(LDLIBS) 

$(OBJS): %.o: %.c $(DEPS)
	$(CC) $(CFLAGS) -c -o $@ $<
