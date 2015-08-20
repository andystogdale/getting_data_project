run_analysis <- function() {
  
  #READ DATA AND COMBINE
  train_y <- read.table("UCI HAR Dataset/train/y_train.txt")
  train_x <- read.table("UCI HAR Dataset/train/X_train.txt", fill = TRUE)
  train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
  train_cbinded <- cbind(train_x, train_y, train_subject)
  
  test_y <- read.table("UCI HAR Dataset/test/y_test.txt")
  test_x <- read.table("UCI HAR Dataset/test/X_test.txt", fill = TRUE)
  test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
  test_cbinded <- cbind(test_x, test_y, test_subject)
  
  all_binded <- rbind(train_cbinded, test_cbinded)
  
  # FILTER OUT UNREQUIRED COLUMNS
  
  all_features <- read.table("UCI HAR Dataset/features.txt")
  meanFeatures <- all_features[grep("mean\\(\\)", all_features[,2]),]
  sdFeatures <- all_features[grep("std\\(\\)", all_features[,2]),]
  features <- rbind(meanFeatures, sdFeatures)
  features <- features[ order(as.numeric(features[,1])),]

  colNums <- as.numeric(features[,1])
   
  colNums <- c(colNums, ncol(all_binded)-1, ncol(all_binded))
  colNums
  all_binded <- all_binded[, colNums]
  
  # ACTIVITY NAMING
  activityNames <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
  all_binded$V1.1 <- activityNames[as.numeric(all_binded$V1.1)]
  
  # COLUMN NAMING
  colNames <- as.character(features[,2])
  colNames <- c(colNames, "Activity", "Subject")
  colnames(all_binded) <- colNames
  
  #reshape and write
  library(reshape2)
  final_data_set <- melt(all_binded, id.vars = c("Activity", "Subject"))
  final_data_set <- aggregate(as.numeric(final_data_set$value), by = list(final_data_set$Activity, final_data_set$Subject, final_data_set$variable), FUN = mean)
  colnames(final_data_set) <- c("Activity", "Subject", "Variable", "Mean")
  
  write.table(final_data_set, file = "final_data.txt", quote = FALSE, row.names = FALSE)

}