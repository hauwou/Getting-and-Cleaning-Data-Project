install.packages("reshape")
library(data.table)
library(dplyr)
library (reshape)

rm(list=ls())

# Load files and variables
featureNames <- read.table("features.txt") #Data frame contains 561 rows, each is a data variable/feature name
#class(featureNames)
activityLabels <- read.table("activity_labels.txt", header = FALSE) #sitting, standing, etc... 

subjectTrain <- read.table("train/subject_train.txt", header = FALSE) #(Training set) table of training set subjects, a number 30 mean subject #30 (21 total subjects/people)
yTrain <- read.table("train/y_train.txt", header = FALSE) #(Training set) table of activity labels, each row is a number that correspond to 1 of 6 activities: sitting, walking, etc...
xTrain <- read.table("train/X_train.txt", header = FALSE) #(Training set) table of 561 columns of data of collected, each row corresponds to data recorded for an activity: sitting, walking, etc..
# dim(xTrain) 
# dim(subjectTrain)
# dim(yTrain)

subjectTest <- read.table("test/subject_test.txt", header = FALSE) #(Testing set) table of test set subjects, a number 2 mean subject #2 (9 total subjects/people)
yTest <- read.table("test/y_test.txt", header = FALSE) #(Testing set) table of activity labels, each row is a number that correspond to 1 of 6 activities: sitting, walking, etc...
xTest <- read.table("test/X_test.txt", header = FALSE) #(Testing set) table of 561 columns of data of collected, each row corresponds to data recorded for an activity: sitting, walking, etc.. 
# dim(xTest) 
# dim(subjectTest)
# dim(yTest)
# head(xTest)

# The data set is organized according to the logic as below:
# Test set files example:
# The subject_test text file contains 1 column of 9 people
# The first 302 rows of subject_test text file is person #2, the second 317 rows is person #4, etc...
# The y_test text file contains 1 column of the ACTIVITIES of 9 people
# For example, the first 302 rows contain the activities of person #2
# The sequence of activities is: 5,4,6,1,3,2,5,4,6,1,3,2
# Which corresponds to: standing (5) -> sitting (4) -> laying (6) -> walking (1) -> walking downstairs (3)
# -> walking upstairs(2) -> standing (5) -> sitting (4) -> laying (6) 
# -> walking (1) -> walking downstairs (3) -> walking upstairs (2)
# The X_test text file is very large, it contains the values of the 561 features 
# For example: row 1 contains the data values for person #2 when standing, row 32 
# contains the data values for person #2 when sitting


# Q1. Merge the training and the test sets 
subjectTotal <- rbind(subjectTrain, subjectTest)
yTotal <- rbind(yTrain, yTest)
xTotal <- rbind(xTrain, xTest)
#head(subjectTotal)
# dim(subjectTotal) #10299 rows
# dim(yTotal) #10299 rows
# dim(xTotal) #10299 rows, 561 columns
colnames(xTotal)<-featureNames[,2] #apply the feature names to xTotal
#head(xTotal,2)
colnames(yTotal)<-"activityType"
#head(yTotal,100)
colnames(subjectTotal)<-"PersonId"
#head(subjectTotal)



completeTable<- cbind(subjectTotal,yTotal,xTotal)
#head(completeTable,1)
#colnames(completeTable)


# Q2. Extracts only the measurements on the mean and standard deviation for each measurement.
filteredColsNames <- grep(".*mean.*|.*std.*", colnames(completeTable), ignore.case=TRUE)
filteredColsNames # a vector of column index
filteredColsNames <- c(1,2,filteredColsNames)
filteredTable <- completeTable[,filteredColsNames]
#colnames(filteredTable)


# Q3. Uses descriptive activity names to name the activities in the data set
# replace the numbers in column 2 (ativityType) with walking, sitting, etc...

# x <- merge(activityLabels,filteredTable,by.x="V1",by.y="activityType",all.x=TRUE)
# rm(x)
# head(filteredTable,11)
# head(x,10)
# tail(x,10)
# dim(x);dim(filteredTable)
# head(x[,c(1,2,3,89)])
# colnames(x[c(1,3)])
# colnames(filteredTable)
# library(data.table)
# setnames(x, old = c('V1','V2'), new = c('activityNumber','activityDescription'))
# colnames(x)
# data.table(x)


filteredTable <- merge(activityLabels,filteredTable,by.x="V1",by.y="activityType",all.x=TRUE)
library(data.table)
setnames(filteredTable, old = c('V1','V2'), new = c('activityNumber','activityDescription'))



# Q4. Appropriately labels the data set with descriptive names.
# use gsub to find and replace column names

colnames(filteredTable) <- gsub("tBody", "timeBody", colnames(filteredTable))
colnames(filteredTable) <- gsub("fBody", "frequencyBody", colnames(filteredTable))
colnames(filteredTable) <- gsub("Acc", "Accelerometer", colnames(filteredTable))
colnames(filteredTable) <- gsub("Gyro", "Gyroscope", colnames(filteredTable))
colnames(filteredTable) <- gsub("BodyBody", "Body", colnames(filteredTable))
colnames(filteredTable) <- gsub("Mag-", "Magnitude-", colnames(filteredTable))
colnames(filteredTable) <- gsub("tGravity","timeGravity", colnames(filteredTable))
#colnames(filteredTable)

# Q5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
str(filteredTable) #10299 obs of 89 variables
filteredTable$activityNumber <- as.factor(filteredTable$activityNumber)
filteredTable$PersonId <- as.factor(filteredTable$PersonId)
#data.table(filteredTable[c(1,2,3,4)])

tidyData <- aggregate( .~ activityDescription + PersonId , data=filteredTable, FUN=mean)
# str(tidyData) #180 obs of 89 variables, 30 person x 6 activities = 180
# the statement above says the following:
# I want to aggregate (aka group) rows based on unique values in the PersonId and activityDescription columns in the filteredTable data source.
# Then, I want to apply the mean function to each column of each aggregated group (excluding the columns used for aggregation, of course)
# The format of the ".~PersonId + columnName" expression means: the "." means apply the mean function to every column in the table (excluding the columns used for aggregation, of course)
# The order of the "PersonId + activityDescription" does matter to the output, in this example, the output table will
# be arranged/ordered by the PersonId first and then by activity
# If switch to "activityDescription+PersonId", the output will be ordered by the activity, then personId


#tidyData <- aggregate( .~PersonId , data=filteredTable, FUN=mean)
#str(tidyData) #30 obs of 89 variables, 30 persons = 30 obs
#There are only 30 obs because the statement only grouped on the PersonId column, there are 30 unique persons

# head(tidyData[c(1:4)],40)
# head(tidyData,1)
#colnames(tidyData)

write.table(tidyData, file = "TidyData.txt", row.names=F)
