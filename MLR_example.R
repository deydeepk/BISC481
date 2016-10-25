######################################
# 12.10.2016
# Multiple Linear Regression (MLR) example
# BISC 481
######################################

## Install packages
# Bioconductor
source("https://bioconductor.org/biocLite.R")
biocLite()
# DNAshapeR
biocLite("DNAshapeR")
# Caret
install.packages("caret")

## Initialization
library(DNAshapeR)
library(caret)
##I changed the working path to my own directory - Deydeep
workingPath <- "/Users/Deydeep/Desktop/BISC481-master/gcPBM/"

## Predict DNA shapes
##I changed the .fa file to either Myc, Mad or Max - Deydeep
fn_fasta <- paste0(workingPath, "Myc.txt.fa")
pred <- getShape(fn_fasta)

## Encode feature vectors
##I changed the feature type to include either 1-mer or both 1-mer and shape - Deydeep
featureType <- c("1-mer")
#featureType <- c("1-mer", "shape")
featureVector <- encodeSeqShape(fn_fasta, pred, featureType)
head(featureVector)

## Build MLR model by using Caret
# Data preparation
##I changed the .txt file to either Myc, Mad or Max - Deydeep
fn_exp <- paste0(workingPath, "Myc.txt")
exp_data <- read.table(fn_exp)
df <- data.frame(affinity=exp_data$V2, featureVector)

# Arguments setting for Caret
trainControl <- trainControl(method = "cv", number = 10, savePredictions = TRUE)

# Prediction without L2-regularized
model <- train (affinity~ ., data = df, trControl=trainControl, 
                method = "lm", preProcess=NULL)
summary(model)

# Prediction with L2-regularized
model2 <- train(affinity~., data = df, trControl=trainControl, 
               method = "glmnet", tuneGrid = data.frame(alpha = 0, lambda = c(2^c(-15:15))))
model2
result <- model2$results$Rsquared[1]