#!/bin/bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
BUILD_DIR="$PROJECT_DIR/build"
APP_NAME="Open in iTerm2"
BUNDLE_DIR="$BUILD_DIR/$APP_NAME.app"
EXECUTABLE_NAME="OpenInIterm2"
MACOS_DIR="$BUNDLE_DIR/Contents/MacOS"
RESOURCES_DIR="$BUNDLE_DIR/Contents/Resources"

echo "=> Cleaning build directory..."
rm -rf "$BUILD_DIR"
mkdir -p "$MACOS_DIR" "$RESOURCES_DIR"

echo "=> Compiling Swift sources (universal binary: arm64 + x86_64)..."
TMP_ARM64=$(mktemp /tmp/openiniterm2_arm64.XXXXXX)
TMP_X8664=$(mktemp /tmp/openiniterm2_x8664.XXXXXX)

swiftc \
    -target arm64-apple-macos11.0 \
    -o "$TMP_ARM64" \
    "$PROJECT_DIR/Sources/main.swift"

swiftc \
    -target x86_64-apple-macos11.0 \
    -o "$TMP_X8664" \
    "$PROJECT_DIR/Sources/main.swift"

lipo -create "$TMP_ARM64" "$TMP_X8664" -output "$MACOS_DIR/$EXECUTABLE_NAME"
rm -f "$TMP_ARM64" "$TMP_X8664"

echo "=> Copying Info.plist..."
cp "$PROJECT_DIR/Resources/Info.plist" "$BUNDLE_DIR/Contents/Info.plist"

if [ -f "$PROJECT_DIR/Resources/AppIcon.icns" ]; then
    echo "=> Copying AppIcon.icns..."
    cp "$PROJECT_DIR/Resources/AppIcon.icns" "$RESOURCES_DIR/AppIcon.icns"
fi

echo "=> Done: $BUNDLE_DIR"
echo "   Drag this app to the Finder toolbar (hold ⌘ while dragging)."
