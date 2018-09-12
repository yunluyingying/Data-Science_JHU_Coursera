# downloda data
setwd("~/Documents/Self-learning/DS/Data Science-JHU/8-Practical ML")
fileurl1<-"https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
fileurl2<-"https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"
download.file(fileurl1,destfile = "./training.csv",method="curl")
download.file(fileurl2,destfile = "./testing.csv",method="curl")
# load library
library(caret)
library(rattle)
# load data
training<-read.csv("training.csv",header = T,sep=",")
testing<-read.csv("testing.csv",header = T,sep=",")
str(training)
str(testing)
#clean data-clean empty columns in training and testing datsets  
training1<-(colSums(is.na(training))==19216)
training2<-training[,!training1]
testing1<-(colSums(is.na(testing))==20)
testing2<-testing[,!testing1]
#Create training and testing subsets in training dataset
set.seed(2017)
intrain=createDataPartition(training2$classe,p=0.60)[[1]]
training3=training2[intrain,]
testing3=training2[-intrain,]
# Prediction with Decision Trees 
modFit1<-train(classe~.,method="rpart",data=training3)
Fit1predict=predict(modFit1,testing3)
confusionMatrix(testing3$classe,Fit1predict)
#The accuracy is only around 0.66, so we should use other prediction algorithm. 
# Prediction with Random forest 
modFit2=train(classe~.,method="rf",data=training3)
Fit2predict=predict(modFit2,testing3)
confusionMatrix(testing3$classe,Fit2predict)

