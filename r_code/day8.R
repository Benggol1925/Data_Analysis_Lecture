#===========================================================
#  				        탐색적 자료분석	21p
#===========================================================
# set working directory
setwd("C:\\BEGAS\\DB진흥원-책수요예측")

# all data : 2013.01.01 ~ 2013.12.31 newly published books w/ all Genre. 57088 rows.
bookdb <- read.csv("dataset_v5.9_final.csv", header=TRUE)
save(bookdb, file="D:/07-Bigdata/Project/bookdb.rdata")

summary(bookdb)
head(bookdb)
str(bookdb)


# check variable attribute 
attach(bookdb)
class(ISBN_13)    # ISBN 13 code
class(PUBL_DATE)  # Publication Date 
class(PUBL_MONTH) # Publication Month
class(D14_SALE)   # Sales amount for 14 days since publication, y variable
class(AU_CNT)     # Number of Authors
class(AU_NO)      # Author id
class(AU_W_CNT)   # Number of Author's old books since the bookstore opened
class(AU_S_CNT)   # Author's accumulative sales amount since the bookstore opened
class(AU_S_AVG)   # AU_S_CNT / AU_W_CNT
class(PU_NO)      # Publisher id 
class(PU_W_CNT)   # Number of Publisher's old book since the bookstore opened
class(PU_S_CNT)   # Publisher's accumulative sales amount since the bookstore opened
class(PU_S_AVG)   # PU_S_CNT / PU_W_CNT
class(BK_PRICE)   # Price of new book

class(BSPT_BIZ)   # Weekly Bestseller score of Business
class(BSPT_LIB)   # Weekly Bestseller score of Humanities(Liberal Arts)
class(BSPT_SLF)   # Weekly Bestseller score of Self-Improvement
class(BSPT_LIT)   # Weekly Bestseller score of Domestic Literature 

class(F_INCOME)   # Quaterly Household Income
class(CSMP_EXP)   # Quaterly Consumption Expenditure(Total)
class(GRCR_EXP)   # Quaterly Consumption Expenditure(grocery)
class(BOOK_EXP)   # Quaterly Consumption Expenditure(Book)
class(BK_S_PRD)   # Monthly Book Sales Forecasting
class(BK_A_PRD)   # Monthly Book Activities Forecasting
class(BK_S_RTL)   # Monthly Book Sales Amount(Retail)
class(BK_S_OLN)   # Monthly Book Sales Amount(Online)
class(CSTMR_PI)   # Monthly Customer Prediction Index
class(CSTMR_PP)   # Monthly Customer Prediction Point
class(UNEMPLOY)   # Monthly Unemployment Rate

class(AU_BS_W1)   # Number of Author's Bestseller(Week1 before Publication of New book)
class(AU_BS_W2)   # Number of Author's Bestseller(Week2 before Publication of New book)
class(AU_BS_W3)   # Number of Author's Bestseller(Week3 before Publication of New book)
class(AU_BS_W4)   # Number of Author's Bestseller(Week4 before Publication of New book)
class(AU_BS_SC)   # Weighted Average Number of Author's Bestseller(W1-10%, W2-20%, W3-30%, W4-40%)
class(PU_BS_W1)   # Number of Publisher's Bestseller(Week1 before Publication of New book)
class(PU_BS_W2)   # Number of Publisher's Bestseller(Week2 before Publication of New book)
class(PU_BS_W3)   # Number of Publisher's Bestseller(Week3 before Publication of New book)
class(PU_BS_W4)   # Number of Publisher's Bestseller(Week4 before Publication of New book)
class(PU_BS_SC)   # Weighted Average Number of PUblisher's Bestseller(W1-10%, W2-20%, W3-30%, W4-40%)

class(AU_S_12M)   # Author's Recent Sales Amount(12 Months)
class(AU_S_06M)   # Author's Recent Sales Amount(6 Months)
class(AU_S_03M)   # Author's Recent Sales Amount(3 Months)
class(AU_S_01M)   # Author's Recent Sales Amount(1 Months)
class(PU_S_12M)   # Publisher's Recent Sales Amount(12 Months)
class(PU_S_06M)   # Publisher's Recent Sales Amount(6 Months)
class(PU_S_03M)   # Publisher's Recent Sales Amount(3 Months)
class(PU_S_01M)   # Publisher's Recent Sales Amount(1 Months)


# change variable attribute
bookdb$ISBN_13 <- as.character(ISBN_13)
bookdb$PUBL_DATE <- as.factor(PUBL_DATE)
bookdb$PUBL_MONTH <- as.factor(PUBL_MONTH)
bookdb$CATEG_NO <- as.factor(CATEG_NO)
bookdb$D14_SALE <- as.numeric(D14_SALE) # y variable
bookdb$AU_CNT <- as.numeric(AU_CNT)
bookdb$AU_W_CNT <- as.numeric(AU_W_CNT)
bookdb$AU_S_CNT <- as.numeric(AU_S_CNT)
bookdb$AU_S_AVG <- as.numeric(AU_S_AVG)
bookdb$PU_W_CNT <- as.numeric(PU_W_CNT)
bookdb$PU_S_CNT <- as.numeric(PU_S_CNT)
bookdb$PU_S_AVG <- as.numeric(PU_S_AVG)
bookdb$BK_PRICE <- as.numeric(BK_PRICE)

bookdb$BSPT_BIZ <- as.numeric(BSPT_BIZ)
bookdb$BSPT_LIB <- as.numeric(BSPT_LIB)
bookdb$BSPT_SLF <- as.numeric(BSPT_SLF)
bookdb$BSPT_LIT <- as.numeric(BSPT_LIT)

bookdb$F_INCOME <- as.numeric(F_INCOME)
bookdb$CSMP_EXP <- as.numeric(CSMP_EXP)
bookdb$GRCR_EXP <- as.numeric(GRCR_EXP)
bookdb$BOOK_EXP <- as.numeric(BOOK_EXP)
bookdb$BK_S_PRD <- as.numeric(BK_S_PRD)
bookdb$BK_A_PRD <- as.numeric(BK_A_PRD)
bookdb$BK_S_RTL <- as.numeric(BK_S_RTL)
bookdb$BK_S_OLN <- as.numeric(BK_S_OLN)
bookdb$CSTMR_PI <- as.numeric(CSTMR_PI)
bookdb$CSTMR_PP <- as.numeric(CSTMR_PP)
bookdb$UNEMPLOY <- as.numeric(UNEMPLOY)

bookdb$AU_BS_W1 <- as.numeric(AU_BS_W1)
bookdb$AU_BS_W2 <- as.numeric(AU_BS_W2)
bookdb$AU_BS_W3 <- as.numeric(AU_BS_W3)
bookdb$AU_BS_W4 <- as.numeric(AU_BS_W4)
bookdb$AU_BS_SC <- as.numeric(AU_BS_SC)
bookdb$PU_BS_W1 <- as.numeric(PU_BS_W1)
bookdb$PU_BS_W2 <- as.numeric(PU_BS_W2)
bookdb$PU_BS_W3 <- as.numeric(PU_BS_W3)
bookdb$PU_BS_W4 <- as.numeric(PU_BS_W4)
bookdb$PU_BS_SC <- as.numeric(PU_BS_SC)

bookdb$AU_S_12M <- as.numeric(AU_S_12M)
bookdb$AU_S_06M <- as.numeric(AU_S_06M)
bookdb$AU_S_03M <- as.numeric(AU_S_03M)
bookdb$AU_S_01M <- as.numeric(AU_S_01M)
bookdb$PU_S_12M <- as.numeric(PU_S_12M)
bookdb$PU_S_06M <- as.numeric(PU_S_06M)
bookdb$PU_S_03M <- as.numeric(PU_S_03M)
bookdb$PU_S_01M <- as.numeric(PU_S_01M)



#===========================================================
#  				                22p	
#===========================================================
# frequency of y 
table(bookdb$PUBL_MONTH)

summary(bookdb$D14_SALE)
table(bookdb$D14_SALE)
SALE_GB <- seq(-100, 1000, by=100)
table(cut(bookdb$D14_SALE, c(SALE_GB, Inf)))


# plotting
plot(bookdb$D14_SALE ~ bookdb$AU_CNT)
abline(lm(bookdb$D14_SALE ~ bookdb$AU_CNT), col = "red")

plot(bookdb$D14_SALE ~ bookdb$AU_W_CNT)
abline(lm(bookdb$D14_SALE ~ bookdb$AU_W_CNT), col = "red")

plot(bookdb$D14_SALE ~ bookdb$AU_S_CNT)
abline(lm(bookdb$D14_SALE ~ bookdb$AU_S_CNT), col = "red")

plot(bookdb$D14_SALE ~ bookdb$AU_S_AVG)
abline(lm(bookdb$D14_SALE ~ bookdb$AU_S_AVG), col = "red")

plot(bookdb$D14_SALE ~ bookdb$PU_W_CNT)
abline(lm(bookdb$D14_SALE ~ bookdb$PU_W_CNT), col = "red")

plot(bookdb$D14_SALE ~ bookdb$PU_S_CNT)
abline(lm(bookdb$D14_SALE ~ bookdb$PU_S_CNT), col = "red")

plot(bookdb$D14_SALE ~ bookdb$PU_S_AVG)
abline(lm(bookdb$D14_SALE ~ bookdb$PU_S_AVG), col = "red")

plot(bookdb$D14_SALE ~ bookdb$CSTMR_PI)
abline(lm(bookdb$D14_SALE ~ bookdb$CSTMR_PI), col = "red")

plot(bookdb$D14_SALE ~ bookdb$CSTMR_PP)
abline(lm(bookdb$D14_SALE ~ bookdb$CSTMR_PP), col = "red")


# plotting w/ log10(y+1)
plot(log10(bookdb$D14_SALE+1) ~ log10(bookdb$AU_CNT))
abline(lm(log10(bookdb$D14_SALE+1) ~ log10(bookdb$AU_CNT)), col = "red")

plot(log10(bookdb$D14_SALE+1) ~ log10(bookdb$AU_W_CNT+1))
abline(lm(log10(bookdb$D14_SALE+1) ~ log10(bookdb$AU_W_CNT+1)), col = "red")

plot(log10(bookdb$D14_SALE+1) ~ log10(bookdb$AU_S_CNT+1))
abline(lm(log10(bookdb$D14_SALE+1) ~ log10(bookdb$AU_S_CNT+1)), col = "red")

plot(log10(bookdb$D14_SALE+1) ~ log10(bookdb$AU_S_AVG+1))
abline(lm(log10(bookdb$D14_SALE+1) ~ log10(bookdb$AU_S_AVG+1)), col = "red")

plot(log10(bookdb$D14_SALE+1) ~ log10(bookdb$PU_W_CNT+1))
abline(lm(log10(bookdb$D14_SALE+1) ~ log10(bookdb$PU_W_CNT+1)), col = "red")

plot(log10(bookdb$D14_SALE+1) ~ log10(bookdb$PU_S_CNT+1))
abline(lm(log10(bookdb$D14_SALE+1) ~ log10(bookdb$PU_S_CNT+1)), col = "red")

plot(log10(bookdb$D14_SALE+1) ~ log10(bookdb$PU_S_AVG+1))
abline(lm(log10(bookdb$D14_SALE+1) ~ log10(bookdb$PU_S_AVG+1)), col = "red")

plot(log10(bookdb$D14_SALE+1) ~ log10(bookdb$CSTMR_PI))
abline(lm(log10(bookdb$D14_SALE+1) ~ log10(bookdb$CSTMR_PI)), col = "red")

plot(log10(bookdb$D14_SALE+1) ~ log10(bookdb$CSTMR_PP))
abline(lm(log10(bookdb$D14_SALE+1) ~ log10(bookdb$CSTMR_PP)), col = "red")


# histogram
hist(bookdb$D14_SALE, nclass=20)
hist(log10(bookdb$D14_SALE), nclass=20)

attach(bookdb)
hist(AU_CNT, nclass=20)
hist(AU_W_CNT, nclass=20)
hist(AU_S_CNT, nclass=20)
hist(AU_S_AVG, nclass=20)
hist(PU_W_CNT, nclass=20)
hist(PU_S_CNT, nclass=20)
hist(PU_S_AVG, nclass=20)

hist(log10(AU_W_CNT+1), nclass=20)
hist(log10(AU_S_CNT+1), nclass=20)
hist(log10(AU_S_AVG+1), nclass=20)
hist(log10(PU_W_CNT+1), nclass=20)
hist(log10(PU_S_CNT+1), nclass=20)
hist(log10(PU_S_AVG+1), nclass=20)


#===========================================================
#  				              23p
#===========================================================
# cor.test
attach(bookdb)
cor.test(D14_SALE, AU_CNT)     # cor = 0.2622262 / p-value < 2.2e-16
cor.test(D14_SALE, AU_W_CNT)   # cor = 0.1890935 / p-value < 2.2e-16
cor.test(D14_SALE, AU_S_CNT)   # cor = 0.3010771 / p-value < 2.2e-16
cor.test(D14_SALE, AU_S_AVG)   # cor = 0.2846076 / p-value < 2.2e-16
cor.test(D14_SALE, PU_W_CNT)   # cor =-0.0211457 / p-value = 0.0594
cor.test(D14_SALE, PU_S_CNT)   # cor = 0.1227032 / p-value < 2.2e-16
cor.test(D14_SALE, PU_S_AVG)   # cor = 0.1767787 / p-value < 2.2e-16
cor.test(D14_SALE, BK_PRICE)   # cor = 0.0021113 / p-value = 0.8507 (X)

cor.test(D14_SALE, BSPT_BIZ)   # cor =-0.0058652 / p-value = 0.6011 (X)
cor.test(D14_SALE, BSPT_LIB)   # cor =-0.0082007 / p-value = 0.4648 (X)
cor.test(D14_SALE, BSPT_SLF)   # cor = 0.0110642 / p-value = 0.3240 (X)
cor.test(D14_SALE, BSPT_LIT)   # cor =-0.0055054 / p-value = 0.6236 (X)

cor.test(D14_SALE, F_INCOME)   # cor =-0.0134811 / p-value = 0.2294 (X)
cor.test(D14_SALE, CSMP_EXP)   # cor =-0.0125098 / p-value = 0.2648 (X)
cor.test(D14_SALE, GRCR_EXP)   # cor =-0.0078770 / p-value = 0.4826 (X)
cor.test(D14_SALE, BOOK_EXP)   # cor =-0.0070450 / p-value = 0.5300 (X)
cor.test(D14_SALE, BK_S_PRD)   # cor =-0.0007526 / p-value = 0.9465 (X)
cor.test(D14_SALE, BK_A_PRD)   # cor = 0.0085301 / p-value = 0.4470 (X)
cor.test(D14_SALE, BK_S_RTL)   # cor = 0.0077438 / p-value = 0.4900 (X)
cor.test(D14_SALE, BK_S_OLN)   # cor = 0.0030628 / p-value = 0.7848 (X)
cor.test(D14_SALE, CSTMR_PI)   # cor =-0.0186792 / p-value = 0.0959 
cor.test(D14_SALE, CSTMR_PP)   # cor =-0.0281026 / p-value = 0.0122 
cor.test(D14_SALE, UNEMPLOY)   # cor =-0.0069487 / p-value = 0.5356 (X)

# boxplot
boxplot(D14_SALE)
boxplot(AU_CNT)
boxplot(AU_W_CNT)
boxplot(AU_S_CNT)
boxplot(AU_S_AVG)
boxplot(PU_W_CNT)
boxplot(PU_S_CNT)
boxplot(PU_S_AVG)



#===========================================================
#    			          Linear Regression 24p
#===========================================================

# formula_01 : linear regression w/ 8 variables 
reg.01 <- D14_SALE ~ AU_W_CNT + AU_S_CNT + AU_S_AVG + PU_W_CNT + PU_S_CNT + PU_S_AVG + CSTMR_PI + CSTMR_PP

summary(lm.01 <- step(lm(reg.01, data = bookdb), direction = "backward")) 
# Adjusted R-squared : 0.1209 / p-value < 2.2e-16 

plot(bookdb$D14_SALE, lm.01$fitted.values)
abline(lm(bookdb$D14_SALE ~ lm.01$fitted.values), col = "red")


#-----------------------------------------------------------------------------------------------------

# formula_02
reg.02 <- D14_SALE ~ AU_W_CNT + AU_S_CNT + AU_S_AVG + PU_W_CNT + PU_S_CNT + PU_S_AVG + CSTMR_PI + CSTMR_PP + 0

summary(lm.02 <- step(lm(reg.02, data = bookdb), direction = "backward")) 
# Adjusted R-squared : 0.1277 / p-value < 2.2e-16 

plot(bookdb$D14_SALE, lm.02$fitted.values)
abline(lm(bookdb$D14_SALE ~ lm.02$fitted.values), col = "red")


#-----------------------------------------------------------------------------------------------------

# formula_03
reg.03 <- log10(D14_SALE+1) ~ log10(AU_W_CNT+1) + log10(AU_S_CNT+1) + log10(AU_S_AVG+1) + log10(PU_W_CNT+1) + log10(PU_S_CNT+1) + log10(PU_S_AVG+1) + log10(CSTMR_PI+1) + log10(CSTMR_PP+1)

summary(lm.03 <- step(lm(reg.03, data = bookdb), direction = "backward")) 
# Adjusted R-squared : 0.3217 / p-value < 2.2e-16 




#===========================================================
#      		         모형 평가 지표 25p
#===========================================================

# formula_01 : linear regression w/ 8 variables 
reg.01 <- D14_SALE ~ AU_W_CNT + AU_S_CNT + AU_S_AVG + PU_W_CNT + PU_S_CNT + PU_S_AVG + CSTMR_PI + CSTMR_PP

summary(lm.01 <- step(lm(reg.01, data = bookdb), direction = "backward")) 
# Adjusted R-squared : 0.1209 / p-value < 2.2e-16 


# MAPE function
MAPE.func <- function(real.value = NULL, pred.value = NULL){
  mape.df <- data.frame(real.val = real.value, pred.val = pred.value)
  tot.r <- sum(mape.df$real.val)
  sum(apply(mape.df, 1, function(x) min(1, abs((x[1]-x[2])/x[1]))*x[1]/tot.r))
}

MAPE.func(real.value = bookdb$D14_SALE, pred.value = lm.01$fitted.values)

# Adjusted R-squared function 
ADJ.R2.func <- function(real.value = NULL, pred.value = NULL, P = NULL, N = NULL){
  1 - ((1 - (cor(real.value, pred.value))^2)*(N - 1) / (N - P - 1))
}
ADJ.R2.func(real.value = bookdb$D14_SALE, 
            pred.value = lm.01$fitted.values, 
            P = length(lm.01$coefficients) - 1, 
            N = nrow(bookdb))


#===========================================================
#      		        일반화 선형모형26p
#===========================================================

# 데이터 전처리
# in case that AU_CNT is 1. 7810 rows.
install.packages("sqldf")
library(sqldf)

bookdb_01 <- sqldf("select * from bookdb where AU_CNT = 1 ")
# in case that AU_SALE_CNT > 0. 7274 rows.
bookdb_02 <- sqldf("select * from bookdb_01 where AU_S_CNT > 0")

# Training data와 test data 나누기
set.seed(212)
ind <- sample(2, nrow(bookdb_02), replace = TRUE, prob = c(0.8,0.2))

bookdb.tr <- bookdb_02[ind==1,]
bookdb.te <- bookdb_02[ind==2,]

# GLM Poisson Regression
library(MASS)
reg.glm <- D14_SALE ~ AU_W_CNT + AU_S_CNT + AU_S_AVG + PU_W_CNT + PU_S_CNT + PU_S_AVG + AU_BS_W1 + AU_BS_W2 + AU_BS_W3 + AU_BS_W4 + AU_BS_SC + PU_BS_W1 + PU_BS_W2 + PU_BS_W3 + PU_BS_W4 + PU_BS_SC+ AU_S_12M + AU_S_06M + AU_S_03M + AU_S_01M + PU_S_12M + PU_S_06M + PU_S_03M + PU_S_01M 
summary(glm.pos <- glm(reg.glm, data = bookdb.tr, family = poisson(link = log))) 
# Null Deviance : 255092
# Residual Deviance : 74963
# AIC : 77347
MAPE.func(real.value = bookdb.tr$D14_SALE, pred.value = glm.pos$fitted.values) 
# MAPE : 0.4635



#===========================================================
#      		              Neural Networks 27p
#===========================================================

# NN(Neural Networks) 

install.packages("nnet")
library(nnet)


# regression formula 
reg.fin <- D14_SALE ~ AU_W_CNT + AU_S_CNT + AU_BS_W1 + AU_BS_W2 + AU_BS_W3 + AU_BS_W4 + PU_BS_W4 + AU_S_03M


# Model fitting 
nfold <- 10
tuning_result <- data.frame(decay_val = NA)  

random_index <- 1:nrow(bookdb_02)                     
cv_data_num <- as.integer(nrow(bookdb_02)/nfold)      

para_names <- c("AU_W_CNT", "AU_S_CNT", "AU_BS_W1", "AU_BS_W2", "AU_BS_W3", "AU_BS_W4", "PU_BS_W4", "AU_S_03M")

pred_val <- real_val <- bookdb_02$D14_SALE              


# set the optimal parameter : decay(parameter for weight decay) 
# choose the decay which has the least RSS value 
for(k in seq(0, 1, length.out = 11))
{
  print(k)
  for(j in 1:nfold)
  {
    if(j != nfold){
      cv_test_index <- random_index[((j-1)*cv_data_num+1):(j*cv_data_num)]
    } else {
      cv_test_index <- random_index[((j-1)*cv_data_num+1):nrow(bookdb_02)]
    }
    model_result <- nnet(reg.fin, data = bookdb_02[-cv_test_index,], decay = as.double(k), size=2, maxit = 100000, trace = F, linout=T, abstol = 1.0e-12, reltol = 1.0e-24)
    pred_val[cv_test_index] <- predict(model_result, as.matrix(bookdb_02[cv_test_index, para_names]))
  }  
  RSS <- mean((pred_val - real_val)^2)
  if(k==0){
    MIN_RSS <- RSS
    tuning_result$decay_val <- k
  } else if(RSS < MIN_RSS){
    MIN_RSS <- RSS
    tuning_result$decay_val <- k
  }
}


# Set model : decay(parameter for weight decay)
# neuralnetwork 
model.nn <- nnet(reg.fin, data = bookdb_02, decay = as.double(tuning_result$decay_val), size=1, maxit = 100000, trace = F, linout=T, abstol = 1.0e-12, reltol = 1.0e-24)


# fitted values
model.nn$fitted.values


# prediction 
pred.nn <- predict(model.nn, as.matrix(bookdb_02[,para_names]))




#===========================================================
#      		              	SVM 28p
#===========================================================

# SVM(Support Vector Machine) 

install.packages("kernlab")
library(kernlab)


# Model fitting 
nfold <- 10
tuning_result <- data.frame(C = NA, epsilon = NA)                     

random_index <- 1:nrow(bookdb.tr)                     
cv_data_num <- as.integer(nrow(bookdb.tr)/nfold)   

para_names <- c("AU_W_CNT", "AU_S_CNT", "AU_BS_W1", "AU_BS_W2", "AU_BS_W3", "AU_BS_W4", "PU_BS_W4", "AU_S_03M")

pred_val <- real_val <- bookdb.tr$D14_SALE   


for(C_val in (1:5)*5)
{
  for(epsilon_val in (1:5)/20)
  {
    Cross_ERR <- cross(ksvm(reg.fin, data = bookdb.tr, type = 'eps-svr', kernel = 'vanilladot', C = C_val, epsilon = epsilon_val, cross = 10))
    
    if(C_val == 5 & epsilon_val == 1/20)
    {
      MIN_ERR <- Cross_ERR
      tuning_result$C <- C_val
      tuning_result$epsilon <- epsilon_val
    } else if (Cross_ERR < MIN_ERR) {
      MIN_ERR <- Cross_ERR
      tuning_result$C <- C_val
      tuning_result$epsilon <- epsilon_val
    }
  }
}


# set model 
model.svm <- ksvm(reg.fin, data = bookdb.tr, type = 'eps-svr', kernel = 'vanilladot', C = tuning_result$C, epsilon = tuning_result$epsilon)


# fitted values
fitted(model.svm)


# prediction
pred.svm <- unlist(predict(model.svm, as.matrix(bookdb.tr[, para_names])))


MAPE.func(real.value = bookdb.tr$D14_SALE, pred.value = c(pred.svm))
# 0.4460

ADJ.R2.func(real.value = bookdb.tr$D14_SALE, pred.value = c(pred.svm), P = 8, N = nrow(bookdb.tr))
# 0.7372



#===========================================================
#      		            Boosting 29p
#===========================================================

# Boosting 

install.packages("gbm")
library(gbm)

# Model fitting 
nfold <- 10
tuning_result <- data.frame(shrinkage = NA)

random_index <- 1:nrow(bookdb_02)                     
cv_data_num <- as.integer(nrow(bookdb_02)/nfold)

para_names <- c("AU_W_CNT", "AU_S_CNT", "AU_BS_W1", "AU_BS_W2", "AU_BS_W3", "AU_BS_W4", "PU_BS_W4", "AU_S_03M")


for(shrinkage in (1:100)/10)
{
  Cross_ERR <- mean(gbm(reg.fin, data = bookdb_02, distribution = "laplace", shrinkage = shrinkage, cv.folds = nfold, verbose = F)$cv.error)
  if(shrinkage == 0.1)
  {
    MIN_ERR <- Cross_ERR
    tuning_result$shrinkage <- shrinkage
  } else if (Cross_ERR < MIN_ERR) {
    MIN_ERR <- Cross_ERR
    tuning_result$shrinkage <- shrinkage
  }
}


# set model
model.gbm <- gbm(reg.fin, data = bookdb_02, distribution = "laplace", shrinkage = tuning_result$shrinkage, verbose = F)

# prediction 
pred.gbm <- predict(model.gbm, bookdb_02[, para_names], n.trees=100)

