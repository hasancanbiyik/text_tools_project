#!/bin/bash

# 1 - Check if csvcut is installed
if ! command -v csvcut &> /dev/null; then
    echo "csvcut is not installed. Install it using: pip install csvkit"
    exit 1
fi

# 2 - Extract the columns
echo "Extracting the original_text and label columns into a new file..."
csvcut -c 5,10 turkish_pets.csv > orig-text_label_turkish_pets.csv

# 3 - Check if the command was successful
if [ $? -eq 0 ]; then
    echo "The new dataset has been successfully created: orig-text_label_turkish_pets.csv"
else
    echo "An error occurred while creating the new dataset."
    exit 1
fi

# TIME TO CREATE THE SECOND SPLIT. IT WILL CONTAIN THE EUPHEMISTIC VS NON-EUPHEMISTIC INSTANCES.

csvcut -c 5,10 turkish_pets.csv > temp_orig_text_label.csv

grep ',0$' temp_orig_text_label.csv > sentences_label_0.csv
grep ',1$' temp_orig_text_label.csv > sentences_label_1.csv

rm temp_orig_text_label.csv


# TIME TO CREATE THE THIRD SPLIT. IT WILL CONTAIN THE CATEGORIES, PETs, and SENTENCES

csvcut -c 2,4,5  turkish_pets.csv > pet_category_sentence.csv


