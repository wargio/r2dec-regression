CC   := gcc

X86  := printf if if2 if_else if_else_if_else while while_while while_if while_if_break while_if_continue while_if_else_if_else switch for_if

LISTFILE := binaries.lst
BINS := $(addprefix x86/, $(X86))
OBJS := $(addsuffix .o, $(BINS))

CFLAGS := -Wall -O0
LDLIBS :=

all: $(OBJS) $(BINS) $(LISTFILE)
	@echo "built."

clean:
	@rm -rf $(BINS) $(OBJS) $(LISTFILE)

$(LISTFILE):
	@echo $(addprefix bins/, $(BINS)) | sed 's/\s\+/\n/g' > $(LISTFILE)
	@echo "[LST] "$(LISTFILE)

$(BINS): %: %.o
	@$(CC) $(CFLAGS) -o $@ $< $(LDLIBS) 
	@echo "[LD]" $@

$(OBJS): %.o: %.c $(DEPS)
	@$(CC) $(CFLAGS) -c -o $@ $<
	@echo "[CC]" $@
