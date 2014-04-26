## libraries used during the analysis
library(plyr)
library(dplyr)
library(reshape2)
library(data.table)
library(car)

## read Samsung phone test dataset from R directory
xTest <- read.table("./UCI HAR Dataset/test/X_test.txt")
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
activityTest <- read.table("./UCI HAR Dataset/test/y_test.txt")
cNames <- read.table("./UCI HAR Dataset/features.txt")

## transpose column names (also called features) from y- to x-axis
names <- t(cNames)

## returns column names and selects row 2 with column names only
names1 <- names[2,]

## returns new test data frame with proper names
names(xTest) <- paste0(names1)

## unlist the activity, coerce into numeric, 
activityTest1 <- as.numeric(unlist(activityTest))
Activity <- recode(activityTest1, "c(1) = 'Walking'; c(2) = 'WalkingUp'; c(3) = 'WalkingDown'; c(4) = 'Sitting'; c(5) = 'Standing'; c(6) = 'Laying'")

## bind "Activity" to left side of data table
dataFrame <- cbind(Activity, xTest)

## returns subjects labeled with "Subject"
subjectTest1 <- rename(subjectTest, c("V1" = "Subject"))

## returns the complete test table with subjects bound to the left
dataFrameTest <- cbind(subjectTest1, dataFrame)

## save dataFrameTest to R directory
write.table(dataFrameTest, file = "dataFrameTest.txt")

## same as above but with training set
xTrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
activityTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
cNames <- read.table("./UCI HAR Dataset/features.txt")

## transpose features from y- to x-axis
names <- t(cNames)

## returns column names and selects row 2 with names only
names1 <- names[2,]

## returns new test data frame with proper names
names(xTrain) <- paste0(names1)

## returns activity levels
activityTrain1 <- as.numeric(unlist(activityTrain))
Activity <- recode(activityTrain1, "c(1) = 'Walking'; c(2) = 'WalkingUp'; c(3) = 'WalkingDown'; c(4) = 'Sitting'; c(5) = 'Standing'; c(6) = 'Laying'")

## binds activity group to left side of data table
dataFrame <- cbind(Activity, xTrain)

## returns subjects labeled with "Subject"
subjectTrain1 <- rename(subjectTrain, c("V1" = "Subject"))

## returns the complete test table with subjects bound to the left
dataFrameTrain <- cbind(subjectTrain1, dataFrame)

## save dataFrameTrain to R directory
write.table(dataFrameTrain, file = "dataFrameTrain.txt")

## merge (stack) the two datasets into a single dataset with the rbind function
samsungData <- rbind(dataFrameTrain, dataFrameTest)

## arrange the the data set by subjects ie. 1-30
samsungDataAll <- arrange(samsungData, Subject)
write.table(samsungDataAll, file = "samsungDataAll.txt")

## select means and std variables
samsungStatistics1 <- select(samsungDataAll, Subject, Activity, grep("mean", colnames(samsungDataAll)), grep("std", colnames(samsungDataAll)))
write.table(samsungStatistics1, file = "samsungStatistics1.txt")
samsungStatistics1 <- tbl_df(samsungStatistics1) 

## summarization of data by first grouping the Subject and Activity variables, next subtract those same two variables, find the means and summarize 
## the original 10299 rows was decreased to 180 rows, with 81 variables comprised of 46 means and 33 standard deviations
df <-  group_by(samsungStatistics1, Subject, Activity)
dfVariables <- names(df)[-(1:2)]  
meanVariables <- sapply(dfVariables ,function(x) substitute(mean(x), list(x=as.name(x))))
summaryTable1 <- do.call(summarise, c(list(.data=df), meanVariables)) 
write.table(summaryTable1, file = "summaryTable1.txt")

## matched statistics: remove means unmatched to standard deviations
temp<-select(samsungDataAll, -296, -297, -298, -375, -376, -377, -454, -455, -456, -515, -528, -541, -554)
samsungStatistics2 <- select(temp, Subject, Activity, grep("mean", colnames(temp)), grep("std", colnames(temp)))

## matched statistics with 180 rows and 68 variables comprised of 33 means and 33 standard deviations
df2 <-  group_by(samsungStatistics2, Subject, Activity)
dfVariables2 <- names(df2)[-(1:2)]  
meanVariables <- sapply(dfVariables2 ,function(x) substitute(mean(x), list(x=as.name(x))))
summaryTable2 <- do.call(summarise, c(list(.data=df2), meanVariables)) 
