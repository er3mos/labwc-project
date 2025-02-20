#!/bin/bash

# Define paths
WORKING_DIR="~/projects/active/labwc-project/config/experimental-config/"
PRODUCTION_CONFIG="~/.config/labwc/"

# Change to working directory
cd "$WORKING_DIR" || exit 1

# 1) Copy config files to production directory, overwriting existing files
cp -f * "$PRODUCTION_CONFIG"

# 2) Create incrementally named backup directory and copy files to it
# Find the highest numbered backup directory that exists
BACKUP_DIRS=$(ls | grep "backup_[0-9]" | sort -n)
NEXT_BACKUP=1

if [ -n "$BACKUP_DIRS" ]; then
    # Get the last number in the sorted list of backup directories
    LAST_BACKUP=$(printf "%s\n$BACKUP_DIRS" | tail -n 1 | cut -d "_" -f 2)
    NEXT_BACKUP=$((LAST_BACKUP + 1))
fi

# Create new backup directory
mkdir "backup_$NEXT_BACKUP"

# Copy files to the backup directory
cp *.config "backup_$NEXT_BACKUP/"

# 3) Run the program for testing purposes
./test_program.sh || {
    echo "Test program failed with error code $?"
    exit 1
}
