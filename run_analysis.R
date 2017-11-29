## This script will create a tidy dataset for the Cleaning Data project

## Define project directory
prj_dir <- "./wk4_prj"
zip_name <- "./dataset.zip"
dataset_home <- "./UCI HAR Dataset"

## Create wk4_prj directory
if(!dir.exists(prj_dir)) dir.create(prj_dir)

#Set Working directory
setwd(prj_dir)

## Download the dataset
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", zip_name)

## Unzip the content
unzip(zip_name)

## Set new Working directory
setwd(dataset_home)


## Read Activity labels
activity_labels <- read.table("./activity_labels.txt")

## Rename columns
colnames(activity_labels) <- c("id", "name")


## Read data
test <- read.table("./test/subject_test.txt")
train <- read.table("./train/subject_train.txt")
all_subject <- rbind(test, train)

test <- read.table("./test/y_test.txt")
train <- read.table("./train/y_train.txt")
all_y <- rbind(test, train)

## Read features
features <- read.table("./features.txt")

## Rename columns
colnames(features) <- c("id","name")

## Find Mean and Std Dev Columns
## This analysis excludes meanFreq
mean_sd_columns <- grep("(mean[(][)]|std[(][)])",features$name)

## Removes the parentesis from the column names
mean_sd_colnames <- gsub("std[(][)]", "std", gsub("mean[(][)]", "mean", features$name[mean_sd_columns]))

test <- read.table("./test/X_test.txt")
train <- read.table("./train/X_train.txt")
all_sets <- rbind(test[,mean_sd_columns], train[,mean_sd_columns])

## Rename list items
names(all_sets) <- mean_sd_colnames

## Step 4 Data Frame
## Rename activities using the function sapply
dataset.df = data.frame(subject = all_subject, activity = sapply(all_y, function(elem){activity_labels$name[activity_labels$id == elem]}), all_sets)


## Step 5 Data Frame
dflen <- length(names(dataset.df))
df2 <- aggregate(dataset.df[,3:dflen], list(dataset.df$subject, dataset.df$activity), mean)
names(df2) <- c("subject", "activity", names(df2)[3:dflen])

## Write Data Set to txt file
write.txt(df2, file = "wk4_prj_step5.txt", row.names = FALSE)
