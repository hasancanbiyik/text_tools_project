#!/bin/bash

# Define file paths
INPUT_FILE="texts_per_line.txt"
STOPWORDS_FILE="en_stopwords.txt"

# Check for stopwords file
if [ ! -f "$STOPWORDS_FILE" ]; then
    echo "Error: Stopword file '$STOPWORDS_FILE' not found."
    exit 1
fi

# Remove numbers and stopwords
echo "Cleaning numbers and stopwords..."
sed -E 's/[0-9]+//g' "$INPUT_FILE" | grep -wvFf "$STOPWORDS_FILE" > texts_cleaned.txt

# Count word frequencies
echo "Counting word frequencies..."
sort texts_cleaned.txt | uniq -c | sort -nr > word_frequencies.txt

# Calculate Type-Token Ratio (TTR)
echo "Calculating Type-Token Ratio..."
tokens=$(wc -l < texts_cleaned.txt)
types=$(sort texts_cleaned.txt | uniq | wc -l)
ttr=$(echo "scale=4; $types / $tokens" | bc)

# Display results
echo "Number of tokens: $tokens"
echo "Number of unique types: $types"
echo "Type-Token Ratio (TTR): $ttr"
echo "Results saved in 'word_frequencies.txt'."