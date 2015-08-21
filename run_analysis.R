run_analysis <- function(source_path="~/R/UCI HAR Dataset", keywords=c("mean()", "std()")){
# Getting and Cleaning Data
#   class.coursera.org/getdata-031
#   Course Project
#
# INPUT PARAMETERS
#   source_path - path to location of original UCI data set folder,
#                   default to UCI HAR Dataset folder stored in R working directory
#   
#   keywords    - list of key words to be found in variable names of final data frame,
#                   default to mean() and std()
# OUTPUT
#   Tidy data set with the average/mean of each variable for each activity and subject.

    ## verify parameter source_path exists, otherwise return error message
    if (!dir.exists(source_path)){
        message <- "INPUT PARAMETER ERROR: Source_path/directory >"
        message <- paste(message, source_path, "< does not exist")
        return(message)
    }
    
    ## build list of data set folders
    data_sets <- list.dirs(path = source_path, recursive = FALSE, full.names = FALSE)
    
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
    features   <- read.table(file_name, quote="\"", comment.char="")
    
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
    
    ## initialize merge data frames count
    df_merge_count <- 0
    
    ## loop thru elements of the data set list and prepare new dataframe for that data set
    for (data_set in data_sets) {
    
        ### read x, y, subject data
        file_name <- paste(source_path, "/", data_set, "/x_", data_set, ".txt", sep = "")
        if (!file.exists(file_name)){
            return(paste("FILE ERROR: file >", file_name, "< does not exist"))
        }
        x <- read.table(file_name, quote="\"", comment.char="")
        
        file_name <- paste(source_path, "/", data_set, "/y_", data_set, ".txt", sep = "")
        if (!file.exists(file_name)){
            return(paste("FILE ERROR: file >", file_name, "< does not exist"))
        }
        y <- read.table(file_name, quote="\"", comment.char="")
        
        file_name <- paste(source_path, "/", data_set, "/subject_", data_set, ".txt", sep = "")        
        if (!file.exists(file_name)){
            return(paste("FILE ERROR: file >", file_name, "< does not exist"))
        }
        s <- read.table(file_name, quote="\"", comment.char="")
        
        ### create temporary dataframe "df"
        df <- data.frame(subject=integer(nrow(x)))
        
        ### add subject data to results data frame
        df$subject <- as.numeric(s[,1])          
        
        ### add data source factor to results data frame
        ### to indicate original data set source for this record, train or test
        df$source_DS <- factor(x=integer(nrow(x)),levels=1:length(data_sets),labels=data_sets)
        ### add source data set folder name to data frame
        t <- which(data_sets == data_set)
        df$source_DS <- factor(x=t,levels=1:length(data_sets),labels=data_sets)  
        
        ### add activity factor column to results data frame
        a  <- as.character(activities[,2])    
        df$activity <- factor(x=integer(nrow(x)),levels=1:length(a),labels=a)
        
        ### add activity factor data to activity data column
        ###  using original activity labels from activity_labels.txt file
        for (i in 1:nrow(df)){
            z <- as.integer(activities[y[i,1],2])
            df$activity[i] <- factor(x=z,levels=1:length(a),labels=a)
        }
        
        ### Copy all original x data columns which include mean() and std() in column name
        col_num       <- ncol(df)
        col_agg_start <- col_num + 1
        for (item in features_idx) {
            
            #### copy data column from original x data frame to results data frame
            df <- cbind(df,x[,item])
            
            #### add name to new column based on origial features.txt data
            col_num <- col_num + 1           
            colnames(df)[col_num] <- paste("Average of",as.character(features$V2[item]))
        }
        
        ### merge current data frame with df_merge
        if (df_merge_count == 0){
            df_merge <- df
        } else {
            df_merge  <- rbind(df_merge, df)
        }
        df_merge_count <- df_merge_count + 1
    }
    
    ## check df_merge to see if there is any data to analyze
    if (df_merge_count == 0){
        return("DATA ERROR: DID NOT FIND ANY DATA TO ANALYZE")
    }
    
    ## create new tidy data set with average/mean of data by activity and subject
    aggregate_seq <- col_agg_start:ncol(df_merge)
    tidy_data_set <- aggregate(df_merge[,aggregate_seq], list(df_merge$activity, df_merge$subject), mean)
    
    ## change df column names
    colnames(tidy_data_set)[1] <- "Activity"
    colnames(tidy_data_set)[2] <- "Subject"
    
    ## return final result
    tidy_data_set
}

