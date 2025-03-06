#!/bin/bash

# Check if at least one argument is provided (input file)
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 input_image"
    exit 1
fi

# Assign input file from the argument
input_file=$1

# Extract the directory path from the input file
input_dir=$(dirname "$input_file")

# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
    echo "ffmpeg is required."
    exit 1
fi

# Define an array of desired widths
widths=(400 800 1600 2400 2912 3840)

# Loop through the widths array
for width in "${widths[@]}"; do
    # Construct the output file name
    output_file="${input_dir}/${width}.avif"

    # Resize the image, maintain aspect ratio, and convert to AVIF with high quality
    ffmpeg -i "$input_file" -map_metadata -1 -vf "scale=$width:-2" -compression_level 0 -pix_fmt yuv420p10le "$output_file"

    echo "Conversion completed: '$output_file'"
done
