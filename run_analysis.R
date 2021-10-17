# run_analysis.R
# Coursera Data Analytics - course 3 Getting and cleaning data - final assignment

write_result <- TRUE

# X Data
X_train <- read.table("data/UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("data/UCI HAR Dataset/test/X_test.txt")
X_all <- rbind(X_train, X_test)
rm(X_train); rm(X_test)

# y data
y_train <- read.table("data/UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("data/UCI HAR Dataset/test/y_test.txt")
y_all <- rbind(y_train, y_test)
rm(y_train); rm(y_test)
# make y data column name mode readable
names(y_all)[names(y_all) == 'V1'] <- 'FeatureId'

# subject data
subject_train <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
subject_all <- rbind(subject_train, subject_test)
rm(subject_train); rm(subject_test)
# make subject column more readable
names(subject_all)[names(subject_all) == 'V1'] <- 'SubjectId'
# names(subject_all)

#
# load features file and make columns more readable
#

features <- read.table("data/UCI HAR Dataset/features.txt")
colnames(features) <- c("FeatureId", "Feature")


# exclude all but mean() and std() lines
feat_idx <- grep("mean\\(\\)|std\\(\\)", features$Feature, ignore.case = TRUE) 

# assing the sub-set of features required
nice_feature_names <- features[feat_idx,]
rm(features)

# remove the round brackets, Add Capitals and remove '-' from feature names
# Also changing BodyBody to just Body
nice_feature_names$Feature <- gsub("-", "", 
                                   sub("BodyBody", "Body", 
                                       sub("-std", "Std", 
                                           sub("-mean", "Mean", 
                                              gsub("[()]", "", nice_feature_names$Feature)
                                              )
                                          )
                                       ) 
                                   )

#
# Load Activity Labels and make columns more readable
#
activity_labels <- read.table("data/UCI HAR Dataset/activity_labels.txt")
colnames(activity_labels) <- c("ActivityId", "Activity")

#
# filter the feature data for the required features 
#
feat_data <- X_all[,feat_idx]
rm(X_all)

# set the feature data columns to be more readable
colnames(feat_data) <- nice_feature_names$Feature

#
# add the subject_Id column
#
feat_data <- cbind(feat_data, subject_all)
rm(subject_all)

#
# add Activity column to the feature data-set
#
feat_data$Activity = "undefined"
feat_data$Activity <- activity_labels[y_all$FeatureId,]$Activity
feat_data$Activity[is.na(feat_data$Activity)] <- "NA"

# 5. using dplyr to group the data by SubjectId and Activity averaging the other
#    columns.

library(dplyr)

dtTidy <- feat_data %>%
    group_by(SubjectId, Activity) %>% summarise_each(funs(mean))

if( write_result ) {
    write.table(dtTidy, file = "result.txt", row.name=FALSE )
    print("result.csv written to disk.")
} else {
    print("Skipped written result.csv to disk.")
}


