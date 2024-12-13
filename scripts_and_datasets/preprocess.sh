#!/bin/bash

# Calculating the number of lines in the edited_text column.
#$1 is the name of the desired column with the text "orig_text", "text", "edited_text", etc

for i in *_pets.tsv
do
	lines=$(wc -l < $i)
	echo "There are $lines lines in the dataset!"

	# Checking to see if there are any empty lines in the dataset.
	empty_lines=$(grep -c '^$' $i)

	echo "There are $empty_lines empty lines in the dataset."

	if [ "$empty_lines" -eq 0 ]; then
		echo "Everything is okay! There are no empty lines."
	else $empty_lines > 0
		echo "There are $empty_lines empty lines in the dataset. Be careful!"

	fi
	# Checking to see how many columns are there in the dataset.
	columns=$(awk -F '\t' '{print NF; exit}' $i)
	echo "There are $columns columns in the dataset'"
	
	#identify the location of the desired column
	read line < $i
	echo $line

	echo $line | tr ' ' '\n' > line.txt
	
	j=$(grep -n ^$1$ line.txt)

	j=$(echo $j | sed 's/:.*//')

	j=$(expr $j + 1)

	echo $j

	# Let's check the total number of unique words in the "orig_text" column.
	unique_words=$(cat $i | cut -f$j | tr ' ' '\n' | sort | uniq | wc -l)
	echo "There are $unique_words unique words in the desired column (this column does not have any markers!)."
	
	#this removes the _pets.tsv from the filename
	k=$(echo $i| cut -d'_' -f1)

	cat $i | cut -f$j > text_$k.txt

	wc -l text_$k.txt
	
	cat text_$k.txt | tr '[A-Z]' '[a-z]' > text1_$k.txt

	#this looks for the euphemistic sentence within the file

	tr '\.\!\?' '\n' < text1_$k.txt > edited_text_$k.txt

	wc -l edited_text_$k.txt

	egrep 'pet_boundary' edited_text_$k.txt > sentence_$k.txt
	wc -l sentence_$k.txt

	tr -d '\?\.,\@\"\=\-' < sentence_$k.txt > sentence_no_punct_$k.txt
	sed 's/\[pet_boundary\]//g' sentence_no_punct_$k.txt > sentence_no_boundary_$k.txt

	cut -d']' -f1 --complement sentence_no_punct_$k.txt > pets_$k.txt
	cut -d'[' -f1 pets_$k.txt > pets2_$k.txt
done