
#suppressMessages(library(randomForest))
suppressMessages(library(randomForest, lib.loc="/diskA/shared/CSC597/project_2/Rpackages/randomForest/"))

args <- commandArgs(trailingOnly=TRUE)

if(length(args) != 3){
  print("Need three parameters:")
  print("    1). Random Forest file")
  print("    2). feature file to be predicted")
  print("    3). output file for predictions")
  quit("no")
}

# load Random Forest
rf <-get(load(args[1]))

# load predicted feature file
data <- read.table(args[2], header=F)

# make the predictions
pred <- predict(rf, data)

# save the predictions into a file
write(as.character(pred), file=args[3], sep="\n")

# End



