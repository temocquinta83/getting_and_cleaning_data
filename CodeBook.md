# Code Book

Here is the sequence followed to clean the data:

Download the dataset from the source
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", zip_name)

Unzip the content
unzip(zip_name)

Move to the new Working directory

Read the Activity labels to map the activities
activity_labels <- read.table("./activity_labels.txt")


Read and concatenate the test and train subjects and activities
test <- read.table("./test/subject_test.txt")
train <- read.table("./train/subject_train.txt")
all_subject <- c(test[[1]], train[[1]])

test <- read.table("./test/y_test.txt")
train <- read.table("./train/y_train.txt")
all_y <- c(test[[1]], train[[1]])

Read the features to map them on the data frame
features <- read.table("./features.txt")

Find the Columns with the words mean or std
mean_sd_columns <- grep("(mean[(][)]|std[(][)])",features$name)

Format Column Names to used the on the data frame
mean_sd_colnames <- gsub("std[(][)]", "std", gsub("mean[(][)]", "mean", features$name[mean_sd_columns]))

Read and concatenate columns using mapply
test <- read.table("./test/X_test.txt")
train <- read.table("./train/X_train.txt")
all_sets <- mapply(c, test[,mean_sd_columns], train[,mean_sd_columns], SIMPLIFY = FALSE)

Rename list's items
names(all_sets) <- mean_sd_colnames

Generate Data Frame for Step 4
Use sapply to write the activity labels instead of the numbers
dataset.df = data.frame(subject = all_subject, activity = sapply(all_y, function(elem){activity_labels$name[activity_labels$id == elem]}), all_sets)

Generate Data Frame for Step 5
Use function aggregate to group by subject and activity
Use dataset.df[,3:length(names(dataset.df))] to avoid returning those values on the data frame
df2 <- aggregate(dataset.df[,3:length(names(dataset.df))], list(dataset.df$subject, dataset.df$activity), mean)

Write Data Set to CSV File
write.csv(df2, file = "wk4_prj_step5.csv", row.names = FALSE)

