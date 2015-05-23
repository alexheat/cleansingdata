# See project readme file at https://github.com/alexheat/cleansingdata

library(dplyr)
library(data.table)

#Analyze the data set downloaded from 
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

#Merges the training and the test sets to create one data set.
traindata <-read.table("train/X_train.txt")
testdata <-read.table("test/X_test.txt")
alldata <- rbind(traindata, testdata)

# To extract only the measurements on the mean and standard deviation for each measurement
# I will search for collums that have "mean" or "std" in the name
# and select only those collums 
colheaders <-fread("features.txt")
meanStdColumnsNum <- grep("mean|std", colheaders$V2, value = FALSE)
meanStdColumnsName <- grep("mean|std", colheaders$V2, value = TRUE)
setnames(alldata,meanStdColumnsNum, meanStdColumnsName)
alldata <- select(alldata, one_of(meanStdColumnsName))

# these files with the activity codes much also be combined 
trainactivity <-read.table("train/y_train.txt")
testactivity <-read.table("test/y_test.txt")
allactivity <- rbind(trainactivity, testactivity)

# to convert the activity codes to friendly names
makeActivityName <- function (i) {
  activities <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
  return(activities[i])
}

# add the activity names to the alldata table and apply the friendly names
allactivity <- mutate(allactivity, V1=makeActivityName(V1))
alldata <- cbind(allactivity, alldata)
setnames(alldata,1, "Activity")

# add the ID for the subject to the table

testsubject <-read.table("test/subject_test.txt")
allsubject <- rbind(trainsubject, testsubject)
alldata <- cbind(allsubject, alldata)
setnames(alldata, 1, "Subject")
# now step 4 of the assignment is complete

# now use dplyr grouping functions to create the tidydata
tidydata <- alldata %>% group_by(Activity, Subject) %>% summarise_each(funs(mean))
write.table(tidydata, "tidydata.txt")