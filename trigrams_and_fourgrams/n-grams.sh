#!/bin/bash

# This script will create trigram and fourgrams  with different variations.

# We lowercase the texts first.
csvcut -c 5 turkish_pets.csv > text.csv
tr '[:upper:]' '[:lower:]' < text.csv > lowercase_texts.csv
rm text.csv

# Split words while preserving the Turkish characters:
grep -o -E '[a-zçğıöşü]+' lowercase_texts.csv > lowercase_texts_per_line.csv

# Creating the other splits for word-per-line.
tail -n +2 lowercase_texts_per_line.csv > first_line_removed.csv
tail -n +3 lowercase_texts_per_line.csv > second_line_removed.csv
tail -n +4 lowercase_texts_per_line.csv > third_line_removed.csv

# Creating trigrams:
paste lowercase_texts_per_line.csv first_line_removed.csv second_line_removed.csv > trigrams.csv

# Creating fourgrams:
paste lowercase_texts_per_line.csv first_line_removed.csv second_line_removed.csv third_line_removed.csv > fourgrams.csv

# To see the most common patterns in trigrams:
echo "The most common patterns in the trigrams are as follows:"
sort trigrams.csv | uniq -c | sort -nr | head -10

# To see the most common patterns in fourgrams:
echo "The most common patterns in the fourgrams are as follows:"
sort fourgrams.csv | uniq -c | sort -nr | head -10




