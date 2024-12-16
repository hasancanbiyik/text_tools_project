#!/bin/bash

# Split the dataset into one word per line
tr '[:space:]' '\n' < normalized_texts.txt | grep -v '^$' > texts_per_line.txt

# Create line-removed splits
for i in 2 3 4; do
    tail -n +$i texts_per_line.txt > line_removed_$i.txt
done

# Create trigrams
paste texts_per_line.txt line_removed_2.txt line_removed_3.txt > trigrams.txt

# Create fourgrams
paste texts_per_line.txt line_removed_2.txt line_removed_3.txt line_removed_4.txt > fourgrams.txt

# Display most common patterns
echo "The most common patterns in the Spanish trigrams are as follows:"
sort trigrams.txt | uniq -c | sort -nr | head -10

echo "The most common patterns in the Spanish fourgrams are as follows:"
sort fourgrams.txt | uniq -c | sort -nr | head -10
