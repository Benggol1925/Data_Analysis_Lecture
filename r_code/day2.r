### day2 ###

#===========================================================
#  		   확률밀도함수와 누적분포함수 (p.12)					
#===========================================================
#균일분포의 p.d.f. : dunif(x,0,1)
#균일분포의 c.d.f. : punif(x,0,1)
#균일분포의 p.d.f.와 c.d.f. 그리기
par(mfrow=c(1,2))
x <- seq(from=-1, to=2, length.out=1000)
plot(x, dunif(x,0,1), cex=0.1, xlab='', ylab='density'
     , main='p.d.f. of Uniform Distribution')
plot(x, punif(x,0,1), cex=0.1, xlab='', ylab='cumulative probability'
     , main='c.d.f. of Uniform Distribution')

#표준정규분포의 p.d.f. : dnrom(x, mean=0, sd=1)
#표준정규분포의 c.d.f. : rnorm(x, mean=0, sd=1)
#표준정규분포의 p.d.f.와 c.d.f. 그리기
par(mfrow=c(1,2))
x <- seq(from=-3, to=3, length.out=1000)
plot(x, dnorm(x,0,1), cex=0.1, xlab='', ylab='density'
     , main='p.d.f. of Normal Distribution')
abline(v=0, col=2, lty=2) #평균의 위치 표시
plot(x, pnorm(x,0,1), cex=0.1, xlab='', ylab='cumulative probability'
     , main='c.d.f. of Uniform Distribution')

#===========================================================
#  			           이항분포	(p.18)			
#===========================================================
#5개 맞힐 확률
dbinom(5, 10, 1/2)
#5개 이하 맞힐 확률
pbinom(5, 10, 1/2)

#8개 이상 맞힐 확률
1-pbinom(7, 10, 1/2)
#윗부분 확률 구할 때는 lower.tail 옵션 사용
pbinom(7, 10, 1/2, lower.tail=F)

#===========================================================
#    	                 정규분포	(p.20)				
#===========================================================
#515kg이하인 철근이 생산될 확률
pnorm(515, mean=520, sd=11)

#530kg이상인 철근이 생산될 확률
pnorm(530, mean=520, sd=11, lower.tail=F)

#하위 10%인 철근의 무게는
qnorm(0.1, mean=520, sd=11)

### 정규분포를 따르는 표본 생성
#평균이 520, 표준편차가 11인 정규분포에서 200개 생성
sample <- rnorm(200, mean=520, sd=11)
sample[1:5]

#생성된 sample의 히스토그램
hist(sample, main='', freq=F)

#N(520,121)의 밀도함수
x <- seq(-3,3,length=500)*11+520
lines(x,dnorm(x, 520, 11))

#===========================================================
#               중심극한정리 (p.22)				
#===========================================================
### 중심극한정리 실습 1 ###
#모집단 : 0.7*N(0,1) + 0.3*N(4,1)(혼합정규분포)
#모집단(혼합정규분포)에서 표본을 생성하는 함수
mixture.generate <- function(n){
  X<-c()
  for(X.ind in 1:n){
    asdf<-sample(c(1,2),1,prob=c(0.7,0.3))
    if(asdf==1) X[X.ind]<-rnorm(1,0,1)
    if(asdf==2) X[X.ind]<-rnorm(1,4,1)
  }
  return(X)
}

#n마다 10000개 표본평균의 히스토그램을 그리는 함수
CLT.practice <- function(n){
  sample.means <- c()
  for(i in 1:10000){
    x <- mixture.generate(n)
    sample.means[i] <- mean(x)
  }
  titles <- paste('Histogram of sample mean with n=',n,sep='')
  hist(sample.means, xlim=c(-2,5), freq=F, main=titles) 
}

par(mfrow=c(2,2))
set.seed(123)
#모집단의 분포
X <- mixture.generate(n) #혼합정규분포에서 1000개 생성
hist(X, freq=F, ylim=c(0,0.3), breaks=20, xlab='', main='Population')

x <- seq(-3,7,length.out=1000)
lines(x, 0.7*dnorm(x)+0.3*dnorm(x,4,1))

#표본평균의 분포
for(n in c(5,30,200)){
  CLT.practice(n) 
}

### 중심극한정리 실습 2 ###
#모집단 : (0,1)에서의 균일분포
#n마다 10000개 표본평균의 히스토그램을 그리는 함수
UNI.CLT <- function(n){
  sample.means <- c()
  for(i in 1:10000){
    x <- runif(n,0,1)
    sample.means[i] <- mean(x)
  }
  titles <- paste('Histogram of sample mean with n=',n,sep='')
  hist(sample.means, xlim=c(0,1), main=titles)
}

par(mfrow=c(2,2))
set.seed(123)
#모집단의 분포
X <- runif(1000,0,1) #균일분포에서 1000개 생성
hist(X, freq=F, breaks=20, xlab='', main='Population')

x <- seq(0,1,length.out=1000)
lines(x, dunif(x,0,1))

#표본평균의 분포
for(n in c(5,30,200)){
  UNI.CLT(n) 
}

#===========================================================
#                   신뢰구간	(p.37)				
#===========================================================
#앞의 문제의 예제의 상황에서 100(1-alpha)% 신뢰구간을 구한다.
n <- 64
sample.mean <- 27.75
alpha <- 0.01

#모표준편차가 5로 알려진 정규모집단인 경우
se <- qnorm(alpha/2, lower.tail=F)*5/sqrt(n)
(ci1 <- data.frame(lower=sample.mean-se, upper=sample.mean+se))

#모표준편차가 알려져 있지 않은 정규모집단인 경우
se <- qt(alpha/2, n-1, lower.tail=F)*5.083/sqrt(n)
(ci2 <- data.frame(lower=sample.mean-se, upper=sample.mean+se))

#===========================================================
#             모평균에 관한 가설 검정 (p.41)
#===========================================================
#데이터 : 앞의 예제에서 사용한 창던지기 기록
data.test <- c(64,64.8,66,63.5,65,68,67,63.6,67.6,68.9)
t.test(data.test, alternative="greater", mu=65)

#===========================================================
#            이표본에 의한 모평균의 비교 (p.47)
#===========================================================
#데이터 : 두 지역(A,B)에서 오존생성률(ozone concentration)을 독립적으로 측정한 자료
#두 지역의 오존생성률의 평균이 같은지 비교
sample <- data.frame(ozone=c(3,4,4,3,2,3,1,3,5,2,5,5,6,7,4,4,3,5,6,5),region=rep(c('A','B'),each=10) )

#상자그림
ggplot(sample, aes(x=region, y=ozone,  fill=region)) + geom_boxplot()

#이표본 비교
t.test(ozone~region, data=sample)

#===========================================================
#       대응비교(쌍체비교)에 의한 모평균의 비교 (p.50)
#===========================================================
#데이터 : 앞 예제에서 사용한 음식 조절 이후 체중 비교 자료
#음식 조절법의 효과가 있는지 검정
sample <- data.frame(before=c(82.1,78.1,86.2,84.8,95.2,91.6,75.3,78.5,83.0,83.5)
                     ,after=c(80.7,78.1,83.9,83.5,91.2,91.2,72.6,76.2,81.6,81.2))

d <- sample$after-sample$before

#대응비교 검정
t.test(d, alternative='less')

#===========================================================
#             이표본에 의한 분산비 검정 (p.56)
#===========================================================
#데이터 : 두 지역(B,C)에서 오존생성률(ozone concentration)을 독립적으로 측정한 자료
#두 지역의 오존생성률의 분산이 같은지 비교
sample <- data.frame(ozone=c(5,5,6,7,4,4,3,5,6,5,3,3,2,1,10,4,3,11,3,10),region=rep(c('B','C'),each=10) )

#분산 비교
var.test(ozone~region, data=sample)