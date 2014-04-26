##Code Book for Samsung Accelerometer Data
####$Six Activity levels: *Walking, Walking Up (stairs), Walking Down (stairs), Sitting, Standing, Laying*
####Subject: 1-30, ages 19-48
####Motion features: 561
####Motion directions: X, Y, Z
###Motion vectors:      
* tBodyAcc-XYZ     
* tGravityAcc-XYZ   
* tBodyAccJerk-XYZ   
* tBodyGyro-XYZ   
* tBodyGyroJerk-XYZ   
* tBodyAccMag   
* tGravityAccMag   
* tBodyAccJerkMag    
* tBodyGyroMag    
* tBodyGyroJerkMag    
* fBodyAcc-XYZ    
* fBodyAccJerk-XYZ    
* fBodyGyro-XYZ   
* fBodyAccMag   
* fBodyAccJerkMag   
* fBodyGyroMag   
* fBodyGyroJerkMag     
####Emphasized statistics: mean (mean value) and std (Standard deviation).
####Raw datafiles used:        
* X_test.txt (set of test motion data for 9 subjects (30%))   
* subject_test.txt (list of test "Subject"" that generated motion data)   
* y_test.txt (list of test "Activity"" performed by subjects)   
* X_train.txt (set of training motion data for 21 subjects (70%))   
* subject_train.txt (list of training "Subject"" that generated motion data)   
* y_train.txt (list of training "Activity"" performed by subjects)   
* features.txt (561 motion features for both test and training sets)      
####Other informational files that were used:        
* README.txt and features_info.txt, which are the source of information in this code book (2).   
###References:    
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.    
###Data source, including text file describing raw datasets:   
[2] <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip> 
Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012
