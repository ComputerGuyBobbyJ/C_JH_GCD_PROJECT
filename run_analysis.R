run_analysis <- function(source_path=getwd(), data_sets=c("train","test"), keywords=c("mean()", "std()")){
# Getting and Cleaning Data
#   class.coursera.org/getdata-031
#   Course Project
#
# INPUT PARAMETERS
#   source_path - path to location of original data set folders
#                   default to working directory
#   data_sets   - original data set files to be analyzed
#                   default to train and test
#   keywords    - list of key words to be found in variable names of final data frame
#                   default to mean() and std()
# OUTPUT
#   Tidy data set with the average/mean of each variable for each activity and subject.

    ## verify parameter source_path exists, otherwise return error message
    if (!dir.exists(source_path)){
        return("INPUT ERROR: source_path/directory does not exist")
    }
    
    ## read activities file
    file_name  <- paste(source_path, "/activity_labels.txt", sep = "")
    if (!file.exists(file_name)){
        return(paste("ERROR: file >", file_name, "< does not exist"))
    }
    activities <- read.table(file_name, quote="\"", comment.char="")

    ## read features file
    file_name  <- paste(source_path, "/features.txt", sep = "")
    if (!file.exists(file_name)){
        return(paste("ERROR: file >", file_name, "< does not exist"))
    }    
    features   <- read.table("~/R/features.txt", quote="\"", comment.char="")
    
    ## create index of features which include key words mean() or std()
    ##   fixed = TRUE option of grep() selected to force exact match for keywords
    features_idx <- integer()
    for (feature in features$V2) {
        for (keyword in keywords){
            if (length(grep(keyword,feature, fixed = TRUE)) > 0){
                features_idx <- append(features_idx,match(feature, features$V2))
            }
        }
    }
    
    ## loop thru elements of the data set list and prepare new dataframe for that data set
    for (data_set in data_sets) {
    
        ### read x, y, subject data
        file_name <- paste(source_path, "/", data_set, "/x_", data_set, ".txt", sep = "")
        x <- read.table(file_name, quote="\"", comment.char="")
        file_name <- paste(source_path, "/", data_set, "/y_", data_set, ".txt", sep = "")    
        y <- read.table(file_name, quote="\"", comment.char="")
        file_name <- paste(source_path, "/", data_set, "/subject_", data_set, ".txt", sep = "")    
        s <- read.table(file_name, quote="\"", comment.char="")
        
        ### create results dataframe
        df <- data.frame(subject=integer(nrow(x)))
        
        ### add subject data to results data frame
        df$subject <- as.numeric(s[,1])          
        
        ### add data source factor to results data frame
        ###  to indicate original data set source for this record, train or test
        df$source_DS <- factor(x=integer(nrow(x)),levels=1:length(data_sets),labels=data_sets)
        ### add source_DS data to results data frame
        t <- which(data_sets == data_set)
        df$source_DS <- factor(x=t,levels=1:length(data_sets),labels=data_sets)  
        
        ### add activity factor to results data frame
        a  <- as.character(activities[,2])    
        df$activity <- factor(x=integer(nrow(x)),levels=1:length(a),labels=a)
        ### add activity factor data to results data frame
        ###  using original activity labels from activity_labels.txt file
        for (i in 1:nrow(df)){
            z <- as.integer(activities[y[i,1],2])
            df$activity[i] <- factor(x=z,levels=1:length(a),labels=a)
        }
        
        ### Copy all original x data columns which include mean() and std() in column name
        col_num <- ncol(df)
        for (item in features_idx) {
            #### copy data column from original x data frame to results data frame
            df <- cbind(df,x[,item])
            #### add name to new column based on origial features.txt data
            col_num <- col_num + 1           
            colnames(df)[col_num] <- paste("Average of",as.character(features$V2[item]))
        }
        
        ### save new train and test data frames
        if (data_set == "train"){
            df_train <- df
        } else {
            df_test  <- df
        }
    }
    
    ## merge new train and test data frames
    df <- rbind(df_train, df_test)

    ## create new tidy data set with average/mean of data by activity and subject    
    df <- aggregate(df[,4:ncol(df)], list(df$activity, df$subject), mean)
    
    ## change df column names
    colnames(df)[1] <- "Activity"
    colnames(df)[2] <- "Subject"
    
    df
}
