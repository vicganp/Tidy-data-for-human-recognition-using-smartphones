library(dplyr)

# Loading activity labels
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activityId", "activityLabel"))
activities[2, 2] <- "WALKING UPSTAIRS"
activities[3, 2] <- "WALKING DOWNSTAIRS"

# Loading the training labels and test labels
training_labels <- read.table("UCI HAR Dataset/train/y_train.txt")
test_labels <- read.table("UCI HAR Dataset/test/y_test.txt")

# Converting to factors
training_labels$V1 <- as.factor(training_labels$V1)
test_labels$V1 <- as.factor(test_labels$V1)

# Modifying levels
levels(training_labels$V1) <- activities$activityLabel
levels(test_labels$V1) <- activities$activityLabel

# Loading features
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("featuresId", "featuresNames"))

# Loading subjects
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Selecting features by mean and standard deviation
MeanAndStd <- grep("(mean|std)\\(\\)", features$featuresNames)

# Loading Training set
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")

# Cleaning column names and extracting columns
colnames(x_train) <- features$featuresNames 
colnames(x_train) <- gsub("-", " ", colnames(x_train))
colnames(x_train) <- gsub("\\(", " ", colnames(x_train))
colnames(x_train) <- gsub("\\)", "", colnames(x_train))
trainingSet <- subset(x_train, select = MeanAndStd)

# Loading Test set
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")

# Cleaning column names and extracting columns
colnames(x_test) <- features$featuresNames 
colnames(x_test) <- gsub("-", " ", colnames(x_test))
colnames(x_test) <- gsub("\\(", " ", colnames(x_test))
colnames(x_test) <- gsub("\\)", "", colnames(x_test))
testSet <- subset(x_test, select = MeanAndStd)


# Complete Train data
trainSubjects <- cbind(subject_train, training_labels$V1)
trainSubjects$trial <- "Train"
colnames(trainSubjects) <- c("Subject", "Activity", "Trial")
trainData <- cbind(trainSubjects, trainingSet)

# Complete Test data
testSubjects <- cbind(subject_test, test_labels$V1)
testSubjects$trial <- "Test"
colnames(testSubjects) <- c("Subject", "Activity", "Trial")
testData <- cbind(testSubjects, testSet)

# Complete merged data
completeData <- rbind(trainData, testData)

# Independent tidy data set
s <- filter(completeData, Subject == 1) %>% group_by(Activity) %>% summarise(across(c(3:68), mean))
Subject <- c(1,1,1,1,1,1)
tidyDataSet <- cbind(Subject, s)

for(i in 2:30){
  s <- filter(completeData, Subject == i) %>% group_by(Activity) %>% summarise(across(c(3:68), mean))
  Subject <- rep(i, 6)
  tidyDataSet <- rbind(tidyDataSet, cbind(Subject, s))
}

write.table(tidyDataSet, file = "tidyDataSet.txt", row.names = FALSE )



