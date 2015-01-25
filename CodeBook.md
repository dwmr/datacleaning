Codebook:
=========

This codebook applies to the data found in the 'tidy_data.csv' file.

The 'tidy_data.csv' dataset is a summarized version of the test and training datasets taken from the UCI HAR data and integrates the training and test set files along with their respective activity and subject files.

With the exception of the activity variable (values for which are strings/categorical), all variable values are numeric.  The subject_id variable is numeric but is intended to function as a categorical variable.  All remaining variable values are continuous numeric values.  Each of these continuous numeric values is a mean calculated for the given variable (from the original UCI HAR data) within its subject-activity group (i.e. each variable is summarized as an average within each distinct subject_id and activity combination).

Variables:
==========

There are 81 variables in the dataset. 

2 Categorical variables:

* subject_id	
* activity	

79 continuous numeric variables - which are summarized signal data taken from the Samsung Galaxy S II.  These signal variables are named according to the following convention:

signalName-statistic-axis

Where 'statistic' is either mean() or std() (standard deviation), and 'axis' is one of 'X', 'Y' or 'Z'.  (Axis is not present for all variables.)

Signal names are:
-----------------

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag
* gravityMean
* tBodyAccMean
* tBodyAccJerkMean
* tBodyGyroMean
* tBodyGyroJerkMean

