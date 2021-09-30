############################ Atomic types ################################
#
# === "Numerics": A mixed type that is coerced to floats or integers as appropriate
# 1. Integers: Trailing "L" means integer
typeof(1L)
# [1] "integer"
class(1L)
# [1] "integer" 
mode(1L)
# [1] "numeric"
#### All individual values are implicitly atomic vectors of length 1
is.vector(1L)
# [1] TRUE
# 2. Doubles (i.e. double-width (64-bit) precision floating point, aka "decimals")
typeof(1)
# [1] "decimal"
class(1)
# [1] "numeric"
mode(1)
# [1] "numeric"
is.vector(1)
# [1] TRUE

# Basic operators behave as expected
1 + 1
# [1] 2
# Integers are converted implicitly unless otherwise handled
typeof(1 + 1L)
# [1] "double"
# Decimal rounding is 'truncation' unless otherwise programmed
as.integer(1.5) + 1L
# [1] 2

# === "character": aka strings
typeof("string")
# [1] "character"
class("string")
# [1] "character"
mode("string")
# [1] "character"
is.vector("string")
# [1] TRUE

# Note that we can get abbreviated information about objects
# by coercing them to a string representation
str(1)
# [1] num 1
str(1L)
# [1] int 1
str("string")
# [1] chr "string"

# Logical operators
typeof(TRUE) # Same for `mode` and `class`
# [1] "logical"
# BEWARE Can be coerced into integers or floats....
typeof(TRUE * 1)
# [1] "double"
typeof(TRUE * 1L)
# [1] "integer"
TRUE | FALSE
# [1] TRUE
TRUE & FALSE
# [1] FALSE
# etc...
# === raw: These are raw byte representations, and used very infrequently

####################### BASIC OPERATORS ########################
# Most operators work as you would expect
1 + 1
# [1] 2
# etc.
# Sometimes operations don't make sense, though
# What does it mean to add a number to a string?
1 + "string"
# Error in 1 + "string" : non-numeric argument to binary operator

# --->>> What does it mean to add a string? R chooses not to decide here
"string" + "character"
# Error in "string" + "character" : non-numeric argument to binary operator
# Concatenation is (one) correct operation
c("string", "character")
# [1] "string"    "character"
# Pasting into single string is another...
paste("string", "character")
# [1] "string character"
# Pasting into a single string without spaces is yet another...
paste("string", "character", sep = '')
# OR
paste0("string", "character")
# [1] "stringcharacter"
# --->>> The correct choice is up to the programmer
# --->>> (...or, unexpected results are likely!)

# Not all operators are intended for use