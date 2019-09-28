# Code Book
Describe the variables of the Getting and Cleaning Assignment Project.

## run_analysis.R 
Perform the data preparation and then followed by the 5 steps in according to the course project’s instructions.

## Assign each data to variables
* features <- features.txt (561 rows, 2 columns): The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
* activities <- activity_labels.txt (6 rows, 2 columns): List of activities performed when the corresponding measurements were taken and its codes (labels)
* subject_test <- test/subject_test.txt (2947 rows, 1 column): Contains the test data of 9/30 volunteer test subjects being observed
* x_test <- test/X_test.txt (2947 rows, 561 columns): Contains the recorded features test data
* y_test <- test/y_test.txt (2947 rows, 1 columns): Contains the test data of activities’code labels
* subject_train <- test/subject_train.txt (7352 rows, 1 column): Contains train data of 21/30 volunteer subjects being observed
* x_train <- test/X_train.txt (7352 rows, 561 columns): Contains recorded features train data
* y_train <- test/y_train.txt (7352 rows, 1 columns): Contains train data of activities’code labels

## Merges the training and the test sets to create one data set
* MergeX (10299 rows, 561 columns) is created by merging x_train and x_test using rbind() function.
* MergeY (10299 rows, 1 column) is created by merging y_train and y_test using rbind() function.
* MergeSubj (10299 rows, 1 column) is created by merging subject_train and subject_test using rbind() function.
* MergeData (10299 rows, 563 column) is created by merging Subject, MergeY and MergeX using cbind() function.

## Extracts only the measurements on the mean and standard deviation for each measurement
ExtractData (10299 rows, 88 columns) is created by 
1. Subset MergeData
2. Select only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

## Uses descriptive activity names to name the activities in the data set
Entire numbers in code column of the TidyData replaced with corresponding activity taken from second column of the activities variable

## Appropriately labels the data set with descriptive variable names
code column in ExtractData renamed into activities
* All Acc in column’s name replaced by Accelerometer
* All Gyro in column’s name replaced by Gyroscope
* All BodyBody in column’s name replaced by Body
* All Mag in column’s name replaced by Magnitude
* All start with character f in column’s name replaced by Frequency
* All start with character t in column’s name replaced by Time

## Tidy up the data
Creates a second, independent tidy data set with the average of each variable for each activity and each subject
TidyData (180 rows, 88 columns) is created by summarizing ExtractData taking the means of each variable for each activity and each subject, after groupped by subject and activity.
Export TidyData into TidyData.txt file.
