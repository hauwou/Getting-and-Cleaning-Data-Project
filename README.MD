---
title: "README.MD"
output: html_document
---

# Getting and Cleaning Data Course Project

To run, type in R -->   source("run_analysis.R")

## Requirements:
You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement.

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive activity names.

5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.



###Download and unzip original data source https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


## The data set is organized according to the logic as below:

Test set files example:

The subject_test text file contains 1 column of 9 people. The first 302 rows of subject_test text file is person #2, the second 317 rows is person #4, etc...

The y_test text file contains 1 column of the ACTIVITIES of 9 people.
For example, the first 302 rows contain the activities of person #2
The sequence of activities is: 5,4,6,1,3,2,5,4,6,1,3,2, which corresponds to: standing (5) -> sitting (4) -> laying (6) -> walking (1) -> walking downstairs (3) -> walking upstairs(2) -> standing (5) -> sitting (4) -> laying (6) 
-> walking (1) -> walking downstairs (3) -> walking upstairs (2)

The X_test text file is very large, it contains the values of the 561 features 
For example: row 1 contains the data values for person #2 when standing, row 32 
contains the data values for person #2 when sitting

## Q1. Merge the training and the test sets

using rbind (rowbind) to merge training and test data sets

assign column names using colnames() function

using cbind to merge the 3 dataframes into 1 complete table

***See code for details



## Q2. Extracts only the measurements on the mean and standard deviation for each measurement.

use grep to extract the column names that match against "mean or std"

grep will return a data frame that contain only the column indexes of the match

grepl (l stands for LOGICAL) will return a true/false dataframe, I prefer the grep()

apply the filtered column indexes to the complete-table to subset out the table of desired columns

**see code for details

## Q3. Uses descriptive activity names to name the activities in the data set

This is asking to replace the numerical values of the activities column with the descriptive activity words (sitting, standing, etc...) 

use the merge function to merge the resulting table in step 2 with the activity label table 

The merged table will get jumbled.  It probably would be less confusing to use a loop or (apply) to match and switch out numbers with descriptions (during the steps of question 1)

***see code for details

## Q4. Appropriately labels the data set with descriptive variable names.

use gsub to replace abbreviations with clear wordings in the column names

*** see code for details

## Q5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The table obtained in question 4 has 10299 observations (or rows) with 89 variables (columns)

First, convert the activityDescription and PersonId columns to factors (as.factor)

Use the aggregate() function to aggregate (aka group by) activityDescription and then by PersonId 

Then write to file.

### Explanation of the aggregate statement

tidyData <- aggregate( .~ activityDescription + PersonId , data=filteredTable, FUN=mean)

str(tidyData) has 180 obs of 89 variables, 30 person x 6 activities = 180

the aggregate statement above says the following:

I want to aggregate (aka group) rows first based on unique values in the activityDescription and then by PersonId columns in the filteredTable data source.

Then, I want to apply the mean function to each column of each aggregated group (excluding the columns used for aggregation, of course)

The format of the ".~PersonId + columnName" expression means: the "." means apply the mean function to every column in the table (excluding the columns used for aggregation, of course)

The order of the "PersonId + activityDescription" does matter to the output, in this example, the output table will be arranged/ordered by the PersonId first and then by activity

If switch to "activityDescription+PersonId", the output will be ordered by the activity, then personId


