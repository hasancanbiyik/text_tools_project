#!/bin/bash

# Calculating the number of lines in the edited_text column.
lines=$(wc -l < turkish_pets.csv)
echo "There are $lines lines in the dataset!"

# Checking to see if there are any empty lines in the dataset.
empty_lines=$(grep -c '^$' turkish_pets.csv)

echo "There are $empty_lines empty lines in the dataset."

if [ "$empty_lines" -eq 0 ]; then
	echo "Everything is okay! There are no empty lines."
else $empty_lines > 0
	echo "There are $empty_lines empty lines in the dataset. Be careful!"

fi

# Checking to see how many columns are there in the dataset.
columns=$(awk -F ',' '{print NF; exit}' turkish_pets.csv)
echo "There are $columns columns in the dataset'"

# Let's check the total number of unique words in the "orig_text" column.
unique_words=$(cut -d',' -f5 turkish_pets.csv | tr ' ' '\n' | sort | uniq | wc -l)
echo "There are $unique_words unique words in the orig_text column (this column does not have any markers!)."

