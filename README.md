# C_JH_GCD_PROJECT
Coursera - John Hopkins - Getting and Cleaning Data - Course Project

#SYNOPSIS

This material was produced as a response to the requirements for the 

Course Project
Getting and Cleaning Data
class.coursera.org/getdata-031.

Source data consists of train and test data set folders originally taken from:
	http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Project Objectives:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of 
   each variable for each activity and each subject.


#FILE LIST

	run_analysis.r

		An R script/function designed to process the source data sets and produce the final 
                tidy data set described above in Project Objective 5.		

	Code_Book.txt

		Document containing information describing the tidy_data_set produced by the R script
		run_analysis.r. 

	README.MD

		This document.

#INSTALLATION

	Copy the R script file, run_analysys.r, to your R working directory.

	Copy the train and test data set folders to your R working directory.


#APPLICATION INTERFACE

	run_analysis(source_path = getwd(), data_sets = c("train", "test"), keywords = c("mean()", "std()").r 


		INPUT PARAMETERS
   			source_path - path to location of source data set folders  - default to working directory getwd()
   			data_sets   - data sets to be analyZed                     - default to c("train", "test")
			keywords    - key words to be found in variable names      - default to c("mean()", "std()")
		OUTPUT
   			tidy data set with the average/mean of each variable for each activity and subject.

	
#OPERATING INSTRUCTIONS

	Type the following commands into the R console after files/folders have been copied to the R working directory:

		source('run_analysis.R')
		tidy_data_set <- run_analysis()
	

#LICENSE

	This project uses data sets, "train" and "test", under the provisions of the original license appearing below:

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
