# Codebook

The data for this analysis comes from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description of the data can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The raw data consists of a zip file that contains a seperate folder for both the test and train data sets which is split into files labelled as X and y corresponding to the measurements and activity respectively. 

The data once downloaded was transformed using the scrip contained in run_analysis.R

First the X_train & X_test and y_train and y_test datasets were merged, then the datasets were labelled using the labels contained in features.txt and activity_labels.txt.

the data is then subset to just the activity label and columns corresponding to the average and standard deviation of the readings.

Finally a new tidy dataset is created that contains the average of each variable for each activity and each subject.