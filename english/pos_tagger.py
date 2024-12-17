import sys
import stanza

# Initialize Stanza pipeline for English
nlp = stanza.Pipeline('en', processors='tokenize,pos')

# Read input from stdin
for line in sys.stdin:
    doc = nlp(line.strip())
    for sentence in doc.sentences:
        print(" ".join([f"{word.text}/{word.upos}" for word in sentence.words]))
