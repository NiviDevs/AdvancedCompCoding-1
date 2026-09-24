#!/usr/bin/env bash

set -euo pipefail

# Determine the repository root.
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Input and output files.
INPUT="$ROOT/ip.txt"
OUTPUT="$ROOT/op.txt"

# Directory for compiled Java classes.
BUILD_DIR="$ROOT/.build"

# Read the Java file passed to the script.
SOURCE="${1:-}"

# Validate the source file.
if [[ -z "$SOURCE" ]]; then
    echo "Error: No Java file specified."
    echo "Usage: ./run.sh path/to/Main.java"
    exit 1
fi

if [[ ! -f "$SOURCE" ]]; then
    echo "Error: Java file not found: $SOURCE"
    exit 1
fi

if [[ "$SOURCE" != *.java ]]; then
    echo "Error: The selected file must be a Java source file."
    exit 1
fi

if [[ ! -f "$INPUT" ]]; then
    echo "Error: ip.txt not found in repository root."
    exit 1
fi

# Extract the Java class name from the filename.
FILENAME="$(basename "$SOURCE")"
CLASS_NAME="${FILENAME%.java}"

# Detect an optional Java package declaration.
PACKAGE="$(
    sed -nE '
        s/^[[:space:]]*package[[:space:]]+([A-Za-z_][A-Za-z0-9_.]*)[[:space:]]*;.*/\1/p
    ' "$SOURCE" | head -n 1
)"

# Construct the fully qualified class name if a package exists.
if [[ -n "$PACKAGE" ]]; then
    CLASS_NAME="$PACKAGE.$CLASS_NAME"
fi

# echo "========================================"
# echo "Java Competitive Coding Runner"
# echo "========================================"
# echo "Source: $SOURCE"
# echo "Class:  $CLASS_NAME"
# echo "Input:  $INPUT"
# echo "Output: $OUTPUT"
# echo

# Remove old compiled classes.
rm -rf "$BUILD_DIR"

# Create a fresh build directory.
mkdir -p "$BUILD_DIR"

# Clear previous output.
: > "$OUTPUT"

# echo "[1/2] Compiling..."

javac \
    -encoding UTF-8 \
    -d "$BUILD_DIR" \
    "$SOURCE"

# echo "[2/2] Running..."
# echo

# Execute with input/output redirection.
java \
    -cp "$BUILD_DIR" \
    "$CLASS_NAME" \
    < "$INPUT" \
    > "$OUTPUT"

# echo "========================================"
# echo "Execution completed."
# echo "Output written to op.txt"
# echo "========================================"