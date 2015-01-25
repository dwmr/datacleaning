#declare function that checks if a package is installed - 
#used to ensure needed packages are available
is.installed <- function(mypkg) is.element(mypkg, installed.packages()[,1])

#check if the plyr package is installed - install if not - then load the package
if (!is.installed('plyr')) install.package('plyr')
library('plyr')

#check if the data.table package is installed - install if not - then load the package
if (!is.installed('data.table')) install.package('data.table')
library('data.table')

#forget looking for a local copy of the data - download it fresh
localFile <- 'dataset.zip'
fileURL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(fileURL,destfile=localFile, mode='wb', method='curl') #On Windows remove method='curl' argument
downloadDate <- date()

#unzip and overwrite to be sure we're working with the data we expect.
unzip(localFile, overwrite=TRUE)#Forget lookig for a local copy of the data - download it fresh

#create index vector for the (mean and std.dev) variables we are interested in
colsToKeep <- c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,
                266:271,294:296,345:350,373:375,424:429,452:454,503:504,513,516:517,526,
                529:530,539,542:543,552)

#read in the variabe names/headers and subset to desired set
csvFile <- 'UCI HAR Dataset/features.txt'
colNames <- read.csv(csvFile, head=FALSE, sep=' ')

#read in the activity indicator for the test set:
csvFile <- 'UCI HAR Dataset/test/y_test.txt'
activityIDs <- read.csv(csvFile, head=FALSE, sep=' ')

#load activity labels:
csvFile <- 'UCI HAR Dataset/activity_labels.txt'
activityLabels <- read.csv(csvFile, head=FALSE, col.names=c('id','label'), sep=' ')

#read in the subject IDs for the test set:
csvFile <- 'UCI HAR Dataset/test/subject_test.txt'
subjectIDs <- read.csv(csvFile, head=FALSE, sep=' ')

#read in the test set - req. data.table package to be installed
csvFile <- 'UCI HAR Dataset/test/X_test.txt'
testSet <- read.table(csvFile)

#Subset the test data to the desired cols.
testSet <- testSet[,colsToKeep]

#Bind subject and activity data to left of test set as new col.
testSet <- cbind(subjectIDs,activityIDs,testSet)

#Prepare the header for the dataset
dataHeader <- as.character(colNames[colsToKeep,2])  #Remove unneeded cols.
dataHeader <- c('subject_id','activity',dataHeader) #Add new ID cols.

#Add the header
names(testSet) <- dataHeader

#Set activity lables on ID (id treated as levels in a factor)
testSet$activity <- factor(testSet$activity, levels=activityLabels$id, labels=activityLabels$label)

#read in the activity indicator for the training set:
csvFile <- 'UCI HAR Dataset/train/y_train.txt'
activityIDs <- read.csv(csvFile, head=FALSE, sep=' ')

#read in the subject IDs for the training set:
csvFile <- 'UCI HAR Dataset/train/subject_train.txt'
subjectIDs <- read.csv(csvFile, head=FALSE, sep=' ')

#read in the training set 
csvFile <- 'UCI HAR Dataset/train/X_train.txt'
trainSet <- read.table(csvFile)

#Subset the training data to the desired cols.
trainSet <- trainSet[,colsToKeep]

#Bind subject and activity data to left of training set as new col.
trainSet <- cbind(subjectIDs,activityIDs,trainSet)

#Add the header
names(trainSet) <- dataHeader

#Set activity lables on ID (id treated as levels in a factor)
trainSet$activity <- factor(trainSet$activity, levels=activityLabels$id, labels=activityLabels$label)

#Merge sets - use rbind.fill from plyr because it is faster
fullSet <- rbind.fill(testSet,trainSet)

#Convert subject ID to factor - because that is how we will treat it
fullSet$subject_id <- factor(fullSet$subject_id)

#Convert data.frame to data.table so we can use the handy summarizing functions
fullSet <- data.table(fullSet)

#Summarize table:
summarizedData <- fullSet[,lapply(.SD,mean), by=list(subject_id,activity)]

#Write tidy data to csv:
write.table(summarizedData, 'tidy_data.txt', sep=',', row.names=FALSE)



