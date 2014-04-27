### About

Script for preparing tidy dataset from [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).


### Running the script

- Download this script
- Download the [data set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and extract.
- Change current directory to the `UCI HAR Dataset` folder and place script there.
- Run `Rscript run_analysis.R`
- The tidy dataset should be created in the current directory as `tidy.txt`


### How script works

- Reading data from `test` folder.
- Extracting only the measurements on the mean and standard deviation for each test measurement.
- Reading data from `train` folder.
- Extracting only the measurements on the mean and standard deviation for each train measurement.
- Merging the training and the test sets to create one data set.
- Changing column names with nicer ones.
- Replacing ActivityId with ActivityName.
- Creating tidy data set with the average of each variable for each activity and each subject. 
