.PHONY: all epub mobi pdf clean

all: epub mobi

epub:
	@echo "Building EPUB..."
	@bash scripts/build.sh epub

mobi:
	@echo "Building MOBI..."
	@bash scripts/build.sh mobi

pdf:
	@echo "Building PDF..."
	@bash scripts/build.sh pdf

clean:
	@echo "Cleaning build directory..."
	@rm -rf build/*.epub build/*.mobi build/*.pdf

help:
	@echo "Available targets:"
	@echo "  all   - Build EPUB and MOBI (default)"
	@echo "  epub  - Build EPUB only"
	@echo "  mobi  - Build MOBI only"
	@echo "  pdf   - Build PDF only"
	@echo "  clean - Remove built files"
	@echo "  help  - Show this help"
