## 3.1 ##
# vectors��2�� : atomic vector & list
# NULL��t���������׬�0���V�q������

## 3.2 ##
# �`����4��atomic vector : logical integer double character
# integer �P double �@�ݩ� numeric
# 2�ظ��֨���atomic vector : complex raw

# �bR�̭�, �ҿת��¶q�Q�������׬�1���V�q, �o�N�O������1[1]�O�i�檺

# �εu�V�q�ͦ����V�q : c() , Combine���Y�g
dbl_var <- c(1, 2.5, 4.5)
int_var <- c(1L, 6L, 10L)
lgl_var <- c(TRUE, FALSE)
chr_var <- c("these are", "some strings")
# �Y�񪺬Oatomic vectors, �h�|���ͤ@�ӷs��atomic vector
c(c(1, 2), c(3, 4))

# �i��typeof(), length()�o���V�q�����������
typeof(dbl_var)
typeof(int_var)
typeof(lgl_var)
typeof(chr_var)
# �A�i��ť�Lmode()��storage.mode(), �����קK�ϥΥL��
# �L�̪��s�b�u�O���F��S�y���ݮe


# �X�G�Ҧ��A��NA�����l���|�^��NA (Not Applicable���Y�g)
NA > 5
10 * NA
!NA
c(1, 2, 3) == NA
# ���F���M���u�����l
NA ^ 0      # ��Ҧ�numeric������
NA | TRUE   # ��Ҧ�logical������
NA & FALSE
# NA�]�i�����X������, ���o��NA�t���h, �]�����ݭn��NA�۵M�|�Q�ন����������
NA_character_
NA_complex_
NA_integer_
NA_real_

# �i�H��is.character() is.double() is.integer() is.logical()
# �Ӵ���type�O�_�ŦX
# ���Ъ`�Nis.vector() is.atomic() is.numeric() 
# �ëD���լO�_��vector, atomic vector, numeric vector

# �batomic vector��, type�����vector���ʽ�
# �ҥH�C�Ӥ��������Τ@type
# �Y��J������type���P�N�Q�j���ഫ
# ���Ǭ�character > double > integer > logical
str(c("a", 1))

# �j�������ƾǹB���Ʒ|�N����type�j���ഫ���ƭ�
x <- c(FALSE, FALSE, TRUE)
as.numeric(x)
sum(x)
mean(x)

as.integer(c("1", "1.5", "a"))  # �H�϶���

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
1 == "1"    # �ƭ�1�Q�j���ഫ���r��"1"
-1 < FALSE  # �޿��FALSE�Q�j���ഫ���ƭ�0
"one" < 2   # �r��"one"�S���������ƭ�
# 4.
# �]�������@�ӯʥ���, NA���Ӽv�T�V�q��type
# �]���γ̧C����logical�����X�A
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

# matrice��array���batomic vector�����X��
# ���L�̺c�v�batomic vector���W, �õ��L�[�W�Fdim�ݩ�

# �ݩʥi�Q��name-value pair, �@��metadata�P����۳s
# ��attr()�Ӭd�ݩέק��ݩ�, �Υ�attributes()�Ӭd�ݭק�����ݩ�
# ��str()�ӳ]�m�����ݩ�
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

# �@��ӻ�, �ݩʬO�D�`�u�R��
# �`�`�H�ۤ@�ǹB��N�����F
attributes(a[1])
attributes(sum(a))
# �u������ݩʸ��`�Q�O�s�U�� : dim , name

# ���T�ؤ�k�i�H�]�mname�ݩ�
x <- c(a = 1, b = 2, c = 3)

x <- 1:3
names(x) <- c("a", "b", "c")

x <- setNames(1:3, c("a", "b", "c"))

# �ڭ̨ϥ�names()���קKattr(x, "name")
# �]�����ȭn�h���r, �ӥB�{���iŪ�ʤ]���C

# �����W�� : unname() �� names(x) <- NULL

# ���F���Ī��ϥ�, names�̦n�O�ߤ@�B�D�ʥ���
# ��R�èS���j�����঳�ʥ����W��
# ���L�p�G�C�ӦW�ٳ����ʥ���, �h�|��^NULL


# �ǥѷs�Wdim�ݩʨӥͦ�2���x�}�Φh���}�C
a <- matrix(1:6, nrow = 2, ncol = 3)
a

b <- array(1:12, c(2, 3, 2))
b

c <- 1:6
dim(c) <- c(3, 2)
c

# �@�ӨS���]�mdim�ݩʪ��V�q�`�Q�Q��1����
# ���ƹ�W�L��dim�ONULL
# ��C(��)�x�}��1���װ}�C, �e�{�W�i���vector�ܹ�
# ���L�̪��欰�o���t��
# �i�H²��qstr()�W�ݨ�t�O
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
?NROW  # ��nrow�\��@��, �åB�N�V�q����1�Ӧ�x�}
NROW(c(1, 2, 3))
NCOL(c(1, 2, 3))
# 3.
x1 <- array(1:5, c(1, 1, 5))
x2 <- array(1:5, c(1, 5, 1))
x3 <- array(1:5, c(5, 1, 1))
# 4.
x <- structure(1:5, comment = "my attribute")
x
?comment     # comment�ݩ�S���ݩ�, �B���|�L�X��
comment(x)
attr(x, "comment")