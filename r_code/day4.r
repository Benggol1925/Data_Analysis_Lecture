### day4 ###

#===========================================================
#                      잔차분석 (p.9)
#===========================================================
#단순 선형회귀분석 예 
sale=data.frame(company=c(1:12),
                adver=c(11,19,23,26,56,62,29,30,38,39,46,49),
                sales=c(23,32,36,46,93,99,49,50,65,70,71,89))

R=lm(sales~adver,data=sale)
summary(R)
plot(sale$sales~sale$adver,pch=19,xlab="adver",ylab="sales")
abline(R,col="red")
par(mfrow=c(2,2));plot(R)

cbind(sales=sale$sales,predict(R, interval="confidence"),
      residual=summary(R)$res)

#===========================================================
#                      다중공선성 (p.17)
#===========================================================
fitness=data.frame=data.frame(oxygen=c(44.609 , 54.297,  49.874,	45.618,	39.442,
                                       50.541,	44.754,	51.855,	40.836,	46.774,
                                       39.407,	45.441,	45.118,	45.79,	48.673,
                                       47.467,	45.313,	59.571,	44.811,	49.091,
                                       60.055,	37.388,	47.273,	49.156,	46.672,	
                                       50.388,	46.08,	54.625,	39.203,	50.545,
                                       47.92),
                              age=c(44,  44,	38,	40,	44,	44,	45,	54,	51,	48,	57,
                                    52,	51,	51,	49,	52,	40,	42,	47,	43,	38,	45,	
                                    47,	49,	51,	49,	54,	50,	54,	57,	48),
                              weight=c(89.47,  85.84,	89.02,	75.98,	81.42,	73.03,
                                       66.45,	83.12,	69.63,	91.63,	73.37,	76.32,
                                       67.25,	73.71,	76.32,	82.78,	75.07,	68.15,
                                       77.45,	81.19,	81.87,	87.66,	79.15,	81.42,
                                       77.91,	73.37,	79.38,	70.87,	97.63,	59.08,
                                       61.24),
                              runtime=c(11.37,  8.65,	9.22,	11.95,	13.08,	10.13,	
                                        11.12,	10.33,	10.95,	10.25,	12.63,	9.63,
                                        11.08,	10.47,	9.4,	10.5,	10.07,	8.17,	11.63,
                                        10.85,	8.63,	14.03,	10.6,	8.95,	10,	10.08,	
                                        11.17,	8.92,	12.88,	9.93,	11.5),
                              rstpluse=c(62,  65,	55,	70,	63,	45,	51,	50,	57,	48,	58,	48,
                                         48,	59,	56,	53,	62,	40,	58,	64,	48,	56,	47,	44,
                                         48,	67,	62,	48,	44,	49,	52),
                              runpluse=c(178,  156,	178,	176,	174,	168,	176,	166,	168,
                                         162,	174,	164,	172,	186,	186,	170,	185,	166,
                                         176,	162,	170,	186,	162,	180,	162,	168,	156,	
                                         146,	168,	148,	170),
                              maxpluse=c(182,  168,	180,	180,	176,	168,	176,	170,	172,	
                                         164,	176,	166,	172,	188,	188,	172,	185,	172,	
                                         176,	170,	186,	192,	164,	185,	168,	168,	165,	
                                         155,	172,	155,	176))

# regression fit                              
R=lm(oxygen~age+weight+runtime+rstpluse+runpluse+maxpluse,data=fitness)
summary(R)

# vif
library(car)
vif(R)

# condition number
X=model.matrix(R)[,-1]
sqrt(eigen(cor(X))$values[1]/eigen(cor(X))$values)

#influence measure
influence.measures(R)
influencePlot(R,id.method='identify',main='influence plot', sub='circle size is proportional to Cooks distance')

#AIC
step(R,direction="backward")

#===========================================================
#                   주성분분석 (p.25)
#===========================================================
son <- data.frame(x1=c(121,108,122,77,140,108,124,130,149,129,
                       154,145,112,120,118,141,135,151,97,109,
                       132,123,129,131,110,47,125,129,130,147,
                       159,135,100,149,149,153,136,97,141,164),
                  x2=c(22,30,49,37,35,37,39,34,55,38,37,33,40,
                       39,21,42,49,37,46,42,17,32,31,23,24,22,
                       32,29,26,47,37,41,35,37,38,27,31,36,37,32),
                  x3=c(74,80,87,66,71,57,52,89,91,72,87,88,60,
                       73,83,80,73,76,83,82,77,79,96,67,96,87,87,
                       102,104,82,80,83,83,94,78,89,83,100,105,76),
                  x4=c(223,175,266,178,175,241,194,200,198,162,
                       170,208,232,157,152,195,152,223,164,188,
                       232,192,250,291,239,231,227,234,256,240,
                       227,216,183,227,258,283,257,252,250,187),
                  x5=c(54,40,41,80,38,59,72,85,50,47,60,51,29,
                       39,88,36,42,74,31,57,50,64,55,48,42,40,
                       30,58,58,30,58,39,57,30,42,66,31,30,27,30),
                  x6=c(254,300,223,209,261,245,242,242,277,268,
                       244,228,279,233,233,241,249,268,243,267,
                       249,315,317,310,268,217,324,300,270,322,
                       317,306,242,240,271,291,311,225,243,264))

m <-apply(son,2,mean)
S <-cov(son)
R<-cor(son)
eigen(S)
eigen(R)

p_cor <-princomp(son,cor=TRUE)
summary(p_cor)
attributes(p_cor)
p_cor$sdev
p_cor$loadings
p_cor$scores

all <-cbind(son,p_cor$scores)
all[order(p_cor$scores[,1]),]

#scatterplot, scree plot and Biplot
library(graphics)
screeplot(p_cor,npcs=6,type="lines",main="scree plot-corrlation")
biplot(p_cor)

#===========================================================
#                   요인분석 (p.42)
#===========================================================
# 요인분석
pilot <- data.frame(x1=c(121,108,122,77,140,108,124,130,149,129,
                         154,145,112,120,118,141,135,151,97,109,
                         132,123,129,131,110,47,125,129,130,147,
                         159,135,100,149,149,153,136,97,141,164),
                    x2=c(22,30,49,37,35,37,39,34,55,38,37,33,40,
                         39,21,42,49,37,46,42,17,32,31,23,24,22,
                         32,29,26,47,37,41,35,37,38,27,31,36,37,32),
                    x3=c(74,80,87,66,71,57,52,89,91,72,87,88,60,
                         73,83,80,73,76,83,82,77,79,96,67,96,87,87,
                         102,104,82,80,83,83,94,78,89,83,100,105,76),
                    x4=c(223,175,266,178,175,241,194,200,198,162,
                         170,208,232,157,152,195,152,223,164,188,
                         232,192,250,291,239,231,227,234,256,240,
                         227,216,183,227,258,283,257,252,250,187),
                    x5=c(54,40,41,80,38,59,72,85,50,47,60,51,29,
                         39,88,36,42,74,31,57,50,64,55,48,42,40,
                         30,58,58,30,58,39,57,30,42,66,31,30,27,30),
                    x6=c(254,300,223,209,261,245,242,242,277,268,
                         244,228,279,233,233,241,249,268,243,267,
                         249,315,317,310,268,217,324,300,270,322,
                         317,306,242,240,271,291,311,225,243,264))
m <-apply(pilot,2,mean)
X <-cov(pilot)
R <-cor(pilot)
fact1 <- factanal(pilot,factors=2,rotation="none")      # no rotation
fact2 <- factanal(pilot,factors=2,scores="regression")  # varimax is the default
fact3 <- factanal(pilot,factors=2,rotation="promax")    # promax rotation
fact1 ; fact2 ; fact3

#scree plot
prin <- princomp(pilot)
screeplot(prin,npcs=6,type="lines",main="scree plot")

#plot of factor pattern
namevar <-names(fact2$loadings) <-c("x1","x2","x3","x4","x5","x6")
plot(fact2$loadings[,1], fact2$loadings[,2],pch=19,xlab="factor1",ylab="factor2",
     main="factor pattern")
text(x=fact2$loadings[,1],y=fact2$loadings[,2],labels=namevar,adj=0)
abline(v=0,h=0)

#plot of factor scores
plot(fact2$scores[,1],fact2$scores[,2],pch=19,xlab="factor1",ylab="factor2",
     main="factor scores")

#===========================================================
#               두 모비율 차이 검정 (p.51)
#===========================================================
# 두 모비율의 차이 검정
table=matrix(c(110,140,104,96),nrow=2)
table=as.table(table)

# 카이제곱 검정
chisq.test(table,correct=F)
chisq.test(table,correct=F)
#===========================================================
#               두 모비율 차이 검정 (p.52)
#===========================================================
# 두 모비율의 차이 검정
table=matrix(c(110,140,104,96),nrow=2)
table=as.table(table)

# Fisher’s exact test
fisher.test(table)

#===========================================================
#               두 모비율 차이 검정 (p.55)
#===========================================================
# 범주형 자료분석 : 두 모비율 차이 검정
table2=matrix(c(63,4,21,12),nrow=2)
table2=as.table(table2)

#install.packages("fmsb")
library(fmsb)

#맥니머 검정
mcnemar.test(table2)

# 카파 검정
Kappa.test(table2)$ase

#===========================================================
#                     교차분석 (p.59)
#===========================================================
# 범주형 자료분석 : 동일성 검정 예 
soft_drink=data.frame(age=c(rep("20대",4),rep("30대",2),"20대","30대",rep("40대",2),"20대","40대"),
                      beverage=factor(rep(c("coke","pepsi","fanta","others"),3),
                                      levels=c("coke","pepsi","fanta","others")),
                      count=c(10,14,4,12,13,9,10,8,12,8,10,10))
#install.packages("gmodels")
library(gmodels)
soft_drink=soft_drink[rep(row.names(soft_drink),soft_drink$count),1:2]

CrossTable(soft_drink$age,soft_drink$beverage,format="SAS",chisq=T,fisher=T)
fisher.test(soft_drink$age,soft_drink$beverage,workspace=2e+07,hybrid=TRUE

#===========================================================
#                     교차분석 (p.62)
#===========================================================            
# 범주형 자료분석 : 독립성 검정 예
edu_eco=data.frame(edu=rep(1:3,each=3),
                  eco=rep(1:3,3),
                  count=c(255,105,81,110,92,66,90,113,88))
edu_eco=edu_eco[rep(row.names(edu_eco),edu_eco$count),1:2]
CrossTable(edu_eco$edu,edu_eco$eco,format="SAS",prop.c=F,prop.t=F,chisq=T)

#===========================================================
#                     교차분석 (p.64)
#=========================================================== 
# 교차표 분석 - 행 간 평균 차이(열이 순서형)
tre_rel=data.frame(trt=rep(1:3,each=5),
                   relief=rep(1:5,3),
                   count=c(6,9,6,3,1,1,4,6,6,8,2,5,6,8,6))
tre_rel=tre_rel[rep(row.names(tre_rel),tre_rel$count),1:2]
CrossTable(tre_rel$trt,tre_rel$relief,format="SAS",prop.c=F,prop.t=F,chisq=T)
#install.packages("vcdExtra")
library(vcdExtra)
CMHtest(table(tre_rel$trt,tre_rel$relief))

#===========================================================
#                     교차분석 (p.66)
#=========================================================== 
# 교차표 분석 - 상관계수(행과 열 모두 순서형)
trt_wash=data.frame(trt=rep(1:3,each=3),
                    wash=rep(1:3,3),
                    count=c(27,14,5,10,17,26,5,12,50))
trt_wash=trt_wash[rep(row.names(trt_wash),trt_wash$count),1:2]
CrossTable(trt_wash$trt,trt_wash$wash,format="SAS",prop.c=F,prop.t=F,chisq=T)
CMHtest(table(trt_wash$trt,trt_wash$wash))

#===========================================================
#                     교차분석 (p.69)
#=========================================================== 
# 교차표 분석 - 연관성 측도 (람다 : lambda)
election=data.frame(city=rep(c("Seoul","Busan","Daegu","Incheon","Kwangju"),each=2,time=2),
                    candidat=c(rep(c("RTW","KYS"),5),rep(c("KDJ","KJP"),5)),
                    vote=c(1683,1637,641,1117,800,275,326,249,23,2,1833,461,182,52,30,23,
                           177,76,450,1))
election=election[rep(row.names(election),election$vote),1:2]

#install.packages("polytomous")
library(polytomous)
associations(table(election$city,election$candidat))

#===========================================================
#                   로지스틱 회귀모형 (p.82)
#===========================================================
# 로지스틱 회귀모형 예
data <- data.frame(sex = c(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2),
                   FISQ = c(149,139,133,89,133,141,135,100,80,83,97,139,141,103,144,133,137,99,138,92,132,140,96,83,132,101,135,91,85,77),
                   weight = c(166,143,172,134,172,151,155,178,180,166,186,132,171,187,191,118,147,146,138,175,118,155,146,135,127,136,122,114,140,106),
                   height = c(72.5,73.3,68.8,66.3,68.8,70.0,69.1,73.5,70.0,71.4,76.5,68.0,72.0,77.0,67.0,64.5,65.0,69.0,64.5,66.0,64.5,70.5,66.0,68.0,68.5,66.3,62.0,63.0,68.0,63.0))


# 로지스틱 회귀모형식
logistic.fit <- glm(factor(sex) ~ FISQ + weight + height, 
                    data = data, family = binomial)


step(direction='backward',logistic.fit)


# 분류표
pred_sex <- predict(logistic.fit, newdata = data[, -1], 
                    type = "response")

cut <- ifelse(pred_sex >= 0.5, 2, 1) ## 절단값 0.5로 설정
result <- table(data$sex, cut)

# 정분류율
accuracy <- (result[1, 1] + result[2, 2]) / sum(result) * 100

#===========================================================
#                  판별분석 (p.91)
#===========================================================
library(MASS)

# 판별분석 예
data <- data.frame(sex = c(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2),
                   FISQ = c(149,139,133,89,133,141,135,100,80,83,97,139,141,103,144,133,137,99,138,92,132,140,96,83,132,101,135,91,85,77),
                   weight = c(166,143,172,134,172,151,155,178,180,166,186,132,171,187,191,118,147,146,138,175,118,155,146,135,127,136,122,114,140,106),
                   height = c(72.5,73.3,68.8,66.3,68.8,70.0,69.1,73.5,70.0,71.4,76.5,68.0,72.0,77.0,67.0,64.5,65.0,69.0,64.5,66.0,64.5,70.5,66.0,68.0,68.5,66.3,62.0,63.0,68.0,63.0))


# 판별분석 모형식
disc.fit <- lda(factor(sex) ~ FISQ + weight + height, data = data)

# 분류표
pred_sex <- predict(disc.fit, newdata = data[, -1])
result <- table(data$sex, pred_sex$class)

# 정분류율
accuracy <- (result[1, 1] + result[2, 2]) / sum(result) * 100

# plot
levels(data$sex) <- c("남자(관측)", "여자(관측)")
levels(pred_sex$class) <- c("남자", "여자")
plot(pred_sex$x, col = data[, 1], pch = 21)
text(c(1:30), pred_sex$x, pred_sex$class, pos = 3)
legend("bottomright", legend = levels(data$sex), 
       col = c("black", "red"), pch = 21, bg = "gray")

