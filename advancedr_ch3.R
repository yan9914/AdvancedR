## 3.1 ##
# vectors有2類 : atomic vector & list
# NULL扮演著類似長度為0的向量的角色

## 3.2 ##
# 常見的4種atomic vector : logical integer double character
# integer 與 double 共屬於 numeric
# 2種較少見的atomic vector : complex raw

# 在R裡面, 所謂的純量被視為長度為1的向量, 這就是為什麼1[1]是可行的

# 用短向量生成長向量 : c() , Combine的縮寫
dbl_var <- c(1, 2.5, 4.5)
int_var <- c(1L, 6L, 10L)
lgl_var <- c(TRUE, FALSE)
chr_var <- c("these are", "some strings")
# 若放的是atomic vectors, 則會產生一個新的atomic vector
c(c(1, 2), c(3, 4))

# 可用typeof(), length()得知向量的類型跟長度
typeof(dbl_var)
typeof(int_var)
typeof(lgl_var)
typeof(chr_var)
# 你可能聽過mode()跟storage.mode(), 但請避免使用他們
# 他們的存在只是為了跟S語言兼容


# 幾乎所有涉及NA的式子都會回傳NA (Not Applicable的縮寫)
NA > 5
10 * NA
!NA
c(1, 2, 3) == NA
# 除了必然為真的式子
NA ^ 0      # 對所有numeric都成立
NA | TRUE   # 對所有logical都成立
NA & FALSE
# NA也可分成幾種類型, 但這跟NA差不多, 因為當需要時NA自然會被轉成對應的類型
NA_character_
NA_complex_
NA_integer_
NA_real_

# 可以用is.character() is.double() is.integer() is.logical()
# 來測試type是否符合
# 但請注意is.vector() is.atomic() is.numeric() 
# 並非測試是否為vector, atomic vector, numeric vector

# 在atomic vector中, type為整個vector的性質
# 所以每個元素必須統一type
# 若輸入元素的type不同將被強制轉換
# 順序為character > double > integer > logical
str(c("a", 1))

# 大部分的數學運算函數會將元素type強制轉換為數值
x <- c(FALSE, FALSE, TRUE)
as.numeric(x)
sum(x)
mean(x)

as.integer(c("1", "1.5", "a"))  # 違反順序

# exercise
# 1.
raw(0)
as.raw(42)
complex(length.out = 1, real = 2, imaginary = 3)
# 2.
typeof(c(1, FALSE))
typeof(c("a", 1))
typeof(c(TRUE, 1L))
# 3.
1 == "1"    # 數值1被強制轉換成字串"1"
-1 < FALSE  # 邏輯值FALSE被強制轉換為數值0
"one" < 2   # 字串"one"沒有相應的數值
# 4.
# 因為做為一個缺失值, NA不該影響向量的type
# 因此用最低階的logical較為合適
typeof(NA)
typeof(c(FALSE, NA_character_))

# 5.
# is.atomic() tests if an object has one of these types:
# "logical", "integer", "double", "complex", "character", "raw" or "NULL"

# is.numeric() tests if an object has integer or double type 
# and is not of "factor", "Date", "POSIXt" or "difftime" class

# is.vector() tests if an object has no attributes, 
# except of names and if its mode() is :
# atomic ("logical", "integer", "double", "complex", "character", "raw"), 
# "list" or "expression"


## 3.3 ##

# matrice跟array不在atomic vector的集合裡
# 但他們構築在atomic vector之上, 並給他加上了dim屬性

# 屬性可想成name-value pair, 作為metadata與物件相連
# 用attr()來查看或修改屬性, 或用attributes()來查看修改全部屬性
# 用str()來設置全部屬性
a <- 1:3
attr(a, "x") <- "abcdef"
attr(a, "x")
attr(a, "y") <- 4:6
str(attributes(a))
# Or equivalently
a <- structure(
  1:3, 
  x = "abcdef",
  y = 4:6
)
structure(attributes(a))

# 一般來說, 屬性是非常短命的
# 常常隨著一些運算就消失了
attributes(a[1])
attributes(sum(a))
# 只有兩種屬性較常被保存下來 : dim , name

# 有三種方法可以設置name屬性
x <- c(a = 1, b = 2, c = 3)

x <- 1:3
names(x) <- c("a", "b", "c")

x <- setNames(1:3, c("a", "b", "c"))

# 我們使用names()而避免attr(x, "name")
# 因為不僅要多打字, 而且程式可讀性也降低

# 移除名稱 : unname() 或 names(x) <- NULL

# 為了有效的使用, names最好是唯一且非缺失值
# 但R並沒有強迫不能有缺失的名稱
# 不過如果每個名稱都為缺失值, 則會返回NULL


# 藉由新增dim屬性來生成2維矩陣或多維陣列
a <- matrix(1:6, nrow = 2, ncol = 3)
a

b <- array(1:12, c(2, 3, 2))
b

c <- 1:6
dim(c) <- c(3, 2)
c

# 一個沒有設置dim屬性的向量常被想成1維度
# 但事實上他的dim是NULL
# 單列(行)矩陣或1維度陣列, 呈現上可能跟vector很像
# 但他們的行為卻有差異
# 可以簡單從str()上看到差別
str(1:3)
str(matrix(1:3, ncol = 1))
str(matrix(1:3, nrow = 1))
str(array(1:3, 3)) 

# exercise
# 1.
setNames
unname
# 2.
dim(c(1, 2, 3))
nrow(c(1, 2, 3))
?NROW  # 跟nrow功能一樣, 並且將向量視為1個行矩陣
NROW(c(1, 2, 3))
NCOL(c(1, 2, 3))
# 3.
x1 <- array(1:5, c(1, 1, 5))
x2 <- array(1:5, c(1, 5, 1))
x3 <- array(1:5, c(5, 1, 1))
# 4.
x <- structure(1:5, comment = "my attribute")
x
?comment     # comment屬於特殊屬性, 且不會印出來
comment(x)
attr(x, "comment")


## 3.4 ##
# class為最重要的向量屬性之一, 這是S3物件系統的基礎
# 擁有class屬性的物件將成為S3物件
# 這使他在generic function中的行為與普通向量有所不同
# 4類重要的S3物件 : factor Date POSIXct difftime

# factor建構在integer vector之上, 用於存取類別資料
# 加上了2個屬性
# class : "factor"
# levels : 包含所有可能出現的值
x <- factor(c("a", "b", "b", "a"))
x
typeof(x)
attributes(x)

# 當有些可能值沒有出現時, factor的用處之一就顯現出來了
# 當我們tabulate一個factor, 就能計數所有的類別
# 即使是沒出現的類別
sex_char <- c("m", "m", "m")
sex_factor <- factor(sex_char, levels = c("m", "f"))
table(sex_char)
table(sex_factor)

# factors的變形 : ordered factors
# 他的行為跟一般的factor差不多
# 不過levels是具有大小順序的
grade <- ordered(c("b", "b", "a", "c"), levels = c("c", "b", "a"))
grade
as.integer(grade)

# R中很多函數會自動將character vectors轉為factors, 
# ex : read.csv() data.frame()
# 但這並不是太好, 因為
# 這些函數並不懂所有可能出現的值有哪些(包含不在資料裡的)
# 而且也不知道是否具有大小順序的意涵在levels裡
# levels該是從理論或實驗設計得來的
# 而不是從資料觀察出來的
# 請使用stringsAsFactors = FALSE來阻止這種行為
# 如果有需要, 請以自己的理論知識手動轉換character資料為factor

# 須要注意, factor是建構在integer vector上
# 請別把他們視為字串
# 即使一些string methods會自動將factor轉換成字串
# 有些( ex: nchar() )則會回報error
# 所以有需要時, 請手動轉換factor為character vector


# Date建構在double vector之上
# 只有一個屬性class : "Date"
today <- Sys.Date()
typeof(today)
attributes(today)
# 之所以是double, 是因為他紀錄從2017-01-01以來的天數
date <- as.Date("1970-02-01")
unclass(date)

# R有兩種形式來存取日期時間格式 : POSIXct POSIXlt
# 此處只提POSIXct, 因為較簡單
# POSIXct用double vector儲存日期時間格式
ct <- as.POSIXct("1970-01-01 01:00", tz = "UTC")
ct
typeof(ct)
attributes(ct)
# tzone屬性只控制表現的形式, 不改變內容
unclass(ct)       # 紀錄從1970-01-01 00:00以來的秒數
structure(ct, tzone = "Asia/Taipei")
unclass(structure(ct, tzone = "Asia/Taipei"))

# duration : 兩日期或兩日期時間的時間差
# 建構在double vector之上
# 有屬性class : "difftime" 跟 units : 單位
one_week_1 <- as.difftime(1, units = "weeks")
one_week_1
typeof(one_week_1)
attributes(one_week_1)
unclass(one_week_1)

one_week_2 <- as.difftime(7, units = "days")
one_week_2
typeof(one_week_2)
attributes(one_week_2)

# exercise
# 1.
# table為建構在integer vector上的物件
# 具有三種屬性
tb <- table(sample(LETTERS, 20, replace = TRUE))
tb
typeof(tb)
attributes(tb)
# 2.
# levels被改變, 內部的integer vector不會改變
# 所以會照著改變後的順序重排factor
f1 <- factor(letters)
levels(f1) <- rev(levels(f1))
x <- factor(c("c", "c", "a", "b"))
x
unclass(x)
levels(x) <- rev(levels(x))
x
unclass(x)
# 3.
f2 <- rev(factor(letters))
f2    # 內部的integer vector被倒序了
unclass(f2)
f3 <- factor(letters, levels = rev(letters))
f3    # 用倒序去解讀letters
unclass(f3)
