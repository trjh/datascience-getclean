library(dplyr)

## x and y are tables to compare -- extra contains columns to skip from y
cmpdata <- function(x,y,extra) {
    mycol = 3; hiscol = 3;
    while(mycol <= 68) {
	if(!identical(x[,mycol],y[,hiscol])) {
	    cat("columns me:",mycol," him:",hiscol," not identical\n")
	    cat(" me: ",names(x)[mycol],"; ",head(x[,mycol]),"\n")
	    cat("him: ",names(y)[hiscol],"; ",head(y[,hiscol]),"\n")
	    stop("exiting")
	}
	mycol <- mycol + 1;
	hiscol <- hiscol + 1;
	while (hiscol %in% extra) { hiscol <- hiscol + 1 }
    }; print("all identical")
}

## read a file from disk, compare it to my test data
testdata <- function(file, sep = " ") {

    tidydata <- read.table("tidydata.txt", header = TRUE)

    t2 <- read.table(file, header = TRUE, sep=sep)

    ## presuming they've named activity & subject the same
    t2 <- arrange(t2, activity, subject)

    ## does it have any extra variables
    # he has 13 extra variables, all the meanFreq()
    t2extra = c(grep("meanfreq",names(t2),ignore.case=TRUE),
		grep("^angle",names(t2),ignore.case=TRUE))

    cmpdata(tidydata, t2, t2extra)
}

message("testdata(filename, sep = \" \")")
