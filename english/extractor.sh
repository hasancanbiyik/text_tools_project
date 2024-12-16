#!/bin/bash

# Check if csvcut is installed
if ! command -v csvcut &> /dev/null; then
    echo "csvcut is not installed. Install it using: pip install csvkit"
    exit 1
fi

# Extract and clean text in one step
echo "Extracting columns and cleaning [PET_BOUNDARY] marks..."
csvcut -c 2,3 english_pets.csv | sed 's/\[PET_BOUNDARY\]//g' > english_pets_cleaned.csv

if [ $? -eq 0 ]; then
    echo "The cleaned dataset has been successfully created: english_pets_cleaned.csv"
else
    echo "An error occurred while processing the dataset."
    exit 1
fi