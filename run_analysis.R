# Getting and cleaning data project
# start with appropriate libraries
library(dplyr)

#setting up correct directories
traindir<-"/Users/hamidashtiani/Documents/R Coursera/Getting and Cleaning Data/Dataset/train"
testdir<-"/Users/hamidashtiani/Documents/R Coursera/Getting and Cleaning Data/Dataset/test"
gendir<-"/Users/hamidashtiani/Documents/R Coursera/Getting and Cleaning Data/Dataset/"
setwd(gendir)
features<-read.table("features.txt")

setwd(traindir)

#reading in the data

train<-read.table("X_train.txt")
sub_train<-read.table("subject_train.txt")
act1<-read.table("y_train.txt")

setwd(testdir)
test<-read.table("X_test.txt")
sub_test<-read.table("subject_test.txt")
act2<-read.table("y_test.txt")

id<-rbind(sub_train,sub_test)
activity<-rbind(act1,act2)

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

