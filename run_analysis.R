library(dplyr)
x_test<-read.table("X_test.txt")
x_train<-read.table("X_train.txt")
y_train<-read.table("y_train.txt")
y_test<-read.table("y_test.txt")
x_train_id <- read.table("subject_train.txt")
x_test_id <- read.table("subject_test.txt")
print(c(dim(x_train),dim(x_test),dim(y_train),dim(y_test)))
print(c(dim(x_train_id),dim(x_test_id)))
x_train_id<-rename(x_train_id,subject_id=V1)
x_test_id<-rename(x_test_id,subject_id=V1)
names(x_train_id)
names(x_test_id)
x_train<-cbind(x_train,x_train_id)
x_test<-cbind(x_test,x_test_id)
x_merged<-rbind(x_train,x_test)
y_merged<-rbind(y_train,y_test)
names(x_merged)
print(c(dim(x_merged),dim(y_merged)))
x_selected<-x_merged[,1:6]
for (i in 1:4) x_selected<-cbind(x_selected,x_merged[,(i*40+1):(i*40+6)])
for (i in 1:5) x_selected<-cbind(x_selected,x_merged[,(200+(i-1)*13+1):(200+(i-1)*13+2)])
for (i in 1:3) x_selected<-cbind(x_selected,x_merged[,(265+(i-1)*79+1):(265+(i-1)*79+6)])
for (i in 1:4) x_selected<-cbind(x_selected,x_merged[,(502+(i-1)*13+1):(502+(i-1)*13+2)])
print(dim(x_selected))
head(x_selected)
names(x_selected)
x_final <- rename(x_selected,
                  tBodyAcc_mean_X=V1,tBodyAcc_mean_Y=V2,tBodyAcc_mean_Z=V3,
                  tBodyAcc_std_X=V4,tBodyAcc_std_Y=V5,tBodyAcc_std_Z=V6,
                  tGravityAcc_mean_X=V41,tGravityAcc_mean_Y=V42,tGravityAcc_mean_Z=V43,
                  tGravityAcc_std_X=V44,tGravityAcc_std_Y=V45,tGravityAcc_std_Z=V46,
                  tBodyAccJerk_mean_X=V81,tBodyAccJerk_mean_Y=V82,tBodyAccJerk_mean_Z=V83,
                  tBodyAccJerk_std_X=V84,tBodyAccJerk_std_Y=V85,tBodyAccJerk_std_Z=V86,
                  tBodyGyro_mean_X=V121,tBodyGyro_mean_Y=V122,tBodyGyro_mean_Z=V123,
                  tBodyGyro_std_X=V124,tBodyGyro_std_Y=V125,tBodyGyro_std_Z=V126,
                  tBodyGyroJerk_mean_X=V161,tBodyGyroJerk_mean_Y=V162,tBodyGyroJerk_mean_Z=V163,
                  tBodyGyroJerk_std_X=V164,tBodyGyroJerk_std_Y=V165,tBodyGyroJerk_std_Z=V166,
                  tBodyAccMag_mean=V201,tBodyAccMag_std=V202,
                  tGravityAccMag_mean=V214,tGravityAccMag_std=V215,
                  tBodyAccJerkMag_mean=V227,tBodyAccJerkMag_std=V228,
                  tBodyGyroMag_mean=V240,tBodyGyroMag_std=V241,
                  tBodyGyroJerkMag_mean=V253,tBodyGyroJerkMag_std=V254,
                  fBodyAcc_mean_X=V266,fBodyAcc_mean_Y=V267,fBodyAcc_mean_Z=V268,
                  fBodyAcc_std_X=V269,fBodyAcc_std_Y=V270,fBodyAcc_std_Z=V271,
                  fBodyAccJerk_mean_X=V345,fBodyAccJerk_mean_Y=V346,fBodyAccJerk_mean_Z=V347,
                  fBodyAccJerk_std_X=V348,fBodyAccJerk_std_Y=V349,fBodyAccJerk_std_Z=V350,
                  fBodyGyro_mean_X=V424,fBodyGyro_mean_Y=V425,fBodyGyro_mean_Z=V426,
                  fBodyGyro_std_X=V427,fBodyGyro_std_Y=V428,fBodyGyro_std_Z=V429,
                  fBodyAccMag_mean=V503,fBodyAccMag_std=V504,
                  fBodyBodyAccJerkMag_mean=V516, fBodyBodyAccJerkMag_std=V517,
                  fBodyBodyGyroMag_mean=V529,fBodyBodyGyroMag_std=V530,
                  fBodyBodyGyroJerkMag_mean=V542,fBodyBodyGyroJerkMag_std=V543,
                  )
y_final<-rename(y_merged,activity_labels=V1)
names(x_final)
names(y_final)
x_final_final<-cbind(x_final,y_final)
x_final_final<-cbind(x_final_final,x_merged["subject_id"])
names(x_final_final)
summarized<-x_final_final%>%group_by(activity_labels,subject_id)%>%summarize_all(mean)
write.table(summarized,"tidy_data.txt",row.name=FALSE)
