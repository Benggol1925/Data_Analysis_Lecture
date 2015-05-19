#==================================================
#             R tip : R 코드작성 14-20p
#==================================================

#데이터 추출
Sample.df <- data.frame(AA = rep(letters[1:5],10), BB = sample(60:70, 50, replace = T), stringsAsFactors = FALSE)

#AA컬럼의 값중에서 a인 값만 추출
#Type1
Sample.df[Sample.df$AA == "a",] 
#Type2
subset(Sample.df, AA == "a") 
#Type3
for(i in 1:nrow(Sample.df)) {
  if(Sample.df[i,"AA"] == "a") {
    if(i == 1) {
      Select.df <- Sample.df[i,]
    }else{
      Select.df <- rbind(Select.df, Sample.df[i,])
    }
  }
}

#AA컬럼의 값중에서 a 와 b의 값만 추출
#Type1
Sample.df[Sample.df$AA %in% c("a","b"),]
#Type2
subset(Sample.df, AA %in% c("a","b"))

#컬럼 생성
#CC컬럼을 생성시 AA컬럼의 값이 a이면 1, b이면 2 그렇지 않으면 3의 값을 생성
#Type1
Sample.df[Sample.df$AA == "a", "CC"] <- 1 
Sample.df[Sample.df$AA == "b", "CC"] <- 2 
Sample.df[!(Sample.df$AA %in% c("a","b")), "CC"] <- 3 

#Type2
Sample.df$CC1 <- ifelse(Sample.df$AA == "a", 1, ifelse(Sample.df$AA == "b",2,3))

#Type3
for(i in 1:nrow(Sample.df)) {
  if(Sample.df$AA[i] %in% c("a","b")) {
    if(Sample.df$AA[i] == "a") {
      Sample.df$CC2[i] <- 1
    }else{
      Sample.df$CC2[i] <- 2
    }
  }else{
    Sample.df$CC2[i] <- 3 
  }
}

#필요한 컬럼 Select
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


#for문을 활용한 여러개의 csv File을 호출
#csv File을 R에 호출할때 사용하는 함수는 read.csv() 이다.
#만약 호출하려고 하는 데이터가 여러개(수십 수백개)일때 R코드는 수십줄 수백개줄이 소요된다.
#다음과 같은 방식을 사용하면 여러개의 데이터를 쉽게 R로 호출할 수 있을것이다.
#기본방법
import_csv_1_df <- read.csv(paste(file.dir, "Link_A000001_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_2_df <- read.csv(paste(file.dir, "Link_A000002_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_3_df <- read.csv(paste(file.dir, "Link_A000003_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_4_df <- read.csv(paste(file.dir, "Link_A000004_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_5_df <- read.csv(paste(file.dir, "Link_A000005_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_6_df <- read.csv(paste(file.dir, "Link_A000006_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_7_df <- read.csv(paste(file.dir, "Link_A000007_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_8_df <- read.csv(paste(file.dir, "Link_A000008_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_9_df <- read.csv(paste(file.dir, "Link_A000009_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_10_df <- read.csv(paste(file.dir, "Link_A000010_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_11_df <- read.csv(paste(file.dir, "Link_A000011_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_12_df <- read.csv(paste(file.dir, "Link_A000012_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_13_df <- read.csv(paste(file.dir, "Link_A000013_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_14_df <- read.csv(paste(file.dir, "Link_A000014_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_15_df <- read.csv(paste(file.dir, "Link_A000015_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_16_df <- read.csv(paste(file.dir, "Link_A000016_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_17_df <- read.csv(paste(file.dir, "Link_A000017_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_18_df <- read.csv(paste(file.dir, "Link_A000018_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_19_df <- read.csv(paste(file.dir, "Link_A000019_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_20_df <- read.csv(paste(file.dir, "Link_A000020_df.csv", sep = ""),stringsAsFactor = FALSE)


#수정방법
# 1) 자료불러오기
# 1.1) CSV File 불러오기
# 자료를 불러오기 위하여 디렉토리와 File이름을 정의한다. 
file.dir <- "C:\\Rproject\\EXAM1\\"

# 불러들일 자료는 속도와 교통량이 들어있는 20개의 파일임.
file.name <- shell(paste("dir ", file.dir, "*.CSV /b /w /a-d", sep = ""), intern = TRUE)

for(file.i in 1:length(file.name))
{
  temp.df <- read.csv(paste(file.dir, file.name[file.i], sep = ""),stringsAsFactor = FALSE)
  names(temp.df) <- c("LINK_ID","TIME","SPEED","VOLUMN")
  cat(file.i, "/", length(file.name), "[ N :", nrow(temp.df), "]", "\n")
  assign(paste("import_csv", file.i, "df", sep = "_"), temp.df)
}
#임시파일 삭제
rm(temp.df, file.i)
ls()

#for문을 활용한 여러개의 데이터 하나의 데이터로 합치기
#호출되어진 20개의 파일을 Total_Csv_Speed 이름을 생성
#기존방법
Total_Csv_Speed <- rbind(import_csv_1_df,import_csv_2_df,import_csv_3_df,import_csv_4_df,import_csv_5_df
                         ,import_csv_6_df,import_csv_7_df,import_csv_8_df,import_csv_9_df,import_csv_10_df       ,import_csv_11_df,import_csv_12_df,import_csv_13_df,import_csv_14_df,import_csv_15_df
                         ,import_csv_16_df,import_csv_17_df,import_csv_18_df,import_csv_19_df,import_csv_20_df)

#수정방법
import_csv_names <- apropos("import_csv_")

for(i in 1:length(import_csv_names)) {
  if(i == 1) {
    Total_Csv_Speed <- get(import_csv_names[i], pos = 1)
  }
  else {
    temp.df <- get(import_csv_names[i], pos = 1)
    Total_Csv_Speed <- rbind(Total_Csv_Speed, temp.df)
  }
}

#디렉토리 생성
# 저장위치는 C:\\Rproject\\OUT\\Result로 하는데, 
# 만약 폴더가 없다면 저장할 때 오류가 생기므로 폴더가 없다면 
# DOS 명령어를 이용하여 디렉토리를 생성한다.
dir.name <- shell("dir c:\\Rproject\\OUT /ad /b /w ", intern = TRUE)
if(sum(dir.name %in% "Result") == 0) {
  cat("Result 디렉토리 만들기", "\n")
  shell(paste("mkdir ", "c:\\Rproject\\OUT\\Result", sep = ""))
}



#==================================================
#             R tip : 연산속도 21-30p
#==================================================


#Test1 #AA컬럼값과 BB컬럼값의 합을 구함
#방법1
sample.df1 <- data.frame(AA = c(50000:1), BB = c(1:50000))
system.time(for(i in 1:nrow(sample.df1))
{
  sample.df1$RESULT[i] <- sample.df1$AA[i] + sample.df1$BB[i] 
})

#방법2
sample.df2 <- data.frame(AA = c(50000:1), BB = c(1:50000))
system.time(sample.df2$RESULT <- sample.df2$AA + sample.df2$BB)

#방법3
sample.df3 <- data.frame(AA = c(50000:1), BB = c(1:50000))
system.time(sample.df3$RESULT <- apply(sample.df3, 1, sum))

#방법4
sample.df4 <- data.frame(AA = c(50000:1), BB = c(1:50000))
sample.df4$RESULT <- NULL
system.time(for(i in 1:nrow(sample.df1))
{
  sample.df4$RESULT[i] <- sample.df4$AA[i] + sample.df4$BB[i] 
})

#Test2
#방법1
system.time(for(i in 1:10000){
  if(i == 1)
  {
    result.x <- sample.df[i,]
  }
  else
  {
    result.x <- rbind(result.x, sample.df[i, ])
  }
})

#방법2
result.y <- data.frame(AA = numeric(), BB = numeric(), RESULT = numeric())
system.time(for(i in 1:10000){
  result.y[i, ] <- sample.df[i,]
})

#방법3
result.list <- list()
system.time(for(i in 1:10000){
  result.list[[i]] <- sample.df[i,]
})
system.time(result.z <- do.call(rbind, result.list))

#test3 data.frame, data.table 비교
#data.frame
result.list <- list()
system.time(for(i in 1:1000)
{
  result.list[[i]] <- sample.df
})
system.time(result.z <- do.call(rbind, result.list))

#data.table
result.list <- list()
system.time(for(i in 1:1000)
{
  result.list[[i]] <- as.data.table(sample.df)
})
system.time(result.w <- do.call(rbind, result.list))


#test4 중첩for문 사용
#Sample1
m1 <- matrix(0, nrow = 1000, ncol = 1000)
system.time(for(i in 1:ncol(m1))
{
  for(j in 1:nrow(m1))
    ifelse(i == j, m1[j,i] <- 1,  m1[j,i] <- 2)
})

#Sample1 개선 방안
system.time(for(i in 1:nrow(m1))
{
  t1 <- c(1:ncol(m1))
  t1 <- t1[t1 != i]
  m1[i,i] <- 1
  m1[i, t1] <- 2  
})

#test5
#matrix, data.frame, data.table apply()에서 연산속도

#matrix
m2 <- matrix(rnorm(1e+05), 10000, 10000)
df1 <- as.data.frame(m2)
dt1 <- as.data.table(m2)
system.time(result1 <- apply(m2, 2, sd))

#data.frame
system.time(result2 <- apply(df1, 2, sd))
#사용자  시스템 elapsed 
#3.88    0.14    4.54 

#data.table
system.time(result3 <- apply(dt1, 2, sd))

head(result2)

#test6
#Character형식의 값을 factor처리되어진 속도와 numeric형식의 갓을 factor처리되어진 속도 비교
arr <- rep(letters, 1000)
system.time(for (i in 1:1000) foo1 <- factor(arr))

arr <- rep(1:26, 1000)
system.time(for (i in 1:1000) foo2 <- factor(arr))

#test7 값중에서 큰값을 도출
x <- rnorm(1e07)
y <- rnorm(1e07)

#방법1
system.time(pmax(x, y))

#방법2
system.time(ifelse(x < y, y, x))

#test8 괄호 개수에 따른 연산 속도
x <- rnorm(50)
y <- rnorm(50)
n <- 1000000

#예시1
system.time(for(i in 1:n) x + y)

system.time(for(i in 1:n) (((((x + y))))) )

#괄호가 많을 수록 속도가 오래 걸림.


#test9 compiler Package를 활용한 Function 연산 속도 향상
library(compiler)

myFunction<-function() { for(i in 1:10000000) { 1*(1+1) } }

myCompiledFunction <- cmpfun(myFunction) # Compiled function

system.time( myFunction() )

system.time( myCompiledFunction() )


#test10 Group별 Summary1
Sample.df <- data.frame(AA = rep(c(letters, paste(letters,"-1", sep = ""), paste(letters,"-2", sep = "")),100000), BB = rnorm(2600000*3), stringsAsFactors = FALSE)

#aggregate함수를 사용하여 median 과 mean 연산 소요시간비교
system.time(Result.df1 <- aggregate(Sample.df$BB, by = list(Sample.df$AA), mean))
system.time(Result.df2 <- aggregate(Sample.df$BB, by = list(Sample.df$AA), median))

#for문을 사용하여 median 과 mean 연산 소요시간비교
uni.id <- unique(Sample.df$AA)
system.time(for(i in 1:length(uni.id)){
  if(i == 1) {
    Result.df1a <- data.frame(AA = uni.id[i], VALUE = mean(Sample.df[Sample.df$AA == uni.id[i], "BB"]))
  }
  else{
    Result.df1a <- rbind(Result.df1a, data.frame(AA = uni.id[i], VALUE = mean(Sample.df[Sample.df$AA == uni.id[i], "BB"])))
  }
})
system.time(for(i in 1:length(uni.id)){
  if(i == 1){
    Result.df1a <- data.frame(AA = uni.id[i], VALUE = median(Sample.df[Sample.df$AA == uni.id[i], "BB"]))
  }
  else{
    Result.df1a <- rbind(Result.df1a, data.frame(AA = uni.id[i], VALUE = median(Sample.df[Sample.df$AA == uni.id[i], "BB"])))
  }
})


#==================================================
#               sqldf 개요 32-33p
#==================================================

#Step1 : library Install-----------------------------------------------------------------------------------
#sqldf library install
#sqldf 사용하기 위해서는 CRAN에서 sqldf package를 가지 고와서 설치하여야 한다.
#install.packages('sqldf')
library(sqldf)

#Step2 : sqldf package 둘러보기 및 활용---------------------------------------------------------------
#sqldf package에는 다음과 같이 3가지 함수가 존재한다.

#read.csv.sql : csv file을 호출하는 함수
#csv file을 전체 다 가지고 올수도 있으며 sql문을 활용하여 데이터를 가지고 올 수 있음
#read.csv.sql(file, sql = "select * from file", header = TRUE, sep = ",", row.names, eol, skip, 
#             filter, nrows, field.types, comment.char, dbname = tempfile(), drv = "SQLite", ...)

#먼저 iris데이터를 csv file로 만들자
#경로는 c:\Rproject\EXAM에 iris.csv file로 생성
#예시 경로 폴더가 없으면 먼저 위와 같이 폴더를 생성하도록.
write.csv(iris, "c:\\Rproject\\EXAM\\iris.csv", quote = FALSE, row.names = FALSE)
iris1 <- read.csv.sql("c:\\Rproject\\EXAM\\iris.csv")
head(iris1)
#위와 같이 사용하면 sql문은 다음과 같은 형식이다. select * from file
#file : c:\\Rproject\\EXAM\\iris.csv


#==================================================
#             데이터 호출하기 34-39p
#==================================================

# sql문을 활용하여 Sepal.Length의 길이가 5보다 큰 데이터만 호출하는것을 해보자.
iris2 <- read.csv.sql("c:\\Rproject\\EXAM\\iris.csv", 
                      sql = "select * from file where Sepal.Length  5")
#위와 같이 하였을 때는 다음과 같이 Error가 나온다.
#Error in sqliteExecStatement(con, statement, bind.data) : 
#  RS-DBI driver: (error in statement: no such column: Sepal.Length)

#그럼 옵션에서 eol = "\n"을 사용해서 실행해보자.
#Error in sqliteExecStatement(con, statement, bind.data) : 
#  RS-DBI driver: (error in statement: no such column: Sepal.Length)
iris2 <- read.csv.sql("c:\\Rproject\\EXAM\\iris.csv", 
                      sql = "select * from file where Sepal.Length  5", eol = "\n")

#위와 같이 하였을 떄도 다음과 같이 Error가 나온다. 
#Error in sqliteExecStatement(con, statement, bind.data) : 
#  RS-DBI driver: (error in statement: no such column: Sepal.Length)
#처음에 호출한 데이터 iris1 컬럼명을 확인해보자. 
names(iris1)
#[1] "Sepal_Length" "Sepal_Width"  "Petal_Length" "Petal_Width"  "Species" 
#컬럼명이 다르다. "_"로 되어있네? "."가 아니고.. csv file을 열어 봤을 때도 ".'로 되어있는데.
#그럼 where Sepal.Length  5 - where Sepal_Length  5 로 변경해서 하였을 때는 어떨지 확인해 보자.
iris2 <- read.csv.sql("c:\\Rproject\\EXAM\\iris.csv", 
                      sql = "select * from file where Sepal_Length  5")
#문제없이 잘나온다. 그럼 다음과 같이 하였을 때는?
iris3 <- read.csv.sql("c:\\Rproject\\EXAM\\iris.csv", 
                      sql = "select * from file where Sepal_Length  5", eol = "\n")

#그럼 결과가 동일한지 확인해 보자.
tail(iris2)
tail(iris3)
#iris3의 결과는 마지막에 \r이 붙는다. 왜그럴까?
#옵션에서 eol = "\n"을 사용해서 그런거 같은데 잘모르겠다.
#혹시 마지막 컬럼이 문자여서 그런가?
#그럼 마지막 컬럼을 삭제하고 한번 다시 호출해보자.
#마지막 컬럼을 삭제한 데이터명은 iris2.csv로 하겠다.
iris4 <- read.csv.sql("c:\\Rproject\\EXAM\\iris2.csv", 
                      sql = "select * from file where Sepal_Length  5")

iris5 <- read.csv.sql("c:\\Rproject\\EXAM\\iris2.csv", 
                      sql = "select * from file where Sepal_Length  5", eol = "\n")

#결과가 동일하게 나왔다. 결국 마지막 컬럼이 문자여서 그런 결과가 나온건가?
#혹시 몰라서 다른 데이터를 만들어서 호출해보도록 하자.
#모든 컬럼이 문자로 되어있는 것으로
TestDf <- data.frame(AA = letters[1:10], BB = letters[5:14], CC = LETTERS[1:10])
write.csv(TestDf, "c:\\Rproject\\EXAM\\TestDf.csv", quote = FALSE, row.names = FALSE)
TestDf1 <- read.csv.sql("c:\\Rproject\\EXAM\\TestDf.csv", 
                        sql = "select * from file", eol = "\n")
TestDf2 <- read.csv.sql("c:\\Rproject\\EXAM\\TestDf.csv", 
                        sql = "select * from file")
#역시나 동일한 결과를 내보내고 있다.
#help문 예제에는 eol = "\n"을 썼는데 왜 그런지 모르겠다. 우리는 eol = "\n"옵션을 사용하지 않고 실행하자.

#read.csv2.sql : csv file을 호출하는 함수
#csv file을 전체 다 가지고 올수도 있으며 sql문을 활용하여 데이터를 가지고 올수 있음
read.csv2.sql(file, sql = "select * from file", header = TRUE, sep = ";", row.names, eol, skip, 
              filter, nrows, field.types, comment.char, dbname = tempfile(), drv = "SQLite", ...)
TestDf1 <- read.csv2.sql("c:\\Rproject\\EXAM\\TestDf.csv", 
                         sql = "select * from file", eol = "\n")
TestDf2 <- read.csv2.sql("c:\\Rproject\\EXAM\\TestDf.csv", 
                         sql = "select * from file")
#read.csv2.sql을 위와 같이 실행하면 하나의 컬럼에 붙어서 결과가 나온다.
#sep 디폴트 옵션이 ";"로 되어 있기 때문이다.
#결국 csv file구분자가 ","로 되어있으면, read.csv.sql을 사용하고 ";"로 되어있으면 read.csv2.sql을 사용하자.

#그럼 데이터를 가지고 올때 summary를 해서 가지고 와보자.
Summary_iris <- read.csv.sql("c:\\Rproject\\EXAM\\iris.csv", 
                             sql = "select Species, avg(Sepal_Length) as Mean_Sepal_Length from file group by Species")
#다음과 같이 결과가 나왔다.
#Species Mean_Sepal_Length
#1     setosa             5.006
#2 versicolor             5.936
#3  virginica             6.588
#read.csv.sql, read.csv2.sql 함수를 사용할 때는 csv file에서 조건을 걸어서 사용할 때 유용하지만, 모든 데이터를 사용할 때는 굳이 사용할 필요는 없을 것 같다. 다른 함수를 사용해도 무난하고. data.table package에서 재공하는 fread함수를 사용하면 보다 빠른 속도로 데이터를 호출할 수 있다.



#==================================================
#             데이터 핸들링 41-43p
#==================================================

#전체 데이터에서 5개만 뽑아서 보자 head() 와 동일한 결과를 보인다.
#그런데 굳이 아래와 같이 사용할 필요가 있을까? head()함수를 쓰면 되는데..
sqldf("select * from iris1 limit 5")

#다음은 summary 하는 방법에 대하여 알아보도록 하자.
query.select <- "select Species, avg(Sepal_Length) as Mean_Sepal_Length, min(Sepal_Length) as Min_Sepal_Length, max(Sepal_Length) as Max_Sepal_Length"
query.from <- "from iris1"
query.group <- "group by Species"
query.x <- paste(query.select, query.from, query.group)
summary_iris <- sqldf(query.x)
#위와 같이 그룹별 여러 통계량 값을 구할 수 있다.

#다음은 정렬에 대하여 알아보도록 하자. 디폴트는 오름차순이다.
query.x <- "select * from iris1 order by Sepal_Length" #오름 차순
sqldf(query.x)
#내림차순을 하기 위해서는 다음과 같이 사용하면 된다.
query.x <- "select * from iris1 order by Sepal_Length desc" #내림 차순
sqldf(query.x)

#다음은 join하는 방법에 대하여 알아보도록 하자.
query.x <- "select a.*, b.* from iris1 as a, summary_iris as b where a.Species = b.Species"
Result_df <- sqldf(query.x)
#위와 같이 사용하면 매칭하는 컬럼은 두개가 생성되어진다.
#그러므로 select 문에서 생성할 컬럼을 정의해주는 게 좋다.

#DB에서 사용하는 sql 쿼리문은 동일 하게 사용할 수 있으므로 inner join outer join, full join 등 다양한 join을 사용할 수 있다.
#다양한 데이터를 사용하여 테스트 해보길 바란다.

#추가적으로 다음은 reshape하는 방법에 대하여 알아보도록 하자.
DF <- data.frame(g = rep(1:2, each = 5), t = rep(1:5, 2), v = 1:10)
a16s <- sqldf("select g, sum((t == 1) * v) t_1, sum((t == 2) * v) t_2, sum((t == 3) * v) t_3, sum((t == 4) * v) t_4, sum((t == 5) * v) t_5 from DF group by g")



#==================================================
#             산점도 그리기 45-50p
#==================================================

#plot() 함수
#plot(x,y,main=,sub=,xlab =, ylab=, type=,axes=“”,col=“”,pch=“”)
# x : X축의 자료, y: Y축의 자료
#main : plot의 전체 제목
#sub : plot의 부 제목
#xlab : x축 제목, ylab: y축의 제목.
#type : plot의 형태를 결정
#axes : plot의 테두리 관련
#col : plot의 색

plot(rnorm(100)) #100개의 난수에 대하여 산점도 생성


#제목과 라벨 추가하기

#plot() 함수
#plot(x,y,main=,sub=,xlab =, ylab=, type=,axes=“”,col=“”,pch=“”)
# x : X축의 자료, y: Y축의 자료
#main : plot의 전체 제목
#sub : plot의 부 제목
#xlab : x축 제목, ylab: y축의 제목.
#type : plot의 형태를 결정
#axes : plot의 테두리 관련
#col : plot의 색
plot(rnorm(100), main = "Test Graph", xlab = "index", ylab = "value")
#또는 아래의 방법을 사용
plot(rnorm(100), ann = FALSE)
title(main = "Test Graph", xlab = "index", ylab = "value")

#격자 추가하기

#plot() 함수
#plot(x,y,main=,sub=,xlab =, ylab=, type=,axes=“”,col=“”,pch=“”)
# x : X축의 자료, y: Y축의 자료
#main : plot의 전체 제목
#sub : plot의 부 제목
#xlab : x축 제목, ylab: y축의 제목.
#type : plot의 형태를 결정
#axes : plot의 테두리 관련
#col : plot의 색
#격자를 추가 하기 위해서는 grid 함수를 사용하면 된다.
plot(rnorm(100), ann = FALSE)
title(main = "Test Graph", xlab = "index", ylab = "value")
grid()


# 여러 집단 산점도

#plot() 함수
#plot(x,y,main=,sub=,xlab =, ylab=, type=,axes=“”,col=“”,pch=“”)
# x : X축의 자료, y: Y축의 자료
#main : plot의 전체 제목
#sub : plot의 부 제목
#xlab : x축 제목, ylab: y축의 제목.
#type : plot의 형태를 결정
#axes : plot의 테두리 관련
#col : plot의 색
plot(iris$Petal.Length, iris$Petal.Width, pch = as.integer(iris$Species))
#또는 다음과 같은 방법을 사용해도 된다.
with(iris, plot(Petal.Length, Petal.Width, pch = as.integer(Species)))

# 범례 추가하기

#점 범례
legend(x, y, labels, pch = c(유형1, 유형2, …)
       
#선의 유형에 다른 범례
legend(x, y, labels, lty = c(유형1, 유형2, …)
              
#선의 두께에 따른 범례
legend(x, y, labels, lwd = c(유형1, 유형2, …)
                     
#색상 범례
legend(x, y, labels, col = c(유형1, 유형2, …)
                            
with(iris, plot(Petal.Length, Petal.Width, pch = as.integer(Species)))
legend(1.5, 2.4, c("setosa", "versicolor", "virginica"), pch = 1:3)
     

#모든 변수들 간 그래프 그리기

plot(iris[, c("Sepal.Length","Sepal.Width","Petal.Length","Petal.Width")])
#또는 
Plot(iris[,c(1:4])


#==================================================
#             막대 그래프 그리기 51p
#==================================================

#막대 그래프 그리기
hight_x <- c(120, 125, 130.5, 138, 142, 150)
barplot(hight_x)
barplot(hight_x, main = "초등학생 평균 키", names.arg = c("1학년","2학년","3학년","4학년","5학년","6학년"), ylab = "평균키(Cm)")



#==================================================
#             선 그래프 그리기 52-54p
#==================================================

#선 그래프 그리기
#plot() 함수
#plot(x,y,main=,sub=,xlab =, ylab=, type=,axes=“”,col=“”,pch=“”)
# x : X축의 자료, y: Y축의 자료
#main : plot의 전체 제목
#sub : plot의 부 제목
#xlab : x축 제목, ylab: y축의 제목.
#type : plot의 형태를 결정
#axes : plot의 테두리 관련
#col : plot의 색

hight_x <- c(120, 125, 130.5, 138, 142, 150)
class_x <- c(1,2,3,4,5,6)
plot(class_x, hight_x, type = "l", main = "초등학생 평균 키",
     ylab = "평균키(Cm)", xlab = "학년")

#선의 type

x<-c(2,5,8,5,7,10,11,3,4,7,12,15)
y<-c(1,2,3,4,5,6,7,8,9,10,11,12)
plot(x, y, main="PLOT", sub="Test", xlab="number", ylab="value") 

plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="p") 
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="l") 
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="b") 
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="c") 
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="o") 
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="h") 
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="s") 
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="S") 
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="n")


#선의 너비나 두께를 조정하려면 lwd 인자를 사용. 선의 두께는 1로 기본 설정되어있음
plot(x, y, type = "l", lwd = 2)

#선의 색상을 조절하려면 col 매개변수를 사용. 선의 기본 색은 검은색으로 설정되어있음
plot(x, y, type = "l", col = "red")



#==================================================
#              박스 플롯 그리기 55p
#==================================================

#박스 플롯 그리기
x<-c(2,5,8,5,7,10,11,3,4,7,12,15)
z<-c(3.5, 2.2, 1.5, 4.6, 6.9)

boxplot(x,z)

#또는 

tmp_df <- data.frame(gubun = c(rep(1, 12), rep(2, 5)), value = c(x, z))
boxplot(value ~ gubun, data = tmp_df)


#==================================================
#              히스토그램 그리기 56p
#==================================================

#히스토그램그리기
#객체 다음자리의 숫자는 breaks= 옵션인데, 간단한 숫자로 셀(막대)의 영역을 나누는 것 부터 셀에 대한 함수계산 수행까지 가능

data(Cars93, package  = "MASS")
hist(Cars93$MPG.city, main = "City MPG (1993)",  xlab= "MPG")

hist(Cars93$MPG.city, breaks = 20,main = "City MPG (1993)",  xlab= "MPG")



#==================================================
#              그래프 저장하기 57-58p
#==================================================

# ------------------------------------------------------------------------------
# 그래프 생성 및 저장
# -------------------------------------

# 저장위치는 C:\\Rproject_1\\OUT\\Result로 하는데, 
# 만약 폴더가 없다면 저장할 때 오류가 생기므로 폴더가 없다면 
# DOS 명령어를 이용하여 디렉토리를 생성한다.
dir.name <- shell("dir c:\\Rproject_1\\OUT /ad /b /w ", intern = TRUE)
if(sum(dir.name %in% "Result") == 0) {
  cat("Result 디렉토리 만들기", "\n")
  shell(paste("mkdir ", "c:\\Rproject_1\\OUT\\Result", sep = ""))
}

# 그래프 창 크기를 조정 
dev.new(width=30, height=20)
op <- par(mfrow = c(2,1))
tmp.df <- get(import_csv_names[1], pos= 1)
plot(tmp.df$TIME, tmp.df$SPEED, type = "b", main = paste("LINK ID : ",unique(tmp.df$LINK_ID), "시간대별 속도", sep =" "), xlab = "TIME", ylab = "속도(Km/h)")
plot(tmp.df$TIME, tmp.df$VOLUMN, type = "b", main = paste("LINK ID : ",unique(tmp.df$LINK_ID), "시간대별 교통량", sep =" "), xlab = "TIME", ylab = "교통량")
image.dir <- "c:\\Rproject_1\\OUT\\Result\\"
savePlot(paste(image.dir,  "링크별속도및교통량", ".jpg", sep = ""), type = "jpg")
par(op)
dev.off()

#==================================================
#              R의 색상 63-65p
#==================================================

color <- c("#FF0000", "#FFFF00", "#00FF00", "#00FFFF", "#0000FF", "#FF00FF") 
pie(rep(1,6), col = color, labels = color)
par(new = T)
pie(rep(1,1), col = "white", radius = 0.5, labels = "")

par(mfrow = c(5,1))
n <- 10
barplot(rep(1,n), col = rainbow(n, alpha =1), axes=F, main = "raindow colors")
barplot(rep(1,n), col = heat.colors(n, alpha =1), axes=F, main = "heat colors")
barplot(rep(1,n), col = terrain.colors(n, alpha =1), axes=F, main = "terrain colors")
barplot(rep(1,n), col = topo.colors(n, alpha =1), axes=F, main = "topo colors")
barplot(rep(1,n), col = cm.colors(n, alpha =1), axes=F, main = "cyan-magenta colors")

install.packages("RColorBrewer")

library(RColorBrewer)
display.brewer.all(type = "seq")




#==================================================
#             ggplot2 패키지 설치 67p
#==================================================

#ggplot2 패키지 설치

install.packages(“ggplot2”)

#라이브러리 호출
library(ggplot2)


#==================================================
#           ggplot2 : 산점도 그리기 69-72p
#==================================================
library(ggplot2)

qplot(mtcars$wt, mtcars$mpg)

qplot(wt, mpg, data = mtcars)

ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point()


# 제목과 라벨 추가하기

#그래프 생성 함수 코드 작성 후 (+) 로 제목과 라벨을 추가 하면 된다. 
#ggtilte() #제목 추가
#aes(x , y) #x : x축 라벨, y : y축 라벨

ggplot(mtcars) + geom_point() + ggtitle("Test ggplot2") + aes(x=wt, y=mpg)


# 격자 제거하기
q <-ggplot(mtcars) + geom_point() + ggtitle("Test ggplot2") + aes(x=wt, y=mpg)
q + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) #모든격자 제거
q + theme(panel.grid.major.x = element_blank(), panel.grid.minor.x = element_blank()) #수직 격자 제거
q + theme(panel.grid.major.y = element_blank(), panel.grid.minor.y = element_blank()) #수평 격자 제거

#여러집단 산점도 생성하기

#옵션중 shape를 사용하여 여러집단에 대하여 산점도를 생성한다.
ggplot(iris, aes(x = Petal.Length, y = Petal.Width, shape = Species)) + geom_point()


#==================================================
#           ggplot2 : 막대 그래프 73p
#==================================================

qplot(Time, demand, data = BOD, geom = "bar", stat = "identity")
#또는
ggplot(BOD, aes(x = Time, y = demand)) + geom_bar(stat = "identity")


#==================================================
#           ggplot2 : 박스 플롯 74p
#==================================================

qplot(supp, len, data = ToothGrowth, geom = "boxplot")
#또는
ggplot(ToothGrowth, aes(x=supp, y = len)) + geom_boxplot()


#==================================================
#           ggplot2 : 히스토그램 75p
#==================================================

qplot(mtcars$mpg, binwidth = 4)
#또는
ggplot(mtcars, aes(x=mpg)) + geom_histogram(binwidth = 4)




#==================================================
#           googleVis 77-79p
#================================================== 

install.packages("googleVis")
library(googleVis)

value1 <- c(60, 20, 8, 7, 3, 2)
item1 <- c("아메리카노", "카페라떼", "카푸치노", "카페모카", "바닐라라떼", "아보카토")
Encoding(item1) <- "utf-8"
df <- data.frame(item1 , value1)
Pie2 <- gvisPieChart(df, options = list(is3D = TRUE))
plot(Pie2)
print(Pie2, file = "c:\\Temp\\커피판매비율.html")





#==================================================
#           폴리곤 데이터 활용하기 83-87p
#==================================================

library(sp)
load("C:\\Rproject\\DATA\\KOR_adm0.RData")
str(gadm)
plot(gadm)

load("C:\\Rproject\\DATA\\KOR_adm1.RData")
str(gadm)
plot(gadm)

load("C:\\Rproject\\DATA\\KOR_adm2.RData")
str(gadm)
plot(gadm)

#서울 지역만 추출하여 구별지도 생성
seoul <- gadm[gadm$NAME_1 == "Seoul",]
plot(seoul, col = c(1:length(unique(seoul$NAME_2))))



#==================================================
#           ggplot2를 활용한 지도 생성 88-89p
#==================================================

library(ggplot2)
library(maps)

#세계지도 그리기
world_df <- map_data("world")
head(world_df)
qplot(long, lat, data = world_df, geom = "polygon", fill = region, group = group)

#한국 지도 그리기
korea_list <- world_df$region %in% c("South Korea", "North Korea")
korea_df <- world_df[korea_list, ]
qplot(long, lat, data = korea_df, geom = "polygon", fill = region, group = group)



#==================================================
#         구글맵을 활용한 지도 생성 90-94p
#==================================================

#패키지 설치
install.packages("dismo")
install.packages("rgdal")

#패키지 로딩
library(dismo)
library(rgdal)

#한국을 선택하여 지도 그리기
korea_map <- gmap("South Korea")
head(korea_map)
plot(korea_map)

#도로가 표시되는 지도 생성
#지도에 도로가 표시되어지기 위해서는 옵션중 type의 설정을 바꿔주면 된다.
korea_map <- gmap("South Korea", type = "roadmap")
head(korea_map)
plot(korea_map)

#위성 지도 생성
#지도에 도로가 표시되어지기 위해서는 옵션중 type의 설정을 바꿔주면 된다.
korea_map <- gmap("South Korea", type = "satellite")
head(korea_map)
plot(korea_map)

install.packages("ggmap")
library(ggmap)
geocode('서울시 중구 남대문로 5가 541 서울스퀘어')



#==================================================
#           텍스트 마이닝 102-104p
#==================================================

library(KoNLP)
library(tm)
library(wordcloud)

#파일을 한글형식으로 불러오기
text_data <- Corpus(DirSource("C:/Rproject/TEXT/", encoding = "UTF-8", recursive = TRUE))

#호출한 텍스트 확인하기
text_data[[2]]

#명사단어 추출
word_list_1 <- unlist(sapply(text_data[[1]]$content, extractNoun, USE.NAMES = FALSE))
word_list_2 <- unlist(sapply(text_data[[2]]$content, extractNoun, USE.NAMES = FALSE))
head(word_list_1, 10)


#추출된 단어의 빈도수 
word_cnt_1 <- table(word_list_1)
word_cnt_2 <- table(word_list_2)
head(word_cnt)

par(mfrow = c(1,2))
wordcloud(names(word_cnt_1), freq=word_cnt_1, max.words = 100, colors = brewer.pal(8, "Dark2"))
title("노무현대통령 취임사")
wordcloud(names(word_cnt_2), freq=word_cnt_2, max.words = 100, colors = brewer.pal(8, "Dark2"))
title("박근혜대통령 취임사")



#==================================================
#       이미지 분석 : EBImage 108-118p
#================================================== 


#디렉토리 설정
setwd("C:\\Rproject")
      
#패키지 설치 및 불러오기
## https://www.bioconductor.org에서 다운로드 가능
source("C:\\RSC\\biocLite.R")
      
## install.packages와 동일한 기능
biocLite("EBImage")
library(EBImage)
      
#이미지 데이터 읽어오기
## readImage 함수를 이용함(파일명과, 파일형식을 지정함)

image.i <- readImage("IMAGE\\person.jpg", "JPEG")
                     
#이미지 표시
## display 함수를 이용함
## method는 internet으로 이미지를 표시하는 "browser“와 R로 표시하는 “raster”로 구분됨
display(image.i, method ="raster")
                     
#이미지 쓰기
## writeImage 함수를 이용함
## 이미지로 저장하는 객체명, 저장경로 및 이름, 파일형식을 지정함
writeImage(image.i, "OUT\\person.jpg", "JPEG")
                     
#이미지 데이터 정보 확인
print(image.i)

#이미지 데이터 가공 1
## + 연산자는 이미지의 밝기를 조절함
image.i1 <- image.i + 0.5
display(image.i1, method ="raster")

## * 연산자는 이미지의 명암을 조절함
image.i2 <- image.i * 3
display(image.i2, method ="raster")

## ^ 연산자는 gamma correction을 조절함
image.i3 <- image.i ^ 0.5
display(image.i3, method ="raster")


#이미지 데이터 정보 확인
print(image.i)

#이미지 데이터 가공 2
## 특정 위치의 이미지를 잘라냄
## 배열정보 입력
image.i4 <- image.i[99:276, 124:201, 2]
display(image.i4, method ="raster")

## 특정 값 이상의 Pixel정보만 추출함
image.i5 <- image.i  0.5
display(image.i5, method ="raster")

## 이미지를 회전시킴(Transpose)
image.i6 <- t(image.i[ , , 2])
display(image.i6, method ="raster")


#이미지 데이터 정보 확인
print(image.i)

#이미지 회전
## rotate 함수를 사용함
image.i7 <- rotate(image.i, 30)
display(image.i7, method ="raster")

#이미지 원점 조절
## translate 함수를 사용함
image.i8 <- translate(image.i, c(40, 70))
display(image.i8, method ="raster")

#이미지 반전
## flip 함수를 사용함
image.i9 <- flip(image.i)
display(image.i9, method ="raster")


#이미지 데이터 정보 확인
print(image.i)
#회색조 이미지로 변경
image.i10 <- image.i
colorMode(image.i10) <- Grayscale
display(image.i10, method ="raster")
#Pixel 단위의 색상 정보 변경
## 해당배열의 Pixel 위치의 색상값 변경
image.i11 <- image.i
image.i11[236:276, 106:146, 1] <- 1
image.i11[236:276, 156:196, 2] <- 1
image.i11[236:276, 206:246, 3] <- 1
display(image.i11, method ="raster")
#회색조 이미지에 컬러 정보 추가하기
## rgbImage함수를 이용하여 RGB 컬러 정보를 추가함
image.i12 <- rgbImage(red = image.i, green = flip(image.i), blue = flop(image.i))
display(image.i12, method ="raster")


#이미지 데이터 정보 확인
print(image.i)
#Filtering 1
## makeBrush 함수와 filter2 함수를 사용하여
## 낮은 수준의 이미지 filtering을 수행함(Noise 제거)
filter.i <- makeBrush(21, shape = 'disc')
filter.x <- filter.i / sum(filter.i)
image.i13 <- filter2(image.i, filter.x)
display(image.i13, method ="raster")

#Filtering 2
## 높은 수준의 이미지 filtering을 수행함(경계선 강조)
filter.k <- matrix(1, ncol = 3, nrow = 3)
filter.k[2, 2] <- -8
image.i14 <- filter2(image.i, filter.k)
display(image.i14, method ="raster")


#이미지 데이터 불러오기
## Segmentation 설명을 위해 예제 이미지를 변경함(패키지 내장 이미지)
image.k <- readImage(system.file('images', 'nuclei.tif', package = 'EBImage'))
display(image.k, method = "raster")
#이미지 Segmentation
## 개체 구분
## thresh 함수를 사용함
## thresh 함수는 직사각형의 window를 생성하여 
## 이웃 지점과의 평균 값을 비교하며,
## 유사도를 평가함(w = 너비, h = 높이, offset = 평균값으로부터 임계 offset)
thre.nuc <- thresh(image.k[ , , 1], w = 10, h = 10, offset = 0.05)
## 개체 구분 시각화
## channel 함수는 회색조 이미지에 컬러 작업을 수행할 수 있도록 
## 구조를 변환하는 함수임
image.y <- channel(image.k[ , , 1], 'rgb')
## paintObjects 함수는 동일한 그룹으로 구분된 Pixel에 구분선을 표시함
seg.image <- paintObjects(thre.nuc, image.y, col = '#ff00ff')
display(seg.image, method = "raster")




#==================================================
#             JAVA와 연동 131p
#================================================== 



import org.rosuda.JRI.*;

public class TestR {
  
  public static void main(String[] args) {
    System.out.println();
    String[] Rargs = {"--vanilla"};
    Rengine ren = new Rengine(Rargs, false, null);
    
    if(!ren.waitForR()){
      System.out.println("Cannot Load R");
      return ;
    }
    REXP rn = ren.eval("round(rnorm(10),3)");
    
    double[] rnd = rn.asDoubleArray();
    
    for(int i=0; i<rnd.length; i++) {
      System.out.print(rnd[i] + " ");
    }
    ren.end();
    System.out.println("Bye.!!");
  }
  
}



#==================================================
#             shiny 133-140p
#================================================== 

#Step1 : shiny package install---------------------------------------------------------------------------
install.packages("shiny")
#다음 package는 아래와같이 하였는데 install 안되는 문제점이 있었다.
install.packages("httpuv")
#그래서 다음과 같은 방식으로 설치를 하였다.
#1: 다음 사이트를 들어같다. http://cran.r-project.org/web/packages/httpuv/index.html
#2: downloads에 있는 다음 파일을 다운로드 받는다. Windows binary:   httpuv_1.2.3.zip
#3: 다운로드되어진 zip file을 설치한다. install.packages("C:/Users/begas00/Downloads/httpuv_1.2.3.zip", repos = NULL)
#----------------------------------------------------------------------------------------------------------

#Step2 : library 호출-------------------------------------------------------------------------------------
library(shiny)


#Step3 : Shiny 처음하기----------------------------------------------------------------------------------------------------
#먼저 제공하고 있는 예제를 한번 실행해 보자.
runExample("01_hello")
#다음과 같은 예시를 하기위해서는 두개의 R File이 있어야 한다.
# ui.R : 화면을 구성하는 R File
# server.R : 화면에서 선택한 input값을 받아서 실행하는 R File

#ui.R 파일 내용
# Define UI for application that plots random distributions 
shinyUI(pageWithSidebar( 
  # Application title
  headerPanel("Hello Shiny!"),
  # Sidebar with a slider input for number of observations
  sidebarPanel(
    sliderInput("obs", 
                "Number of observations:", 
                min = 1,
                max = 1000, 
                value = 500)
  ),
  # Show a plot of the generated distribution
  mainPanel(
    plotOutput("distPlot")
  )
))

# server.R 파일 내용
library(shiny)

# Define server logic required to generate and plot a random distribution
shinyServer(function(input, output) {
  
  # Expression that generates a plot of the distribution. The expression
  # is wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should be automatically 
  #     re-executed when inputs change
  #  2) Its output type is a plot 
  #
  output$distPlot <- renderPlot({
    
    # generate an rnorm distribution and plot it
    dist <- rnorm(input$obs)
    hist(dist)
  })
})


#실행방법

#다음과 같이 진행을 하면 된다.
#1. 폴더를 생성한다. 필자는 다음과 같은 폴더를 생성하였다. c:/Rproject/shinyapp
#2. ui.R 과 server.R 파일을 위에 생성한 폴더에 생성하자.
#3. 위와 같이 하였으면 99%는 한것이다.
#4. 아래와 runApp함수를 사용하여서 실행하면 끝~~!
runApp("c:\Rproject\shinyapp")

#Input 과 output 정의
#input뒤에 $표시후 뒤에 값이 input명이다.
#예를 들어서 ui.R에서 sliderInput("obs", "Number of observations:", min = 1, max = 1000, value = 500)와 같이 정의 하였으면
#sliderInput()함수는 슬라이더 패널이며 "obs"가 사용자가 1~1000까지 의 값중에서 선택한 값을 obs에 할당한다.
#사용자가 5를 선택하였으면 다음과 같이 되어지는 것이다. input$obs <- 5


#Stop4 : Select Box와 Check Box생성하여 실행하기---------------------------------------------------
#아래의 코드를 보면 selectInput, checkboxInput 함수가 보일것이다.
#selectInput : select box
#checkboxInput : check box
?selectInput
?checkboxInput
# selectInput(inputId, label, choices, selected = NULL, multiple = FALSE)
# inputId : Input 명
# label : Input 명 설명
# choices : 선택되어지는 변수 리스트
# selected : default로 선택되어지는 변수
# multiple : 다중 선택 여부

# checkboxInput(inputId, label, value = FALSE)
# inputId : Input 명
# label : Input 명 설명
# value : 디폴트는 FALSE 사용자가 선택하면 TRUE값으로 전환


#ui.R
library(shiny)

# Define UI for miles per gallon application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Miles Per Gallon"),
  
  # Sidebar with controls to select the variable to plot against mpg
  # and to specify whether outliers should be included
  sidebarPanel(
    selectInput("variable", "Variable:",
                list("Cylinders" = "cyl", 
                     "Transmission" = "am", 
                     "Gears" = "gear")),
    
    checkboxInput("outliers", "Show outliers", FALSE)
  ),
  
  # Show the caption and plot of the requested variable against mpg
  mainPanel(
    h3(textOutput("caption")),
    
    plotOutput("mpgPlot")
  )
))


#server.R
library(shiny)
library(datasets)

mpgData <- mtcars
mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))

# Define server logic required to plot various variables against mpg
shinyServer(function(input, output) {
  
  formulaText <- reactive({
    paste("mpg ~", input$variable)
  })
  
  # Return the formula text for printing as a caption
  output$caption <- renderText({
    formulaText()
  })
  output$mpgPlot <- renderPlot({
    boxplot(as.formula(formulaText()), 
            data = mpgData,
            outline = input$outliers)
  })
})

runApp("c:\Rproject\shinyapp1")

#화면에 tab----------------------------------------------------------------------------------------------
#한 화면에 여러 Tab을 생성하여 다양한 결과를 도출할 수 있다.
#한 화면에 여러 Tab을 생성하기 위해서는 ui.R 스크립트에서 아래와 같이 사용하면 된다.
#mainPanel : 기본 화면 구성하는 함수로써 화면에 차트 및 결과 또는 데이터를 표현하기 위하여 사용한다.
#tabsetPanel : mainPanel()함수 안에 작성하는 함수로써 화면에 tab을 구성한다.
#tabPanel : tabsetPanel()함수 안에 작석하는 함수로써 tab panel을 생성한다.

mainPanel(
  tabsetPanel(
    tabPanel("Plot", plotOutput("plot")), 
    tabPanel("Summary", verbatimTextOutput("summary")), 
    tabPanel("Table", tableOutput("table"))
  )
)

runApp("c:\Rproject\shinyapp2")



