#!/bin/bash

set -e

# Configuration
BOOK_TITLE="ХВОЙНЫЕ: История, жизнь и тайны вечнозелёного мира"
OUTPUT_DIR="build"
METADATA="metadata.yaml"

# Chapter files in order
CHAPTERS=(
    "chapters/00-introduction.md"
    "chapters/01-birth-of-conifers.md"
    "chapters/02-epochs.md"
    "chapters/03-conifers-and-humans.md"
    "chapters/04-pinaceae.md"
    "chapters/05-cupressaceae.md"
    "chapters/06-09-rare-families.md"
    "chapters/10-12-internal-life.md"
    "chapters/13-17-world-and-future.md"
    "chapters/18-conclusion-appendices.md"
)

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Function to build EPUB
build_epub() {
    echo "Building EPUB..."
    
    pandoc "$METADATA" "${CHAPTERS[@]}" \
        -o "$OUTPUT_DIR/conifers-book.epub" \
        --toc \
        --toc-depth=3 \
        --epub-chapter-level=1 \
        --metadata title="$BOOK_TITLE"
    
    echo "EPUB created: $OUTPUT_DIR/conifers-book.epub"
}

# Function to build MOBI (requires Calibre's ebook-convert)
build_mobi() {
    echo "Building MOBI..."
    
    # First build EPUB if it doesn't exist
    if [ ! -f "$OUTPUT_DIR/conifers-book.epub" ]; then
        build_epub
    fi
    
    # Convert EPUB to MOBI using Calibre
    if command -v ebook-convert &> /dev/null; then
        ebook-convert "$OUTPUT_DIR/conifers-book.epub" "$OUTPUT_DIR/conifers-book.mobi"
        echo "MOBI created: $OUTPUT_DIR/conifers-book.mobi"
    else
        echo "Error: ebook-convert (Calibre) not found. Please install Calibre."
        echo "Skipping MOBI generation."
        return 1
    fi
}

# Function to build PDF
build_pdf() {
    echo "Building PDF..."
    
    pandoc "$METADATA" "${CHAPTERS[@]}" \
        -o "$OUTPUT_DIR/conifers-book.pdf" \
        --toc \
        --toc-depth=3 \
        --pdf-engine=xelatex \
        -V geometry:margin=2cm \
        -V mainfont="DejaVu Serif" \
        -V lang=ru
    
    echo "PDF created: $OUTPUT_DIR/conifers-book.pdf"
}

# Main execution
case "${1:-all}" in
    epub)
        build_epub
        ;;
    mobi)
        build_mobi
        ;;
    pdf)
        build_pdf
        ;;
    all)
        build_epub
        build_mobi || echo "Warning: MOBI build failed, continuing..."
        ;;
    *)
        echo "Usage: $0 {epub|mobi|pdf|all}"
        exit 1
        ;;
esac

echo "Build completed!"
