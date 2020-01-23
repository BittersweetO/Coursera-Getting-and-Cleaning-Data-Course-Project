library(dplyr)
#reading data
Features   <- read.table('C:/Bittersweet/Develop/Working Directory/Coursera/Getting and Cleaning Data Course Project/Getting and Cleaning Data Course Project/UCI HAR Dataset/features.txt', col.names = c("n","f"))
Activities <- read.table('C:/Bittersweet/Develop/Working Directory/Coursera/Getting and Cleaning Data Course Project/Getting and Cleaning Data Course Project/UCI HAR Dataset/activity_labels.txt', col.names = c("c", "a"))
Xtest      <- read.table('C:/Bittersweet/Develop/Working Directory/Coursera/Getting and Cleaning Data Course Project/Getting and Cleaning Data Course Project/UCI HAR Dataset/test/X_test.txt', col.names = Features$f)
Ytest      <- read.table('C:/Bittersweet/Develop/Working Directory/Coursera/Getting and Cleaning Data Course Project/Getting and Cleaning Data Course Project/UCI HAR Dataset/test/y_test.txt', col.names = "c")
Xtrain     <- read.table('C:/Bittersweet/Develop/Working Directory/Coursera/Getting and Cleaning Data Course Project/Getting and Cleaning Data Course Project/UCI HAR Dataset/train/X_train.txt', col.names = Features$f) 
Ytrain     <- read.table('C:/Bittersweet/Develop/Working Directory/Coursera/Getting and Cleaning Data Course Project/Getting and Cleaning Data Course Project/UCI HAR Dataset/train/y_train.txt', col.names = "c") 
SUBtest    <- read.table('C:/Bittersweet/Develop/Working Directory/Coursera/Getting and Cleaning Data Course Project/Getting and Cleaning Data Course Project/UCI HAR Dataset/test/subject_test.txt', col.names = "s")
SUBtrain   <- read.table('C:/Bittersweet/Develop/Working Directory/Coursera/Getting and Cleaning Data Course Project/Getting and Cleaning Data Course Project/UCI HAR Dataset/train/subject_train.txt', col.names = "s") 
#merge data 
X   <- rbind(Xtest,Xtrain)
Y   <- rbind(Ytest,Ytrain)
SUB <- rbind(SUBtest,SUBtrain)
Data <- cbind(SUB, X, Y)
#select sd and mean
DataNew <- Data %>%
           select(s, c, contains("mean"), contains("std"))
#renamed
DataNew$c <- Activities[DataNew$c,2]
