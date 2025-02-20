#!/bin/bash

# paths and labwc variable
src_config_dir="~/projects/active/labwc-project/config/experimental-config/"
dest_config_dir="~/.config/labwc/"
program_to_run="labwc -d"

# 1) Copy config files from working directory to production, overwriting existing files
echo "Copying configuration files..."
cp -f "${src_config_dir}/*" "${dest_config_dir}/"

# 2) Create archive directory named by date and copy working directory config files
current_date=$(date '+%Y-%m-%d')
archive_base="config_archive_${current_date}"

# Check if the base directory exists, append a letter if necessary
archive_dir="${src_config_dir}/${archive_base}"
counter=0

while [ -d "${archive_dir}" ]; do
    counter=$((counter + 1))
    letter=$(printf "%s" "a" | tr 'a' "a${counter}")
    archive_dir="${src_config_dir}/${archive_base}_${letter}"
done

mkdir -p "${archive_dir}"

echo "Archiving configuration files to ${archive_dir}..."
cp -f "${src_config_dir}/*" "${archive_dir}/"

# 3) Run the program for testing purposes
echo "Running program for testing..."
${program_to_run}
