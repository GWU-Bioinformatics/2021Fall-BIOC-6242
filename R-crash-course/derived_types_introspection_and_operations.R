################## DERIVED TYPES ####################
# Atomic vectors
# ---- "Atomic" means contained data is of one type!
# Create a vector
vector_1 = 1:10
# Same vector, with a slightly altered invocation
vector_2 = seq(1, 10, by = 1)

# Logical operations can be performed in vectors!
vector_1 == vector_2
# [1] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE

# The `seq` invocation is more expressive, though -
vector_3 = seq(100, 1, by = -5)

# Vectors perform math element-wise, *NOT* through linear algebra rules
vector_1 * vector_2

vector_4 = c(1,2,3)

vector_1 * vector_4
# [1]  1  4  9  4 10 18  7 16 27 10
# Warning message:
# In vector_1 * vector_4 :
#   longer object length is not a multiple of shorter object length

# --->>> This can lead to unexpected behavior!
# --->>> *** But doesn't always give a warning! *** <<<---
vector_5 = c(1,2)
vector_1 * vector_5
# [1]  1  4  3  8  5 12  7 16  9 20
# Here, R chooses to assume you meant to do this unless the lengths are
# not multiples!

### Matrices
# Matrices can perform math using the (very, very fast)
# linear algebra libraries from C and FORTRAN (see BLAS and LAPACK)
# First, define a vector containing data
mat_1.data = c(1,2,3,4,5,6,7,8,9)
# Shape the data into a matrix
mat_1 = matrix(mat1.data,nrow=3,ncol=3,byrow=TRUE)

# alternatively, emplace the data at matrix creation
mat_2 <- matrix(seq(1, 9, by = 1), nrow=3, ncol=3,byrow=FALSE)

# Matrices DO NOT do matrix operations by default(!)
mat_1 * mat_2
#      [,1] [,2] [,3]
# [1,]    1    8   21
# [2,]    8   25   48
# [3,]   21   48   81

# --->>> See e.g. https://www.statmethods.net/advstats/matrix.html
# for the list of matrix operations
mat_1 %*% mat_2  # Dot product

# Matrices do NOT always behave the way you might expect! 
mat_3 = matrix(seq(1:4), byrow=TRUE)
mat_4 = matrix(seq(1:4), byrow=FALSE)
dim(mat_3) == dim(mat_4)
# [1] TRUE TRUE
dim(mat_3)
# [1] 4 1
mat_3
#      [,1]
# [1,]    1
# [2,]    2
# [3,]    3
# [4,]    4

# etc. 
##### There are many pitfalls to linear algebra operations in R #######

# Lists in R are not limited to one data type
list_1 = list(1,2,3,"this list is clever!")
list_1
# [[1]]
# [1] 1
# 
# [[2]]
# [1] 2
# 
# [[3]]
# [1] 3
# 
# [[4]]
# [1] "this list is clever!"

# Lists are indexed by position 
# NB - R is "1" indexed, unlike many common languages 
# FORTRAN and MATLAB being the major exceptions
list_1[1]
# [[1]]
# [1] 1
# Lists can be constructed (or edited) to include key-value pairs
# based on a defined "hash" for lookup later
list_1[['a']] = 1L
# Hashed values are recovered using the `$` syntax or [[<key>]]:
list_1$a
# [1] 1
list_1[['a']]
# [1] 1
# Each indexed entry is itself a list
typeof(list_1[1])
# [1] "list"
# The entry itself is the first value in the list stored in the parent list
typeof(list_1[[1]])
# [1] "double"
# While hashed entries store the entry directly
typeof(list_1$a)
# [1] "integer"

####################### DATA FRAMES ######################
# Under the hood, data frames 2 dimensional lists-of-lists
# All of the above caveats apply!
# ...more on this later...

