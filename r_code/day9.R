#==================================================
#     				도움말 활용 31~33p
#==================================================

help() #전체 Help 메뉴가 나타남
help(mean) #평균을 구하는 함수에 대한 Help
?mean
?"mean"
help("[[") #특수문자 등의 사용법에 대해서서도 help 기능을 이용할 수 있음
?"[["
    
help.search("mean")
??mean
#help.search 함수를 사용시 키워드내에 따옴표를 사용하여야 검색이 되며, 
#??를 사용시에는 따옴표를 사용여부는 관계없음

#패키지에 포함된 내용을 확인시
help(package = "RODBC")

#==================================================
#       		 작업공간 설정 및 저장 40p
#==================================================
# 작업공간 설정 및 저장

#getwd 함수를 사용하여 현재 작업공간 위치를 알 수 있다.
getwd()

#setwd 함수를 사용하여 사용자가 사용할 작업 공간 위치를 설정 할 수 있다.
setwd("D:\\작업방\\RProject")

#ls 함수를 사용하여 현재 작업공간의 오브젝트 리스트를 확인 할 수 있다.
ls() 


#현재 사용하고 있는 작업공간 저장
save.image() 

#지정한 것만 저장 시
save(object list, file = "myfile.RData") 

#작업공잔 불러오기
load("myfile.RData")


#==================================================
#         	         출력 41p
#==================================================

print(summary(iris))

cat("Cat 함수 예제 : 1더기 5의 값은 ? ", 1+5, "\n")

cat("오늘의 날짜는 ?", date(), "\n")

#==================================================
#         	    변수 목록보기 42p
#==================================================
x <- 10
y <- 10
z <- c(1,2,3,4,5)

#생선된 변수 목록을 보여준다
# ls함수에서는 목록만 보여주며 변수의 유형 값 등을 확인 할 수 없다.
ls()

#ls.str함수는 생성된 변수 목록 뿐만 아니라 각 변수의 유형 및 값 등을 확인 할 수 있다.
ls.str()


#==================================================
#                 변수 삭제 43p
#==================================================
x <- 10
y <- 20
z <- 30
ls()  #생성된 변수 보기

rm(x)  #x변수 삭제

rm(list = ls()) #오브젝트 내의 모든 변수 삭제


#==================================================
#                 벡터 생성 44p
#==================================================

x <- 10
y <- c(1,2,3,4,5)
z <- c(x, y)
a <- c(“one”, “two”, “three”)
b <- c(TRUE, FALSE, TRUE)
c <- y – x
d <- c(y, a)


#==================================================
#                 데이터 import 48p
#==================================================

#CSV 파일 가져오기 예시 1: read.csv()로 csv file import
system.time(DF1 <-read.csv("c:\\Rproject\\test.csv",stringsAsFactors=FALSE))

#CSV 파일 가져오기 예시 2 : read.table()로 csv file import
system.time(DF2 <- read.table("c:\\Rproject\\test.csv",header=TRUE,sep=",",quote="",
                              stringsAsFactors=FALSE,comment.char="",nrows=n,
                              colClasses=c("integer","integer","numeric",
                                           "character","numeric","integer")
                              
#CSV 파일 가져오기 예시 3 : fread()로 csv file import.
#이번에는 data.table package에서 제공하는 fread()함수를 사용하여 데이터를 호출해보자.
system.time(DT1 <- fread("c:\\Rproject\\test.csv"))
                              
#CSV 파일 가져오기 예시 4: read.csv.sql()로 csv file import
require(sqldf)
system.time(SQLDF <- read.csv.sql("c:\\Rproject\\test.csv",dbname=NULL))
                              
#==================================================
#                 데이터 export 49p
#==================================================

#Sample Data 생성

n <- 1e6
DT <- data.frame( a=sample(1:1000,n,replace=TRUE),
                  b=sample(1:1000,n,replace=TRUE),
                  c=rnorm(n),
                  d=sample(c("foo","bar","baz","qux","quux"),n,replace=TRUE),
                  e=rnorm(n),
                  f=sample(1:1000,n,replace=TRUE) )

# CSV 파일로 저장하기 예시  1 
write.table(DT,"c:\\Rproject\\test.csv",sep=",",row.names=FALSE, quote=FALSE)

# CSV 파일로 저장하기 예시  2
write.csv(DT, “c:\\Rproject\\test.csv”,sep=“,”,row.names=FALSE, quote=FALSE)



#==================================================
#            RODBC로 데이터 가져오기 50p
#==================================================

#Step1 : library Install-----------------------------------------------------------------------------------
#RODBC library install
#RODBC를 사용하기 위해서는 CRAN에서 RODBC package를 설치하여야 한다.
install.packages('RODBC')
library(RODBC)
#----------------------------------------------------------------------------------------------------------

# DB 접속 : DB 접속 및 ODBC 설정이 사전에 필요함
db.connect <- odbcConnect(dsn = odbc.dsn, uid = odbc.uid, pwd = odbc.pwd, believeNRows=FALSE)

#쿼리문 작성
sql.x <- “select * from tmp1 “

# 데이터 가져오기
import.tb.list <- sqlQuery(db.connect, sql.x, stringsAsFactors = FALSE)

# 접속정보 해제
odbcClose(db.connect)

#==================================================
#            DB에 데이터 저장하기 51-52p
#==================================================

#DB 테이블에 데이터 insert
#데이터를 insert 하는 방법에는 두가지가 있다.
#먼저 sqlSave함수를 사용하여 데이터를 Insert하는 방법과 sqlQuery함수를 사용하여 Insert하는 방법이 있다.

#sqlSave함수를 사용하여 Insert
hdb    <- odbcConnect(dsn = "orcl", uid = "scott", pwd = "tiger", believeNRows = FALSE)
sqlSave(hdb,Sample.df, "COMP_MST", append = TRUE, rownames = FALSE)
odbcClose(hdb)

hdb    <- odbcConnect(dsn = "orcl", uid = "scott", pwd = "tiger", believeNRows = FALSE)
test.df <- sqlQuery(hdb, " select * from COMP_MST ")
odbcClose(hdb)


#sqlQuery함수를 사용하여 Insert
hdb    <- odbcConnect(dsn = "orcl", uid = "scott", pwd = "tiger", believeNRows = FALSE)
query.x <- "insert into COMP_MST(COMPANY, COMP_GROUP, NAMES, AGE, PHONE_NUM) values('Begas', 'Group1', 'jangeunhi', 28, '01099990000')"
sqlQuery(hdb, query.x)
odbcClose(hdb)

hdb    <- odbcConnect(dsn = "orcl", uid = "scott", pwd = "tiger", believeNRows = FALSE)
test.df <- sqlQuery(hdb, " select * from COMP_MST ")
odbcClose(hdb)



#==================================================
#                   벡터58-61p
#==================================================
seq(1, by=0.05, along=1:5)    #seq(시작값, by=증가분, 조건지정)
seq(1, 7, by=2)
seq(1, -1, by=-0.5)
seq(1,7,length=3)
rev(seq(1:5))   #rev : 자료의 순서를 역순으로 만드는 함수

rep(c(1,2,3),3)  #rep(a,b)는 a를 b만큼 반복
rep(1:3,3)      #a:b는 a부터 b까지의 수
rep(c(4,2), times=2)
rep(c(4,2), times=c(2,1))
rep(c(4,2), length=3)
paste("no", 1:5)     #반복되는 문자에 첨자를 붙여줌

v1 <- c(1,2,3)   #숫자형 벡터 생성
v2 <- c("a", "b", "c")   #문자형 벡터 생성
v3 <- c(T, F, T)
height <- c(160, 140, 155)     #height 벡터 생성
people <- c("Ned", "Jill", "Pat") 
names(height) <- people   #height 벡터의 원소에 이름을 할당
height["Ned"]
names(height) <- NULL      #height 벡터의 원소의 이름을 삭제

vec1 <- c(1,2,3,4,5)  #1~5까지 자료를 갖는 vec1 변수 생성
vec1[2]     #두 번째 자료
vec1[c(2,3,5)]    #vec1의 2, 3, 5의 값만 표현
vec1[c(-2,-3)]    #vec1의 2, 3번째 자료 값 삭제
vec1[vec12]    #vec1에서 2보다 큰 값만 표현
vec1[2] <- 6    #두 번째 위치의 2값이 6으로 대체됨
replace(vec1, 3, 2)   #vec1의 세 번째 자료를 2로 변경
append(vec1, 8, 5)    #vec1의 5번째 자료 다음에 8을 삽입
v1 <- 1:3
v2 <- 2:4
v1 * v2   #벡터의 각 원소간 곱셈

height <- 175   #height 스칼라 생성
heights <- c(160,140,155)   #heights 벡터 생성
heights[c(2,1,2)]    #heights의 2, 1, 2번째 원소 추출
heights <- append(heights, height)    #heights와 height를 결합
heights.1 <- append(heights,180,after=2)   #heights의 2번째 다음에 180 추가
heights <- replace(heights, 2,142)  #heights의 2번째 원소를 142로 변경
heights.2 <- replace(heights,c(2,4),c(140,142)) #2번째 140, 4번째 142로 변경
numbers <- 1:5  #1~5의 값을 갖는 벡터 생성
heights <- heights.2[2:4]  heights.2에서 2~4번째 값까지만 생성
length(heights)    #벡터의 길이 지정


#==================================================
#                   행렬62-63p
#==================================================

#행렬(matrix)은 여러 변수들이 이차원적으로 모여 있는 개체로, 
#행렬을 생성하기 위해서는 matrix() 함수를 사용
#matrix() 함수 이외에 cbind(), rbind(), dim() 등을 이용하여 행렬을 생성시킬 수 있음
matrix(1:9, nrow=3)                            #nrow  : 행의 개수 지정
matrix(c(1,4,7,2,5,8,3,6,9), byrow=T, ncol=3)  #ncol : 열의 개수 지정 byrow=T : 행 기준 행렬을 생성
r1 <- c(1,4,7)                                 #r1, r2, r3 행 벡터 생성
r2 <- c(2,5,8)
r3 <- c(3,6,9)
rbind(r1, r2, r3)                                #rbind : 행을 기준으로 결합
cbind(r1, r2, r3)                              #cbind : 열을 기준으로 결합

m1 <- 1:9
dim(m1) <- c(3,3)

#행렬과 관련된 여러 함수와 성분의 추출과 삭제 등에 관해 알아봄
mat <- matrix(c(1,2,3,4,5,6,7,8,9), ncol=3, byrow=T) #행 기준 3열의 행렬 생성
mat[1,]                                       #행렬 mat의 1행의 값
mat[,3]                                       #행렬 mat의 3열의 값
mat[mat[,3]  4, 1]                           #3열에서 4보다 큰 행의 값 중 1열의 모든 값
mat[mat[,3]  4, 2]                           #3열에서 4보다 큰 행의 값 중 2열의 모든 값
mat[2,, drop=F]                               #2행 값만을 추출
is.matrix(mat[2,,drop=F])                       #mat[2,,drop=F]가 행렬인지 확인


#==================================================
#                   배열64-65p
#==================================================

#배열의 속성 :  행렬의 속성과 같이 자료의 개수를 나타내는 length, 형태를 보여주는 mode, 
#각 차원의 벡터의 크기를 나타내는 dim 그리고 각 차원의 리스트 이름을 나타내는 dimnames로 구성

#배열의 생성
#배열을 생성하기 위한 함수로 array() 함수와 dim() 함수가 있음
array(1:6)                                      #1~6의 자료로 1차원 배열 생성
array(1:6, c(2,3))                              #1~6의 자료로 2차원 배열 생성
array(1:8, c(2,2,2))                             #1~8의 자료로 3차원 배열 생성
arr <- c(1:24)                                 #1~24의 자료 생성
dim(arr) <- c(3,4,2)                           #dim() 함수를 이용하여 3행 4열의 행렬 2개 생성

#배열의 연산
ary1 <- array(1:8, dim = c(2,2,2))  
ary2 <- array(8:1, dim = c(2,2,2))
ary1 + ary2                                    #자료의 덧셈
ary1 * ary2                                    #자료의 곱셈
ary1 %*% ary2                                #두 배열 원소들의 곱의 합
sum(ary1 * ary2)                             # ary1 %*% ary2 와 같은 결과를 냄
#배열원소의 추출 및 삭제
ary1[,,1]
ary1[1,1,]
ary1[1,,-2]


#==================================================
#                 데이터 프레임66-67p
#==================================================
#data.frame() : 이미 생성되어 있는 벡터들을 결합하여 데이터 프레임을 생성
char1 <- rep(LETTERS[1:3],c(2,2,1))          #벡터 char1
num1 <- rep(1:3,c(2,2,1))                     #벡터 num1
test1 <- data.frame(char1, num1)              #test1 데이터 프레임 생성

#as.data.frame() :모든 다른 종류의 자료객체들을 데이터 프레임으로 변환
a1 <- c("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o")
dim(a1) <- c(5,3)
test3 <- as.data.frame(a1)                     #a1을 데이터 프레임으로 변환

df1 <- data.frame(Col1 = c(“A”,”B”,”C”), Col2 = c(1,2,3), Col3 = c(3,2,1))
df1[행, 열]
1) df1[ , “Col3”]  결과 : 3, 2, 1 출력
2) df1[1, ]           결과 : A  1  3 출력
3) df1[3, “Col1”]  결과 : C 출력


#==================================================
#                 리스트68-71p
#==================================================

li <- list("top", c(2,4,6),c(T,F,T))              #list(문자, 숫자, 논리형 객체) 
li[[1]]                                        #[[1]]:첫 번째 성분
mat1 <- matrix(1:4, nrow=2)
list1 <- list("A", 1:8, mat1)
son <- list(son.name = c("Minsu", "Minchul"), son.cnt = 2, son.age = c(2.6))

#리스트 속성 : 벡터의 속성과 같이 자료의 개수, 형태, 구성요소의 이름 등을 보여주는 length, mode, names로 구성
length(son)                                   #son 리스트 자료의 개수
mode(son)                                    #son 리스트 자료의 형태
names(son)                                   #son 리스트 각 구성요소의 이름

#예제1(생성)
exm <- list(c("Abe", "Bob", "Carol", "Deb"),c("Weight","Waist")) #exm의 이름으로 list생성
exm[[2]]                                      #리스트의 2번째 성분
exm[[2]][2]                                  #2번째 성분 2번째 원소
names(exm) <- c("Rows","Columns")           #exm 리스트에 성분 이름 부여
exm$Rows                                    #exm의 Rows 성분만 표현
exm$Rows[2]                                 #Rows 성분 2번째 원소 표현
exm$Columns                                 #exm의 Columns 성분만 표현

#예제2(추가 및 삭제)
list1 <- list("A", 1:8)                         #list1 리스트 생성
list1[[3]] <- list(c(T, F))                      #세 번째 성분을 추가
list1[[2]][9] <- 9                             #두 번째 성분에 원소 추가
ist1[3] <- NULL                             #세 번째 성분 삭제
list1[[2]] <- list1[[2]][-9]                   #두 번째 성분의 9번째 원소 삭제

#관련함수
#리스트는 성분에 리스트와 벡터 등을 사용할 수 있음
#예제1
a <- 1:10
b <- 11:15                                    #벡터 a, b 생성
klist <- list(vec1=a, vec2=b, descrip="example")
klist[[2]][5]                                  #두 번째 성분 vec2의 5번째 원소
klist$vec2[c(2,3)]                             #vec2의 2, 3번째 원소


#==================================================
#                 사칙연산72-74p
#==================================================

#산술연산자(사칙연산)
1+2 
x<-3
y<-2
x+y
x-y
x*y
x/y

a<-c(1,2)
b<-c(3,4)
a+b #벡터 변수의 덧셈
a-b #벡터 변수의 뺄셈
a*b #벡터 변수의 곱셈
a/b #벡터 변수의 나눗셈

A<-matrix(c(5,10,2,1), ncol=2)
B<-matrix(c(3,4,5,6), ncol=2)
A+B #행렬변수의 덧셈
A-B #행렬변수의 뺄셈
A*B #행렬변수의 곱셈
A/B #행렬변수의 나눗셈

A<-matrix(c(5,10,2,1), ncol=2)
B<-matrix(c(3,4,5,6), ncol=2)
A%/%B #행렬변수의 정수나눗셈

#행렬의 곱
A<-matrix(c(5,10,2,1), ncol=2)
B<-matrix(c(3,4,5,6), ncol=2)
#(5*3) + (2*4) ; (5*5) + (2*6) ; (10*3) + (1*4) ; (10*5) + (1*6)
A%*%B

#==================================================
#                 비교연산75-76p
#==================================================

# '==' 비교되는 두 항이 같은지를 비교함. 같을 경우 True, 다를 경우 False
1==2
x<-2
y<-3
x==y

# '!=' 비교되는 두 항이 다른지를 비교함. 같을 경우 False, 다를 경우 True
1!=2
x<-2
y<-3
x!=y

# '<=' 왼쪽 항이 오른쪽 항보다 작거나 같음을 비교함. 작거나 같으면 True, 크면 False
1<=2
x<-2
y<-2
x<=y

# '<' 왼쪽 항이 오른쪽 항보다 작음을 비교함. 작으면 True, 크면 False
1<2

# '' 왼쪽 항이 오른쪽 항보다 큼을 비교함. 크면 True, 작으면 False
12

# '=' 왼쪽 항이 오른쪽 항보다 크거나 같음을 비교함. 크거나 같으면 True, 작으면 False
1=2


#==================================================
#                 논리연산77p
#==================================================

# && : 일반적인 and 논리 연산자
2==2 && 34
# & : 벡터에서의 and 논리 연산자
2==2 && c(2==2, 34) #벡터에서 && 연산자를 사용해도 결과는 나오지만 틀린 결과가 출력된다.
2==2 & c(2==2, 34)
# || : 일반적인 or 논리 연산자
2==2 || 34
# | : 벡터에서의 or 논리 연산자
2!=2 || c(2==2, 34) #벡터에서 || 연산자를 사용해도 결과는 나오지만 틀린 결과가 출력된다.
2!=2 | c(2==2, 34)
# ! : not 연산자
!TRUE


#==================================================
#               행/열 문자열 개수79-80p
#==================================================

tmp_df <- data.frame(AA = rnorm(10), BB = letters[1:10])
nrow(tmp_df) #nrow 함수는 행의 개수를 결과로 나타난다
ncol(tmp_df) #ncol 함수는 열의 개수를 결과로 나타낸다.
dim(tmp_df) #dim 함수는 행과 열의 개수를 결과로 나타낸다.
tmp_vec <- c("OK" ,"NOT", "APPLE", "SCHOOL")
nchar(tmp_vec) #nchar 함수는 각각의 값의 문자개수를 결과로 나타낸다.


#백터내의 값의 개수를 알기 위해서는 length 함수를 사용한다.
length(tmp_vec)
tmp_df <- data.frame(AA = c(1:5), BB = c("A","A","B","B","B"))
names(tmp_df) #열의 이름의 결과를 내보낸다.
colnames(tmp_df) #열의 이름의 결과를 내보낸다.
rownames(tmp_df) #행의 이름의 결과를 내보낸다.
dimnames(tmp_df) #열과 행의 이름의 결과를 내보낸다.


#==================================================
#               행/열 이름 변경81-82p
#==================================================

names(tmp_df)[1] <- "AA_1" #첫번째 열의 이름을 변경한다.
names(tmp_df) <- c("AA_2", "BB_2") #첫번째 열과 두번째 열의 이름을 변경한다.
colnames(tmp_df)[1] <- "AA" #첫번째 열의 이름을 변경한다.
rownames(tmp_df)[1] <- "row1" #첫번째 행의 이름을 변경한다.


#==================================================
#               열 추가/제거하기83-84p
#==================================================

tmp_df <- data.frame(AA = c(1:5), BB = c("A","A","B","B","B"))

#CC컬럼을 새로 생성하고 그 안에 값을 1로 채워 넣음 
tmp_df$CC <- 1

#컬럼 AA와 컬럼 CC의 값의 합한 값을 새로운 DD컬럼으로 생성
tmp_df$DD <- tmp_df$AA + tmp_df$CC

tmp_df[, -1] #첫번째 위치의 컬럼 제거

tmp_df[, -"AA"]  #오류 발생함
다음에 오류가 있습니다-"AA" : 단항연산자에 유효한 인자가 아닙니다

tmp_df[, c("BB","CC","DD")]

subset(tmp_df, select = -AA)



#==================================================
#               데이터 추출85-87p
#==================================================

Sample.df <- data.frame(AA = rep(letters[1:5],10), BB = sample(60:70, 50, replace = T), stringsAsFactors = FALSE)

#AA컬럼의 값중에서 a인 값만 추출
#Type1
Sample.df[Sample.df$AA == "a",] 
#Type2
subset(Sample.df, AA == "a") 
#AA컬럼의 값중에서 a 와 b의 값만 추출
#Type1
Sample.df[Sample.df$AA %in% c("a","b"),]
#Type2
subset(Sample.df, AA %in% c("a","b"))
#Type3
for(i in 1:nrow(Sample.df)) 
{
  if(Sample.df[i,"AA"] == "a")
  {
    if(i == 1)
    {
      Select.df <- Sample.df[i,]
    }else{
      Select.df <- rbind(Select.df, Sample.df[i,])
    }
  }
}
# 필요한 컬럼 Select
Sample.df1 <- Sample.df
#Type1
Sample.df1[,c("AA","BB","CC")]
#Type2
Sample.df1[,c(1,2,3)]
#Type3
Sample.df1[,c(-4,-5)]
#Type4
subset(Sample.df1,select = c("AA","BB","CC"))
#Type5
subset(Sample.df1,select = c(AA, BB, CC))
#Type6
subset(Sample.df1,select = c(-CC1,-CC2))


#==================================================
#               데이터 합치기88-91p
#==================================================

# 컬럼을 합치기 위해서는 cbind함수를 사용한다.
#단. 합칠 대상의 데이터의 행 개수는 동일 하여야 한다.
#데이터 프레임인 경우 합칠 두 개의  데이터유형이 달라도 상관 없지만, matrix인 경우 데이터 유형이 같아야 한다.

aa <- c(1:5)
bb <- c(5:1)
cbind(aa,bb)

tmp_df <- data.frame(AA = c(1:5), BB = letters[1:5])
cbind(tmp_df, aa)

#행을 합치기 위해서는 rbind함수를 사용한다.
#단, 합칠 대상의 열 개수는 동일 하여야 한다.
#데이터 프레임인 경우 합칠 두개의 데이터의 각각의 열의 유형이 동일하여야 한다.

rbind(aa, bb)

tmp_df1 <- data.frame(AA = c(1:2), BB = c("A","A"))
tmp_df2 <- data.frame(AA = c(3:4), BB = c("B","B"))
rbind(tmp_df1, tmp_df2)

# 공통된 열을 하나이상 가지고 있는 두 데이터 프레임에 대하여 공통된 열에 맞춰 행들을 하나의 데이터 프레임으로 병합하기 위해서는 merge 함수를 사용한다.

tmp1 <- data.frame(AA = c("A","A","B"), BB = c(1,2,3))
tmp2 <- data.frame(AA = c("A","C"), CC = c("OLD", "NEW"))

#tmp1기준으로 데이터 합치기
merge(tmp1, tmp2, by = "AA", all.x = T)

#tmp2 기준으로 데이터 합치기
merge(tmp1, tmp2, by = "AA", all.y = T)

# 공통된 열을 하나이상 가지고 있는 두 데이터 프레임에 대하여 공통된 열에 맞춰 행들을 하나의 데이터 프레임으로 병합하기 위해서는 merge 함수를 사용한다.

#전체 합치기 매칭이 안되는 값은 NA로 표시
merge(tmp1, tmp2, by = "AA", all = T)

#매칭이 되어지는 데이터만 합치기
merge(tmp1, tmp2, by = "AA", all = F)

#==================================================
#               데이터 분할하기92p
#==================================================

# 집단별 데이터를 분류하기 위해서는 split 함수를 사용하면 된다.
# 집단별로 분류된 데이터는 list 형태로 생성되어진다.

split(tmp1, tmp1$AA)

#문장을 나눌 때는 strsplit 함수를 사용하면 된다
strsplit("A text I want to display with spaces", " ")


#==================================================
#               자료형 변환하기93p
#==================================================

# 각 자료형에 대해서, 값들을 그 자료형으로 변환하는 함수

as. character() #문자형으로 변환
as.complex() #복소수형으로 변환
as.numeric () or as.double #실수형으로 변환
as.integer() #정수형으로 변환
as.logical() #논리형으로 변환
as.factor() #요인형으로 변환
as.date() #날짜형으로 변환


#==================================================
#            데이터 구조 변환하기94p
#==================================================
# 데이터 구조를 변환하는 함수
as.data.frame() #데이터 프레임 형태로 변환
as.list() #리스트 형태로 변환
as.matrix() #메트릭스 형태로 변환
as.vertor() #벡터 형태로 변환



#==================================================
#               데이터 정렬하기96-97p
#==================================================
a <- c(1,4,5,3,5,3,7) #벡터형태에서는 sort 함수를 사용하여 정렬
sort(a)
order(a) #값의 순위값을 나타낸다
sort(a, decreasing = T)
order(a, decreasing = T)

tmp1 <- data.frame(AA = c("A","A","B","C","D"), BB = c(5,3,6,1,2))
tmp1[order(tmp1$BB),] #오름차순 정렬
tmp1[order(tmp1$BB, decreasing = T), ] #내림차순 정렬


#==================================================
#               문자열 처리98-100p
#==================================================

#문자열 합치기 위해서는 paste 함수를 사용한다.
paste("Hi", " R !!", sep = "")
paste("Hi", " R !!", sep = "-")

#문자열을 사용자 정의에 따라 자르고 싶을때는 substring 함수를 사용한다.
substring(a, 1,2)

#문자열 또는 단어에서 특정 단어를 찾기위해서는 grep 함수를 사용한다.
text <- c("arm", "foot", "lefroo", "bafoobar")
grep("foo", text)

#문자뒤의 공백제거
str <- "test  "
sub(" +$", "", str)

#대문자 또는 소문자로 변경하기 위해서는 toupper/ tolower 함수를 사용한다.
toupper(a)
b <- "APPLE"
tolower(b)
strsplit("A text I want to display with spaces", " ") #문장을 나눌 때는 strsplit 함수를 사용하면 된다


#==================================================
#             날짜변환 및 처리101-102p
#==================================================

date() #현재 날짜 정보 표출 (요일/월/ 일/시/분/초/년도)
Sys.time() #현재 날짜 정보 표출(년/월/일/시/분/초)
Sys.Date() #현재 날짜 정보 표출(년/월/일)

weekdays(Sys.Date()) #요일 추출
weekdays(seq(Sys.Date(), length.out=10, by="1 days")) 
months(Sys.Date()) #월 추출

as.Date("20140101","%Y%m%d") #문자열 날짜형태로 변환
as.Date("20140101","%Y%m%d") + 10 #문자열 날짜형태로 변환 후 10일 추가하여 결과 표출
z <- as.difftime(c(0,30,60), units = "mins") #분단위 값의 차이값 표출
as.numeric(z, units = "secs") #분단위 차이값 초단위로 표출
as.numeric(z, units = "hours") #분단위 차이값 시간단위로 표출
format(z) 

#==================================================
#             결측값 처리103-105p
#==================================================

# 결측값 처리
is.na(x)
complete.cases(x1, x2,...) 

#NA값 처리
DT <- fread("c:/Rproject/sample.csv")
library(zoo) 
DT <- na.locf(DT) #NA값 전에 값이 있으면 NA값 전의 값으로 변경
DT <- na.locf(DT, fromLast = TRUE) #시작값이 NA값이면 NA이후의 값으로 변경



#==================================================
#             행/열 전환하기106p
#==================================================

install.packages(“reshape”)
library(reshape)
mydata <- data.frame(id = c(1, 1, 2, 2), time  =c(1, 2, 1, 2),  x1 = c(5, 3, 6, 2), x2 = c(6, 5, 1, 4))
melt(mydata, id=c("id","time"))


#==================================================
#                 데이터 요약109p
#==================================================

x <- c(1:10)
length(x)
sum(x)
prod(x)
cumsum(x)
cumprod(x)
cummin(x)
cummax(x)



#==================================================
#                  대푯값111p
#==================================================

mean(x)
median(x)
max(x)
min(x)
which.max(x)
which.min(x)
y <- c(1,1,1,2,2,3,5,5)
unique(y)
range(x)

#==================================================
#                   정렬113p
#==================================================

rev(x)
y <- c(9,10,3,2,6)
rank(y)
sort(y)
df1 <- data.frame(X = c(1,3,4,2,5), Y = c(1,2,3,4,5))
df1[order(df1$X),]

#==================================================
#                   문자형115-118p
#==================================================

x <- c("a","b","c","d")
x <- toupper(x)
x <- tolower(x)
x <- c("apple", "table", "car")
nchar(x)
x <- "문자형 데이터를 정해진 구분자로 분리"
strsplit(x, split = " ")
split_x <- strsplit(x, split = " ")
split_x

x <- c("문자형", "데이터를", "정해진", "구분자로", "분리")
strtrim(x, 2)
strtrim(x, 4)
substr("abdcefg", 1,3)
paste(x, collapse = " ")

x <- c("korea", "english", "china")
x
grep("e", x)
regexpr("e", x)
gregexpr("e", x)


#==================================================
#                   기타120-122p
#==================================================

x <- matrix(1:10, ncol = 2)
scale(x, scale = FALSE)
subset(airquality, Temp  94, select = c(Ozone, Temp))
sample(c(1:10), 5)

intersect <- function(x, y) y[match(x, y, nomatch = 0)]
intersect # the R function in base, slightly more careful 
intersect(1:10, 7:20)
which(LETTERS == "R") 
choose(5, 2) 
for (n in 0:10) print(choose(n, k = 0:n))
x <- 5 any(x < 0) 
x <- c(1,2,3,4,5) 
any(x < 0) 
gl(2, 2, labels = c("Control", "Treat")) 
diff(c(5,99)) 

#==================================================
#                 if문 (조건문)124p
#==================================================

#특정한 조건을 만족했을 경우에만 프로그램 코드를 수행하는 제어 구문. 항상 논리 연산이 수반 된다
#if(조건) 실행문
x <- c(1,2,3,4); y <- c(2,1,4,5)
if(sum(x) < sum(y)) print(x) #x의 합이 y의 합보다 작을 경우 실행

#if(조건) 조건이 참일 때 실행문 else 조건이 참이 아닐 때 실행문
#괄호안의 조건이 참이면 참일때의 실행문을 수행하고 거짓일 때는 참이 아닐때의 실행문을 수행하는 표현식
x <- c(1,2,3,4)
y <- c(2,1,4,5)
if(mean(x)>mean(y)) print("Mean(x)>Mean(y)") else print("Mean(x)<Mean(y)")

#중첩 조건문 : 조건문 안에 조건문이 있는 표현식
if(length(x)==5) {
  if(sum(x) == 10) print("length=5, sum=10")
} else {
  print("length=4, sum=10")
}

#ifelse(조건, 조건이 참일때의 실행문, 조건이 참이 아닐때의 실행문)
ifelse(x<y, x, y)
ifelse(sum(x-y) > 0, "positive", ifelse(sum(x-y) < 0 , "negative", "zero"))


#==================================================
#             switch문 (조건문)126p
#==================================================
# switch문 (조건문)
#switch(인수, 표현식1, 표현식2, ....)
#예제1 :인수의 결과값이 문자열을 가질 때
#type이라는 문자열 인수값(var)에 해당하는 인수(var)를 찾아서 인수값(var(x))을 실행
x <- c(1,2,3,4)
type<-"var"
switch(type, mean=mean(x), median=median(x), sum=sum(x), var=var(x))

#예제2 : 인수의 결과값이 1보다 큰 정수 값을 가질 때
#정수 값에 해당하는 순서의 표현식을 실행한다. 정수값이 1이므로 첫 번째표현식(mean(x))을 실행한다.
x <- c(1,2,3,4)
switch(1, mean(x), median(x), sum(x), var(x))


#==================================================
#              for문 (반복문)128-129p
#==================================================

for(변수 in 반복횟수) 실행문 : 실행문을 반복횟수만큼 실행
#예제1
#변수 i가 1에서 5까지의 값을 갖을 때까지 print(rep(i,i))라는 실행문을 실행한다. 
#i=1이면 print(rep(1,1))을 실행하고 i=2이면 print(rep(2,2))을 실행한다. 이렇게 i=5일때까지 실행을 하게된다.
for(i in 1:5) print(rep(i,i))

#예제2 : 1부터 10까지 합 구하기
sum.x<-0
for(i in 1:10) sum.x<-sum.x + i
sum.x

#중첩 루프 : 반복문 안에 반복문이 있는 구문
#예제1 : 구구단 만들기
gugu<-matrix(0, ncol=9, nrow=9)
for(i in 1:9) {
  for(j in 1:9) {
    gugu[i,j]<-i*j
  }
}
gugu


#==================================================
#              while문 (반복문)130-131p
#==================================================

while(조건) 실행문 : 조건이 참일 때까지 실행문을 수행

#예제1 #a의 값이 5이하 까지 반복적으로 진행
a<-1
while(a<=5) {
  print(rep(a,a)) 
  a<-a+1
}
#예제2 : 1부터 10까지 합 구하기
a<-1
sum.a<-0
while(a <= 10) {
  sum.a<-sum.a + a
  a<-a+1
}
sum.a


#==================================================
#             repeat문 (반복문)132-133p
#==================================================

#repeat 실행문 : 실행문을 계속 수행하다 실행문에서 break문을 만나서 반복수행을 그만둔다

a<-1
repeat {
  if(a  5) break #a의 값이 5보다 큰 경우 break 실행
  print(rep(a,a)) 
  a<-a+1
}  

#예제2 : 1부터 10까지 합 구하기
a<-1
sum.a<-0
repeat {
  if(a  10) break #a의 값이 10보다 큰 경우 break 실행
  sum.a<-sum.a + a
  a<-a+1
}
sum.a


#==================================================
#             apply문 (반복문)134-135p
#==================================================

#apply 함수 예제

height <- c(140,155,142,175)                  #height 벡터 생성
size.1 <- matrix(c(130,26,110,24,118,25,112,25), ncol=2, byrow=T, dimnames=list(c("Abe", "Bob", "Carol", "Deb"), c("Weight", "Waist")))
size <- cbind(size.1, height) # size.1 행렬과 height 벡터의 열 기준 결합
colmean <- apply(size, 2, mean)              #2열의 평균값을 계산
rowmean <- apply(size, 1, mean)              #1행의 평균값을 계산
colvar <- apply(size, 2, var)                   #2열의 분산값을 계산
rowvar <- apply(size, 1, var)                   #1행의 분산값을 계산

#sapply 함수 예제
#결과 값이 테이블 형테로 나타난다.
x <- list(a = 1:10, beta = exp(-3:3), logic = c(TRUE,FALSE,FALSE,TRUE))
sapply(x, quantile)

#lapply 함수 예제
#결과값이 리스트 형태로 나타난다.
lapply(x, quantile)


#==================================================
#             by문 (반복문)136p
#==================================================

#by 함수 예제
#by(data, INDICES, FUN, ..., simplify = TRUE)

require(stats) 

#warpbreaks 테이블의 tension컬럼 값 구분에 따라, breaks, wool 컬럼의 
#기초 통계량 값을 생성
by(warpbreaks[, 1:2], warpbreaks[,"tension"], summary) 
by(warpbreaks[, 1], warpbreaks[, -1], summary) 
by(warpbreaks, warpbreaks[,"tension"], function(x) lm(breaks ~ wool, data = x))


#==================================================
#           aggregate문 (반복문)137-138p
#==================================================

#aggregate 함수 예제
aggregate(x, by, FUN, ..., simplify = TRUE)
head(iris)

aggregate(iris$Sepal.Length, by = list(iris$Species), summary)
#조건에 by = list(iris$Species) 로 할경우 컬럼 명이 Group.1으로 강제 할당 된다.
#컬럼명을 정의 하고 싶으면 다음과 같이 작성하면 된다.
aggregate(iris$Sepal.Length, by = list(Species = iris$Species), summary)



#==================================================
#         data.table 개요 및 생성140-141p
#==================================================

install.packages('data.table')
library(data.table)

DF <- data.frame(x=c("b","b","b","a","a"),v=rnorm(5))
DT <- data.table(x=c("b","b","b","a","a"),v=rnorm(5))
DT
DF

CARS <- data.table(cars)
CARS2 <- CARS

#tables()함수를 사용하면 오브젝트에 생성되어진 data.table들의 정보를 보여준다.
tables()

#컬럼 생성
DT <- data.table(a=LETTERS[c(1,1:3)],b=4:7,key="a")
DT[,c:=8]        # c라는 컬럼이름으로 생성되어지며 값은 8을 넣은다.
DT[2,c:=10]     # c의 컬럼의 두번째 Row의 값을 10으로 변경한다.
DT[,c:=NULL]     # c컬럼을 삭제한다.
DT   
DT$c <- 8 #이런 방법을 사용해도 위의 DT[,c:=8]방법과 동일하다.



#==================================================
#                 데이터 추출142-149p
#==================================================

#data.table 데이터 추출
DT
DT[, x] #data.table에서 컬럼을 하나를 추출할 때 컬럼명에 따음표("")를 입력하지 않음
DT[, "x"] # 다음과 같이 출력되어짐 -   [1] "x"
DT$x #data.frame과 같은 방법으로 사용할 수 있음
DT[DT$x == "b",] #x컬럼의 값에서 b인  데이터를 추출하는 방식은 data.frame과 동일하다.
#그럼 data.table에서 subset함수를 사용할 수 있을까?
subset(DT, x == "b") #당연히 가능하다.!!!


#그럼 데이터를 추출할 때 꼭 컬럼명을 써야 데이터를 추출할 수 있는 것인가? 값만 입력을 해도 데이터를 가지고 올 수 없을까?
#그러한 경우에는 setkey()함수를 사용하면 된다.
#먼저 setkey(데이터 테이블 명, 키로 설정할 컬럼명)를 설정하여야 한다.
setkey(DT, x)
tables() #tables()함수로 각각의 data.table정보를 보면 DT data.table에 KEY로 x가 설정되어진것을 확인할 수 있다.
#그럼 한번 데이터를 추출해 볼까?
DT["b", ] #아래의 결과와 같이 컬럼명을 입력하지 않아도 x컬럼의 값 중에서 b인 것만 추출되어 졌다.


#다음은 옵션에서 mult를 알아보기로 하자 
DT[,mult="first"] #다음과 같을 때는 인식이 안 된다.
DT["b", mult = "first"] #x의 값이 b인 데이터에서 첫번쨰 값을 뽑아온다.

#그럼 혹시 처음 방법은 x의 값이 a와 b가 있어서 그런건 아닐까?
DT2 <- data.table(x=c("b","b","b","b","b"),v=rnorm(5)) #새로운 data.table을 만들어 보자 x컬럼의 값은 b로만 하고 key값은 정의를 하지 않고 실행해보자.
DT2[ , mult = "first"] #이런 방법으로 결과가 나오지 않는다. 그럼 x컬럼에 key값을 정의해서 다시 해보자.

setkey(DT2, x)
DT2[ , mult = "first"] 
#이방법도 안 된다. 그럼 결국은 다음과 같은 방법을 사용하였을 때나 가능한 방법이다.

DT2["b" , mult = "first"]
DT[c("a","b"), mult = "first"]


#결국 mult = "first"는 키값으로 정의되어진 x의 컬럼의 값에서 요인별 첫번째 값을 추출할 때 사용 하는 방법이다.
#mult의 변수는 "all" ,"first", "last"가 있다.
#그리고 x의 컬럼에 키값을 설정하면 다음과 같이 사용할 수 있다.
DT["a"] #아래와 같이 코드를 사용을 하지 않아도 결과가 나온다.
DT["a", ]
#그럼 DT 데이터 테이블에 컬럼을 추가할 때는 data.frame과 동일하다.
DT$z <- 1
DT
DT["a"] #이 방법은 나머지 모든 컬럼이 같이 나오게 된다. 그럼 x의 컬럼이 a일 때 v, z의 컬럼만 보고 싶을 때는 어떻게 해야 할까?
DT["a", c(v, z)] #V1이라는 새로운 컬럼이 생성되어지면서 v, z의 값이 들어가 있는것을 확인할 수 있다.
DT[i = "a", j = list(v,z)] #list()안에 컬럼명을 입력하면 되어진다. 
DT["a", list(v, z)]
DT["a", list("v", "z")] #컬럼명에 따옴표를 사용하면 안 된다.


#그럼 이번에는 좀더 많은 데이터를 가지고 data.frame과 data.table의 데이터 추출의 속도를 알아보기로 하자.

#먼저 예제 데이터를 생성한다.
grpsize <-ceiling(1e7/26^2)
tt <- system.time( DF <- data.frame(x=rep(LETTERS,each=26*grpsize),
                                    y=rep(letters,each=grpsize),
                                    v=runif(grpsize*26^2),
                                    stringsAsFactors=FALSE))
#DF = row : 10,000,068, col = 3
head(DF,3)
tail(DF,3)

#data.frame에서 x컬럼의 값 중에서 "R"을 y컬럼의 값 중에서 "h"를 추출하여 ana1의 새로운 data.frame에 저장하는 시간을 알아보자
tt <- system.time(ans1 <- DF[DF$x=="R" & DF$y=="h",]) #1.7초 걸린다. 



#그럼 subset()함수를 사용하였을 때는 얼마나 나올까?
tt <- system.time(ana1.1 <- subset(DF, x == "R" & y == "h")) #위의 방법보다 속도가 더 오래 걸린다. 1.9초

#그럼 x, y의 컬럼을 factor로 변경하면 속도가 빨라질까?
DF$x <- as.factor(DF$x)
DF$y <- as.factor(DF$y)
tt <- system.time(ans1.2 <- DF[DF$x=="R" & DF$y=="h",]) 
#factor로 변경하였더니 속도가 더 오래 걸리는 것으로 나타났다.

#사용자  시스템 elapsed 
#2.74    0.09    2.84

tt <- system.time(ana1.3 <- subset(DF, x == "R" & y == "h"))
#사용자  시스템 elapsed 
#2.98    0.11    3.09 


#그럼 이번에는 data.frame의 DF를 data.table로 생성하여 데이터를 추출해보자. 
DT <- data.table(DF)
setkey(DT, x, y)  #알고 있겠지만 동시에 여러 컬럼에 key값을 설정할 수 있다. 
ss <- system.time(ans2 <- DT[J("R", "h")]) #여기서 보면 J라는 함수를 사용하였다.
# J는 data.table안에서만 사용할 수 있다. 
#위의 결과는 순식간에 데이터를 추출하게 된다. 

#x y컬럼을 key값으로 정의 하지 않으면 연산 속도가 얼마나 걸리는지 파악해 본다.
DT2 <- data.table(DF)
ss <- system.time(ans3 <- DT2[DT2$x == "R" & DT2$y == "h"]) 
#data.frame보다는 빠른 속도를 보여주지만 컬럼에 키값을 설정한 것 보다는 속도가 느리게 나왔다.
#사용자  시스템 elapsed 
#0.94    0.01    0.96

unique(ans2 == ans3) #추출되어지는 결과는 동일하다.


ss <- system.time(ana4 <- subset(DT2, x == "R" & y == "h")) 
#subset()함수를 사용할 때는 소요시간이 더 오래 걸리는 것으로 나왔다.
#사용자  시스템 elapsed 
#1.13    0.09    1.21



#==================================================
#           데이터 그룹 통계량 생성150-153p
#==================================================

#그룹별 통계량 구하기
#data.frame에서는 그룹별 sum하는 것은 aggregate를 추천한다.
#다른 방법을 사용해보았지만 aggregate가 가장 빠르게 나왔다. 

#먼저 예제 데이터를 만들어보자.
DF <- data.frame(x=rep(LETTERS,each=26*grpsize),
                 y=rep(letters,each=grpsize),
                 v=runif(grpsize*26^2),
                 stringsAsFactors=FALSE)
DT <- data.table(DF)
setkey(DT,x,y) #DT테이블에 컬럼 x, y를 키값으로 정의하자


#우선적으로 data.frame를 테스트 해보자 얼마나 속도가 나오는지.
tt <- system.time(Sum_DF <- aggregate(DF$v, by = list(DF$x), sum))
head(Sum_DF)
#사용자  시스템 elapsed 
#12.18    0.50   12.68 
#data.frame을 그룹별로 sum하는 소요시간은 12.68초가 소요되었다. 생각 외로 오래 걸린다.

#그럼 data.table을 테스트 해보자. data.table은 aggregate함수를 사용하지 않고 내부적으로 그룹별로 sum을 할수 있다.
ss <- system.time(Sum_DT <- DT[,sum(v),by=x])
head(Sum_DT)
#사용자  시스템 elapsed 
#0.24    0.03    0.26 
# 1초도 되지 않는 시간에 결과가 나왔다. 48배의 속도의 차이가 났다. 


#그럼 data.table에 aggregate함수를 사용해서 그룹별 sum을 하였을 때는 얼마나 걸릴까?
ss <- system.time(Sum_DT2 <- aggregate(DT$v, by = list(DT$x), sum))
#사용자  시스템 elapsed 
#11.98    0.53   12.51
#이런 방법은 사용하지 말자 data.frame과 거의 같은 결과가 나왔다. 

#그럼 동시에 sum, min, max, median을 구해보기로 하자 
ss <- system.time(Sum_DT3 <- DT[,list(SUM1 = sum(v),
                                      MIN1 = min(v),
                                      MAX1 = max(v),
                                      MED1 = median(v)),by=x])
#사용자  시스템 elapsed 
#0.55    0.02    0.56
#역시나 1분이 되지 않는 시간에 결과가 나왔다.



#확장 예제
ss <- system.time(Sum_DT4 <- DT[,sum(v),by= list(x, y)]) #x, y별로 그룹하여 sum한 결과도 0.18초가 나왔다.

tt <- system.time(Sum_DF2 <- aggregate(DF$v, by = list(DF$x, DF$y), sum))
#사용자  시스템 elapsed 
#14.29    0.81   15.10 

#다음과 같이 필요한 데이터만 추출하여 그룹별 sum을 구할수도 있다.
ss <- system.time(Sum_DF5 <- DT[c("A","B"), sum(v)])




#==================================================
#               데이터 합치기154-156p
#==================================================

#먼저 예제 데이터를 만들고..
DF_1 <- data.frame(AA = letters[1:5], BB = rnorm(5), stringsAsFactors=FALSE)
DF_2 <- data.frame(AA = letters[1:10], CC = c(1:10), stringsAsFactors=FALSE)
DF_3 <- data.frame(EE = LETTERS[1:5], DD = sample(1:100, 5), stringsAsFactors=FALSE)
DF_4 <- data.frame(AA = letters[6:8], BB = rnorm(3), stringsAsFactors=FALSE)

DT_1 <- data.table(DF_1)
DT_2 <- data.table(DF_2)
DT_3 <- data.table(DF_3)
DT_4 <- data.table(DF_4)


#먼저 cbind를 해보자
cbind(DF_1, DF_3)
cbind(DT_1, DT_3)
#data.frame과 data.table과 같은 결과가 나왔다.

#그럼 rbind는 ?
rbind(DF_1, DF_4)
rbind(DT_1, DT_4)
#역시나 동일한 결과가 나왔다.

#그럼 마지막 테스트 merge다
merge(DF_1, DF_2, all.x = T)
merge(DT_1, DT_2, by = "AA", all.x = T)

setkey(DT_1, AA)
setkey(DT_2, AA)
merge(DT_1, DT_2, all.x = T) 

#그럼 key 설정을 해지하는 것은 어떻게 해야 할까? 
setkey(DT_1, NULL) #key 설정 해지방법은 NULL을 사용하면 된다.

#테스트를 한결과 data.table도 rbind, cbind, merge를 사용할 수 있다.
#그러면 rbind, cbind, merge와 같은 결과를 내는 방법이 있을지 알아보기로 하자.

DT_1[DT_2] 
#이 방법은 Key 값을 설정해야 사용할 수 있다. 그런데 outer join과 같은 결과가 나오네..

#그럼 left join과 같은 결과가 나오려면 어떻게 해야 하지?
DT_1[DT_2, nomatch = 0] #nomatch = 0으로 설정하면 된다.
DT_2[DT_1] #이 방법을 사용해도 된다.
#하지만 위 방법보다는 확실한 merge()함수를 사용하기로 하자.








#==================================================
#               기초통계량158-160p
#==================================================


mydata <- data.frame(id = c(1, 1, 2, 2), time  =c(1, 2, 1, 2), x1 = c(5, 3, 6, 2), x2 = c(6, 5, 1, 4))
sapply(mydata, mean, na.rm = TRUE)
summary(mydata)
fivenum(x) 

library(Hmisc)
describe(mydata) 

library(pastecs)
stat.desc(mydata)

library(psych)
describe(mydata)

library(psych)
describe.by(mydata, group, ...)

library(doBy)
summaryBy(mpg + wt ~ cyl + vs, data = mtcars, FUN = function(x) { c(m = mean(x), s = sd(x)) } )


x <- rnorm(100)
quantile(x)
#quantile 함수에서 기본 옵션으로 설정 시 위와 같은 결과 표출

quantile(x, probs = c(0.2)) #20% 위치
quantile(x, probs = c(0.2, 0.4)) #20%, 40% 위치
diff(range(quantile(x, probs = c(0.2, 0.4)))) #20%, 40% 범위값


x <- rnorm(100)
min(x) #최소값
max(x) #최대값
median(x) #중앙값
mean(x) #평균
sd(x) #표준편차
var(x) #분산
rank(x) #값의 순위


#==================================================
#             빈도/교차 테이블161p
#==================================================

mydata <- data.frame(id = c(1, 1, 2, 2), time  =c(1, 2, 1, 2), x1 = c(5, 3, 6, 2), x2 = c(6, 5, 1, 4))

#2차원 빈도표
attach(mydata)
mytable <- table(A,B)
mytable # print table

#3차원 빈도표
mytable <- table(A, B, C) 
ftable(mytable) 
mytable <- xtabs(~A+B+c, data = mydata)
ftable(mytable)
summary(mytable)
#2차원 교차표
library(gmodels)
CrossTable(mydata$myrowvar, mydata$mycolvar)

#독립성검정
chisq.test(mytable)
fisher.test(x)
Mantel-Haenszel test


#==================================================
#                   t-test 162p
#==================================================

#표본을 이용한 모평균 검정 : 모집단에서 나온 표본이 모집단의 평균이 합리적으로 특정 값 m일 수 있는 지 확인

sample_x <- rnorm(50, mean = 100, sd = 15)
t.test(sample_x, mu = 95)

#두 모집단의 평균 비교
#t.test는 기본 설정으로 데이터가 서로 대응되지 않는다고 가정함. 만약 관측들이 대응하고 있다면 옵션에서 paired = TRUE로 설정

sample_x <- rnorm(50, mean = 100, sd = 10)
sample_y <- rnorm(50, mean = 100, sd = 15)
t.test(sample.x, sample.y)

t.test(sample.x, sample.y, paired = TRUE)



#==================================================
#                   상관분석 164p
#==================================================


cor(mtcars, use = " complete.obs", method = "kendall")  # 상관계수 
cov(mtcars, use = "complete.obs")  # 공분산


# 상관관계 신뢰수준
library(Hmisc)
rcorr(x, type = "pearson") 
rcorr(as.matrix(mtcars))



#================================================
#  			    K-means(군집분석)165p
#================================================

#K 평균 군집법 : 미리 k개의 군집수를 정해놓고 군집 내에서 거리들의 제곱합이 최소가 되도록 군집들을 나누는 방법

#자료(정규 난수) 생성
set.seed(100)
x <- rbind(matrix(rnorm(100, sd = 0.3), ncol = 2),
           matrix(rnorm(100, mean = 1, sd = 0.3), ncol = 2))
colnames(x) <- c("x", "y")


#k평균 군집법 
(cl <- kmeans(x, 2))
#군집 분석 결과를 그래프로 표현
plot(x, col = cl$cluster, ,main='K-means Clustering')
#군집의 중심을 표현
points(cl$centers, col = 1:2, pch = 8, cex = 2)


#==================================================
#  			        계층적 군집 분석166p
#==================================================

#계층적 군집 분석 : 거리가 가까운 군집끼리 묶는 병합 방법과 먼 거리에 있는 군집들을 차례로 분리하는 분할 방법

#예제 자료 생성
x <- as.data.frame(matrix(c(0,0, .5,.5, 4.1,4.1, 2,2.5, 3,2.5, 2,2), byrow=T, ncol=2))
rownames(x) <- c('A','B','C','D','E','F')
#계층적 군집 분석 : 단일연결법(single)  
h <- hclust(dist(x), method='single')
#덴드로그램 생성
plot(h, xlab='', main='Dendrogram Example', sub='', hang=-1)


#==================================================
#    		            회귀분석 167p
#==================================================

lm(formula, data, subset, weights, na.action, method = "qr", model = TRUE, x = FALSE, 
   y = FALSE, qr = TRUE, singular.ok = TRUE, contrasts = NULL, offset, ...)

require(graphics) 
## Annette Dobson (1990) "An Introduction to Generalized Linear Models". 
## Page 9: Plant Weight Data. 
ctl <- c(4.17,5.58,5.18,6.11,4.50,4.61,5.17,4.53,5.33,5.14) 
trt <- c(4.81,4.17,4.41,3.59,5.87,3.83,6.03,4.89,4.32,4.69)
group <- gl(2, 10, 20, labels = c("Ctl","Trt")) 
weight <- c(ctl, trt) 
lm.D9 <- lm(weight ~ group)
lm.D90 <- lm(weight ~ group - 1) # omitting intercept 
anova(lm.D9) 
summary(lm.D90) 
opar <- par(mfrow = c(2,2), oma = c(0, 0, 1.1, 0)) 
plot(lm.D9, las = 1) 
# Residuals, Fitted, ... par(opar)


#==================================================
#   					로지스틱 회귀분석168p
#==================================================

#boot 패키지의 nodal 자료 사용
library(boot)
data(nodal)
#관측치 53개, 변수 5개인 nodal 자료에서 로지스틱 모형 적합
#반응 변수(r) : 림프절이 전립선 암에 대해 양성이면 1 아니면 0

x <- nodal[,-1]
#logisti 모형 적합
logit.fit = glm(r~., data=x, family="binomial")
#모형 적합 결과
summary(logit.fit)
#양성일 확률에 대한 예측값
predict(logit.fit, type='response')



#==================================================
#     				변수선택 169-171p
#==================================================

#전진 선택법 
#ElemStatLearn 패키지의 prostate 자료 사용
library(ElemStatLearn)

Data <- prostate[,-ncol(prostate)]

#전진 선택법은 상수항만 포함된 모형(lm.const)에서 출발
lm.const <- lm(lpsa~1, data=Data)

#AIC를 이용한 전진 선택법
forward.aic <- step(lm.const, lpsa~lcavol + lweight + age + lbph + svi + lcp + gleason + pgg45, direction="forward")

#선택된 최종 모형
summary(forward.aic)


#후진 소거법 
#전진 제거법과 같은 자료 사용
#후진 소거법은 모든 변수가 포함된 모형(lm.full)에서 출발
lm.full <- lm(lpsa~., data=Data)

#AIC를 이용한 후진 소거법
backward.aic = step(lm.full, lpsa~1, direction="backward")

#선택된 최종 모형
summary(backward.aic)


#단계적 선택법 
#전진 제거법과 같은 자료 사용
#단계적 선택법은 적절한 모형에서 출발
#여기서는 상수항만 포함된 모형(lm.const)에서 출발
#AIC를 이용한 단계적 선택법

stepwise.aic <- step(lm.const, lpsa~lcavol + lweight + age + lbph + svi + lcp + gleason + pgg45, direction="both")

#선택된 최종 모형
summary(stepwise.aic)

#============================================
#  					      Tree 172p
#============================================

library(boot)
data(nodal)
Data <- nodal[,-1] # 데이터 지정
Data_train <- Data[1:40,]  # Training 데이터 지정
Data_test <- Data[41:53,] # Test 데이터 지정
xtrain <- Data_train[,-1] # X train 지정
ytrain <- Data_train[,1] # Y train 지정
xtest <- Data_test[,-1] # X test 지정
ytest <- Data_test[,1] # Y test 지정

library(tree)
tree.fit <- tree(as.factor(r)~.,data=Data_train) # Tree 모형 적합
plot(tree.fit,type="u",lwd=3) # Tree 그림
text(tree.fit)
yhat <- predict(tree.fit,xtest) # test 자료를 predict
pred <- c()
for(i in 1:nrow(yhat)){
  pred[i]=which(yhat[i,]0.5)-1}
b <- table(ytest,pred) # 오분류표
print(b)



#==================================================
#   			     	    KNN 173p
#==================================================

library(boot)
data(nodal)
Data <- nodal[,-1] # 데이터 지정
Data_train <- Data[1:40,]  # Training 데이터 지정
Data_test <- Data[41:53,] # Test 데이터 지정
xtrain <- Data_train[,-1] # X train 지정
ytrain <- Data_train[,1] # Y train 지정
xtest <- Data_test[,-1] # X test 지정
ytest <- Data_test[,1] # Y test 지정


library(class)
error = rep(0,10)
for(i in 1:10){ # 1 부터 10 까지 중 최적의 k 를 찾음
  out = knn.cv(train=xtrain,cl=ytrain,k=i)
  error[i] = sum(ytrain != out)/nrow(Data_train)}
plot(1:10,error,type="l",lwd=3,xlab="k",ylab="error") 
yhat <- knn(train = xtrain, cl = ytrain, test = xtest, k = 10) # test 자료를 predict
b <- table(ytest,yhat) # 오분류표 구함
print(b)



#==================================================
#   			     	    SVM 174p
#==================================================

library(boot)
data(nodal)
Data <- nodal[,-1] # 데이터 지정
Data_train <- Data[1:40,]  # Training 데이터 지정
Data_test <- Data[41:53,] # Test 데이터 지정
xtrain <- Data_train[,-1] # X train 지정
ytrain <- Data_train[,1] # Y train 지정
xtest <- Data_test[,-1] # X test 지정
ytest <- Data_test[,1] # Y test 지정

library(e1071)
svm.fit <- svm(as.factor(r)~.,data=Data_train) # svm 적합
summary(svm.fit)
yhat <- predict(svm.fit,xtest) # test 자료를 predict
yhat
b <- table(ytest,yhat) # 오분류표 구함
print(b)


#==================================================
#   			      Neural network 175p
#==================================================

data(infert) # 데이터 불러오기
s=sample(nrow(infert))
traininf=infert[s[1:150],-1] # training set 지정
testinf=infert[s[150:nrow(infert)],-1] # test set 지정
xtrain=traininf[,-4]
ytrain=traininf[,4]
xtest=testinf[,-4]
ytest=testinf[,4]

library(devtools)
library(nnet)
nn <- nnet(xtrain,ytrain,data=traininfert,size=2,linout=T)
source_url('https://gist.githubusercontent.com/Peque/41a9e20d6687f2f3108d/raw/85e14f3a292e126f1454864427e3a189c2fe33f3/nnet_plot_update.r')
plot.nnet(nn)
yhat<-predict(nn,xtest)
yhat[yhat0.5]=1
yhat[yhat<=0.5]=0
b = table(ytest,yhat)
print(b)

