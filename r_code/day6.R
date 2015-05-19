# ==========================================================
#  				               연관성 분석31-34p
#=========================================================== 

#install.packages("arules")
library(arules)

a_df <- sample(c(LETTERS[1:5],NA),10,TRUE)
a_df <- data.frame(X=a_df, Y=sample(a_df))

trans <- as(a_df,"transactions")
as(trans, "data.frame")

#Adult data
data(Adult)

# association rules with support >=0.4  
# support=0.4 옵션을 주게되면 지지도가 0.4 이상인 것
rules <- apriori(Adult,parameter=list(support=0.4))

summary(rules)

# 지지도가 0.4이상이면서 향상도가 1.3 이상인 것
rules.sub <- subset(rules, subset=rhs %pin% "sex" & lift>1.3)
inspect(sort(rules.sub)[1:3])



#===========================================================
#  			              	군집분석55-66p					
#===========================================================
# 데이터 생성
crime <- data.frame(num=1:16,
                    city=c("Atlanta","Boston","Chicago","Dallas","Denver","Detroit",
                           "Hartford","Honolulu","Houston","Kansas City","Los Angeles",
                           "New Orlean","New Yotk","Portland","Tucson","Washington"),
                    murder=c(16.5,4.2,11.6,18.9,6.9,13.0,2.5,3.6,16.8,10.8,9.7,10.3,
                             9.4,5.9,5.1,12.5),
                    rape=c(24.8,13.3,4.7,34.2,41.5,35.7,8.8,12.7,26.6,43.2,51.8,39.7,
                           19.4,23.0,22.9,27.6))
attach(crime)
# murder와 rape만 가져오기
x <- crime[,3:4]
# 소수점 둘째 자리까지 표현
dx <- round(dist(x), digits=2)

# 거리구하기
D1 <- dist(x) # 유클리드
D2 <- dist(x,method="manhattan") # 맨하탄
# Hierarchical cluster analysis
hc1 <- hclust(dist(x)^2,method="single") #최단 연결법
plot(hc1,labels=city,hang=1, main="dendrogram : single")

hc2 <- hclust(dist(x)^2, method="complete") #최장 연결법
plot(hc2, labels=city, hang=1, main="dendrogram : complete")

c1.num <- 2  # setting number of clusters
hc1.result <- cutree(hc1,k=c1.num)
plot(x,pch=hc1.result,col=hc1.result)
text(x,labels=city, adj=-0.1, cex=0.8, main="single")

hc2.result <- cutree(hc2,k=c1.num)
plot(x,pch=hc2.result, col=hc2.result)
text(x,labels=city, adj=-0.1, cex=0.8, main="complete")


# K-means 

crime <- data.frame(num=1:16,
                    city=c("Atlanta","Boston","Chicago","Dallas","Denver","Detroit",
                           "Hartford","Honolulu","Houston","Kansas City","Los Angeles",
                           "New Orlean","New Yotk","Portland","Tucson","Washington"),
                    murder=c(16.5,4.2,11.6,18.9,6.9,13.0,2.5,3.6,16.8,10.8,9.7,10.3,
                             9.4,5.9,5.1,12.5),
                    rape=c(24.8,13.3,4.7,34.2,41.5,35.7,8.8,12.7,26.6,43.2,51.8,39.7,
                           19.4,23.0,22.9,27.6))
attach(crime)
x <- crime[,3:4]

crime_k <- kmeans(x,centers=3) # 3개 군집
attributes(crime_k)
crime_k$cluster

#grouping
clus <- cbind(city,x,crime_k$cluster)
clus1 <- clus[(clus[,4]==1),]
clus2 <- clus[(clus[,4]==2),]
clus3 <- clus[(clus[,4]==3),]

kc <-table(crime_k$cluster)
plot(x,pch=crime_k$cluster,col=crime_k$cluster,main="K-means clustering")
text(x,labels=city,adj=-0.1, cex=0.8)



#===========================================================
#  					                CART 110-114p
#===========================================================
setwd("데이터 저장위치")

UKM <- read.csv("데이터이름.확장자명", header = T)
UKM <- data.frame(UKM)
head(UKM)
str(UKM)

# Train, Test data
sample.num  <- sample(1:nrow(UKM), 0.7*nrow(UKM))
train       <- UKM[sample.num,]
test        <- UKM[-sample.num,]

library(rpart)
library(rpart.plot)

ukm.tr.cart <- rpart(UNS ~.,train)
ukm.tr.cart
plot(ukm.tr.cart)
text(ukm.tr.cart, all=T)

# 시각적인 그래프
prp(ukm.tr.cart, type=4, extra=1, digits=3)

# 예측
yhat  <- predict(ukm.tr.cart, newdata=test, type="class")
ytest <- test[,6]
table(yhat,ytest)


#===========================================================
#  					              C5.0  115-117p				
#===========================================================

#install.packages("C50")
library(C50)

# modeling 
ukm.tr.c5  <- C5.0(UNS ~.,train)
summary(ukm.tr.c5)
plot(ukm.tr.c5)

# 예측
yhat  <- predict(ukm.tr.c5, newdata=test, type="class")
ytest <- test[,6]
table(yhat,ytest)


#===========================================================
#  			                	QUESET	118-120p					
#===========================================================
#install.packages("party")
library(party)

# modeling
ukm.tr.q <- ctree(UNS ~., train, controls = ctree_control(testtype=c("Bonferroni")))
summary(ukm.tr.q)

# plot
plot(ukm.tr.q)

# predict & table
yhat  <- predict(ukm.tr.q, newdata=test, type="class")
ytest <- test[,6]
table(yhat,ytest)


#===========================================================
#  				              	Tree 121-125p
#===========================================================
#install.packages("tree")
library(tree)
ukm.tr <- tree(UNS ~ ., data=train, split="deviance")
ukm.tr

plot(ukm.tr)
text(ukm.tr)
summary(ukm.tr)


# 노드 가지치기
ukm.tr1 <- snip.tree(ukm.tr, nodes=c(10))
plot(ukm.tr1)
text(ukm.tr1, all=T)

# 파티션 만들기
par(pty="s")
plot(train[,4], train[,5], type="n", xlab="LPR", ylab="PEG")
text(train[,4], train[,5], c("h","l","m","vl")[train[,6]])
partition.tree(ukm.tr, add=TRUE, cex=1.5)

#끝마디수로 노드 가지치기 
ukm.tr2 <- prune.misclass(ukm.tr)
plot(ukm.tr2)
fin.tr  <- prune.misclass(ukm.tr, best=6)

plot(fin.tr)
text(fin.tr)