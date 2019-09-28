setwd("D:/Coursera/Data Science - Specialization (by Johns Hopkins University)/3-Getting and Cleaning Data/Assignment")
library(dplyr)
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, "./Dataset.zip")
Unzip("./Dataset.zip")
list.files("./UCI HAR Dataset", recursive = TRUE)

## Read all of tables.
features <- read.table("./UCI HAR Dataset/features.txt", col.names = c("No", "Functions"))
activities <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("Code", "Activity"))
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features$Functions)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "Code")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "Subject")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features$Functions)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "Code")

## Step 1: Merges the training and the test sets to create one data set.
MergeX <- rbind(x_train, x_test)
MergeY <- rbind(y_train, y_test)
MergeSubj <- rbind(subject_train, subject_test)
MergeData <- cbind(MergeSubj, MergeY, MergeX)

## Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
ExtractData <- MergeData %>% select(Subject, Code, contains("mean"), contains("std"))

## Step 3: Uses descriptive activity names to name the activities in the data set.
ExtractData$Code <- activities[ExtractData$Code, 2]

## Step 4: Appropriately labels the data set with descriptive variable names.
names(ExtractData)[2] = "Activity"
names(ExtractData)<-gsub("Acc", "Accelerometer", names(ExtractData))
names(ExtractData)<-gsub("Gyro", "Gyroscope", names(ExtractData))
names(ExtractData)<-gsub("BodyBody", "Body", names(ExtractData))
names(ExtractData)<-gsub("Mag", "Magnitude", names(ExtractData))
names(ExtractData)<-gsub("^t", "Time", names(ExtractData))
names(ExtractData)<-gsub("^f", "Frequency", names(ExtractData))
names(ExtractData)<-gsub("tBody", "TimeBody", names(ExtractData))
names(ExtractData)<-gsub("-mean()", "Mean", names(ExtractData), ignore.case = TRUE)
names(ExtractData)<-gsub("-std()", "STD", names(ExtractData), ignore.case = TRUE)
names(ExtractData)<-gsub("-freq()", "Frequency", names(ExtractData), ignore.case = TRUE)
names(ExtractData)<-gsub("angle", "Angle", names(ExtractData))
names(ExtractData)<-gsub("gravity", "Gravity", names(ExtractData))

## Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
TidyData <- ExtractData %>% group_by(Subject, Activity) %>% summarize_all(funs(mean))
write.table(TidyData, "./TidyData.txt", row.name=FALSE)
