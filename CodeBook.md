---
title: "CodeBook"
output: html_document
---

The TidyData.txt file contains 180 rows and 89 columns

The file is a table that is grouped by the activityDescription column and then by PersonId column, other columns contain the average values of the raw data (raw data not included)

table showing only 4 columns and 15 rows
```{r}
head(tidyData[c(1:4)],15)
```


   activityDescription | PersonId | activityNumber | timeBodyAccelerometer-mean()-X
   
LAYING        1              6                      0.2215982

SITTING        1              4                      0.2612376

STANDING        1              5                      0.2789176

WALKING        1              1                      0.2773308

WALKING_DOWNSTAIRS        1              3                      0.2891883

WALKING_UPSTAIRS        1              2                      0.2554617

LAYING        2              6                      0.2813734

SITTING        2              4                      0.2770874

STANDING        2              5                      0.2779115

WALKING        2              1                      0.2764266

WALKING_DOWNSTAIRS        2              3                      0.2776153

WALKING_UPSTAIRS        2              2                      0.2471648

LAYING        3              6                      0.2755169

SITTING        3              4                      0.2571976

STANDING        3              5                      0.2800465


##These are the column names

 [1] "activityDescription"                               
 [2] "PersonId"                                          
 [3] "activityNumber"                                    
 [4] "timeBodyAccelerometer-mean()-X"                    
 [5] "timeBodyAccelerometer-mean()-Y"                    
 [6] "timeBodyAccelerometer-mean()-Z"                    
 [7] "timeBodyAccelerometer-std()-X"                     
 [8] "timeBodyAccelerometer-std()-Y"                     
 [9] "timeBodyAccelerometer-std()-Z"                     
[10] "timeGravityAccelerometer-mean()-X"                 
[11] "timeGravityAccelerometer-mean()-Y"                 
[12] "timeGravityAccelerometer-mean()-Z"                 
[13] "timeGravityAccelerometer-std()-X"                  
[14] "timeGravityAccelerometer-std()-Y"                  
[15] "timeGravityAccelerometer-std()-Z"                  
[16] "timeBodyAccelerometerJerk-mean()-X"                
[17] "timeBodyAccelerometerJerk-mean()-Y"                
[18] "timeBodyAccelerometerJerk-mean()-Z"                
[19] "timeBodyAccelerometerJerk-std()-X"                 
[20] "timeBodyAccelerometerJerk-std()-Y"                 
[21] "timeBodyAccelerometerJerk-std()-Z"                 
[22] "timeBodyGyroscope-mean()-X"                        
[23] "timeBodyGyroscope-mean()-Y"                        
[24] "timeBodyGyroscope-mean()-Z"                        
[25] "timeBodyGyroscope-std()-X"                         
[26] "timeBodyGyroscope-std()-Y"                         
[27] "timeBodyGyroscope-std()-Z"                         
[28] "timeBodyGyroscopeJerk-mean()-X"                    
[29] "timeBodyGyroscopeJerk-mean()-Y"                    
[30] "timeBodyGyroscopeJerk-mean()-Z"                    
[31] "timeBodyGyroscopeJerk-std()-X"                     
[32] "timeBodyGyroscopeJerk-std()-Y"                     
[33] "timeBodyGyroscopeJerk-std()-Z"                     
[34] "timeBodyAccelerometerMagnitude-mean()"             
[35] "timeBodyAccelerometerMagnitude-std()"              
[36] "timeGravityAccelerometerMagnitude-mean()"          
[37] "timeGravityAccelerometerMagnitude-std()"           
[38] "timeBodyAccelerometerJerkMagnitude-mean()"         
[39] "timeBodyAccelerometerJerkMagnitude-std()"          
[40] "timeBodyGyroscopeMagnitude-mean()"                 
[41] "timeBodyGyroscopeMagnitude-std()"                  
[42] "timeBodyGyroscopeJerkMagnitude-mean()"             
[43] "timeBodyGyroscopeJerkMagnitude-std()"              
[44] "frequencyBodyAccelerometer-mean()-X"               
[45] "frequencyBodyAccelerometer-mean()-Y"               
[46] "frequencyBodyAccelerometer-mean()-Z"               
[47] "frequencyBodyAccelerometer-std()-X"                
[48] "frequencyBodyAccelerometer-std()-Y"                
[49] "frequencyBodyAccelerometer-std()-Z"                
[50] "frequencyBodyAccelerometer-meanFreq()-X"           
[51] "frequencyBodyAccelerometer-meanFreq()-Y"           
[52] "frequencyBodyAccelerometer-meanFreq()-Z"           
[53] "frequencyBodyAccelerometerJerk-mean()-X"           
[54] "frequencyBodyAccelerometerJerk-mean()-Y"           
[55] "frequencyBodyAccelerometerJerk-mean()-Z"           
[56] "frequencyBodyAccelerometerJerk-std()-X"            
[57] "frequencyBodyAccelerometerJerk-std()-Y"            
[58] "frequencyBodyAccelerometerJerk-std()-Z"            
[59] "frequencyBodyAccelerometerJerk-meanFreq()-X"       
[60] "frequencyBodyAccelerometerJerk-meanFreq()-Y"       
[61] "frequencyBodyAccelerometerJerk-meanFreq()-Z"       
[62] "frequencyBodyGyroscope-mean()-X"                   
[63] "frequencyBodyGyroscope-mean()-Y"                   
[64] "frequencyBodyGyroscope-mean()-Z"                   
[65] "frequencyBodyGyroscope-std()-X"                    
[66] "frequencyBodyGyroscope-std()-Y"                    
[67] "frequencyBodyGyroscope-std()-Z"                    
[68] "frequencyBodyGyroscope-meanFreq()-X"               
[69] "frequencyBodyGyroscope-meanFreq()-Y"               
[70] "frequencyBodyGyroscope-meanFreq()-Z"               
[71] "frequencyBodyAccelerometerMagnitude-mean()"        
[72] "frequencyBodyAccelerometerMagnitude-std()"         
[73] "frequencyBodyAccelerometerMagnitude-meanFreq()"    
[74] "frequencyBodyAccelerometerJerkMagnitude-mean()"    
[75] "frequencyBodyAccelerometerJerkMagnitude-std()"     
[76] "frequencyBodyAccelerometerJerkMagnitude-meanFreq()"
[77] "frequencyBodyGyroscopeMagnitude-mean()"            
[78] "frequencyBodyGyroscopeMagnitude-std()"             
[79] "frequencyBodyGyroscopeMagnitude-meanFreq()"        
[80] "frequencyBodyGyroscopeJerkMagnitude-mean()"        
[81] "frequencyBodyGyroscopeJerkMagnitude-std()"         
[82] "frequencyBodyGyroscopeJerkMagnitude-meanFreq()"    
[83] "angle(timeBodyAccelerometerMean,gravity)"          
[84] "angle(timeBodyAccelerometerJerkMean),gravityMean)" 
[85] "angle(timeBodyGyroscopeMean,gravityMean)"          
[86] "angle(timeBodyGyroscopeJerkMean,gravityMean)"      
[87] "angle(X,gravityMean)"                              
[88] "angle(Y,gravityMean)"                              
[89] "angle(Z,gravityMean)"