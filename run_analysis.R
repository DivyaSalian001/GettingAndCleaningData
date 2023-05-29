library(dplyr)

# Checking if the file already exists.

filename <- "getdata_projectfiles_UCI_HAR_Dataset.zip"

if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}

# Checking if folder exists
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}


# Merges the training and the test sets to create one data set.
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))

activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

# Test set
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")


# Training set
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")


X_data <- rbind(x_train, x_test)
Y_data <- rbind(y_train, y_test)
Subject_data <- rbind(subject_train, subject_test)
Merged_data <- cbind(Subject_data, Y_data, X_data)

# Extracts only the measurements on the mean and standard deviation for each measurement. 
Tidy_data <- Merged_data %>% select(subject, code, contains("mean"), contains("std"))

# Uses descriptive activity names to name the activities in the data set
Tidy_data$code <- activities[Tidy_data$code, 2]

# Appropriately labels the data set with descriptive variable names. 
names(Tidy_data)[2] = "activity"
names(Tidy_data)<-gsub("Acc", "Accelerometer", names(Tidy_data))
names(Tidy_data)<-gsub("Gyro", "Gyroscope", names(Tidy_data))
names(Tidy_data)<-gsub("BodyBody", "Body", names(Tidy_data))
names(Tidy_data)<-gsub("Mag", "Magnitude", names(Tidy_data))
names(Tidy_data)<-gsub("^t", "Time", names(Tidy_data))
names(Tidy_data)<-gsub("^f", "Frequency", names(Tidy_data))
names(Tidy_data)<-gsub("tBody", "TimeBody", names(Tidy_data))
names(Tidy_data)<-gsub("-mean()", "Mean", names(Tidy_data), ignore.case = TRUE)
names(Tidy_data)<-gsub("-std()", "STD", names(Tidy_data), ignore.case = TRUE)
names(Tidy_data)<-gsub("-freq()", "Frequency", names(Tidy_data), ignore.case = TRUE)
names(Tidy_data)<-gsub("angle", "Angle", names(Tidy_data))
names(Tidy_data)<-gsub("gravity", "Gravity", names(Tidy_data))

# Create a second, independent tidy data set using the above data with the average of each variable for each activity and each subject.
Final_tidy_data <- Tidy_data %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(Final_tidy_data, "FinalTidyData.txt", row.name=FALSE)
