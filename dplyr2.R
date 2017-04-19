##dplyr套件介紹應用
install.packages(dplyr)
library(dplyr)
####arrange介紹#####
##對欄位做排序
##
#################
#1.排序(由小到大)
arrange(mtcars,mpg)
#2.排序(由大到小)
arrange(mtcars,desc(mpg))
#3.對兩個欄位排序
arrange(mtcars,cyl,disp)
#4.可以欄位做運算排名
arrange(mtcars,mpg+disp)
##############################

#####summarise介紹######
## 計算欄位min mean sum sd
##max var length median IOR
##first last nth n n_distinct
#######################
##mpg的第一筆
summarise(mtcars,first(mpg))
##筆數
summarise(mtcars,obs=n())
##第n筆XX欄位===nth(X,n)
summarise(mtcars,obs=nth(mpg,10))

#####group by 介紹 ########
#
#分組去計算 
##########################

#1.以iris為例，分別對不同總類去計算mean
iris%>%
  group_by(Species)%>%
  summarise(meanSL=mean(Sepal.Length))