

activity_labels <- read.table("activity_labels.txt",header=F) #labels of the six activities
features <- read.table("features.txt", header= F) #features names

subject_train <-read.table("subject_train.txt",header= F)
X_train <- read.table("X_train.txt",header=F)
Y_train <- read.table("y_train.txt",header=F) 

subject_test <- read.table("subject_test.txt",header = F)
X_test <- read.table("X_test.txt",header= F)
y_test <- read.table("y_test.txt", header = F)

##Checking property of datasets
str(activity_labels) # 6 obs and 2 variables
str(features) # 561obs and 2 vriables
str(subject_train) #7352obs and 1 var
str(X_train) #7352obs and 561 var
str(Y_train) #7352obs and 1 var
str(subject_test) #2947obs and 1 var
str(X_test) #2947obs and 561 var
str(y_test) #2947obs and 1 var

#1. Merging the datasets
subject_data <- rbind(subject_train,subject_test)
X_data <- rbind(X_train,X_test)
Y_data <- rbind(Y_train,y_test)

#Assigning names to dataset variables
names(subject_data) <- c("Subject")
names(Y_data) <- c("Activity")
features_names <- features
names(X_data)<- features_names$V2

#Merging cols to get combined data frame 
Merge_data<- cbind(subject_data,Y_data)
All_data <- cbind(X_data,Merge_data)

#2. Applying mean and sd on the data
sapply(subject_data,mean,na.rm=TRUE)
sapply(subject_data,sd,na.rm=TRUE)
sapply(X_data,mean,na.rm=TRUE)
sapply(X_data,sd,na.rm=TRUE)
sapply(Y_data,mean,na.rm=TRUE)
sapply(Y_data,sd,na.rm=TRUE)

#3. Giving descriptive names to activity
All_data$Activity[All_data$Activity==1] <- "WALKING"
All_data$Activity[All_data$Activity==2] <- "WALKING_UPSTAIRS"
All_data$Activity[All_data$Activity==3] <- "WALKING_DOWNSTAIRS"
All_data$Activity[All_data$Activity==4] <- "SITTING"
All_data$Activity[All_data$Activity==5] <- "STANDING"
All_data$Activity[All_data$Activity==6] <- "LAYING"

head(All_data$Activity,30)

#4. Assigning descriptive names to feature variables
names(All_data)<-gsub("^t", "time", names(All_data))
names(All_data)<-gsub("^f", "frequency", names(All_data))
names(All_data)<-gsub("Acc", "Accelerometer", names(All_data))
names(All_data)<-gsub("Gyro", "Gyroscope", names(All_data))
names(All_data)<-gsub("Mag", "Magnitude", names(All_data))
names(All_data)<-gsub("BodyBody", "Body", names(All_data))

#5. Creating and aggregate tidy Data
tidy_data<-aggregate(.~Subject +Activity,All_data,mean)
tidy_data <- tidy_data[order(tidy_data$Subject,tidy_data$Activity),]
write.table(tidy_data,file="Aggregate_tidy_data.txt",row.name=FALSE)
str(tidy_data)





