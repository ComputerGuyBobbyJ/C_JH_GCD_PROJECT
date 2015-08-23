# C_JH_GCD_PROJECT
Coursera - John Hopkins - Getting and Cleaning Data - Course Project

#SYNOPSIS

This material was produced as a response to the requirements for the 

	Course Project
		Getting and Cleaning Data
		class.coursera.org/getdata-031.

Source data set folder "UCI HAR Dataset" taken from:
	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Original data obtained from:
	http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Project Objectives:
<ol>
  <li>Merges the training and the test sets to create one data set.</li>
  <li>Extracts only the measurements on the mean and standard deviation for each measurement.</li>
  <li>Uses descriptive activity names to name the activities in the data set</li>
  <li>Appropriately labels the data set with descriptive variable names.</li>
  <li>From the data set in step 4, creates a second, independent tidy data set with the average of 
   each variable for each activity and each subject.</li>
</ol>


#FILE LIST

	run_analysis().r

		An R script/function designed to process the source data sets and produce the final 
                tidy data set described above in Project Objective 5.		

	Code_Book.txt

		Document containing information describing the tidy_data_set produced by the R script
		run_analysis.r. 

	README.md

		This document.

#INSTALLATION

	Copy the R script file, "run_analysys.r", to the R working directory.

	Copy the "UCI HAR Dataset" folder to the R working directory.


#APPLICATION INTERFACE

	run_analysis(source_path = "~/R/UCI HAR Dataset", keywords = c("mean()", "std()").r 

		INPUT PARAMETERS
   			source_path - path to location of source data set folder
                                        default to ~/R/UCI HAR Dataset

			keywords    - key words to be found in variable names
                                        default to c("mean()", "std()")
		OUTPUT
   			tidy data set with the average/mean of each numeric variable for 
                        each activity and subject.


#APPLICATION OVERVIEW

	For each of the original source data sets, "train" and "test":

		Data columns are copied into temporary data frame "df" when the column name 
		contains the key word "mean()" or "std()",

		Two data columns are added:

  			Activity – labels taken from the source data set file activity_labels.txt

  			Subject  - subject id number taken from the source data set files
				   "subject_train.txt" and "subject_test.txt"

		The column names for the numeric data columns are created by adding a prefix of
		“Avg_of_” to the original source data set column name.

		The data is then merged using:

   			df_merge <- rbind(df_merge, df)

		The process is repeated for the next source data set


	A final data frame, named "tidy_data_set", is produced from the merged data frame "df_merge"
	by calculating the average/mean of all numeric data columns grouped by activity and subject 
        as follows:
 
	tidy_data_set <- aggregate(df_merge[,col_start_agg:ncol(df_merge)], list(df_merge$activity,_ 
                         df_merge$subject), mean)

	
#OPERATING INSTRUCTIONS

	Type the following commands into the R console after files/folders have been copied to the R 
        working directory:

		source('run_analysis.R')
		tidy_data_set <- run_analysis()

#ISSUES/BUGS

	As directed in the submission process, the tidy script file produced by the R script
	run_analysis() is written to a text file, "tidy_data_set.txt", using the command 
	write.table(..., row.names - FALSE) and then it is uploaded through the submission page. 

	The uploaded txt file, "tidy_data_set.txt", contains complete data column names.

	A downloaded copy of the txt file, "tidy_data_set.txt", contains complete data column names.

	But reading the downloaded file "tidy_data_set.txt" with either read.table or read.csv 
	abbreviates the column names. 

	The column name is read in as a shorter version of the actual column name stored in 
	"tidy_data_set.txt".

	For example, the "tidy_data_set.txt" column name "Avg_of_tBodyAcc-mean()-X" is read 
	in as "Average.of.tBodyAcc.mean...X".



#LICENSE

	This project uses data sets, "train" and "test", under the provisions of the original license 
        appearing below:

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
