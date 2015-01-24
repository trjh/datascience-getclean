## Getting and Cleaning Data
## Course Project

This repository contains a processed version of the [UCI HAR Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones),
according to the objectives laid out in the [Getting and Cleaning Data Course
Project](https://class.coursera.org/getdata-010/human_grading/view/courses/973497/assessments/3/submissions).

### Contents

This repository includes the following files:

* README.md -- this file
* CodeBook.md -- description of the variables contained in the data set
* run\_analysis.R -- an R script used to process the files in the **UCI HAR Dataset** directory into a tidy data set
* tidydata.txt -- the tidy data set

The **UCI HAR Dataset** files are not included in this repository, but are available directly via [this link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) or indirectly from the [dataset home page](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

One extra file, **experimental.R**, contains extra code (alternative ways to
do what run\_analysis.R does) and commentary.  Thus I can still record all my
experiments and approaches, but not confuse those trying to grade my work.

### More information

The Human Activity Recognition Using Smartphones Data Set  (*UCI HAR Dataset*) is a database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone (Samsung Galaxy S II) with embedded inertial sensors.

The original data set contains 10,299 measurements spread across 30 subjects performing 6 activities, and split into a 2,947 measurement test set and a 7,352 measurement training set.  These data samples are provided in raw form (as 128 element vectors), and in processed form.  The processed (features) variables are calculations of 17 signals, in the time and frequency domain, from each 128-element sample.  These 17 signals are then put through various other functions, and these comprise the 561 "features" provided for each measurement in the source data set.

The objectives of this project are to create one R script (*run_analysis.R*) that does the following: 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

A further explanation of how the script carries out each of these steps follows.

#### Merge the training and the test sets to create one data set.

The script first creates a character vector *files* that contains the files we want to read.  We don't bother with the raw measurements files contained in the source dataset, but instead go straight for the files containing the features variables (X\_test.txt, X\_train.txt), the subject identifier (subject\_test.txt, subject\_train.txt), and the activity identifier (y\_test.txt, y\_train.txt)

These files are each read in to a separate variable, then merged using *cbind* into the 565-column **testdata** and **traindata** tables.

Finally, we use *rbind* to merge those two tables into a **dataset** table
with 563 columns and 10,299 rows.


#### Extract only the measurements on the mean and standard deviation for each measurement. 

In this section, we create a new data.frame, **dataextract**, containing only
the desired measurements, as well as the activity and subject variables.

I've taken the directions as meaning that the only features from the original
dataset that are desired are those that contain "mean()" and "std()".  There
are 7 additional variables from features.txt that mention a Mean -- all are
angles between two variables (one or both are Means).  These would not seem
to be means of a measurement, as requested, so they are not included in our
extract.

I have identified the desired column numbers from the original data
set via *egrep* on features.txt, and placed them into a numeric
vector **featurescols**.  This is used to simply select the desired
columns out of **dataset** into our new **dataextract** data.frame.

At the end of this section, we run a sanity check to ensure that
**dataextract** has the expected dimensions, and that it does not contain any
NA values.


#### Uses descriptive activity names to name the activities in the data set

In this section, we read the activity\_labels.txt file into
**activity_labels**, which contains two columns -- the activity numbers (as
used at this point in the **dataextract** table activity column), and the
activity names.

We then use *lapply* over the activity column of **dataextract**, applying a
function that translates the activity number **a** into the appropriate label
with **activity_labels[a,2]**.

Finally, we use the result to replace the existing activity column of
**dataextract**


#### Appropriately labels the data set with descriptive variable names. 

In this section, we read the features.txt file, which contains two columns --
row numbers, and labels.  We then modify the labels to remove parenthesis and
dashes (though the final result will have parenthesis).

Finally, we use the **featurescols** vector from the last section to extract
the desired, tidied activity labels and use *names* to apply them to our
extract table, **dataextract**


#### From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Here we look to the *dplyr* library, to group the data extract by activity and
subject, then summarize it via those groupings.

We first create a data table frame **dataextractd**, then use the chaining
feature of *dplyr* to first apply the *group_by* function to the data table
frame, then the *summarize* function to build a new table (**tidydata**) with
the activity, subject, and the mean() of the remaining 66 variables from
**dataextractd**.

We summarize these 66 columns by explicitly naming all 66, each within the
*mean* function.  There is very likely an easier way to do this, but I want to
have this project ready for submission before I lose myself looking for it.

Finally, we use *capture.output* to send the output of *write.table* to a
file.


### Author

* [Tim Hunter](https://plus.google.com/u/0/113114363071053007842/about/p/pub)
