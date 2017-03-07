## Load packages
library("dplyr")

## Read data files
features <- read.table("features.txt")
activity_names <- read.table("activity_labels.txt")
xtest <- read.table("test/X_test.txt", col.names = features$V2)
ytest <- read.table("test/y_test.txt", col.names = c("activity name"))
subtest <- read.table("test/subject_test.txt", col.names = c("subject"))
xtrain <- read.table("train/X_train.txt", col.names = features$V2)
ytrain <- read.table("train/y_train.txt", col.names = c("activity name"))
subtrain <- read.table("train/subject_train.txt", col.names = c("subject"))

## Merge test data
merged_test <- cbind(subtest, ytest, xtest)

## Merge train data
merged_train <- cbind(subtrain, ytrain, xtrain)

## Merge test and train data
merged_data <- full_join(merged_test, merged_train)

## Extract only the measurements on mean and stdev for each measurement
my_data <- select(merged_data, subject, activity.name, contains("mean"), contains("std"))

## Replace activity codes with activity names
my_data$activity.name[my_data$activity.name == 1] <- "walking"
my_data$activity.name[my_data$activity.name == 2] <- "walking upstairs"
my_data$activity.name[my_data$activity.name == 3] <- "walking downstairs"
my_data$activity.name[my_data$activity.name == 4] <- "sitting"
my_data$activity.name[my_data$activity.name == 5] <- "standing"
my_data$activity.name[my_data$activity.name == 6] <- "laying"

## Group data by subject and activity
group_by_subject <- group_by(my_data, subject)
group_by_activity <- group_by(my_data, activity.name)

## Get mean of each variable by subject and activity
subject_avgs <- summarize_each(group_by_subject, funs(mean))
activity_avgs <- summarize_each(group_by_activity, funs(mean))

## Remove extraneous subject and activity variables
activity_avgs <- select(activity_avgs, -subject)
subject_avgs <- select(subject_avgs, -activity.name)

## Rename subject and activity variables
subject_avgs <- rename(subject_avgs, obs = subject)
activity_avgs <- rename(activity_avgs, obs = activity.name)

## Bind DFs with average data
final_data <- rbind(subject_avgs, activity_avgs)

## fix variable names
names(final_data) <- gsub("\\.", "", names(final_data))
names(final_data) <- paste0("Average", names(final_data))

## Write the tidy txt file
write.table(final_data, "tidy.txt", quote = FALSE, row.names = FALSE)