### day3 ###

#===========================================================
#                      이상치 판정 (p.8)
#===========================================================
#Outlier detection
#Michelson의 빛의 속도 측정 data
light <- c(850, 740, 900, 1070, 930, 850, 950, 980, 980, 880, 1000
           ,980, 930, 650, 760, 810, 1000, 1000, 960, 960)

boxplot(light)
#sc : 값이 Q1(또는 Q3)을 벗어난 경우 Q1(또는 Q3)를 빼고 IQR로 나눈값
#1.5보다 크면 outlier
install.packages("outliers")
library(outliers)
sc <- scores(light, type='iqr')
cbind(light, sc) 

#===========================================================
#             이상치, 결측치 처리 방법론 (p.11)
#===========================================================
#R에서 결측치는 NA
x <- c(1,2,3,NA,4,7,NA)

#결측치인지 여부
is.na(x)

#결측치를 제외한 통계량(na.rm 옵션 사용)
mean(x,na.rm=T)
median(x, na.rm=T)
sd(x, na.rm=T)

#결측치 제거
na.omit(x)

#평균(중앙값은 mean->median)으로 대체
x[is.na(x)] <- mean(x, na.rm=T)
x

#===========================================================
#                   회귀분석 (p.20)
#===========================================================
#regression analysis 
#데이터 : 예제에서 소개한 광고비와 매출액 데이터
x <- c(11,19,23,26,56,62,29,30,38,39,46,49)
y <- c(23,32,36,46,93,99,49,50,65,70,71,89)
reg_data <- data.frame(x,y)

#회귀모형 생성
reg_model <- lm(y~x, data=reg_data)

#산점도와 적합된 회귀직선
plot(x,y, xlab='adver',ylab='sales')
abline(reg_model,col=2) 

#회귀모형에 대한 정보들
summary(reg_model)

#===========================================================
#                  일원배치법 (p.24)
#===========================================================
#One-way ANOVA
#InsectSprays에서 spray(A~F)의 효과가 같은지 검정

data(InsectSprays)
print(InsectSprays)

#상자그림
ggplot(InsectSprays, aes(x=spray, y=count,  fill=spray)) + geom_boxplot()

#분산분석
aov.result <- aov(count~spray, data=InsectSprays)

#여러가지 plot
par(mfrow=c(2,2))
plot(aov.result)

#분산분석표
summary(aov.result)

#===========================================================
#                    이원배치법 (p.26)
#===========================================================
#Two-way ANOVA
#데이터 : 화학공정 데이터
y <- c(90.4, 90.7, 90.2, 90.2, 90.1, 90.4, 92.2, 91.6, 90.5, 93.7, 91.8, 92.8)
pressure <- as.factor( rep(c(200,220,240),4) )
temp <- as.factor( rep(c('low','high'),each=6) )

#상자그림과 교호작용 plot
par(mfrow=c(2,2))
plot(y~temp)
plot(y~pressure)
interaction.plot(temp,pressure,y,bty='l', main='interaction plot')
interaction.plot(pressure,temp,y,bty='l', main='interaction plot')

#분산분석
#temp:preessure는 temp와 pressure의 교호작용항을 의미
aov.result <- aov(y~temp+pressure+temp:pressure)
summary(aov.result)

#===========================================================
#            Wilcoxon’s signed rank test (p.30)
#===========================================================
#예제의 데이터를 Wilcoxon's signed rank test로 검정
#귀무가설 : M=35
#대립가설 : M>35
sample <- c(25,16,44,82,36,58,18)
wilcox.test(sample, alternative="greater", mu=35) 

#===========================================================
#               Wilcoxon’s rank sum test (p.32)
#===========================================================
#Wilcoxon rank sum test
#데이터 : 예제에 소개된 데이터
#두 식이요법에 차이가 있는지 검정
A <- c(3.5, 4.2, 2.8, 5.1, 2.5)
B <- c(4.5, 6.0, 5.3, 6.8, 6.5)

wilcox.test(B,A) #Wilcoxon rank sum test

#===========================================================
#                 Friedman test  (p.34)
#===========================================================
#Friedman test
#'agricolae 패키지 사용'
#install.packages('agricolae')
library(agricolae)

#데이터 : 예제에 소개된 데이터
#자극(treatment)별로 차이가 있는지 검정
A <- c(1.7, 1.5, 0.1, 0.6)
B <- c(3.4, 2.6, 2.3, 2.2)
C <- c(2.3, 2.1, 0.8, 1.6)
data <- c(A,B,C)
block <- rep(1:4,3)
treatment <- as.factor( rep(c('A','B','C'),each=4) )

(f <- friedman(block, treatment, data))

#===========================================================
#              Kruscal-Wallis H-test  (p.36)
#===========================================================
#Kruscal-Wallis test
#데이터 : 예제에 소개된 데이터
A <- c(257,205,206,231,190,214,228,203)
B <- c(201,164,197,185)
C <- c(248,165,187,220,212,215,281)
D <- c(202,276,207,204,230,227)

kruskal.test(list(A,B,C,D))

#===========================================================
#          Kolmogorov-Smirnov test(일표본)  (p.38) 
#===========================================================
#Kolmogorov-Smirnov test(일표본)
#데이터 : 예제에 소개된 데이터
x <- c(70,55,95,60,63,45,56,61,50,65)
plot.x <- seq(min(x)-1, max(x)+1, length.out=1000)

#검정하고자하는 분포함수와 표본분포함수
plot(plot.x, pnorm(plot.x, mean=60, sd=10), type='l', ylim=c(0,1), xlab='', ylab='')
lines(ecdf(x),col=2)
legend('topleft', c('Null distribution function', 'ECDF'), lty=c(1,1),col=1:2, )

ks.test(x,'pnorm',mean=60,sd=10)

#===========================================================
#          Kolmogorov-Smirnov test(이표본) (p.40) 
#===========================================================
#Kolmogorov-Smirnov test(이표본)
#데이터 : 예제에 소개된 데이터
#두 학과의 성적의 분포가 같은지 검정
A <- c(82,74,89,86,75)
B <- c(88,77,91,87,94,98,83,99)

#A와 B의 표본분포함수
AB <- c(A,B)
plot.x <- seq(min(AB)-1, max(AB)+1, length.out=1000)
plot(ecdf(A), xlim=range(plot.x), xlab='', ylab='', main='ECDF')
lines(ecdf(B), col=2)
legend('topleft', c('A', 'B'), lty=c(1,1),col=1:2 )

#검정
ks.test(A,B)

#===========================================================
#                   정규성 검정 (p.42)  
#===========================================================
#정규성 검정
#데이터 : Kolmogorov-Smirnov test(일표본) 예제에서 사용한 데이터
x <- c(70,55,95,60,63,45,56,61,50,65)

#Shapiro-Wilk test
shapiro.test(x)

#Anderson?Darling test
install.packages('nortest')
library(nortest)
ad.test(x)

#===========================================================
#                   상관계수 (p.45)
#===========================================================
#상관계수
#데이터 : 예제에 소개된 데이터
A <- c(2,1,3,5,4,8,7,6)
B <- c(1,2,4,5,7,6,8,3)

#심사위원 A와 B간의 상관관계를 분석
#산점도 
plot(A,B, main='Scatter plot')

#Spearman Rank correlation coefficient가 0인지 검정
cor.test(A,B, method='spearman')

#Kendall's tau가 0인지 검정
cor.test(A,B, method='kendal')