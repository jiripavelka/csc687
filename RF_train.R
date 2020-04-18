# parameters:
# 1. feature file
# 2. ntree
# 3. mtry - default = sqrt(p) = 17
# 4. RF file

#suppressMessages(library(randomForest))
#suppressMessages(require(randomForest))
suppressMessages(library(randomForest, lib.loc="/diskA/shared/CSC597/project_2/Rpackages/randomForest/"))

args <- commandArgs(trailingOnly=TRUE)

set.seed(101)

# load train data
dat <- read.table(args[1], header=F)

# ntree=501, mtry is the default value

# train
rf <- randomForest(dat[-1], dat$V1, importance=TRUE, na.action=na.omit, ntree=as.integer(args[2]), mtry=as.integer(args[3]))

# save the Random Forest into a file
save(rf, file=args[4])

# End


