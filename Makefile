all:
	@echo "bins"
	@make --no-print-directory -C bins
	@bash ./builder.sh bins/binaries.lst

clean:
	@make clean --no-print-directory -C bins

purge: clean
	@rm -rf tests
