all:
	@echo "bins"
	@make --no-print-directory -C bins
	@echo "generating tests"
	@bash ./builder.sh bins/binaries.lst

clean:
	@make clean --no-print-directory -C bins
	