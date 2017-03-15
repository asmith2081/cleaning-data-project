## Load packages
library("dplyr")

## Read data files
features <- read.table("features.txt")
xtest <- read.table("test/X_test.txt", col.names = features$V2)
ytest <- read.table("test/y_test.txt", col.names = c("activity"))
subtest <- read.table("test/subject_test.txt", col.names = c("subject"))
xtrain <- read.table("train/X_train.txt", col.names = features$V2)
ytrain <- read.table("train/y_train.txt", col.names = c("activity"))
subtrain <- read.table("train/subject_train.txt", col.names = c("subject"))

## Merge test data
merged_test <- cbind(subtest, ytest, xtest)

## Merge train data
merged_train <- cbind(subtrain, ytrain, xtrain)

## Join test and train data
merged_data <- full_join(merged_test, merged_train)

## Extract only the measurements on mean and stdev for each measurement
my_data <- select(merged_data, subject, activity, contains("mean"), contains("std"))

## Replace activity codes with activity names
my_data$activity[my_data$activity == 1] <- "walking"
my_data$activity[my_data$activity == 2] <- "walking upstairs"
my_data$activity[my_data$activity == 3] <- "walking downstairs"
my_data$activity[my_data$activity == 4] <- "sitting"
my_data$activity[my_data$activity == 5] <- "standing"
my_data$activity[my_data$activity == 6] <- "laying"

## Group data by subject and activity
grouped_data <- group_by(my_data, subject, activity)

## Get mean of each variable by each subject and each activity
avg_data <- summarize_each(grouped_data, funs(mean))

## fix variable names
names(avg_data) <- gsub("\\.", "", names(avg_data))
names(avg_data) <- paste0("Average", names(avg_data))
names(avg_data) [1:2] <- c("subject", "activity")

## Write the tidy txt file
write.table(avg_data, "tidy.txt", quote = FALSE, row.names = FALSE)