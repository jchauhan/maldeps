#!/bin/bash

# Check if correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <source_directory> <output_directory>"
    exit 1
fi

source_dir="$1"
output_dir="$2"

# Create the output directory if it doesn't exist
mkdir -p "$output_dir"

# Iterate through the zip files in the source directory
for zip_file in "$source_dir"/*.zip; do
    # Get the file name without extension
    file_name=$(basename "$zip_file" .zip)

    # Unzip the file to a temporary directory
    temp_dir=$(mktemp -d)
    echo "Unzipping $temp_dir $zip_file"
    unzip -P "infected" -d "$temp_dir" "$zip_file"
    ls -l "$temp_dir"
    # Create a new zip file without password in the output directory
    new_zip_file="$output_dir/$file_name.zip"
    # cd "$temp_dir" || exit
    zip -r "$new_zip_file" "$temp_dir"

    # Clean up temporary directory
    rm -r "$temp_dir"

    echo "Password removed from $zip_file. New zip file created: $new_zip_file"
done

echo "Done"

