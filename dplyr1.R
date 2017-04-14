##dplyr套件介紹應用
install.packages(dplyr)
library(dplyr)
####select()介紹########
##欄位選取
########################
#select(df,var1,var2)
#df為資料 var1,var2欄位
######
#選出兩個欄位
select(mtcars,mpg,cyl)
#扣除欄位
select(mtcars,-(mpg:cyl))
#starts_with收尋指定開頭欄位
select(mtcars,starts_with("m"))
#ends_with收尋指定開頭欄位
select(mtcars,ends_with("m"))
#match(X)和catains(X) 收尋包含X的所有欄位
select(mtcars,contains("m"))
select(mtcars,match("m"))
###mutate介紹#####
##將欄位運算後，成新欄位
##
#################
mutate(mtcars,AA=disp+hp)

##fliter介紹####
##條件對觀察直篩選
###############
filter(mtcars,cyl>4)
filter(mtcars,cyl>4|mpg>21)
filter(mtcars,cyl>4&mpg>21)
