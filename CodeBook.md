# Code Book

This file describes the steps followed to clean the data for this project

Firse, we download the dataset from the source indicated on this project "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", using the download.file command. After that, we unzip the content into a local folder where we can start loading the data into memory. We use the variables test and train to load the data and then the command cbind to join both data frames. In order to translate some of the dataset values, we load the activity labels and features, and use them when creating the data frame. As part of the project's requirements, we extract the columns that represent the mean and std dev only. meanFreq was also excluded from this analysis. After that, we rename the sets columns and translate the activities using the sapply function. Then, we calcute the mean of the values by subject and activity, using the aggregate function. 

Finally, we generate the txt file with the data frame content.
