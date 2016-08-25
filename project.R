install.packages("rpart")
install.packages("e1071")
install.packages("class")
install.packages("ipred")
install.packages("adabag")
install.packages("ada")
install.packages("gbm")
install.packages("randomForest")
install.packages("ggplot2")
library("e1071")
library("class")
library("rpart")
library("ipred")
library("adabag")
library("ada")
library("gbm")
library("ggplot2")
library("randomForest")

pump = read.csv("myTrain.csv", header = TRUE)
pump[, -which(sapply(pump, is.numeric))]<-as.data.frame(lapply((pump[,-which(sapply(pump, is.numeric))]), as.factor))

############ Class Distribution
a= ggplot(data = pump,mapping = aes(factor(pump$status_group)))
a+ geom_bar()

############## Sampling
ind = sample(2,nrow(pump),replace = TRUE,prob = c(0.7,0.3))
train_pump =  pump[ind ==1,]
train_pump = na.omit(train_pump)
test_pump = pump[ind ==2,]
test_pump= na.omit(test_pump)

################## Naive Bayes
naive = naiveBayes(as.factor(status_group)~.,train_pump )
predict_naive = predict(naive, test_pump)
table(predict_naive, test_pump$status_group)
plot(predict_naive, test_pump$status_group, main="Naive Bayes")

################### DTree
water_tree = rpart(status_group~.,method = "class",data=train_pump)
printcp(water_tree)
prunedTree = prune(water_tree,cp=0.01)
pred = predict(prunedTree,test_pump,type="class")
table(pred, test_pump$status_group)
plot(pred, test_pump$status_group,main="Decision Tree")

################## Random Forest
rf <- randomForest(as.factor(status_group) ~ .,data=train_pump,importance=TRUE, ntree=2000)
predict_forest<-predict(rf,test_pump)
table(predict_forest, test_pump$status_group)
plot(predict_forest, test_pump$status_group,main = "Random Forest")

################## Bagging
bag <- ipred::bagging(as.factor(status_group)~., data=train_pump, boos = TRUE,mfinal=10,control = rpart.control(cp = 0)) 
predict_bag<-predict(bag,test_pump)
table(predict_bag,test_pump$status_group)
plot(predict_bag,test_pump$status_group, main = "Bagging")

################ Boosting
gb = gbm.fit(train_pump[,-31],train_pump[,31],n.trees=1,verbose = FALSE,shrinkage=0.001 ,bag.fraction = 0.3 ,interaction.depth = 1, n.minobsinnode = 1, distribution = "gaussian")  
predict_boosting <- predict(gb,test_pump[,-31],n.trees=1)
table(predict_boosting,test_pump$status_group)

############ SVM
svm = svm(as.factor(status_group)~., data=train_pump, kernel="linear", cost= 1)
predict_svm = predict(svm, test_pump)
table(predict_svm,test_pump$status_group)
plot(predict_svm,test_pump$status_group,main = "SVM")

################## END ########################################




