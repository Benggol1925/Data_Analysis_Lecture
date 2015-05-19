#===========================================================
#    	       Support Vector Machines(SVM) 55-59p
#===========================================================
# train set / test set 

UKM <- read.csv("UKM.csv", header = T)
UKM <- UKM[,-7]
N <- nrow(UKM)
set.seed(1111)
tr.idx <- sample(1:N, size = N/2, replace = FALSE)
y <- UKM[,6]
x.tr <- UKM[tr.idx,-6] 
x.te <- UKM[-tr.idx,-6]
head(UKM)

# fit svm
install.packages("e1071")
library(e1071)
fit.svm <- svm(UNS~., data=UKM[tr.idx,], kernel = "linear")

# classification plot
plot(fit.svm, UKM, LPR ~ PEG)
summary(fit.svm)

# test
pred <- predict(fit.svm, newdata = x.te)

# check accuracy
table(pred, y[-tr.idx])

# compute decision values
pred <- predict(fit.svm, newdata = x.te, decision.value = TRUE)
attr(pred, "decision.value")[1:5,]

# visualize (classes by color, SV by crosses) :
plot(cmdscale(dist(x.tr)),
     col = as.integer(y[tr.idx]),
     pch = c("o","+")[1:N %in% fit.svm$index + 1])

# tuning 
obj <- tune(svm, UNS ~ LPR + PEG, data = UKM, 
            ranges = list(gamma = c(1.95, 2.05), cost = c(0.25, 0.35)))
summary(obj)
plot(obj)


#===========================================================
#  			              	신경망 모형	90-93p
#===========================================================
install.packages("nnet")
install.packages("devtools")
install.packages("doBy")
install.packages("NeuralNetTools")
library(devtools)
library(NeuralNetTools)
library(nnet)
library(doBy)

# training set / test set
UKM$num <- 1:nrow(UKM)
ukm.tr <- sampleBy(~ UNS, frac = 0.5, data = UKM)
ukm.te <- UKM[-ukm.tr$num, ]

# fit a neural network 
ukm1   <- nnet(UNS ~ ., data=ukm.tr, size = 2, decay = 5e-4)
summary(ukm1)

# 예측
y <- ukm.te$UNS 
p <- predict(ukm1, ukm.te, type="class")
table(y, p)


test.err <- function(h.size){
  
  ukm <- nnet(UNS ~., data=ukm.tr, size = h.size,
              decay = 5e-4, trace = FALSE)
  y <- ukm.te$UNS
  p <- predict(ukm, ukm.te, type = "class")
  err <- mean(y != p)
  c(h.size, err)
}

out <- t(sapply(2:10, FUN= test.err))
plot(out, type="b", xlab="The number of Hidden units",
     ylab="Test Error")

plotnet(ukm1)


#=========================================================== 
#                 					KNN    106p
#=========================================================== 

library(class)
set.seed(1)
y <- UKM[,6]
tr.idx <- sample(length(y), length(y)*0.5, replace=FALSE)
x.tr <- UKM[tr.idx, -6]
x.te <- UKM[-tr.idx, -6]

# modeling
m1 <- knn(x.tr, x.te, y[tr.idx], k = 3)

# 예측
table(m1, y[-tr.idx])
mean(m1 != y[-tr.idx])


#===========================================================
#   				          Naive Bayes    118-119p
#===========================================================
library(e1071)

y <- UKM[,6]
tr.idx <- sample(length(y), length(y)*0.5, replace=FALSE)
x.tr <- UKM[tr.idx, ]
x.te <- UKM[-tr.idx, ]
# modeling
model   <- naiveBayes(UNS ~ ., data = x.tr)
# 예측
predict(model, x.te)
predict(model, x.te[1:10,], type = "raw")
pred    <- predict(model, x.te)
table(pred, y[-tr.idx])
mean(pred != y[-tr.idx])


# ==========================================================
#  				            전진선택법 129-131p
#==========================================================

install.packages("ElemStatLearn")
library(ElemStatLearn)
Data <- prostate[,-ncol(prostate)]

#전진 선택법은 상수항만 포함된 모형(lm.const)에서 출발
lm.const <- lm(lpsa~1, data=Data)

#AIC를 이용한 전진 선택법
forward.aic <- step(lm.const, lpsa~lcavol + lweight 
                    + age + lbph + svi + lcp + gleason 
                    + pgg45, direction="forward")

#선택된 최종 모형
summary(forward.aic)


#===========================================================
#  				            후진 소거법 132-133p 
#===========================================================

#후진 소거법은 모든 변수가 포함된 모형(lm.full)에서 출발
lm.full <- lm(lpsa~., data=Data)

#AIC를 이용한 후진 소거법
backward.aic = step(lm.full, lpsa~1, direction="backward")

#선택된 최종 모형
summary(backward.aic)


#===========================================================
#  				          단계적 선택법  134-135p
#===========================================================

#단계적 선택법은 적절한 모형에서 출발
#여기서는 상수항만 포함된 모형(lm.const)에서 출발
#AIC를 이용한 단계적 선택법
stepwise.aic <- step(lm.const, lpsa~lcavol + lweight 
                     + age + lbph + svi + lcp + gleason 
                     + pgg45, direction="both")

#선택된 최종 모형
summary(stepwise.aic)


#=========================================================== 
#  				              	LASSO   139-140p
#===========================================================

# 데이터 불러오기
data(attitude)

# 반응 변수 지정
y <- attitude[,1] 

# 설명 변수 지정
x <- attitude[,-1] 

install.packages("glmnet")
library(glmnet)

# lasso 적합
lasso.fit <- glmnet(as.matrix(x),y,alpha=1)  

# 최적 조율 모수
cv.lasso <- cv.glmnet(as.matrix(x),y,alpha=1)  

# lasso 최종 모형
coef(lasso.fit,s=cv.lasso$lambda.min)


#===========================================================
#  					            Elastic net    144p
#===========================================================

# 데이터 불러오기
data(attitude)

# 반응 변수 지정
y <- attitude[,1]

# 설명 변수 지정
x <- attitude[,-1] 

#install.packages("glmnet")
library(glmnet)

# alpha = 0.5 인 elastic net 적합
lasso.fit <- glmnet(as.matrix(x),y,alpha=0.5)

# 최적 조율 모수
cv.lasso <- cv.glmnet(as.matrix(x),y,alpha=0.5)

# elastic net 최종 모형
coef(lasso.fit,s=cv.lasso$lambda.min)


#========================================================
#  		      	주성분 회귀분석		148-151p	
#========================================================

#데이터 읽기

import <- read.table("import_data.txt",header=TRUE)
import <- import[,-1]

# 주성분 분석
pc.cr <- princomp(import[,-1],cor=TRUE)
summary(pc.cr) 
summary(pc.cr)$loading
screeplot(pc.cr, npcs=3, type='lines')

#주성분 회귀분석 결과
S <- data.frame(summary(pc.cr)$score) # score 값 이용
R <- lm(scale(import$import) ~ Comp.1+Comp.2+Comp.3, data=S)
summary(R)
R <- lm(scale(import$import) ~ Comp.1+Comp.2, data=S)
summary(R)

#=======================================================
#  				    부분 최소 제곱	155-157p		
#=======================================================

#pls 패키지의 gasoline 자료 이용
install.packages("pls")
library(pls)
#부분 최소 제곱 회귀 모형 적합 : 교차확인 법을 통해 최대 10개의 성분까지 탐색
gas1 <- plsr(octane~NIR, ncomp = 10, data = gasoline, validation = "LOO")
#교차확인법 결과
summary(gas1)
#교차확인법 결과 도표로 표현
plot(RMSEP(gas1), legendpos = "topright")
#최적의 성분 개수인 2개의 성분을 가지는 부분 최소 제곱 회귀 모형 적합
gas1 <- plsr(octane~NIR, ncomp = 2, data = gasoline)
#X score
gas1$scores
#반응변수에 대한 예측값과, 반응변수에 대한 그래프
plot(gas1$fitted.values[,,2],gasoline$octane, pch=19)
