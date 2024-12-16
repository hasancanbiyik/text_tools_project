#!/bin/bash

# Calculate the number of lines
lines=$(wc -l < turkish_pets_cleaned.csv)
echo "There are $lines lines in the dataset!"

# Check for empty lines
empty_lines=$(grep -c '^$' turkish_pets_cleaned.csv)
echo "There are $empty_lines empty lines in the dataset."

if [ "$empty_lines" -eq 0 ]; then
    echo "Everything is okay! There are no empty lines."
else
    echo "There are $empty_lines empty lines in the dataset. Be careful!"
fi

# Check the number of columns
columns=$(awk -F ',' '{print NF; exit}' turkish_pets_cleaned.csv)
echo "There are $columns columns in the dataset."

# Normalize case and remove punctuation
echo "Normalizing case and removing punctuation."
tr '[:upper:]' '[:lower:]' < turkish_pets_cleaned.csv | tr -d '[:punct:]' > normalized_texts.txt