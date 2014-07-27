## ReadMe for Supporting the run_analysis.R Program

Important: Make sure the files have been downloaded and extracted and that your working directory is set to that location (ReadMe.txt is in that directory)

## Original Course Project Instructions:
* Getting & Cleaning Data Course Project Instructions.md contains the instructions as well as the links to the original dataset instructions, downloads, and project details

## Original Data (not kept in the repository, but crucial to the program):
For additional detail on the original datasets, please refer to the Getting & Cleaning Data Course Project Instructions.md file in the repository
* subject_test.txt		contains the subject index into the measurements of the 'test' group (x_test.txt and y_test.txt)
* x_test.txt 			contains the measurements of the 'test' group
* y_test.txt			contains the activities performed in the measurements of the 'test' group 
* subject_train.txt		contains the Subject index into the measurements of the 'train' group (x_train.txt and y_train.txt)
* x_train.txt 			contains the measurements of the 'train' group
* y_train.txt			contains the activities performed in the measurements of the 'train' group 
* activity_labels.txt	contains the labels for the numeric activities in the y_test.txt and y_train.txt files
* features.txt			contains a list of the measurements that will be used as column headers		
* ReadMe.txt			contains details about these original files and datasets

## Generated Dataset:
Step5TidyData.txt		contains the averages for each subject by activity and can be opened or read as a tab-delimited text file

## Code Book:
* CodeBook.md			contains all newly generated variable names

## How the Script Works

1. Step Goal: to create a file that combines the test and train measurements for each subject 
	* Read in the test subjects and the train subjects (subject_test.txt and subject_train.txt)
	* Read in the test measurements and the train results  (x_test.txt and x_train.txt)
	* Read in the test activities and the train activities  (y_test.txt and y_train.txt)
	* Combine these files into one dataset for subjects, measurements, and activities
	* Create the new field subjectID to identify the subjects for each measurement (in the first column)
	* Read in the features.txt file to 
1. Step Goal: to extract only the measurements for mean and standard deviation
	* Read in the features listings for use as column headings for measurements data
	* Grep for the columns containing headers with mean and standard deviation
1. Step Goal: replace numeric activity values with the descriptive activity names in the data set
	* Read in the activity labels listings and replace numeric representations in activities data
	* Convert activities to factor to map in values from activity labels
1. Step Goal: label the data set with descriptive variable names 
	* Tidy up the column headers in the measurement data
1. Step Goal: create a second, independent tidy data set with the average of each variable for each activity and each subject
	* Reshape the data by melting the file down by subject and activity, then set the means for each variable
	* Write to tab separated .txt file without the row numbers for uploading to Coursera (as per David Hood)