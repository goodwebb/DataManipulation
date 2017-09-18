##Data.table應用介紹
library(data.table)
DT<-as.data.table(iris)
##Section1:Selecting columns in j
##
##
#1.選欄位DT[,.(B,C)]
DT[,.(Sepal.Width,Petal.Length)]
#2.直接對欄位畫圖
DT[,plot(Sepal.Width,Petal.Length)]
#3.對欄位做處理產生新欄位
DT[,.(Sepal.Width,Total=sum(Sepal.Width),mean=sum(Sepal.Width))]

##Section2:Doing j by group
##
##簡介:群組的概念
##
#1.以Species分群，算mean
DT[,.(TotalA=sum(Sepal.Length)),by=.(Species)]
#2.針對某幾筆做分群
DT[c(1,4,57,100),.(TotalA=sum(Sepal.Length)),by=.(Species)]
##Section3:Chaining
##
##簡介:連續做事情
##
#1.運算出平值後，排序
DT[1:2,.(TotalA=sum(Sepal.Length)),by=.(Species)][order(-Species)]

##Section4:Subset of Data
##
##簡介:快速對所有變數做運算
##
#1.
DT[,lapply(.SD,mean),by=Species]
#2.選特定欄位
DT[,lapply(.SD,mean),by=Species,.SDcols=2:3]
#3.每組的扣除最後一筆
DT[,.SD[-1],by=Species,.SDcols=2:3]

##Section5:Using := in j
##
##簡介:變數處理直接加到後面
##
#1.加入一個欄位(sum)
DT[,Total:=sum(Sepal.Width),by=Species]
DT
#2.加入一個欄位(sum)，但特定觀察值
DT[2:100,Total2:=sum(Sepal.Width),by=Species]
#3.將新增欄位移除
DT[,Total:=NULL]
#4.同時處理多個欄位運算
DT[,`:=`(A=sum(Sepal.Width),B=mean(Sepal.Width)),by=Species]
mycols<-c("A","B")
DT[,(mycols):=NULL]
DT[,6:=NULL]

##Section6:set()
##
#1.set(DT,index,column,value)
DT2<-DT
for(i in 1:2)set(DT2,1,i,NA)
#2.改欄位名字
setnames(DT2,"Sepal.Length","B")
setnames(DT2,"Sepal.Width","A")
setnames(DT2,"Petal.Length","C")
setnames(DT2,"Petal.Width","D")
#3.調整欄位順序
setcolorder(DT2,c("Species","A","B","C","D"))

##Section7:Indexing
##
##簡介
DT3<-as.data.table(iris)
#1.指定條件
DT3[Species=="setosa"]
DT3[Species%in%c("setosa","virginica")] ##or的意思
#2. ^表示開頭，$表示字尾
setnames(DT3,gsub("^Sepal\\.","",names(DT3)))
#3.移除欄位
DT3[,grep("Pet",names(DT3)):=NULL]
#4.
DT3[Length*Width>25]
DT3[,is_L:=Length*Width>25]
DT3[is_L==TRUE] 
#or另外一個方法
DT3[(is_L)]

#Section8:Key
#
#簡介:Key和value的概念
#
#1.setkey設定 key和value
DT5<-as.data.table(iris)
setkey(DT5,Species,Sepal.Length)
DT5["setosa"]
#2.mult使用
DT5["setosa",mult="first"]
#3.選擇第一筆和最後一筆
DT5["setosa",.SD[c(1,.N)]] 
DT5[c("setosa","virginica"),.SD[c(1,.N)],by=.EACHI]

#Section9:Rolling join
#
#簡介:join的概念
#1.Get key
key(DT5)
#2.有選到指定的值
DT5[.("setosa",4.3)]
#3.未選到值~~其他欄位會給NA
DT5[.("setosa",4.44)]
#4.roll使用:可以找最接近的值
DT5[.("setosa",4.44),roll=TRUE]
DT5[.("setosa",4.39),roll="nearest"]