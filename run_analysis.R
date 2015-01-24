## Script to process UCI HAR Dataset
## as per instructions for Getting and Cleaning Data Course Project

# Base path of the UCI HAR Dataset -- by default, this script expects that it
# will find the dataset files under the 'UCI HAR Dataset' directory, which in
# turn should be in the current directory of the script
basepath <- "UCI HAR Dataset/"

# complain if that director isn't found
if (!file.exists(basepath)) {
    print(paste("Please run this script in the same directory as the",
	  basepath, "directory"))
}

##
## 1. Merges the training and the test sets to create one data set.
##

# As we'll see from later steps, we need the 'features' data (variables
# calculated, in the time & frequency domain, from the raw samples), as well
# as the subject and activity associated with each set of features.  This data
# is in the X, subject, and y files, respectively.  First we'll build a vector
# with the full filenames.

# build a vector of filenames
files <-
sapply(c("test", "train"),
       function(set) c(paste(basepath,set,"/X_",set,".txt",sep=""),
		    paste(basepath,set,"/subject_",set,".txt",sep=""),
		    paste(basepath,set,"/y_",set,".txt",sep=""))
)

# now read the test data set -- the default settings of read.table are fine here
testfeat <- read.table(files[1,"test"])		# 563 col, 2947 rows
testsub  <- read.table(files[2,"test"])		# 1 col, 2947 rows
testact  <- read.table(files[3,"test"])		# 1 col, 2947 rows

# create a merged table of test data -- the features are placed first in the
# table for ease of extracting specific columns later.
testdata <- cbind(testfeat, testsub, testact)

# keep memory tidy
rm(testfeat, testsub, testact)

# now read the train data in the same manner
# i could do the whole thing with a for loop, but this is
# more explicit
trainfeat <- read.table(files[1,"train"])	# 563 col, 7352 rows
trainsub  <- read.table(files[2,"train"])	# 1 col, 7352 rows
trainact  <- read.table(files[3,"train"])	# 1 col, 7352 rows

# create a merged table of training data
traindata <- cbind(trainfeat, trainsub, trainact)

# keep memory tidy
rm(trainfeat, trainsub, trainact)

# finally, merge the data sets -- first goal reached
dataset <- rbind(traindata, testdata)

## sanity check
if (!identical(as.numeric(dim(dataset)), c(10299, 564))) {
    print("expected merged dataset to have dimensions 10299 x 563")
    print("stopping")
    return;
}

# keep memory tidy
rm(traindata, testdata)

# set up a dplyr data frame table for later use.  we'll do some things
# the 'hard' way, and the 'dplyr' way, to learn about dplyr
library(dplyr)
datasetd <- tbl_df(dataset)

##
## 2. Extracts only the measurements on the mean and standard deviation for
##    each measurement.
##

# The features_info.txt files starts out describing 17 signals, measured from
# the raw samples in the time and frequency domain.  Two of the measurements
# estimated from each of these signals are
#
# mean(): Mean value
# std(): Standard deviation
#
# 9 single domain, 8 in X/Y/Z = 9 * 2 + 8 * 3 * 2 = 66 mean() and std()
# measurements
#
# There are 7 additional variables from features.txt that mention a Mean --
# all are angles between two variables (one or both are Means).  Thease would
# not seem to be means of a measurement, as requested, so they are not
# included in our extract.

# the unix command line
# 	egrep "(mean|std)\(" features.txt | awk '{print $1","}'
# ...was used to build up a list of the column numbers that we need
# from X_(train|test)

# define the column numbers we want to extract from dataset
featurescols = c(
       1,   2,   3,   4,   5,   6,  41,  42,  43,  44,  45,  46,  81,
      82,  83,  84,  85,  86, 121, 122, 123, 124, 125, 126, 161, 162,
     163, 164, 165, 166, 201, 202, 214, 215, 227, 228, 240, 241, 253,
     254, 266, 267, 268, 269, 270, 271, 345, 346, 347, 348, 349, 350,
     424, 425, 426, 427, 428, 429, 503, 504, 516, 517, 529, 530, 542,
     543)
subjectcol = 562
activitycol = 563

# perform the extract, placing the activity and subject columns at the start
# of the extract table
dataextract <- dataset[c(activitycol, subjectcol, featurescols)]

# now, as we don't yet have proper column names, we'll define some variables
# and a function to tell us which extract columns are which.
# in dataextract, activity is column 1, subject is column 2,
# and the 66 features we extracted correspond to columns 3-68
e.activitycol = 1
e.subjectcol  = 2

# given n, a column number in the original features list,
# returns the column number it corresponds to in the extract
e.feature <- function(n) ( which(featurescols == n) + 2 )

## sanity check
if (!identical(as.numeric(dim(dataextract)), c(10299, 68))) {
    print("expected dataset extract to have dimensions 10299 x 68")
    print("stopping")
    return;
}

# now, to assure ourselves that the extracted data is "clean"
# we lapply is.na to data.extract, which results in 68 logical vectors
# we sapply sum to the 68 logical vectors to get a list of NA
# 	values in each column
# finally we sum the result of this to get the sum total of all NA
# values in the dataextract
# ...and verify that it is zero
if (sum(sapply(lapply(dataextract,is.na),sum)) != 0) {
    print("expected no NA values in dataextract, stopping")
    return
}

# done via dyplr -- we have to use the V names, because dplyr doesn't
# use column numbers.  however, before we can do that, we have to
# change the name on activitycol and subjectcol, as they are
# duplicates (V1 and V2)
names(datasetd)[activitycol] <- "activity"
names(datasetd)[subjectcol]  <- "subject"
dataextractd <-
    select(datasetd, activity, subject, num_range("V", featurescols))

##
## 3. Uses descriptive activity names to name the activities in the data set
##

# The activity column is currently a number in the range 1:6.  This is
# translated to activities by the activity_labels.txt file.  We're now going
# to read in that file and use it to change the activity column in dataextract
# to a factor of six descriptive activity names

# read the activity labels
activity_labels <-
    read.table(paste(basepath,"/activity_labels.txt", sep=""))
	
# now use lapply to create a factor vector containing activity names.
# ...i thought i might need to use vapply, but
#	(a) the 2nd column of activity_labels is already a factor
#	(b) i couldn't figure out how to tell vapply to return a
#	    factored result with FUN.VALUE equal to factor(1) or
#	    factor(0) or as.factor()

activity_column <-
    lapply(dataextract[e.activitycol],
	   function(a) activity_labels[a,2])

# replace the activity column in the dataextract table with the  labeled
# column (first element in the list from lapply)
dataextract[e.activitycol] <- activity_column[[1]]

# dplyr: don't see another way to do this at the mo
dataextractd$activity = activity_column$V1

##
## 4. Appropriately labels the data set with descriptive variable names. 
##

# here, we'll just use "activity" and "subject" for the first two
# variable names.  we'll collect the rest of the variable names from
# the features.txt file.  we'll need to modify those names to remove
# the parenthesis in mean() and std(), so as it make the variable names
# easier to use

feature_labels <-
    read.table(paste(basepath,"/features.txt", sep=""),
	       stringsAsFactors = FALSE)

# substitute any instance of ( or ) with the empty string ""
feature_labels["clean"] <- gsub("[()]","",feature_labels$V2)

# substitute any instance of - with the string "_" as the dashes will be
# interpreted as minus signs in dataextract$tBodyGyro-mean-X
feature_labels["clean"] <- gsub("-","_",feature_labels$clean)

# now apply our collected new names to the dataextract table
names(dataextract) =
    c("activity", "subject", feature_labels$clean[featurescols])

# a little sanity check
# feature 121 is tBodyGyro-mean()-X
if (!identical(dataextract$tBodyGyro_mean_X,
	       as.numeric(dataset[121][[1]])
	      ))
{
    print(paste("expected tBodyGyro_mean_X to have same values",
		"as in dataset col 121, stopping"))
    return
}

# dplyr: not very different but let's show mutate() anyway
feature_lab2 <- tbl_df(
    read.table(paste(basepath,"/features.txt", sep=""),
	       stringsAsFactors = FALSE)
)

# dplyr: this probably isn't the best way to do this
feature_lab2 <- feature_lab2 %>%
		mutate(clean = gsub("[()]","",V2)) %>%
		mutate(clean = gsub("-","_",clean))
names(dataextractd) =
    c("activity", "subject", feature_lab2$clean[featurescols])

##
##    5. From the data set in step 4, creates a second, independent tidy data
##       set with the average of each variable for each activity and each
##       subject.
##

# the easiest way to do this is with dplyr.  I don't yet have a way to
# programmatically specify that I want the mean() of all columns in
# "dataextractd", so until I come across that in the week 3 lessons, I'll just
# list them, using

comment_list_method <- '
select(dataextractd, -activity, -subject) %>% names %>%
sapply(function(a) paste("mean(",a,"),",sep="")) %>%
write.table(row.names = FALSE, col.names = FALSE, quote = FALSE)
'

tidydata <- dataextractd %>%
    group_by(activity, subject) %>%
    summarize(
	mean(tBodyAcc_mean_X),
	mean(tBodyAcc_mean_Y),
	mean(tBodyAcc_mean_Z),
	mean(tBodyAcc_std_X),
	mean(tBodyAcc_std_Y),
	mean(tBodyAcc_std_Z),
	mean(tGravityAcc_mean_X),
	mean(tGravityAcc_mean_Y),
	mean(tGravityAcc_mean_Z),
	mean(tGravityAcc_std_X),
	mean(tGravityAcc_std_Y),
	mean(tGravityAcc_std_Z),
	mean(tBodyAccJerk_mean_X),
	mean(tBodyAccJerk_mean_Y),
	mean(tBodyAccJerk_mean_Z),
	mean(tBodyAccJerk_std_X),
	mean(tBodyAccJerk_std_Y),
	mean(tBodyAccJerk_std_Z),
	mean(tBodyGyro_mean_X),
	mean(tBodyGyro_mean_Y),
	mean(tBodyGyro_mean_Z),
	mean(tBodyGyro_std_X),
	mean(tBodyGyro_std_Y),
	mean(tBodyGyro_std_Z),
	mean(tBodyGyroJerk_mean_X),
	mean(tBodyGyroJerk_mean_Y),
	mean(tBodyGyroJerk_mean_Z),
	mean(tBodyGyroJerk_std_X),
	mean(tBodyGyroJerk_std_Y),
	mean(tBodyGyroJerk_std_Z),
	mean(tBodyAccMag_mean),
	mean(tBodyAccMag_std),
	mean(tGravityAccMag_mean),
	mean(tGravityAccMag_std),
	mean(tBodyAccJerkMag_mean),
	mean(tBodyAccJerkMag_std),
	mean(tBodyGyroMag_mean),
	mean(tBodyGyroMag_std),
	mean(tBodyGyroJerkMag_mean),
	mean(tBodyGyroJerkMag_std),
	mean(fBodyAcc_mean_X),
	mean(fBodyAcc_mean_Y),
	mean(fBodyAcc_mean_Z),
	mean(fBodyAcc_std_X),
	mean(fBodyAcc_std_Y),
	mean(fBodyAcc_std_Z),
	mean(fBodyAccJerk_mean_X),
	mean(fBodyAccJerk_mean_Y),
	mean(fBodyAccJerk_mean_Z),
	mean(fBodyAccJerk_std_X),
	mean(fBodyAccJerk_std_Y),
	mean(fBodyAccJerk_std_Z),
	mean(fBodyGyro_mean_X),
	mean(fBodyGyro_mean_Y),
	mean(fBodyGyro_mean_Z),
	mean(fBodyGyro_std_X),
	mean(fBodyGyro_std_Y),
	mean(fBodyGyro_std_Z),
	mean(fBodyAccMag_mean),
	mean(fBodyAccMag_std),
	mean(fBodyBodyAccJerkMag_mean),
	mean(fBodyBodyAccJerkMag_std),
	mean(fBodyBodyGyroMag_mean),
	mean(fBodyBodyGyroMag_std),
	mean(fBodyBodyGyroJerkMag_mean),
	mean(fBodyBodyGyroJerkMag_std)
    )

outputfilename <- "tidydata.txt"

capture.output(
    write.table(tidydata, row.name = FALSE),
    file = outputfilename
)

cat(paste("output table 'tidydata' written to file:",outputfilename,"\n"))
