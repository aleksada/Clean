##read file folder
file<-list.files("UCI HAR Dataset-2",full.names=TRUE)
train<-list.files("UCI HAR Dataset-2/train",full.names=TRUE)
test<-list.files("UCI HAR Dataset-2/test",full.names=TRUE)
##read data
X.train=read.table(train[3])
X.test=read.table(test[3])
##Merges the training and the test sets to create one data set.
dataset=rbind(X.train,X.test)
##read index
feature<-read.table(file[3])
index.mean<-subset(feature, grepl("mean()", V2))
index.std<-subset(feature, grepl("std()", V2))
index<-rbind(index.mean,index.std)
##Extracts the measurements on the mean and standard deviation for each measurement. 
newdata<-dataset[,index$V1]
##Uses descriptive activity names to name the activities in the data set
y.train=read.table(train[4])
y.test=read.table(test[4])
y=rbind(y.train,y.test)
y<-as.factor(y$V1)
label=read.table(file[1])
levels(y)<-label$V2
newdata1<-cbind(newdata,y)
##labels the data set with descriptive variable names. 
names(newdata1)<-c(as.character(index$V2), 'activities') 
##Creates a second, independent tidy data set with the 
##average of each variable for each activity and each subject.
sub.train=read.table(train[2])
sub.test=read.table(test[2])
sub=rbind(sub.train,sub.test)
names(newdata2)<-c(names(newdata1),"subject")
tiny_data<-aggregate(.~activities+subject,data=newdata2,mean)
View(tiny_data)
write.table(tiny_data,"Clean/tiny_data.txt",row.name=FALSE)
