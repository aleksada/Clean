###Guide to create the tidy data file
1. Download the data folder, and set the downloaded location as my R default directory.
2.Use "list.files" function to store the file path of all data, train data, and test data.

```{r}
file<-list.files("UCI HAR Dataset-2",full.names=TRUE)
train<-list.files("UCI HAR Dataset-2/train",full.names=TRUE)
test<-list.files("UCI HAR Dataset-2/test",full.names=TRUE)
```
3.Merge the main data X.train and X.test, named it as "dataset" 

```{r}
X.train=read.table(train[3])
X.test=read.table(test[3])
dataset=rbind(X.train,X.test)
```
4.Match the measurements' names with their indexes, and then extracts only the measurements on the mean and standard deviation. 

```{r}
feature<-read.table(file[3])
index.mean<-subset(feature, grepl("mean()", V2))
index.std<-subset(feature, grepl("std()", V2))
index<-rbind(index.mean,index.std)
newdata<-dataset[,index$V1]
```
5. Match the descriptive activity names with their indexes and name the activities in the data set, I added it as a new column called activities to newdata, and called the merged dataset as newdata1

```{r}
y.train=read.table(train[4])
y.test=read.table(test[4])
y=rbind(y.train,y.test)
y<-as.factor(y$V1)
label=read.table(file[1])
levels(y)<-label$V2
newdata1<-cbind(newdata,y)
names(newdata1)<-c(as.character(index$V2), 'activities') 
```
6.Labels the data set with descriptive variable names. 

```{r}
names(newdata1)<-c(as.character(index$V2), 'activities') 
```
7.Read the subject file from subject.test and subject.train, then merge it.
After that, add another new column called "subject" to newdata1.
At last, use aggregate function to creates a second, independent tidy data set with the average of each variable for each activity and each subject.

```{r}
sub.train=read.table(train[2])
sub.test=read.table(test[2])
sub=rbind(sub.train,sub.test)
names(newdata2)<-c(names(newdata1),"subject")
tiny_data<-aggregate(.~activities+subject,data=newdata2,mean)
```
