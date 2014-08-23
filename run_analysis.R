## Read the test and train data into R. You will need to have the UCI HAR Dataset within your working
## directory before you begin. See the readme file for a URL to download this data.

## Read in the test data
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

## Read in the train data
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

## Combine the three files for test data so that the subject and activity are associated to the results in one table.
test <- cbind(subject_test, y_test, X_test)

## Let's do the same now for train.
train <- cbind(subject_train, y_train, X_train)

## Now let's merge the train and test data into one complete dataset.
mergedData <- rbind(train, test)

## Subset the data for only mean and standard deviation measurements of the variables.
subsetData <- mergedData[,c(1:8,43:48,83:88,123:128,163:168,203:204,216:217,229:230,242:243,255:256,268:273,347:352,426:431,505:506,518:519,531:532,544:545)]

## Rename the activity names to be descriptive rather than coded numbers
subsetData$V1.1[subsetData$V1.1==1] <- "WALKING"
subsetData$V1.1[subsetData$V1.1==2] <- "WALKING_UPSTAIRS"
subsetData$V1.1[subsetData$V1.1==3] <- "WALKING_DOWNSTAIRS"
subsetData$V1.1[subsetData$V1.1==4] <- "SITTING"
subsetData$V1.1[subsetData$V1.1==5] <- "STANDING"
subsetData$V1.1[subsetData$V1.1==6] <- "LAYING"

## Label the variables so that our columns make sense!
colnames(subsetData) <- c("personid", "activity", "tBodyAcc-meanX", "tBodyAcc-meanY", "tBodyAcc-meanZ", "tBodyAcc-stdX", "tBodyAcc-stdY", "tBodyAcc-stdZ", "tGravityAccMeanX", "tGravityAccMeanY", "tGravityAccMeanZ", "tGravityAccStdX", "tGravityAccStdY", "tGravityAccStdZ", "tBodyAccJerkMeanX", "tBodyAccJerkMeanY", "tBodyAccJerkMeanZ", "tBodyAccJerkStdX", "tBodyAccJerkStdY", "tBodyAccJerkStdZ", "tBodyGyroMeanX", "tBodyGyroMeanY", "tBodyGyroMeanZ", "tBodyGyroStdX", "tBodyGyroStdY", "tBodyGyroStdZ", "tBodyGyroJerkMeanX", "tBodyGyroJerkMeanY", "tBodyGyroJerkMeanZ", "tBodyGyroJerkStdX", "tBodyGyroJerkStdY", "tBodyGyroJerkStdZ", "tBodyAccMagMean", "tBodyAccMagStd", "tGravityAccMagMean", "tGravityAccMagStd", "tBodyAccJerkMagMean", "tBodyAccJerkMagStd", "tBodyGyroMagMean", "tBodyGyroMagStd", "tBodyGyroJerkMagMean", "tBodyGyroJerkMagStd", "fBodyAccMeanX", "fBodyAccMeanY", "fBodyAccMeanZ", "fBodyAccStdX", "fBodyAccStdY", "fBodyAccStdZ", "fBodyAccJerkMeanX", "fBodyAccJerkMeanY", "fBodyAccJerkMeanZ", "fBodyAccJerkStdX", "fBodyAccJerkStdY", "fBodyAccJerkStdZ", "fBodyGyroMeanX", "fBodyGyroMeanY", "fBodyGyroMeanZ", "fBodyGyroStdX", "fBodyGyroStdY", "fBodyGyroStdZ", "fBodyAccMagMean", "fBodyAccMagStd", "fBodyBodyAccJerkMagMean", "fBodyBodyAccJerkMagStd", "fBodyBodyGyroMagMean", "fBodyBodyGyroMagStd","fBodyBodyGyroJerkMagMean", "fBodyBodyGyroJerkMagStd")

## Reshape the dataset to show the mean of each variable by activity for each person.
## Reshape2 library will need to be loaded for this step.
dataMelt <- melt(subsetData,id=c("personid", "activity"),measure.vars=c("tBodyAcc-meanX", "tBodyAcc-meanY", "tBodyAcc-meanZ", "tBodyAcc-stdX", "tBodyAcc-stdY", "tBodyAcc-stdZ", "tGravityAccMeanX", "tGravityAccMeanY", "tGravityAccMeanZ", "tGravityAccStdX", "tGravityAccStdY", "tGravityAccStdZ", "tBodyAccJerkMeanX", "tBodyAccJerkMeanY", "tBodyAccJerkMeanZ", "tBodyAccJerkStdX", "tBodyAccJerkStdY", "tBodyAccJerkStdZ", "tBodyGyroMeanX", "tBodyGyroMeanY", "tBodyGyroMeanZ", "tBodyGyroStdX", "tBodyGyroStdY", "tBodyGyroStdZ", "tBodyGyroJerkMeanX", "tBodyGyroJerkMeanY", "tBodyGyroJerkMeanZ", "tBodyGyroJerkStdX", "tBodyGyroJerkStdY", "tBodyGyroJerkStdZ", "tBodyAccMagMean", "tBodyAccMagStd", "tGravityAccMagMean", "tGravityAccMagStd", "tBodyAccJerkMagMean", "tBodyAccJerkMagStd", "tBodyGyroMagMean", "tBodyGyroMagStd", "tBodyGyroJerkMagMean", "tBodyGyroJerkMagStd", "fBodyAccMeanX", "fBodyAccMeanY", "fBodyAccMeanZ", "fBodyAccStdX", "fBodyAccStdY", "fBodyAccStdZ", "fBodyAccJerkMeanX", "fBodyAccJerkMeanY", "fBodyAccJerkMeanZ", "fBodyAccJerkStdX", "fBodyAccJerkStdY", "fBodyAccJerkStdZ", "fBodyGyroMeanX", "fBodyGyroMeanY", "fBodyGyroMeanZ", "fBodyGyroStdX", "fBodyGyroStdY", "fBodyGyroStdZ", "fBodyAccMagMean", "fBodyAccMagStd", "fBodyBodyAccJerkMagMean", "fBodyBodyAccJerkMagStd", "fBodyBodyGyroMagMean", "fBodyBodyGyroMagStd","fBodyBodyGyroJerkMagMean", "fBodyBodyGyroJerkMagStd"))

tidyData <- dcast(dataMelt, personid + activty ~ variable,mean)

## Now we can save this tidy data set as a text file using write.table() with row.name = FALSE
write.table(tidyData, file="./Documents/tidy_data.txt", row.names=FALSE)