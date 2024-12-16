#!/bin/bash

# Split words while preserving Turkish characters
grep -o -E '[a-zçğıöşü]+' normalized_texts.txt > lowercase_texts_per_line.csv

# Create line-removed splits
for i in 2 3 4; do
    tail -n +$i lowercase_texts_per_line.csv > line_removed_$i.csv
done

# Create trigrams
paste lowercase_texts_per_line.csv line_removed_2.csv line_removed_3.csv > trigrams.csv

# Create fourgrams
paste lowercase_texts_per_line.csv line_removed_2.csv line_removed_3.csv line_removed_4.csv > fourgrams.csv

# Display most common patterns
echo "The most common patterns in the trigrams are as follows:"
sort trigrams.csv | uniq -c | sort -nr | head -10

echo "The most common patterns in the fourgrams are as follows:"
sort fourgrams.csv | uniq -c | sort -nr | head -10