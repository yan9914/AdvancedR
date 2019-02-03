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
# 因為他們只有在S語言(R語言前身)有兼容性


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