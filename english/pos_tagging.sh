#!/bin/bash

# Step 1: Generate POS-tagged output
echo "Generating POS-tagged output..."
cat texts_cleaned.txt | python3 pos_tagger.py > pos_tagged_output.txt

# Step 2: Calculate POS frequencies
echo "Calculating POS frequencies..."
cut -d'/' -f2 pos_tagged_output.txt | sort | uniq -c | sort -nr > pos_frequencies.txt

# Step 3: Display POS frequency summary
echo "POS frequency analysis completed. The frequencies are:"
cat pos_frequencies.txt

# Final message
echo "POS tagging and frequency analysis complete. Results saved in 'pos_frequencies.txt'."