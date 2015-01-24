## Getting and Cleaning Data
## Course Project

## Code Book

The following is a list of each of the variables in tidy_data.txt, with a
short description.

* activity -- a string label, detailing which one of six particular activities the subject was engaged in during the measurements
* subject -- a number, 1-30, identifying which subject this measurement applies to

The remainder of the values are the mean value of all the measurements taken
while a particular subject was engaged in a particular activity.  Each mean is
taken over between 36 and 95 individual measurements.[^1]

[^1]: The mean number of measurements is 57

* tBodyAcc measurements -- measurements of Body acceleration in the X, Y, and Z directions, in the time domain, normalized and bounded within [-1,1].  Source units were standard gravity units 'g', thus the units here are proportional to g.
  * mean(tBodyAcc_mean_X) -- mean of tBodyAcc in the X direction
  * mean(tBodyAcc_mean_Y) -- as previous, in the Y direction
  * mean(tBodyAcc_mean_Z) -- as previous, in the Z direction
  * mean(tBodyAcc_std_X) -- standard deviation of tBodyAcc in the X direction
  * mean(tBodyAcc_std_Y) -- in the Y direction
  * mean(tBodyAcc_std_Z) -- in the Z direction

* mean(tGravityAcc_mean_X)
* mean(tGravityAcc_mean_Y)
* mean(tGravityAcc_mean_Z)
* mean(tGravityAcc_std_X)
* mean(tGravityAcc_std_Y)
* mean(tGravityAcc_std_Z)
* mean(tBodyAccJerk_mean_X)
* mean(tBodyAccJerk_mean_Y)
* mean(tBodyAccJerk_mean_Z)
* mean(tBodyAccJerk_std_X)
* mean(tBodyAccJerk_std_Y)
* mean(tBodyAccJerk_std_Z)
* mean(tBodyGyro_mean_X)
* mean(tBodyGyro_mean_Y)
* mean(tBodyGyro_mean_Z)
* mean(tBodyGyro_std_X)
* mean(tBodyGyro_std_Y)
* mean(tBodyGyro_std_Z)
* mean(tBodyGyroJerk_mean_X)
* mean(tBodyGyroJerk_mean_Y)
* mean(tBodyGyroJerk_mean_Z)
* mean(tBodyGyroJerk_std_X)
* mean(tBodyGyroJerk_std_Y)
* mean(tBodyGyroJerk_std_Z)
* mean(tBodyAccMag_mean)
* mean(tBodyAccMag_std)
* mean(tGravityAccMag_mean)
* mean(tGravityAccMag_std)
* mean(tBodyAccJerkMag_mean)
* mean(tBodyAccJerkMag_std)
* mean(tBodyGyroMag_mean)
* mean(tBodyGyroMag_std)
* mean(tBodyGyroJerkMag_mean)
* mean(tBodyGyroJerkMag_std)
* mean(fBodyAcc_mean_X)
* mean(fBodyAcc_mean_Y)
* mean(fBodyAcc_mean_Z)
* mean(fBodyAcc_std_X)
* mean(fBodyAcc_std_Y)
* mean(fBodyAcc_std_Z)
* mean(fBodyAccJerk_mean_X)
* mean(fBodyAccJerk_mean_Y)
* mean(fBodyAccJerk_mean_Z)
* mean(fBodyAccJerk_std_X)
* mean(fBodyAccJerk_std_Y)
* mean(fBodyAccJerk_std_Z)
* mean(fBodyGyro_mean_X)
* mean(fBodyGyro_mean_Y)
* mean(fBodyGyro_mean_Z)
* mean(fBodyGyro_std_X)
* mean(fBodyGyro_std_Y)
* mean(fBodyGyro_std_Z)
* mean(fBodyAccMag_mean)
* mean(fBodyAccMag_std)
* mean(fBodyBodyAccJerkMag_mean)
* mean(fBodyBodyAccJerkMag_std)
* mean(fBodyBodyGyroMag_mean)
* mean(fBodyBodyGyroMag_std)
* mean(fBodyBodyGyroJerkMag_mean)
* mean(fBodyBodyGyroJerkMag_std)
