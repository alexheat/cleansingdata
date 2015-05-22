# Assignment Readme and Code Book
For Coursera Getting and Cleaning Data class assignment.

## Overview
The project involves combining multiple text files into one dataset, arranging the table, and then creating a new table that summarizes the data as the final output. (tidydata.txt)

The data in this assignment is motion sensor readings from a smartphone. You can read about the data here [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones][1] and you can download the data here [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip][2]

It is not necessary to understand the data to complete the assignment, though I briefly explain it in the Code Book section below.

## Summary of run_analysis.R script
In Dataset.zip there are 8 files that you need to use. The data is broken into training and test datasets and you need to combine all of the files below into one dataset.

 - features.txt (Stores the collum names for the X_ files)
 - activity_labels.txt (List of friendly activity names,such as "Walking")
 - train/X_train.txt (This is the main data files)
 - train/y_train.txt (Index of activity names from 1-6 that correspond to the activities in activity_labels.txt. These needs to be added as a column to the X_train.txt)
 - train/subject_train.txt (Numeric index that corresponds to the study participants. These needs to be added as a column to the X_train.txt)
 - test/X_test.txt (This is the main data files)
 - test/y_test.txt (Index of activity names from 1-6 that correspond to the activities in activity_labels.txt. These needs to be added as a column to the X_test.txt)
 - test/subject_test.txt (Numeric index that corresponds to the study participants. X_test.txt. These needs to be added as a column to the X_test.txt)

run_analysis.R performs the following actions on the data in the above files. I used dplyr functions as much as I could.

 - Reads X_train.txt & X_test.txt and combines into a single data.table called alldata
 - Reads features.txt and saves as vector colheaders
 - Search for columns with search that have "mean" or "std" in the name and use those as names for the columns in all data
 - select the columns that we have named and assign them back to alldata. Now alldata will only have 79 columns 
 - Then read the files that have the subject and activity collums and add them to alldata as new columns on the left side of the table.

Now you should have an alldata table with 10,299 rows and 81 columns.

Next we want to calculate the average of each variable, for each subject, and each activity--and save in a new tidydata table.

You can this very simply with one line of code using dpylr funtions

    alldata %>% group_by(Activity, Subject) %>% summarise_each(funs(mean))

Then I saved the output to tidydata.txt

## Code Book describing tidydata.txt

Full list of columns in output table

1.     Activity
2.	Subject
3.	tBodyAcc-mean()-X
4.	tBodyAcc-mean()-Y
5.	tBodyAcc-mean()-Z
6.	tBodyAcc-std()-X
7.	tBodyAcc-std()-Y
8.	tBodyAcc-std()-Z
9.	tGravityAcc-mean()-X
10.	tGravityAcc-mean()-Y
11.	tGravityAcc-mean()-Z
12.	tGravityAcc-std()-X
13.	tGravityAcc-std()-Y
14.	tGravityAcc-std()-Z
15.	tBodyAccJerk-mean()-X
16.	tBodyAccJerk-mean()-Y
17.	tBodyAccJerk-mean()-Z
18.	tBodyAccJerk-std()-X
19.	tBodyAccJerk-std()-Y
20.	tBodyAccJerk-std()-Z
21.	tBodyGyro-mean()-X
22.	tBodyGyro-mean()-Y
23.	tBodyGyro-mean()-Z
24.	tBodyGyro-std()-X
25.	tBodyGyro-std()-Y
26.	tBodyGyro-std()-Z
27.	tBodyGyroJerk-mean()-X
28.	tBodyGyroJerk-mean()-Y
29.	tBodyGyroJerk-mean()-Z
30.	tBodyGyroJerk-std()-X
31.	tBodyGyroJerk-std()-Y
32.	tBodyGyroJerk-std()-Z
33.	tBodyAccMag-mean()
34.	tBodyAccMag-std()
35.	tGravityAccMag-mean()
36.	tGravityAccMag-std()
37.	tBodyAccJerkMag-mean()
38.	tBodyAccJerkMag-std()
39.	tBodyGyroMag-mean()
40.	tBodyGyroMag-std()
41.	tBodyGyroJerkMag-mean()
42.	tBodyGyroJerkMag-std()
43.	fBodyAcc-mean()-X
44.	fBodyAcc-mean()-Y
45.	fBodyAcc-mean()-Z
46.	fBodyAcc-std()-X
47.	fBodyAcc-std()-Y
48.	fBodyAcc-std()-Z
49.	fBodyAcc-meanFreq()-X
50.	fBodyAcc-meanFreq()-Y
51.	fBodyAcc-meanFreq()-Z
52.	fBodyAccJerk-mean()-X
53.	fBodyAccJerk-mean()-Y
54.	fBodyAccJerk-mean()-Z
55.	fBodyAccJerk-std()-X
56.	fBodyAccJerk-std()-Y
57.	fBodyAccJerk-std()-Z
58.	fBodyAccJerk-meanFreq()-X
59.	fBodyAccJerk-meanFreq()-Y
60.	fBodyAccJerk-meanFreq()-Z
61.	fBodyGyro-mean()-X
62.	fBodyGyro-mean()-Y
63.	fBodyGyro-mean()-Z
64.	fBodyGyro-std()-X
65.	fBodyGyro-std()-Y
66.	fBodyGyro-std()-Z
67.	fBodyGyro-meanFreq()-X
68.	fBodyGyro-meanFreq()-Y
69.	fBodyGyro-meanFreq()-Z
70.	fBodyAccMag-mean()
71.	fBodyAccMag-std()
72.	fBodyAccMag-meanFreq()
73.	fBodyBodyAccJerkMag-mean()
74.	fBodyBodyAccJerkMag-std()
75.	fBodyBodyAccJerkMag-meanFreq()
76.	fBodyBodyGyroMag-mean()
77.	fBodyBodyGyroMag-std()
78.	fBodyBodyGyroMag-meanFreq()
79.	fBodyBodyGyroJerkMag-mean()
80.	fBodyBodyGyroJerkMag-std()
81.	fBodyBodyGyroJerkMag-meanFreq()
