#Getting and Cleaning Data Project
Activity recognition is becoming easier as more people are wearing smartphones that can be used to collect and transmit information about their activity.  Since smartphones also have internet access they can be used to collect location and activity data and then transmit the information for analysis.  This may be especially useful in the healthcare industry for monitoring the growing population of elderly [1-3] or for monitoring the exercise patterns of people [4].  
The  data used in this project was generated by Samsung Smartphone accelerometers and the data were provided by Anguita et al. [1] and is available for downloading [5].  Activity information from a Samsung Smartphone was considered for individuals that were Walking, Walking Up (stairs), Walking Down (stairs), Sitting, Standing, or Laying.  A training set of  data was comprised of 21 subjects and a test set was comprised of 9 subjects.  
##Goal and Summary of Project:
1. Merge all data into a single data set, which has been called **samsungDataAll**.  It is in a “tidy” format, with the following characteristics: 10299 rows, and 563 columns, that starts with **Subject**, **Activity** (with 6 labeled levels), followed by 561 motion vectors.
2. Extract the mean and standard deviation for each measurement and create a data set with descriptive names, which has been called **samsungStatistics1**.  Its is the same as **samsungDataAll** except the number of columns was reduced to 81.  
3. An additional data set was created, named **samsungStatistics2**, which is identical to **samsungStatistics** except an additional 13 columns of mean data has been removed.  This data has been removed because they do not have matched standard deviations.
4. Finally, two summary data sets were created with the average of each variable.  These data sets are **summaryTable1** and  **summaryTable2**, and were summarized  from **samsungStatistics1** and **samsungStatistics2**, respectively.    

###Summary of tidy data sets      
File Name                     | Number of Columns        | Number of Rows     
:-----------------------------|:-------------------------:|:------------:
 **samsungDataAll**           |    563                    |     10299     
 **samsungStatistics1**       |      81                   |    10299    
 __samsungStatistics2*__      |        68                 |     10299     
 **summaryTable1**            |          81               |      180      
 __summaryTable2*__           |       68                  |    180    
__*These two files have matched means and standard deviations and are the most likely needed for the project, else the files with 81 columns and 13 additional means that are not matched with standard deviations can be used.__   


##References:

1.  [Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012.](http://link.springer.com/chapter/10.1007%2F978-3-642-35395-6_30#page-1)
2.  [Anguita, D, Ghio, A, Oneto, L, Parra, X. and Reyes-Ortiz, J. L . A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.](https://www.elen.ucl.ac.be/Proceedings/esann/esannpdf/es2013-11.pdf )
3.  Anguita, D, Ghio, A, Oneto, L, Parra, X. and Reyes-Ortiz, J. L . Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. 4th International Workshop of Ambient Assited Living, IWAAL 2012, Vitoria-Gasteiz, Spain, December 3-5, 2012. Proceedings. Lecture Notes in Computer Science 2012, pp 216-223.
4.  Kwapisz, J. R. Weiss, G. M., and Moore, S. A. (2010). Activity Recognition using Cell Phone Accelerometers. ACM SIGKDD Explorations Newsletter archive. Vol. 12, 2, 74-82   
5.  <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>
  
#Run_analysis R Markdown
Project requirements as [written](https://class.coursera.org/getdata-002/human_grading/view/courses/972080/assessments/3/submissions):    
1.  Merges the training and the test sets to create one data set.   
2.  Extracts only the measurements on the mean and standard deviation for each measurement.    
3.  Uses descriptive activity names to name the activities in the data set.   
4.  Appropriately labels the data set with descriptive activity names.    
5.  Creates a second, independent tidy data set with the average of each variable for each activity and each subject.   
### R-script Function and Usage
##Data       
Data was obtained from: <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip> 
The zip file was downloaded, unzipped and saved to the R working directory.  
#####Libraries used during the analysis.
```{r}
library(plyr)
library(dplyr)
library(reshape2)
library(data.table)
library(car)
```
##Test set
Read Samsung phone test data sets from the R directory.  Four data sets were used.  For the purpose of this project the inertial data was not used.  Three of the data sets are unique to the 9 test subjects.  The feature data set has the motion vector column names and is common to both test and training sets. 
```{r}
xTest <- read.table("./UCI HAR Dataset/test/X_test.txt")
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
activityTest <- read.table("./UCI HAR Dataset/test/y_test.txt")
cNames <- read.table("./UCI HAR Dataset/features.txt")
```
Transpose column names (also called features) from y- to x-axis.
```{r}
names <- t(cNames)
```
Returns column names and selects row 2 with column names only.
```{r}
names1 <- names[2,]
```
Returns new test data frame with 561 motion vectors.
```{r}
names(xTest) <- paste0(names1)
```
Unlist the activity and coerce into numeric.  Activity levels are changed to descriptive activity names. 
```{r}
activityTest1 <- as.numeric(unlist(activityTest))
Activity <- recode(activityTest1, "c(1) = 'Walking'; c(2) = 'WalkingUp'; c(3) = 'WalkingDown'; c(4) = 'Sitting'; c(5) = 'Standing'; c(6) = 'Laying'")
```
Add "Activity" to left side of data table.
```{r}
dataFrame <- cbind(Activity, xTest)
```
The "V1" label is replaced with "Subject" label.  
```{r}
subjectTest1 <- rename(subjectTest, c("V1" = "Subject"))
```
Returns the complete test table with subject numbers added to the furthest most left side.
```{r}
dataFrameTest <- cbind(subjectTest1, dataFrame)
```
Save tidy dataFrameTest to R directory.
```{r}
write.table(dataFrameTest, file = "dataFrameTest.txt")
```
##Training set
The same steps are used to obtain a tidy training data set as were used to obtain a tidy test data set.  In this data set there are 21 subjects.
```{r}
xTrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
activityTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
cNames <- read.table("./UCI HAR Dataset/features.txt")
```
Transpose features from y- to x-axis.
```{r}
names <- t(cNames)
```
Returns column names and selects row 2 with names only.
```{r}
names1 <- names[2,]
```
Returns new training data frame with 561 motion vectors.
```{r}
names(xTrain) <- paste0(names1)
```
Unlist the activity and coerce into numeric.  Activity levels are changed to descriptive activity names.
```{r}
activityTrain1 <- as.numeric(unlist(activityTrain))
Activity <- recode(activityTrain1, "c(1) = 'Walking'; c(2) = 'WalkingUp'; c(3) = 'WalkingDown'; c(4) = 'Sitting'; c(5) = 'Standing'; c(6) = 'Laying'")
```
Add "Activity" to left side of data table.
```{r}
dataFrame <- cbind(Activity, xTrain)
```
The "V1" label is replaced with "Subject" label.
```{r}
subjectTrain1 <- rename(subjectTrain, c("V1" = "Subject"))
```
Returns the complete training data table with subject numbers added to the furthest most left side.
```{r}
dataFrameTrain <- cbind(subjectTrain1, dataFrame)
```
Save dataFrameTrain to R directory.
```{r}
write.table(dataFrameTrain, file = "dataFrameTrain.txt")
```
#####Merge (stack) the tidy training and test data sets into a single dataset with the rbind function.
```{r}
samsungData <- rbind(dataFrameTrain, dataFrameTest)
```
##samsungDataAll: a tidy data frame with all subjects, activities and motion vectors.
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;__samsungDataAll fulfills requirements 1 and 3 of project assignment.__   
####Reorder the the data set by subjects 1-30 and save the large tidy data frame with 563 columns and 10299 rows.
```{r}
samsungDataAll <- arrange(samsungData, Subject)
write.table(samsungDataAll, file = "samsungDataAll.txt")
```
##samsungStatistics1: a tidy data frame with 81 variables and 10299 rows.
Select means and std variables and then file is saved.  This produces a data set with 46 mean and 33 standard deviation values.
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;__samsungStatistics1 may fulfill requirements 2-4 of project assignment.__ 
```{r}
samsungStatistics1 <- select(samsungDataAll, Subject, Activity, grep("mean", colnames(samsungDataAll)), grep("std", colnames(samsungDataAll)))
write.table(samsungStatistics1, file = "samsungStatistics1.txt")
```
Create a data frame table.  Although this is not a necessary part of the code, inclusion ensures that only the first few rows and all columns are returned upon printing.
```{r}
samsungStatistics1 <- tbl_df(samsungStatistics1)
```
##summaryTable1: summarization of samsungStatistics1 with 81 variables and 180 rows.       
#####Data is first grouped by the Subject and Activity variables.  Next, subtract those same two variables, calculate the means, summarize the results and save the file.
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;__summaryTable1 may fulfill requirement 5 of project assignment.__
```{r}
df <-  group_by(samsungStatistics1, Subject, Activity)
dfVariables <- names(df)[-(1:2)]  
meanVariables <- sapply(dfVariables ,function(x) substitute(mean(x), list(x=as.name(x))))
summaryTable1 <- do.call(summarise, c(list(.data=df), meanVariables)) 
write.table(summaryTable1, file = "summaryTable1.txt")
```
##samsungStatistics2: a tidy data frame with 68 variables and 10299 rows.
#####Prepare another table with matched statistics.  This removes means that are not matched to standard deviations.
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;__If samsungStatistics1 does not fulfill requirements 2-4 of project assignment then samsungStatistics2 should.__
```{r}
temp <- select(samsungDataAll, -296, -297, -298, -375, -376, -377, -454, -455, -456, -515, -528, -541, -554)
samsungStatistics2 <- select(temp, Subject, Activity, grep("mean", colnames(temp)), grep("std", colnames(temp)))
```
##summaryTable2: summarization of samsungStatistics1 with 68 variables and 180 rows.
#####Finally, a matched statistics data set is produced, which is comprised of 33 means and 33 standard deviations.
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;__If summaryTable1 does not fulfill requirement 5 of project assignment then summaryTable2 should.__
```{r}
df2 <-  group_by(samsungStatistics2, Subject, Activity)
dfVariables2 <- names(df2)[-(1:2)]  
meanVariables <- sapply(dfVariables2 ,function(x) substitute(mean(x), list(x=as.name(x))))
summaryTable2 <- do.call(summarise, c(list(.data=df2), meanVariables))
write.table(summaryTable2, file = "summaryTable2.txt")
```
