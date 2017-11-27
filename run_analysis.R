## This script will create a tidy dataset for the Cleaning Data project

## Define project directory
#prj_dir <- "./wk4_prj"
#zip_name <- "./dataset.zip"
#dataset_home <- "./UCI HAR Dataset"

## Create wk4_prj directory
#if(!dir.exists(prj_dir)) dir.create(prj_dir)

#Set Working directory
#setwd(prj_dir)

## Download the dataset
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", zip_name)

## Unzip the content
#unzip(zip_name)

## Set new Working directory
#setwd(dataset_home)


## Read Activity labels
activity_labels <- read.table("./activity_labels.txt")

## Rename columns
colnames(activity_labels) <- c("id", "name")


## Read data
test <- read.table("./test/subject_test.txt")
train <- read.table("./train/subject_train.txt")
all_subject <- c(test[[1]], train[[1]])

test <- read.table("./test/y_test.txt")
train <- read.table("./train/y_train.txt")
all_y <- c(test[[1]], train[[1]])

## Read features
features <- read.table("./features.txt")

## Rename columns
colnames(features) <- c("id","name")

## Find Columns
mean_sd_columns <- grep("(mean[(][)]|std[(][)])",features$name)

## Format Column Names
mean_sd_colnames <- gsub("std[(][)]", "std", gsub("mean[(][)]", "mean", features$name[mean_sd_columns]))

test <- read.table("./test/X_test.txt")
train <- read.table("./train/X_train.txt")
all_sets <- mapply(c, test[,mean_sd_columns], train[,mean_sd_columns], SIMPLIFY = FALSE)

## Rename list items
names(all_sets) <- mean_sd_colnames

## Step 4 Data Frame
dataset.df = data.frame(subject = all_subject, activity = sapply(all_y, function(elem){activity_labels$name[activity_labels$id == elem]}), all_sets)

## Write CSV File
#write.csv(dataset.df, file = "wk4_prj_step_4.csv")


## Step 5 Data Frame
df2 <- aggregate(dataset.df[,3:length(names(dataset.df))], list(dataset.df$subject, dataset.df$activity), mean)

## Write Data Set to CSV File
write.csv(df2, file = "wk4_prj_step5.csv", row.names = FALSE)

