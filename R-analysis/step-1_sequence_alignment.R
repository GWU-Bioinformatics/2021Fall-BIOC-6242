# Art of Alignment, section 5.1
# Alignment of bacterial rplB genes (50S ribosomal protein L2)
library(DECIPHER)
fas <- system.file("extdata", "50S_ribosomal_protein_L2.fas", package="DECIPHER")
# Find the example sequence file used in this tutorial:
dna <- readDNAStringSet(fas)
print('Printing the input DNA object:')
dna

print('Sleeping for 10 seconds')
Sys.sleep(10)

AA <- AlignTranslation(dna, type="AAStringSet") # align the translation
print('Saving a browser-based view of the alignments')
ifelse(!dir.exists(file.path(getwd(), 'results')), dir.create(file.path(getwd(), 'results')), FALSE)
BrowseSeqs(AA, highlight=1, openURL=FALSE, htmlFile="./results/alignment.html")

print('...continuing')

DNA <- AlignSeqs(dna) # align the sequences directly without translation
# DNA <- AlignTranslation(dna) # align the translation then reverse translate

# write the aligned sequences to a FASTA file
writeXStringSet(DNA, file="./results/aligned_FASTA.fas")


