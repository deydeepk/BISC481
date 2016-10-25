######################################
# 01.10.2016
# Emsemble plots example
# BISC 481
######################################

# Initialization
library(DNAshapeR)

# Extract sample sequences
#I changed this file path to my computer
fn <- "/Users/Deydeep/Desktop/BISC481-master/CTCF/bound_500.fa"
#The bound ued Chip-Seq and unbound was randomly chosen from the genome. This means that 
#The middle part is where the minor groove witdth is recognized by the transcription factors


# Predict DNA shapes
pred <- getShape(fn)

# Generate ensemble plots

#I ran four diffetent plotShape functions - Deydeep
#plotShape(pred$MGW)
#plotShape(pred$ProT)
#plotShape(pred$Roll)
plotShape(pred$HelT)
heatShape(pred$ProT, 20)
