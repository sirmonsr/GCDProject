# Getting and Cleaning Data course project     
# Human Activity Recognition Using Smartphones Data Set
# R Sirmons               24 Aug 2014
#
# Read data
features<-read.table("features.txt", stringsAsFactors = FALSE)
activity_labels<-read.table("activity_labels.txt", stringsAsFactors = FALSE)
Stest<-read.table("subject_test.txt")
Xtest<-read.table("X_test.txt")
Ytest<-read.table("Y_test.txt")
Strain<-read.table("subject_train.txt")
Xtrain<-read.table("X_train.txt")
Ytrain<-read.table("Y_train.txt")
# start with test data
# activity labels are merged with test data
YAtest<-merge(Ytest,activity_labels)
# Apply names to data
names(YAtest)<-c("ActivityId", "ActivityName")
names(Xtest)<-as.vector(features$V2)
names(Stest)<-"SubjectId"
# combine activities, subjects and data
XYtest<-cbind(Stest,YAtest,Xtest)
# Do same for training data
# activity labels are merged with test data
YAtrain<-merge(Ytrain,activity_labels)
# Apply names to data
names(YAtrain)<-c("ActivityId", "ActivityName")
names(Xtrain)<-as.vector(features$V2)
names(Strain)<-"SubjectId"
# combine activities, subjects and data
XYtrain<-cbind(Strain,YAtrain,Xtrain)
# combine test and training data
XYall<-rbind(XYtest,XYtrain)
# filter to mean or standard deviation fields 
XYms<-XYall[,c(1:3,grep("std",names(XYall)),grep("mean",names(XYall)))]
# calculate averages by subject and activity
numfld<-(length(names(XYms)))
XYag<-aggregate(XYms[,4:numfld], by=list(XYms$SubjectId, XYms$ActivityId), data = XYms, FUN="mean")
# provide friendly names for fields
colnames(XYag) <- paste("Average of", colnames(XYag), sep = "_")
colnames(XYag)[1]<-"SubjectId"
colnames(XYag)[2]<-"ActivityId"
# reapply activity labels
XYave<-merge(XYag, activity_labels, by.x="ActivityId", by.y="V1", all=TRUE)
colnames(XYave)[82]<-"ActivityName"
# rearrange name columns
XYtidy<-cbind(XYave[,1,drop = FALSE],XYave[,82,drop = FALSE],XYave[,2,drop = FALSE],XYave[,3:81],stringsAsFactors = FALSE)
# write XYtidy to disk file
write.table(XYtidy,file="XYtidy.txt",row.names=FALSE, col.names = TRUE)
# NOTE: You may need to use read.table with header=TRUE to view XYtidy.txt
