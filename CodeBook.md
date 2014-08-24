---
title: "CodeBook for Getting and Cleaning Data course project"
author: "R Sirmons"
date: "Sunday, August 24, 2014"
output: html_document
---
Code Book for Getting and Cleaning Data course project     	
Human Activity Recognition Using Smartphones Data Set

NOTE:  You may need to use read.table with header=TRUE to view XYtidy.txt

--Overview of received data:

The dataset is from experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity measurements at a constant rate of 50Hz were captured by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window).  This data collected as multiple files with each having 2947 observations from the 30 subjects and their activities relating to the sensor and axis with values for each of the 128 windows sampled.  This data was summarized into a dataset with 561 variables or 'features' that was then split into test and training datasets.

Relevant datasets provided include both a test and training version with 561 variables, or features (X_test.txt and X_train.txt), test and train sets specifying the subject for each observation (Y_test.txt and Y_train.txt), the feature names (features.txt), and the activity names (activity_labels.txt).  Supporting files of the 128 window inertial measurements for both test and training were provided but not used in this exercise.

--Variables

Since the thrust of this exercise is creating a tidy dataset of the averages of the mean and standard deviations estimates by subject and activity, the relevant variables in the tidy dataset (XYtidy.txt) are:

ActivityId (field [1]):    V1 in Y_test.txt and Y_train.txt, link to V1 in activity_labels.txt; id of activity

ActivityName (field [2]):  V2 in activity_labels.txt; description of activity

SubjectId (field [3]):  V1 in subject_test.txt; id for volunteer who conducted test

The following are the averages by subject and activity of the mean or standard deviation estimates.  The original names, which were descriptive of axis and type of measurement, were prefixed by "Average of_" to differentiate them.  The units of the original data were not specified beyond being sensor signals.  The units of the below variable are therefore either mean of sensor units per subject per activity or standard deviation of sensor units per subject per activity.

Standard Deviation Averages (fields [4:36]):

Average of_tBodyAcc-std()-X
Average of_tBodyAcc-std()-Y	Average of_tBodyAcc-std()-Z
Average of_tGravityAcc-std()-X	Average of_tGravityAcc-std()-Y
Average of_tGravityAcc-std()-Z	Average of_tBodyAccJerk-std()-X
Average of_tBodyAccJerk-std()-Y	Average of_tBodyAccJerk-std()-Z
Average of_tBodyGyro-std()-X	Average of_tBodyGyro-std()-Y
Average of_tBodyGyro-std()-Z	Average of_tBodyGyroJerk-std()-X
Average of_tBodyGyroJerk-std()-Y	Average of_tBodyGyroJerk-std()-Z
Average of_tBodyAccMag-std()	Average of_tGravityAccMag-std()
Average of_tBodyAccJerkMag-std()	Average of_tBodyGyroMag-std()
Average of_tBodyGyroJerkMag-std()	Average of_fBodyAcc-std()-X
Average of_fBodyAcc-std()-Y	Average of_fBodyAcc-std()-Z
Average of_fBodyAccJerk-std()-X	Average of_fBodyAccJerk-std()-Y
Average of_fBodyAccJerk-std()-Z	Average of_fBodyGyro-std()-X
Average of_fBodyGyro-std()-Y	Average of_fBodyGyro-std()-Z
Average of_fBodyAccMag-std()	Average of_fBodyBodyAccJerkMag-std()
Average of_fBodyBodyGyroMag-std()	Average of_fBodyBodyGyroJerkMag-std()
	
Mean Averages(fields [37:82]):

Average of_tBodyAcc-mean()-X	Average of_tBodyAcc-mean()-Y
Average of_tBodyAcc-mean()-Z	Average of_tGravityAcc-mean()-X
Average of_tGravityAcc-mean()-Y	Average of_tGravityAcc-mean()-Z
Average of_tBodyAccJerk-mean()-X	Average of_tBodyAccJerk-mean()-Y
Average of_tBodyAccJerk-mean()-Z	Average of_tBodyGyro-mean()-X
Average of_tBodyGyro-mean()-Y	Average of_tBodyGyro-mean()-Z
Average of_tBodyGyroJerk-mean()-X	Average of_tBodyGyroJerk-mean()-Y
Average of_tBodyGyroJerk-mean()-Z	Average of_tBodyAccMag-mean()
Average of_tGravityAccMag-mean()	Average of_tBodyAccJerkMag-mean()
Average of_tBodyGyroMag-mean()	Average of_tBodyGyroJerkMag-mean()
Average of_fBodyAcc-mean()-X	Average of_fBodyAcc-mean()-Y
Average of_fBodyAcc-mean()-Z	Average of_fBodyAcc-meanFreq()-X
Average of_fBodyAcc-meanFreq()-Y	Average of_fBodyAcc-meanFreq()-Z
Average of_fBodyAccJerk-mean()-X	Average of_fBodyAccJerk-mean()-Y
Average of_fBodyAccJerk-mean()-Z	Average of_fBodyAccJerk-meanFreq()-X
Average of_fBodyAccJerk-meanFreq()-Y	Average of_fBodyAccJerk-meanFreq()-Z
Average of_fBodyGyro-mean()-X	Average of_fBodyGyro-mean()-Y
Average of_fBodyGyro-mean()-Z	Average of_fBodyGyro-meanFreq()-X
Average of_fBodyGyro-meanFreq()-Y	Average of_fBodyGyro-meanFreq()-Z
Average of_fBodyAccMag-mean()	Average of_fBodyAccMag-meanFreq()
Average of_fBodyBodyAccJerkMag-mean()	Average of_fBodyBodyAccJerkMag-meanFreq()
Average of_fBodyBodyGyroMag-mean()	Average of_fBodyBodyGyroMag-meanFreq()
Average of_fBodyBodyGyroJerkMag-mean()	Average of_fBodyBodyGyroJerkMag-meanFreq()

--Data transforms to create XYtidy.txt dataset

After reading all data the test data is processed first.  First the activity labels are merged with the Y_test data. Next the features data are applied to the X_test data as the 561 variable names and friendly names (ActivityId,  ActivityName, SubjectId) are applied to the subject data and the activity data.  Finally the test data, the subject data and the activity data are combined into one data frame.  This processing is then repeated for the training data.

Next the test and training data frames are combined into one data frame.  That combined data frame is then filtered to only columns with "mean" or "std" in their names (plus ActivityId,  ActivityName, and SubjectId).  Then this data frame is aggregated by SubjectId and ActivityId and an average calculated for each data field for each aggregation.  The columns are then renamed to prefix all 'mean' or 'std' columns with "Average of_" to differentiate them from other variables in the original dataset.  The activity labels are then merged with the data frame and the ActivityId,  ActivityName, and SubjectId column names reapplied.  Finally the ActivityName column is moved to place it next to the ActivityId column and the data frame written to the disk as XYtidy.txt using row.names =FALSE.

