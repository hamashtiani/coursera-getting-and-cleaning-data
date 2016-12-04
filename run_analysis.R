# Getting and cleaning data project
# start with appropriate libraries
library(dplyr)

#downloading the data

URL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file<-"week4data.zip"

if(!file.exists(file)){
	download.file(URL,file,method="curl")
}

if(!file.exists("UCI HAR Dataset")){
	unzip(file)
}

#reading in the data

train<-read.table("UCI HAR Dataset/train/X_train.txt")
sub_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
act1<-read.table("UCI HAR Dataset/train/y_train.txt")

test<-read.table("UCI HAR Dataset/test/X_test.txt")
sub_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
act2<-read.table("UCI HAR Dataset/test/y_test.txt")
features<-read.table("UCI HAR Dataset/features.txt")
id<-rbind(sub_train,sub_test)
activity<-rbind(act1,act2)

#temporary dataset
dataset<-rbind(train,test)

# finding the measurements with only the mean and standard deviations
mean_vars<-grep("mean", features$V2)
std_vars<-grep("std", features$V2)
d1<-dataset[mean_vars]
d2<-dataset[std_vars]
d3<-cbind(d1,d2)

mean_nam<-make.names(features[mean_vars,2])
std_nam<-make.names(features[std_vars,2])
nam<-c(mean_nam,std_nam)

# replacing the variable names with actual names
for(i in 1:length(names(d3))){
	if(i<47){
		names(d3)[i]<-mean_nam[i]
	}else{
		names(d3)[i]<-std_nam[i-46]
	}
}

# putting the dataset together
datasetnew<-cbind(id,activity,d3)

# making the variable names readable and more "tidy"
names(datasetnew)<-gsub("\\.","", names(datasetnew))
names(datasetnew)[1]<-"ID"
names(datasetnew)[2]<-"activity"

# outputing the new dataset
newSet<-aggregate(datasetnew[,3:81],list(datasetnew$ID,datasetnew$activity),mean)

write.table(newSet,"meandata.txt", sep="/t", row.name=FALSE)

