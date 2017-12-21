all:
	@echo "run manually './testall.sh /path/to/r2dec-js'"
	@echo "to build the tests again, use 'make build'"

build:
	@echo "bins"
	@make --no-print-directory -C bins
	@bash ./builder.sh bins/binaries.lst

clean:
	@make clean --no-print-directory -C bins

purge: clean
	@rm -rf tests
