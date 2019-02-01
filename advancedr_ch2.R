library(lobstr)

## 2.2 ##

# 記憶體存在相同地方
x <- c(1,2,3)
y <- x
obj_addr(x)
obj_addr(y)


# 記憶體存在不同地方
x <- c(1,2,3)
y <- c(1,2,3)
obj_addr(x)
obj_addr(y)

# 每次賦值x的位置都會改變
x <- c(1,2,3)
obj_addr(x)
x <- c(1,2,3)
obj_addr(x)

# 物件名稱只能由 字母 數字 . _ 所組成, 且不能以 _或數字 作為開頭
# 任何系統所保留的字詞也不能使用, 例如 TRUE NULL if function 等
# 使用不合語法的名稱會出現error
_abc <- 1
if <- 10
# 若萬不得已需使用不合語法的名稱, 須以反引號包住
`_abc` <- 1
`_abc`
`if` <- 10
`if`

# 2.2.2 exercise

# 1
a <- 1:10
b <- a
c <- b
d <- 1:10
obj_addr(a)
obj_addr(b)
obj_addr(c)
obj_addr(d)
# a,b,c同時連到同一塊記憶體儲存著1:10
# 而d則連到另一塊儲存著1:10的記憶體

# 2 它們存在同一塊記憶體
mean
base::mean
get("mean")
evalq(mean)
match.fun("mean")
obj_addr(mean)
obj_addr(base::mean)
obj_addr(get("mean"))
obj_addr(evalq(mean))
obj_addr(match.fun("mean"))

# 3   將參數check.names設為FALSE
?read.csv

# 4
?make.names
make.names('TRUE')
make.names('if')
make.names(c("a and b", "a-and-b"), unique = TRUE)
make.names('_abc')
make.names('')
make.names(c("", "X"), unique = TRUE)

# 5  
# 因為.123e1為0.123*10^1被視為數字開頭, 所以為不合語法的名稱
# .接數字的開頭, 皆為不合語法的名稱
.123e1 <- 2
make.names('.123e1')


## 2.3 ##

x <- c(1,2,3)
y <- x
obj_addr(y)
y[[1]] <- 2     # 動過之後, y被copy到別的地方
obj_addr(y)

x <- c(1,2,3)
cat(tracemem(x), "\n")
y <- x
y[[3]] <- 4L
y[[3]] <- 5L
untracemem(y)

f <- function(a) {
  a
}
x <- c(1, 2, 3)
cat(tracemem(x), "\n")
z <- f(x)     # 因為沒有更動, 所以記憶體位置沒有改變
untracemem(x)

l1 <- list(1, 2, 3)
l2 <- l1
l2[[3]] <- 4
ref(l1, l2)
# 因為列表有更動, 需使用別的記憶體儲存列表框架
# 列表的第1,2位沒有更動, 所以沒有被複製到別處
# 但第三位改連到了別處的記憶體
# 這種不完全複製的方式稱為淺複製 (shallow copy)
# 另外一種完全複製的方式稱為深複製 (deep copy)
# 在R 3.1.0之前, 所有複製都是使用深複製

# data frame為每一位置都裝著向量的列表
d1 <- data.frame(x = c(1, 5, 6), y = c(2, 4, 3))
d2 <- d1
ref(d1, d2)
d2[, 2] <- d2[, 2] * 2
ref(d1, d2)   # 列表的框架跟列表第2位有動
d3 <- d1
d3[1, ] <- d3[1, ] * 3
ref(d1, d3)   # 列表框架跟列表的1,2位都有動

x <- c("a", "a", "abc", "d")
ref(x, character = TRUE)    # R 使用 global string pool
y <- c("abc")
ref(y, character = TRUE)

# exercise

# 1 因為1:10不為物件名稱, 每次呼叫時記憶體位置都不同
tracemem(1:10)

# 2 因為原本是整數的向量, 須先轉換成數值向量, 才能將第3位改成數值4
x <- c(1L, 2L, 3L)
tracemem(x)
class(x)
x[[3]] <- 4
class(x)

x <- c(1L, 2L, 3L)
tracemem(x)
class(x)
x[[3]] <- 4L
class(x)

# 3
a <- 1:10
b <- list(a, a)
c <- list(b, a, 1:10)
ref(a, b, c)

# 4
x <- list(1:10)
ref(x)
x[[2]] <- x
ref(x)


## 2.4 ##

obj_size(letters)
obj_size(ggplot2::diamonds)

x <- runif(1e6)
obj_size(x)
y <- list(x, x, x)
obj_size(y)         # 只比x多80B
obj_size(list(NULL, NULL, NULL))    # 80B為列表框架的大小
obj_size(list(NULL, NULL))
obj_size(list(NULL))

banana <- "bananas bananas bananas"
obj_size(banana)
obj_size(rep(banana, 100))  
# 因為使用global string pool, 這減少了記憶體的使用
# 所以使用的記憶體並非原來的100倍

# obj_size(x) + obj_size(y) = obj_size(x, y) 唯有在x與y沒有共用的值時成立
obj_size(x, y)
# 所以此處obj_size(x, y) = obj_size(y)

# R 3.5.0 以後有個功能叫alternative representative
# 在特定的向量中, 可以只存取頭尾的值
# 因此不論多大的向量, 所用的記憶體都一樣
# 其中":"為最常見的使用
obj_size(1:3)
obj_size(1:1e3)
obj_size(1:1e6)
obj_size(1:1e9)

# exercise

# 1
y <- rep(list(runif(1e4)), 100)
object.size(y)
obj_size(y)
?obj_size

# 2
funs <- list(mean, sd, var)
obj_size(funs)          # 包含list的框架
obj_size(mean, sd, var)

# 3
a <- runif(1e6)
obj_size(a)

b <- list(a, a)
obj_size(b)
obj_size(a, b)

b[[1]][[1]] <- 10
obj_size(b)     # 只有動到列表的第1位, 第2位不動, 所以約為a大小的2倍
obj_size(a, b)  # b列表的第2位跟a是共用的


b[[2]][[1]] <- 10
obj_size(b)     # b列表的1,2位都有更動,
obj_size(a, b)  # a,b沒有共用的元素
obj_size(a) + obj_size(b)   # obj_size(a, b) = obj_size(a) + obj_size(b)


## 2.5 ##

x <- data.frame(matrix(runif(5 * 1e4), ncol = 5))
medians <- vapply(x, median, numeric(1))
cat(tracemem(x), "\n")
for (i in seq_along(medians)) {
  x[[i]] <- x[[i]] - medians[[i]]
}


x <- data.frame(matrix(runif(5 * 1e4), ncol = 5))
medians <- vapply(x, median, numeric(1))
y <- as.list(x)
cat(tracemem(y), "\n")
for (i in seq_along(medians)) {
  y[[i]] <- y[[i]] - medians[[i]]
}


e1 <- rlang::env(a = 1, b = 2, c = 3)
e2 <- e1
e1$c <- 4
e2$c        # 並沒有copy, 而是整個environment做改動

e <- rlang::env()
e$self <- e
ref(e)

# exercise

# 1
x <- list()     # 名稱x連結到list物件
obj_addr(x)
x[[1]] <- x     # 產生新x, 新x的第1位與舊x一起連結到list物件, 同時舊x被刪除 
obj_addr(x)
obj_addr(x[[1]])# 其中第1位仍連結著list物件

# 3
e <- rlang::env()
tracemem(e)


