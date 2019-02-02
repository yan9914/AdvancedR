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
# 你可能聽過mode()跟storage.mode(), 但請別使用他們
# 因為他們只有在S語言(R語言前身)有兼容性

