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
