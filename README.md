# cleaning-data-project

Files included in the repo:
- codebook.md - provides a description of all the variables in the dataset
- run_analysis.R - r code to reproduce the analysis
- tidy.txt - dataset produced by the analysis

To run_analysis.R you need to have features.txt in your working directory, and two sub-directories with the following files:

Train
- X_train.txt
- y_train.txt
- subject_train.txt

Test
- X_test.txt
- y_test.txt
- subject_test.txt

Required packages: dplyr

run_analysis.R executes the following steps:  
1. Loads the dplyr package  
<<<<<<< HEAD
2. Reads the data files from the working directory and adds the feature names to the columns of the data frames
3. cbinds the subject, X_test, and y_test data
4. cbinds the subject, X_train, and y_train data
5. Joins the test and train data
6. Extracts only the measurements on mean and stdev for each measurement
7. Replaces the activity codes with activity names
8. Creates a data frame grouped by subject and then by activity
9. Creates a data frames using the data frame created in the prior step that has the means of each variable by each subject and each activity.
11. Make variable names readable and descriptive
12. Write a .txt file with the new data set.
=======
2. Reads the data files from the working directory and adds the feature names to the columns of the data frames  
3. cbinds the subject, X_test, and y_test data  
4. cbinds the subject, X_train, and y_train data  
5. Joins the test and train data  
6. Extracts only the measurements on mean and stdev for each measurement  
7. Replaces the activity codes with activity names  
8. Creates two data frames, one grouped by subject and the other grouped by activity  
9. Create two data frames using the data frames create in the prior step that have the means of each variable by subject and activity  
10. Removes extraneous subject and activity variables from each new data frame  
11. Renames the subject and activity variables in each data frame  
12. rbinds the to data frames with average values into a final data set  
13. Make variable names readable and descriptive  
14. Write a .txt file with the new data set  
>>>>>>> 2aa086bc3b3f7ea4af9fb0315216c5df749d66fa
