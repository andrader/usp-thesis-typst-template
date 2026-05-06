# Recipe to test the Typst package
# This assumes you have typst installed and available in your PATH
# and that your test files are in the examples/ directory

# Set the default recipe
default:
    just test

# Build directory variable
build_dir:="build"


test:
    @echo "Run Typst on all .typ files at depth 1 (examples/*.typ and examples/*/*.typ)"
    @for file in examples/*.typ examples/*/*.typ; do \
        if [ ! -f "$file" ]; then \
            continue; \
        fi; \
        out="{{build_dir}}/${file}.pdf"; \
        mkdir -p "$(dirname "$out")"; \
        echo " Compiling $file..."; \
        if ! typst compile --root . "$file" "$out"; then \
            echo "Error compiling: $file"; \
        fi; \
    done
    @echo "All .typ files have been processed. Check the {{build_dir}}/ directory for output PDFs."

# Clean build artifacts
clean:
    rm -rf {{build_dir}}/*
    @echo "Cleaned {{build_dir}}/ directory."
