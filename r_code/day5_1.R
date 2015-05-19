### day5 ###

#===========================================================
#                베이지안 회귀분석 (p.14)
#===========================================================
library(MASS)

x = seq(20,42, by =2)
y = c(8.4, 9.5, 11.8, 10.4, 13.3, 14.8,
	13.2, 14.7, 16.4, 16.5, 18.9, 18.5)


p   <- 1; nn  <- length(y); N   <- 10000
X <- cbind(rep(1,nn),x)
beta.hat <- solve(t(X)%*%X)%*%t(X)%*%y
s2 <- t(y)%*%(diag(nn)-X%*%solve(t(X)%*%X)%*%t(X))%*%y/(nn-p-1)
vec.b <- matrix(0, nrow = p+1, ncol = N)
vec.sigma2 <- rep(0,N)
set.seed(1)
for (m in 1:N)
{  
  r  <- rgamma(1,(nn-2)/2, (nn-2)*s2/2)
  vec.sigma2[m] <- 1/r
  b  <- mvrnorm(1, beta.hat, solve(t(X)%*%X)/r)
  vec.b[,m] <- b
}

#1 
mean(vec.b[1,]) ; sd(vec.b[1,])
hist(vec.b[1,])
#2
mean(vec.b[2,]) ; sd(vec.b[2,])
hist(vec.b[2,])
#3
mean(vec.sigma2) ; sd(vec.sigma2)
hist(vec.sigma2)

#===========================================================
#         Nonparametric Function Estimation (p.22)
#===========================================================
library(KernSmooth)
data(geyser, package="MASS")

x <- geyser$duration
tmp = hist(x)
hist(x, breaks = seq(0,6, by = .5))
hist(x, breaks = seq(.2,6.2, by = .5))
hist(x, breaks = seq(.2,6.2, by = .7))
hist(x, breaks = seq(.2,6.2, by = .8))


#===========================================================
#         Nonparametric Function Estimation (p.23)
#===========================================================
# Kernel density estimation (KDE)

# Bandwidth selection
h <- dpik(x)
bw.nrd(x)
bw.nrd0(x)
bw.ucv(x)

# Estimation
est <- bkde(x, bandwidth=h)
est1 = density(x, bw = h)
est2 = density(x, bw = h/2)
est3 = density(x, bw = 2*h)
est4 = density(x)



# Plot
plot(est,type="l")
lines(est2,col = 2)
lines(est3,col = 3)
lines(est4, col = 4)


#===========================================================
#         Nonparametric Function Estimation (p.30)
#===========================================================
x <- geyser$duration
y <- geyser$waiting
plot(x, y)

# Bandwidth selection for kernel regression
h <- dpill(x, y)

# Kernel regression fit
fit <- locpoly(x, y, bandwidth = h)
fit2 <- locpoly(x, y, bandwidth = h/2)
fit3 <- locpoly(x, y, bandwidth = 2*h)

lines(fit, col = 2)
lines(fit2, col = 3)
lines(fit3, col = 4)




fit2 = loess(y~x, degree=2)
tp1 = order(fit2$x)

lines(fit2$x[tp1], fit2$fitted[tp1],col = 4)

#===========================================================
#               함수형 자료 분석 (p.51)
#===========================================================
install.packages("refund")
library(refund)

# data 불러오기
data(DTI)
y <- DTI$case[DTI$visit==1]
X <- DTI$cca[DTI$visit==1,]
ind <- rowSums(is.na(X))>0

# 결측치 제거
y <- y[!ind]
X <- X[!ind,]
y=y[-c(32,81)]
X=X[-c(32,81),]

# test set 생성
set.seed(1)
N <- length(y)
test <- sample(N,10)

# functional data fit
fit<-fgam(y~af(X,splinepars=list(k=c(7,7),m=list(c(2,2),c(2,2)))),family=binomial(),subset=(1:N)[-test])
fit$fitted

# predict
pred<-predict(fit,newdata=list(X=X[test,]),type='response',family=binomial(),PredOutOfRange=TRUE)
pred
pred.dec = ifelse(pred >= .5,1,0)
pred.dec


table(y[test],pred.dec)
#############
install.packages("fda.usc")
library(fda.usc)

x.fdata = fdata(X[-test,]) 
y.fdata = as.data.frame(y[-test]); names(y.fdata) = "y"
all.fdata = list("df" = y.fdata, "x" = x.fdata)
fit2 = classif.gkam(y~x,family = binomial(), data = all.fdata)
x.fdata.test = list("x" = fdata(X[test,]))
pred2 = predict.classif(fit2,x.fdata.test )
table(y[test], pred2)


fit3 = classif.np(y[-test], x.fdata) 
table(y[-test], fit3$group.est)
pred3 = predict.classif(fit3, fdata(X[test,]))
table(y[test], pred3)

#########
# functional linear model

data(tecator)
x=tecator$absorp.fdata
x.d1<-fdata.deriv(x)
tt<-x[["argvals"]]
dataf=as.data.frame(tecator$y)

nbasis.x=11;nbasis.b=5

basis1=create.bspline.basis(rangeval=range(tt),nbasis=nbasis.x)
basis2=create.bspline.basis(rangeval=range(tt),nbasis=nbasis.b)

f=Fat~Protein+x
basis.x=list("x"=basis1)
basis.b=list("x"=basis2)
ldata=list("df"=dataf,"x"=x)
res=fregre.lm(f,ldata,basis.x=basis.x,basis.b=basis.b)
summary(res)


f2=Fat~Protein+xd
xd=fdata.deriv(x,nderiv=2,class.out='fdata',nbasis=nbasis.x)
ldata2=list("df"=dataf,"xd"=xd)
basis.x2=list("xd"=basis1)
basis.b2=list("xd"=basis2)
res2=fregre.lm(f2,ldata2,basis.x=basis.x2,basis.b=basis.b2)
summary(res2)

par(mfrow=c(2,1))
plot(x)
plot(res$beta.l$x,main="functional beta estimation")

par(mfrow=c(2,1))
plot(xd)
plot(res2$beta.l$xd,col=2)

#===========================================================
#                   시계열 분석 (p.76)
#===========================================================
require(astsa)
data(jj)
plot(jj, ylab=‘Earnings per share’, main=‘J&J’)

#===========================================================
#                   시계열 분석 (p.77)
#===========================================================
# log transform
dljj<-diff(log(jj))
plot(log(jj), main=‘log(jj)’, ylab=‘log(Earnings)’)

#===========================================================
#                   시계열 분석 (p.78)
#===========================================================
# Set up the graphics
par(mfrow=c(2,1))

# histogram
hist(dljj,prob=TRUE,12)

# Smooth it (density for details)
lines(density(dljj))

#normal Q-Q plot
qqnorm(dljj)
qqline(dljj)

#===========================================================
#                   시계열 분석 (p.79)
#===========================================================
# lag plot
lag.plot(dljj,9,do.lines=FALSE)

#===========================================================
#                   시계열 분석 (p.80)
#===========================================================
# 분해
dog<-stl(log(jj),'per')
plot(dog)

#===========================================================
#                   시계열 분석 (p.81)
#===========================================================
Q<-factor(cycle(jj))

# not necessary to ‘center’ time
# but the results look nicer
trend <- time(jj)-1970

# run the regression without an intercept
# the na.action statement is to retain time
reg <- lm(log(jj)~0+trend+Q,na.action=NULL)
summary(reg)

# plot
plot(spline(time(jj),log(jj)),type='l',xlab='Time',ylab='log(jj)')
lines(reg$fit,col='red')

#===========================================================
#                   시계열 분석 (p.82)
#===========================================================
# 잔차 plot
plot(resid(reg))

# acf plot
acf(resid(reg))

#===========================================================
#                   시계열 분석 (p.84)
#===========================================================
# exam2
# data
x<-arima.sim(list(order=c(1,0,1),ar=0.9,
                  ma=-0.5),n=100)

# model fitting
x.fit <- arima(x,order=c(1,0,1))
x.fit


