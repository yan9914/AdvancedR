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