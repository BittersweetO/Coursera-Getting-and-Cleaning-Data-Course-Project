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
#labels data
names(DataNew)[2] = "activity"
names(DataNew)<-gsub("Acc", "Accelerometer", names(DataNew))
names(DataNew)<-gsub("Gyro", "Gyroscope", names(DataNew))
names(DataNew)<-gsub("BodyBody", "Body", names(DataNew))
names(DataNew)<-gsub("Mag", "Magnitude", names(DataNew))
names(DataNew)<-gsub("^t", "Time", names(DataNew))
names(DataNew)<-gsub("^f", "Frequency", names(DataNew))
names(DataNew)<-gsub("tBody", "TimeBody", names(DataNew))
names(DataNew)<-gsub("-mean()", "Mean", names(DataNew), ignore.case = TRUE)
names(DataNew)<-gsub("-std()", "STD", names(DataNew), ignore.case = TRUE)
names(DataNew)<-gsub("-freq()", "Frequency", names(DataNew), ignore.case = TRUE)
names(DataNew)<-gsub("angle", "Angle", names(DataNew))
names(DataNew)<-gsub("gravity", "Gravity", names(DataNew))
#Average of each variable
DataFinal <- DataNew %>%
             group_by(s,activity) %>%
             summarise_all(funs(mean))
write.table(DataFinal, "DataFinal.txt", row.names = F)