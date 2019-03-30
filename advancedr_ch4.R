## 4.2 ##
x <- c(2.1, 4.2, 3.3, 5.4)

x[c(3, 1)]
x[order(x)]
# 重複的指標回傳重複的值
x[c(1, 1)]
# 指標採無條件捨去
x[c(2.1, 2.9)]

# 負整數將特定元素排除
x[-c(3, 1)]
# 無法同時取正又取負
x[c(-1, 2)]

x[c(TRUE, TRUE, FALSE, FALSE)]
x[x > 3]

# 在x[y]中, 若x與y長度不一致, 則採循環規則
x[c(TRUE, FALSE)]
x[c(TRUE, FALSE, TRUE, FALSE)]
# NA的指標回傳NA的值
x[c(TRUE, TRUE, NA, FALSE)]

# 留白則回傳原向量, 這在1維向量看不出用處, 但在2維以上非常有用
x[]

# 0回傳長度0的向量
x[0]

# 若已被命名, 則可用字元向量回傳相符的元素
(y <- setNames(x, letters[1:4]))
y[c("d", "c", "a")]
y[c("a", "a", "a")]
z <- c(abc = 1, def = 2)
# 用[]取子集採完全匹配
z[c("a", "d")]

# factor"無法"做到取子集的動作
# 因為他輸入的是factor內部的integer向量
y[factor("b")]

# 在list中, 用[取子集回傳list, 用[[及$則回傳列表中的元素


a <- matrix(1:9, nrow = 3)
colnames(a) <- c("A", "B", "C")
a[1:2, ]
a[c(TRUE, FALSE, TRUE), c("B", "A")]
a[0, -2]

# 在matrices跟arrays中, [將結果盡可能簡化到最小維度
# 下兩者皆是一維向量
a[1, ]
a[1, 1]

?outer
vals <- outer(1:5, 1:5, FUN = "paste", sep = ",")
vals
vals[]

# 因為array是一行一行存的, 所以也能用單一的數字來取
# 由左至右, 右上至下, 取第1,3,17個元素
vals[c(1, 3, 17)]

# 或者用矩陣取子集
select <- matrix(ncol = 2, byrow = TRUE, c(
  1, 1,
  3, 1,
  2, 4
))
vals[select]

# 當用單一的index來對data frame取子集
# 則行為像是list, 取的是行

# 當用2個index來對data frame取子
# 則行為表現如同matrix

df <- data.frame(x = 1:3, y = 3:1, z = letters[1:3])

df[df$x == 2, ]
df[c(1, 3), ]
df[c("x", "z")]
df[, c("x", "z")]

# 注意: 當要取的是單一向量
# 矩陣式取法會將輸出簡化為向量
# 列表式取法則不會
str(df["x"])
str(df[, "x"])

# 然而tibble不論何種情況都回傳tibble
df <- tibble::tibble(x = 1:3, y = 3:1, z = letters[1:3])

str(df["x"])
str(df[, "x"])

# 設定drop = FALSE保留維度

a <- matrix(1:4, nrow = 2)
str(a[1, ])
str(a[1, , drop = FALSE])

df <- data.frame(a = 1:2, b = 1:2)
str(df[, "a"])
str(df[, "a", drop = FALSE])

# 將維度化簡常使程式缺乏沿用性
# 使得有些情況可行, 有些情況產生bug

# 而使用factor時也有drop這個變項
# 但跟上面談的不太一樣
z <- factor(c("a", "b"))
z[1]
z[1, drop = TRUE]

# exercise
# 1
mtcars[mtcars$cyl == 4, ]
mtcars[-(1:4), ]
mtcars[mtcars$cyl <= 5, ]
mtcars[mtcars$cyl %in% c(4 ,6), ]

# 2
x <- 1:5
x[NA]
x[NA_real_]
typeof(NA)
typeof(NA_real_)
# 因為NA的type是logical所以會有循環規則

# 3
x <- outer(1:5, 1:5, FUN = "*")
upper.tri(x)
x[upper.tri(x)]

# 4
mtcars[1:20]
mtcars[1:10]
str(mtcars)  # 只有11行

# 5
diag

# 6
df <- data.frame(a = c(1, NA, 3),
                 b = c(NA, 2, NA),
                 c = c(1, 2, 3))
is.na(df)
df[is.na(df)] <- 0
df
