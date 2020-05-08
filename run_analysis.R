##url for datasource
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
temp <- tempfile()
download.file(url,temp)

#training data
X_test <- read.table(unz(temp, "UCI HAR Dataset/test/X_test.txt"))
y_test <- read.table(unz(temp, "UCI HAR Dataset/test/y_test.txt"))
subject_test <- read.table(unz(temp, "UCI HAR Dataset/test/subject_test.txt"))

#testing data
X_train <- read.table(unz(temp, "UCI HAR Dataset/train/X_train.txt"))
y_train <- read.table(unz(temp, "UCI HAR Dataset/train/y_train.txt"))
subject_train <- read.table(unz(temp, "UCI HAR Dataset/train/subject_train.txt"))

#labels for data
X_labels <- read.table(unz(temp, "UCI HAR Dataset/features.txt"))
y_labels <- read.table(unz(temp, "UCI HAR Dataset/activity_labels.txt"))

unlink(temp)

#1 Merges the training and the test sets 
X <- rbind(X_test, X_train)
y <- rbind(y_test, y_train)
subject <- rbind(subject_test, subject_train)

#3 Use descriptive activity names to name the activities in the data set
y <- data.frame(factor(y$V1, levels = c(1, 2, 3, 4,5, 6), 
            labels = y_labels$V2))

#4 Appropriately labels the data set with descriptive variable names.
colnames(X) <- X_labels$V2
colnames(subject) <- c("subject")
colnames(y) <- "Activity"


#2 Extracts only the measurements on the mean and standard deviation for each measurement.
X <- X[ , grepl( "std()|mean()" , names(X) ) ] #include strings with std or mean
X <- X[ , !grepl( "Freq" , names(X) ) ] #exclude column labels that include Freq

#Merge X and y together
data <- cbind(y, X)
data <- cbind(subject, data)

#5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library (dplyr)
library(magrittr)
tidy_set <- data[ , grepl( "activity|mean" , names(data) ) ]
tidy_set <- aggregate(tidy_set[, 3:68], list(tidy_set$Activity, tidy_set$subject), mean)
colnames(tidy_set)[1:2] <- c("Activity", "Subject")
write.table(tidy_set, file = "tidy_set.txt", row.names = FALSE)
