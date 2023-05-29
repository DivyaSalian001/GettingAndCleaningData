## Code Book:
Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## About run_analysis.R

1. Download the dataset.

2. Assign each data to variables.
    - *features <- features.txt* - The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
    - *activities <- activity_labels.txt* - List of activities performed when the corresponding measurements were taken and its codes (labels)
    - *subject_test <- test/subject_test.txt* - contains test data of test subjects being observed.
    - *x_test <- test/X_test.txt* - contains the Test set.
    -  *y_test <- test/Y_test* - contains the Test labels.
    -  *subject_train <- test/subject_train.txt* - Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
    - *x_train <- train/X_train.txt* - contains the Training set.
    -  *y_train <- train/Y_train* - contains the Training labels.
    
 3. Merges the training and the test sets to create one data set.
    - *X_data* - created by merging x_train and x_test using rbind() function.
    - *Y_data* - created by merging y_train and y_test using rbind() function.
    - *Subject_data* - created by merging subject_train and subject_test using rbind() function.
    - *Merged_data* - created by merging Subject_data, Y_data and X_data using cbind() function.

4. Extracts only the measurements on the mean and standard deviation for each measurement.
   - *Tidy_data* - created by subsetting Merged_data, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement.
   
5. Uses descriptive activity names to name the activities in the data set.
    - Entire numbers in code column of the *Tidy_data* replaced with corresponding activity taken from second column of the activities variable.

6. Appropriately labels the data set with descriptive variable names.
    - *code* column in *Tidy_data* renamed into *activity*
    - All *Acc* in column’s name replaced by *Accelerometer*
    - All *Gyro* in column’s name replaced by *Gyroscope*
    - All *BodyBody* in column’s name replaced by *Body*
    - All *Mag* in column’s name replaced by *Magnitude*
    - All *start with character t* in column’s name replaced by *Time*
    - All *start with character f* in column’s name replaced by *Frequency*
    - All *tBody* in column’s name replaced by *TimeBody*
    - All *angle* in column’s name replaced by *Angle*
    - All *gravity* in column’s name replaced by *Gravity*

7. From the data set in step 6, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    - *Final_tidy_data* is created by sumarizing *Tidy_data* taking the means of each variable for each activity and each subject, after groupped by subject and activity.
    - Export *Final_tidy_data* into *FinalTidyData.txt* file.

