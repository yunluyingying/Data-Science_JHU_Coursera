#downloda data
fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,destfile = "./data8.zip",method="curl")
data8<-unzip("data8.zip")
#laod the files
features<-read.table(data8[2])
activity_label<-read.table(data8[1])
#set the train data
subject_train<-read.table(data8[26])
colnames(subject_train)<-"SubjectID"
x_train<-read.table(data8[27],header = F)
colnames(x_train)<-features[,2]
y_train<-read.table(data8[28])
colnames(y_train)<-"Activity"
train<-cbind(subject_train,y_train,x_train)
#set the test data
subject_test<-read.table(data8[14])
colnames(subject_test)<-"SubjectID"
x_test<-read.table(data8[15],header = F)
colnames(x_test)<-features[,2]
y_test<-read.table(data8[16])
colnames(y_test)<-"Activity"
test<-cbind(subject_test,y_test,x_test)
#task 1
train_test<-rbind(train,test)
#task 2
library(dplyr)
valid_train_test<-make.names(names(train_test),unique = T,allow_=T)
names(train_test)<-valid_train_test
train_test_sub=select(train_test, SubjectID, Activity,contains(".mean.."),contains(".std.."))
#task 3&4
train_test_sub$Activity<-factor(train_test_sub$Activity,levels=activity_label$V1,labels = activity_label$V2)
#task 5
train_test_sub_ave<-aggregate(.~SubjectID+Activity,train_test_sub,mean)
write.table(train_test_sub_ave, "Tidydata.txt", row.name=FALSE)
