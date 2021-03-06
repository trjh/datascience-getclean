## Code Book: Getting and Cleaning Data Course Project

### Study Design / Source Variables

The data in this project comes from the Human Activity Recognition
Using Smartphones Data Set ( [UCI HAR Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) ).
This is a database built from the recordings of 30 subjects performing
activities of daily living (ADL) while carrying a waist-mounted smartphone
(Samsung Galaxy S II) with embedded inertial sensors.

More details on the design of the UCI study are provided at the link above,
and in the README.txt and features_info.txt files in the dataset.  The rest of
this section will briefly describe the source variables we used to create our
own tidy data version of the UCI data set.

From the UCI HAR Dataset README.txt file:

> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details.

All measurements are normalized and bounded within [-1,1], so the units are not exact, but merely proportional to the named units.

The components of the measurements are:

* tBodyAcc -- the body acceleration measurement (separated from the sensor acceleration signal), in the time domain.  Units propritional to standard gravity g.
* tGravityAcc -- the gravity acceleration measurement (separated from the sesnsor acceleration signal), in the time domain.  Units propritional to standard gravity g.
* tBodyAccJerk -- the time rate of change of tBodyAcc, derived from the body linear acceleration.  Jerk is the acceleration of the acceleration[^1].  Units proportional to meters per second cubed (m/s^3)
* tBodyGyro -- the angular velocity vector measured by the gyroscope for each window sample, in the time domain. Units are proportional to radians/second.
* tBodyGyroJerk -- time rate of change of tBodyGyro.  Units are proportional to (radians/second^2)
* tBodyAccMag -- magnitude of the 3 dimensional tBodyAcc measurement, calculated using the Euclidian norm.  Units are probably proportional to standard gravity g.  *I don't know, I'm pretty far out of my depth here.*
* tGravityAccMag -- magnitude of the 3 dimensional tGravityAcc measurement, calculated using the Euclidian norm.  Units proportional to standard gravity g.
* tBodyAccJerkMag -- magnitude of the 3 dimensional tBodyAccJerk measurement. Units proportional to m/s^3
* tBodyGyroMag -- magnitude of the 3 dimensional tBodyGyro measurement. Units proportional to radians/second.
* tBodyGyroJerkMag -- magnitude of the 3 dimensional tBodyGyroJerk measurement.  Units proportional to radians/second^2
* fBodyAcc -- the body acceleration measurement processed through a Fast Fourier Transform (FFT).  Units proportional to standard gravity g.[^2]
* fBodyAccJerk -- time rate of change of fBodyAcc, units porporitional to m/s^3
* fBodyGyro -- the angular velocity vector measured by the gyroscope, processed through a FFT -- thus result is in the frequency domain.  Units proportional to radians/second.
* fBodyAccMag -- magnitude of 3 dimensional fBodyAcc measurement.  Units proportional to g.
* fBodyAccJerkMag -- magnitude of 3 dimensional fBodyAccJerk measurement, units proportional to m/s^3
* fBodyGyroMag -- magnitude of 3 dimensional fBodyGyro measurement.  Units proportional to radians/second.
* fBodyGyroJerkMag -- magnitude of 3 dimensional fBodyGyroJerk measurement (time rate of change of fBodyGyro), units proportional to radians/second^2.

[^1]: [Wikipedia: Jerk (physics)](http://en.wikipedia.org/wiki/Jerk_%28physics%29)

[^2]: [What are the units of the FFT output?](http://math.stackexchange.com/questions/175043/what-is-the-unit-of-the-fft-output)

----

### Tidy Data Set Variables

The following is a list of each of the variables in our tidy data set (tidy_data.txt), with a short description based on the details in the previous section.
The process used to derive these variables is described in the accomanying
README.md file, and in the comments of the run_analysis.R script.

* activity -- a string label, detailing which one of six particular activities the subject was engaged in during the measurements
* subject -- a number, 1-30, identifying which subject this measurement applies to

The remainder of the values are the mean value of all the measurements taken while a particular subject was engaged in a particular activity.  Each mean is taken over between 36 and 95 individual measurements.[^3]

[^3]: The mean number of measurements is 57

* mean(tBodyAcc_mean_X) -- mean of means of tBodyAcc in the X direction
* mean(tBodyAcc_mean_Y) -- as above, in the Y direction
* mean(tBodyAcc_mean_Z) -- as above, in the Z direction
* mean(tBodyAcc_std_X) -- mean of standard deviations of tBodyAcc in the X direction
* mean(tBodyAcc_std_Y) -- as above, in the Y direction
* mean(tBodyAcc_std_Z) -- as above, in the Z direction
* mean(tGravityAcc_mean_X) -- mean of means of tGravityAcc in the X direction
* mean(tGravityAcc_mean_Y) -- as above, in the Y direction
* mean(tGravityAcc_mean_Z) -- as above, in the Z direction
* mean(tGravityAcc_std_X) -- mean of standard deviations of tGravityAcc in the X direction
* mean(tGravityAcc_std_Y) -- as above, in the Y direction
* mean(tGravityAcc_std_Z) -- as above, in the Z direction
* mean(tBodyAccJerk_mean_X) -- mean of means of tBodyAccJerk in the X direction
* mean(tBodyAccJerk_mean_Y) -- as above, in the Y direction
* mean(tBodyAccJerk_mean_Z) -- as above, in the Z direction
* mean(tBodyAccJerk_std_X) -- mean of standard deviations of tBodyAccJerk in the X direction
* mean(tBodyAccJerk_std_Y) -- as above, in the Y direction
* mean(tBodyAccJerk_std_Z) -- as above, in the Z direction
* mean(tBodyGyro_mean_X) -- mean of means of tBodyGyro in the X direction
* mean(tBodyGyro_mean_Y) -- as above, in the Y direction
* mean(tBodyGyro_mean_Z) -- as above, in the Z direction
* mean(tBodyGyro_std_X) -- mean of standard deviations of tBodyGyro in the X direction
* mean(tBodyGyro_std_Y) -- as above, in the Y direction
* mean(tBodyGyro_std_Z) -- as above, in the Z direction
* mean(tBodyGyroJerk_mean_X) -- mean of means of tBodyGyroJerk in the X direction
* mean(tBodyGyroJerk_mean_Y) -- as above, in the Y direction
* mean(tBodyGyroJerk_mean_Z) -- as above, in the Z direction
* mean(tBodyGyroJerk_std_X) -- mean of standard deviations of tBodyGyroJerk in the X direction
* mean(tBodyGyroJerk_std_Y) -- as above, in the Y direction
* mean(tBodyGyroJerk_std_Z) -- as above, in the Z direction
* mean(tBodyAccMag_mean) -- mean of means of tBodyAccMag 
* mean(tBodyAccMag_std) -- mean of standard deviations of tBodyAccMag 
* mean(tGravityAccMag_mean) -- mean of means of tGravityAccMag 
* mean(tGravityAccMag_std) -- mean of standard deviations of tGravityAccMag 
* mean(tBodyAccJerkMag_mean) -- mean of means of tBodyAccJerkMag 
* mean(tBodyAccJerkMag_std) -- mean of standard deviations of tBodyAccJerkMag 
* mean(tBodyGyroMag_mean) -- mean of means of tBodyGyroMag 
* mean(tBodyGyroMag_std) -- mean of standard deviations of tBodyGyroMag 
* mean(tBodyGyroJerkMag_mean) -- mean of means of tBodyGyroJerkMag 
* mean(tBodyGyroJerkMag_std) -- mean of standard deviations of tBodyGyroJerkMag 
* mean(fBodyAcc_mean_X) -- mean of means of fBodyAcc in the X direction
* mean(fBodyAcc_mean_Y) -- as above, in the Y direction
* mean(fBodyAcc_mean_Z) -- as above, in the Z direction
* mean(fBodyAcc_std_X) -- mean of standard deviations of fBodyAcc in the X direction
* mean(fBodyAcc_std_Y) -- as above, in the Y direction
* mean(fBodyAcc_std_Z) -- as above, in the Z direction
* mean(fBodyAccJerk_mean_X) -- mean of means of fBodyAccJerk in the X direction
* mean(fBodyAccJerk_mean_Y) -- as above, in the Y direction
* mean(fBodyAccJerk_mean_Z) -- as above, in the Z direction
* mean(fBodyAccJerk_std_X) -- mean of standard deviations of fBodyAccJerk in the X direction
* mean(fBodyAccJerk_std_Y) -- as above, in the Y direction
* mean(fBodyAccJerk_std_Z) -- as above, in the Z direction
* mean(fBodyGyro_mean_X) -- mean of means of fBodyGyro in the X direction
* mean(fBodyGyro_mean_Y) -- as above, in the Y direction
* mean(fBodyGyro_mean_Z) -- as above, in the Z direction
* mean(fBodyGyro_std_X) -- mean of standard deviations of fBodyGyro in the X direction
* mean(fBodyGyro_std_Y) -- as above, in the Y direction
* mean(fBodyGyro_std_Z) -- as above, in the Z direction
* mean(fBodyAccMag_mean) -- mean of means of fBodyAccMag 
* mean(fBodyAccMag_std) -- mean of standard deviations of fBodyAccMag 
* mean(fBodyAccJerkMag_mean) -- mean of means of fBodyAccJerkMag 
* mean(fBodyAccJerkMag_std) -- mean of standard deviations of fBodyAccJerkMag 
* mean(fBodyGyroMag_mean) -- mean of means of fBodyGyroMag 
* mean(fBodyGyroMag_std) -- mean of standard deviations of fBodyGyroMag 
* mean(fBodyGyroJerkMag_mean) -- mean of means of fBodyGyroJerkMag 
* mean(fBodyGyroJerkMag_std) -- mean of standard deviations of fBodyGyroJerkMag 

The bulk of the descriptions in this section are programattically
self-explanatory:

    head -1 tidydata.txt | fmt -1 | sed 's/"//g' | \
    perl -ne 'chomp;$m=" -- mean of "; /_mean/ && ($m.="means ");' \
          -e '/_std/ && ($m.="standard deviations ");' \
	  -e '/mean\(([^_]+)_/ && ($m.="of $1 ");' \
	  -e '/_([YZ])/ && ($m=" -- as above, in the $1 direction");' \
	  -e '/_X/ && ($m.="in the X direction"); print "* $_$m\n"'
