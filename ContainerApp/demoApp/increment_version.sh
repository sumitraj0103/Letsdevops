#!/bin/bash

VERSION_FILE="version.txt"

# Check if the version file exists; if not, create it with an initial version
if [ ! -f "$VERSION_FILE" ]; then
  echo "1.0" > "$VERSION_FILE"
fi

# Read the current version from the file and increment it
CURRENT_VERSION=$(cat "$VERSION_FILE")
NEW_VERSION=$(awk '{printf "%.1f", $0 + 0.1}' <<< "$CURRENT_VERSION")

# Update the version in the file
echo "$NEW_VERSION" > "$VERSION_FILE"

# Print the new version
echo "the new version value in Sumit$NEW_VERSION"
