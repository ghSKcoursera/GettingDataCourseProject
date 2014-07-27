###############################################################################
##### Important Note:                                                         #
#####   Make sure the files have been downloaded and extracted and that you   #
#####   are in its root directory along with the original dataset ReadMe.txt  #
###############################################################################

library(plyr)
library(reshape2)

#####  Read in the raw data files for test and train groups #####

# Read in the test subjects and the train subjects (subject_test.txt and subject_train.txt)
subjectsTest  <- read.table("./test/subject_test.txt")
subjectsTrain <- read.table("./train/subject_train.txt")
# Read in the test results and the train results  (x_test.txt and x_train.txt)
measurementsTest  <- read.table("./test/X_test.txt")
measurementsTrain <- read.table("./train/X_train.txt")
# Read in the test activities and the train activities  (y_test.txt and y_train.txt)
activitiesTest  <- read.table("./test/y_test.txt")
activitiesTrain <- read.table("./train/y_train.txt")

##### Combine these files into one dataset (Step 1 in the Course Project Instructions) #####

## Preprocessing to prepare for merge: merge test and train data for subjects, measurements, and activities
# Combine the test and train subjects
subjectsTable <- rbind(subjectsTest, subjectsTrain)
# Combine the test and train measurements
measurementsTable <- rbind(measurementsTest, measurementsTrain)
# Combine the test and train activities
activitiesTable <- rbind(activitiesTest, activitiesTrain)

## Preprocessing to prepare for merge: column headers, mean and standard deviation measurements, and activity description substitutions
# Provide a more descriptive column heading of subjectID
colnames(subjectsTable) <- "subjectID"
# Read in the features listings for use as column headings for measurements data
featuresTable <- read.table("./features.txt")
colnames(measurementsTable) <- featuresTable[, 2]
# Extract only the mean and standard deviation std data from the measurements (Step 2 in the Course Project Instructions)
measurementMeanSTDColums <- grepl("mean()",colnames(measurementsTable)) | grepl("std()",colnames(measurementsTable))
measurementsTable <- measurementsTable[, measurementMeanSTDColums]
# Read in the activity labels listings and replace numeric representations in activities data using 'V1' as 'id' (Step 3 in the Course Project Instructions)
activityLabelsTable <- read.table("./activity_labels.txt")
activitiesTable <- join(activitiesTable,activityLabelsTable)
# Convert activities to factor to map in values from activity labels
activity <- as.factor(activitiesTable[,1])
activity <- mapvalues(activity,from = as.character(activityLabelsTable[,1]), to = as.character(activityLabelsTable[,2]))
# Tidy up the column headers in the measurement data
names(measurementsTable) <- gsub("BodyBody","Body", names(measurementsTable))
names(measurementsTable) <- gsub("-","", names(measurementsTable))
  
# Combine (left to right) the subject, activities, and measurements datasets into one
activityRecognition <- cbind(subjectsTable, activity, measurementsTable)
# head(activityRecognition)

##### Create a second, independent tidy data set with the average of each variable for each activity and each subject (Step 1 in the Course Project Instructions) #####

# Reshape the data by melting the file down by subject and activity, then set the means for each variable
averageActivity <- melt(activityRecognition, id=c("subjectID","activity"))
averageActivity <- dcast(averageActivity, subjectID+activity ~ variable, mean)

# Write to tab separated .txt file without the row numbers for uploading to Coursera (as per David Hood)
write.table(file = "Step5TidyDataset.txt",x = averageActivity, sep = "\t", row.names = F)

