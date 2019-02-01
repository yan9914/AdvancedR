library(lobstr)

## 2.2 ##

# �O����s�b�ۦP�a��
x <- c(1,2,3)
y <- x
obj_addr(x)
obj_addr(y)


# �O����s�b���P�a��
x <- c(1,2,3)
y <- c(1,2,3)
obj_addr(x)
obj_addr(y)

# �C�����x����m���|����
x <- c(1,2,3)
obj_addr(x)
x <- c(1,2,3)
obj_addr(x)

# ����W�٥u��� �r�� �Ʀr . _ �Ҳզ�, �B����H _�μƦr �@���}�Y
# ����t�ΩҫO�d���r���]����ϥ�, �Ҧp TRUE NULL if function ��
# �ϥΤ��X�y�k���W�ٷ|�X�{error
_abc <- 1
if <- 10
# �Y�U���o�w�ݨϥΤ��X�y�k���W��, ���H�Ϥ޸��]��
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
# a,b,c�P�ɳs��P�@���O�����x�s��1:10
# ��d�h�s��t�@���x�s��1:10���O����

# 2 ���̦s�b�P�@���O����
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

# 3   �N�Ѽ�check.names�]��FALSE
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
# �]��.123e1��0.123*10^1�Q�����Ʀr�}�Y, �ҥH�����X�y�k���W��
# .���Ʀr���}�Y, �Ҭ����X�y�k���W��
.123e1 <- 2
make.names('.123e1')


## 2.3 ##

x <- c(1,2,3)
y <- x
obj_addr(y)
y[[1]] <- 2     # �ʹL����, y�Qcopy��O���a��
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
z <- f(x)     # �]���S�����, �ҥH�O�����m�S������
untracemem(x)

l1 <- list(1, 2, 3)
l2 <- l1
l2[[3]] <- 4
ref(l1, l2)
# �]���C�������, �ݨϥΧO���O�����x�s�C���ج[
# �C������1,2��S�����, �ҥH�S���Q�ƻs��O�B
# ���ĤT���s��F�O�B���O����
# �o�ؤ������ƻs���覡�٬��L�ƻs (shallow copy)
# �t�~�@�ا����ƻs���覡�٬��`�ƻs (deep copy)
# �bR 3.1.0���e, �Ҧ��ƻs���O�ϥβ`�ƻs

# data frame���C�@��m���˵ۦV�q���C��
d1 <- data.frame(x = c(1, 5, 6), y = c(2, 4, 3))
d2 <- d1
ref(d1, d2)
d2[, 2] <- d2[, 2] * 2
ref(d1, d2)   # �C�����ج[��C����2�즳��
d3 <- d1
d3[1, ] <- d3[1, ] * 3
ref(d1, d3)   # �C���ج[��C����1,2�쳣����

x <- c("a", "a", "abc", "d")
ref(x, character = TRUE)    # R �ϥ� global string pool
y <- c("abc")
ref(y, character = TRUE)

# exercise

# 1 �]��1:10��������W��, �C���I�s�ɰO�����m�����P
tracemem(1:10)

# 2 �]���쥻�O��ƪ��V�q, �����ഫ���ƭȦV�q, �~��N��3��令�ƭ�4
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
obj_size(y)         # �u��x�h80B
obj_size(list(NULL, NULL, NULL))    # 80B���C���ج[���j�p
obj_size(list(NULL, NULL))
obj_size(list(NULL))

banana <- "bananas bananas bananas"
obj_size(banana)
obj_size(rep(banana, 100))  
# �]���ϥ�global string pool, �o��֤F�O���骺�ϥ�
# �ҥH�ϥΪ��O����ëD��Ӫ�100��

# obj_size(x) + obj_size(y) = obj_size(x, y) �ߦ��bx�Py�S���@�Ϊ��Ȯɦ���
obj_size(x, y)
# �ҥH���Bobj_size(x, y) = obj_size(y)

# R 3.5.0 �H�ᦳ�ӥ\��salternative representative
# �b�S�w���V�q��, �i�H�u�s���Y������
# �]�����צh�j���V�q, �ҥΪ��O���鳣�@��
# �䤤":"���̱`�����ϥ�
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
obj_size(funs)          # �]�tlist���ج[
obj_size(mean, sd, var)

# 3
a <- runif(1e6)
obj_size(a)

b <- list(a, a)
obj_size(b)
obj_size(a, b)

b[[1]][[1]] <- 10
obj_size(b)     # �u���ʨ�C������1��, ��2�줣��, �ҥH����a�j�p��2��
obj_size(a, b)  # b�C������2���a�O�@�Ϊ�


b[[2]][[1]] <- 10
obj_size(b)     # b�C����1,2�쳣�����,
obj_size(a, b)  # a,b�S���@�Ϊ�����
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
e2$c        # �èS��copy, �ӬO���environment�����

e <- rlang::env()
e$self <- e
ref(e)

# exercise

# 1
x <- list()     # �W��x�s����list����
obj_addr(x)
x[[1]] <- x     # ���ͷsx, �sx����1��P��x�@�_�s����list����, �P����x�Q�R�� 
obj_addr(x)
obj_addr(x[[1]])# �䤤��1�줴�s����list����

# 3
e <- rlang::env()
tracemem(e)

