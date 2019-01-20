library(lobstr)

## 2.2 ##

# 記憶體存在相同地方
x <- c(1,2,3)
y <- x
obj_addr(x)
obj_addr(y)
y[[1]] <- 2     # 動過之後, y被copy到別的地方
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

# 變數名稱只能由 字母 數字 . _ 所組成, 且不能以 _或數字 作為開頭
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
