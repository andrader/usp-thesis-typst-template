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

# Release to Typst Universe. The source of truth is this repo; the Universe copy is
# generated from it. Flow: bump `version` in typst.toml, commit, `just tag`, `just release`.

# Copy the package into build/packages/preview/<name>/<version> (typst.toml `exclude` applies)
stage:
    scripts/release.sh stage

# Stage, compile the staged template and run typst-package-check
check:
    scripts/release.sh check

# Tag HEAD as v<version> and push the tag
tag:
    scripts/release.sh tag

# Check, then push the package to your fork of typst/packages and open the PR
release:
    scripts/release.sh pr

# Clean build artifacts
clean:
    rm -rf {{build_dir}}/*
    @echo "Cleaned {{build_dir}}/ directory."
