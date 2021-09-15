# Art of Alignment, section 7

# Confirm DECIPHER is installed, install if not
required_packages = c("DECIPHER")
to_install = required_packages[!(required_packages %in% installed.packages()[,"Package"])]
if(length(to_install)) stop("Missing the DECIPHER package, aborting!")

library(DECIPHER)
# Load the data, as before
db <- system.file("extdata", "Influenza.sqlite", package="DECIPHER")
synteny <- FindSynteny(db, verbose=FALSE)

print('Showing synteny of the various genomes')
print(synteny)

InfluenzaA <- AlignSynteny(synteny, db, verbose=FALSE)
print('Listing regions of synteny between influenza genomes')
print(unlist(InfluenzaA[[1]]))
print('Pausing')

Sys.sleep(10)

print('Creating a visualization of pairwise synteny between genomes')

ifelse(!dir.exists(file.path(getwd(), 'results')), dir.create(file.path(getwd(), 'results')), FALSE)

png('./results/synteny.png')
pairs(synteny, boxBlocks=TRUE)
dev.off()

