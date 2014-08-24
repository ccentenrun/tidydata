tidydata
========

### Data Source

Here are the data for the script: 
  
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

A full description is available at the site where the data was obtained: 
  
  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
  
More information about the data and its use in this script can be found in the Codebook file.

### About the script

This script fulfils an assignment for the Coursera Course "Getting & Cleaning Data". You will need to have the UCI HAR Dataset 
within your working directory before you begin. 

On inspecting the raw data, note that there are two primary data sets: train and test. Within each of these datasets
are three core files: a file listing the person's id, a file for the activity undertaken and a file for the calculated
measurement results for each test.

#### Reading in the data

The first step is therefore to read these six files into r. On inspecting the data with the dim() function, we see that
the three train data files contain 7352 observations and the test data contains 2947 observations. 

As the number of person ids, activities and measurements all have the same observations, we can use cbind() to bind
the three files together for both test and train. Once we do, we see we have two datasets with 563 variables.

We can then combine the test and train datasets as required using rbind() so that the rows for each dataset are 
combined into one full dataset encompassing all persons and their associated measurements for each activity.

#### Finding the mean and standard deviation measurements

We now have a full table of 10299 observations of 563 variables, but we only want to see the variables that relate
to each person and activity for mean and standard deviation measurements. We need the following columns, which all
include a mean() or std() measurement: 3:8,43:48,83:88,123:128,163:168,203:204,216:217,229:230,242:243,255:256,268:273,
347:352,426:431,505:506,518:519,531:532,544:545. Of course we also want to know the person and activity related to 
the measurements, so we need columns 1 and 2 as well. Subset the data for these columns.

#### Creating meaningful activity names

Activity names are coded using numbers from 1-6. To make them more meaningful in the table itself, we can rename these
variables so that all 1's = WALKING, all 2's = WALKING_UPSTAIRS and so on for the 6 activities. Again, see the codebook
for more information on the data itself.

#### Renaming the columns to be meaningful

As read in, the column names are not meaningful as they are V1, V2, V3 and so on. Using colnames() we can specify
more meaningful names for the columns as per the codebook conventions. 

#### Creating a tidy data set

Note: You will need to load the reshape2 library for this step in the script. 

We want to make a tidy data set with the average of each variable for each subject and activity. We first need to melt
the data to set our ids and variables. We can then use dcast() to reshape the data by the mean of the variables for the 
ids of each person and activity.

#### A new tidy data table

As a final step in the script, we can save this tidy data set as a text file using write.table() with row.name = FALSE
