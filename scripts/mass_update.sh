#!/bin/zsh

# Function to show usage
usage() {
    echo "Usage: $0 <search_string> <replacement_string> <target_directory>"
    exit 1
}

# Validate arguments
if [ "$#" -ne 3 ]; then
    usage
fi

SEARCH_STRING="superTheorems:$1"
REPLACEMENT_STRING="superTheorems:$2"
TARGET_DIR="$3"

# Find all .typ files containing the search string
echo "Searching for .typ files containing the string '$SEARCH_STRING' in '$TARGET_DIR'..."
AFFECTED_FILES=$(grep -rl --include="*.typ" "$SEARCH_STRING" "$TARGET_DIR")

if [ -z "$AFFECTED_FILES" ]; then
    echo "No .typ files found containing the string '$SEARCH_STRING'."
    exit 0
fi

# Display the list of affected files
echo "The following files will be modified:"
echo "$AFFECTED_FILES"
echo

# Ask for confirmation
read -q "CONFIRM?Do you want to proceed with the replacement? (y/n): "
echo
if [[ "$CONFIRM" != "y" ]]; then
    echo "Operation canceled."
    exit 0
fi

# Perform the replacement
echo "Applying replacements..."
for file in ${(f)AFFECTED_FILES}; do
    sed -i "s/${SEARCH_STRING}/${REPLACEMENT_STRING}/g" "$file"
done

echo "Replacement complete."
