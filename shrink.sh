#!/bin/bash

# Check if three arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 input_image width output.avif"
    exit 1
fi

# Assign arguments to variables
input_file=$1
width=$2
output_file=$3

# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
    echo "ffmpeg is required."
    exit 1
fi

# Resize the image, maintain aspect ratio, and convert to AVIF with high quality
ffmpeg -i "$input_file" -vf "scale=$width:-2" -compression_level 0 -pix_fmt yuv420p10le "$output_file"

echo "Conversion completed: '$output_file'"
