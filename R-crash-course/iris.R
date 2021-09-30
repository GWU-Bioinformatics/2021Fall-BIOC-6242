# Load the iris data
data(iris)
# Show some summary statistics of the dataset
summary(iris)

############# (Some perils of R, not an exhaustive list) ###############
# Note that R can be sneakily flexible in interpreting  undefined objects in some contexts, but not others
# This is not defined, but R knows to search for it
data(fibbityfoo)
# This is similarly not defined, but R no longer treats it as a searchable string
summary(fibbityfoo)

# Data frames are implicitly indexed both by number and string value
# So an unrelated data frame or list can *accidentally* corrrupt your data frame
# Beware when playing with your data source!
i_1 = iris
list_1 = c(1,2,3)

i_1[,1:3] = list_1
i_1
#     Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
# 1              1           1            1         0.2     setosa
# 2              2           2            2         0.2     setosa
# 3              3           3            3         0.2     setosa
# 4              1           1            1         0.2     setosa
# ...
# 148            1           1            1         2.0  virginica
# 149            2           2            2         2.3  virginica
# 150            3           3            3         1.8  virginica

i_1$Species = list_1
i_1$Species
#   [1] 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1
# ...
# [149] 2 3

########################################################################
# Use `apply` to apply a function to entire columns/rows of data
colnames(iris)
# [1] "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width"  "Species"
numeric_columns = colnames(iris[1:4])
numeric_columns
# [1] "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width"

# We can use the list of numeric column names to view a 'slice' of the iris data frame
str(iris[numeric_columns])
# 'data.frame':   150 obs. of  4 variables:
#  $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
#  $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
#  $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
#  $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...

# Compute the column-wise mean of each property
# Note that the second argument is 'MARGIN':
# --- 2 means column-wise
# --- 1 means row-wise
apply(iris[numeric_columns], 2, mean)
# Sepal.Length  Sepal.Width Petal.Length  Petal.Width
#     5.843333     3.057333     3.758000     1.199333

# This will compute the mean of the 4 dimension properties for each flower - 
# --- which is unlikely to be the intended statistic!
apply(iris[numeric_columns], 1, mean)
# [1] 2.550 2.375 2.350 2.350 2.550 2.850 2.425 2.525 2.225 2.400 2.700 2.500
# ...truncated...
# [145] 4.550 4.300 3.925 4.175 4.325 3.950

# apply() will push up errors for the programmer's attention, 
# but the error may be cryptic
apply(iris$Species, 2, mean)
# Error in apply(iris$Species, 2, mean) :
#   dim(X) must have a positive length

# Have a look at the data:
iris$Species
# [1] setosa     setosa     setosa     setosa     setosa     setosa
# [49] setosa     setosa     versicolor versicolor versicolor versicolor
# [97] versicolor versicolor versicolor versicolor virginica  virginica
# [103] virginica  virginica  virginica  virginica  virginica  virginica
# ... truncated...
# [145] virginica  virginica  virginica  virginica  virginica  virginica
# Levels: setosa versicolor virginica

# These are the species names - categorical variables!
# R treats these as 'factors' (and internally as integers)
is.factor(iris$Species)
# [1] TRUE
str(iris$Species)
# Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...

# Factors can be ordinal (eg 1,2,3,4; 'before', 'after' -- has order)
# or categorical ('red', 'green', 'blue' -- doesn't have an obvious ordering)
is.ordered(iris$Species)
# [1] FALSE

# lapply is a more-flexible version of apply
# Unlike apply, rows or columns are not explicitly selected
# Invocation requires selecting the subset of the dataframe
# explicitly. Note the ", " in defining the iris slice
lapply(iris[, numeric_columns], mean)
# $Sepal.Length
# [1] 5.843333
# 
# $Sepal.Width
# [1] 3.057333
# 
# $Petal.Length
# [1] 3.758
# 
# $Petal.Width
# [1] 1.199333
# Only look at the first 10 rows
lapply(iris[1:10, numeric_columns], mean)
# $Sepal.Length
# [1] 4.86
# 
# $Sepal.Width
# [1] 3.31
# 
# $Petal.Length
# [1] 1.45
# 
# $Petal.Width
# [1] 0.22
# Only use every third row in the computation

lapply(iris[seq(1, nrow(iris), by = 3), numeric_columns], mean)
# $Sepal.Length
# [1] 5.842
# 
# $Sepal.Width
# [1] 3.044
# 
# $Petal.Length
# [1] 3.716
# 
# $Petal.Width
# [1] 1.18

# Finally, lapply allows additional arguments to be passed to the function of choice
# Here, tell function `mean` to remove any 'NA' values from the data set
lapply(iris[, numeric_columns], mean, na.rm = TRUE)
# $Sepal.Length
# [1] 5.843333
# 
# $Sepal.Width
# [1] 3.057333
# 
# $Petal.Length
# [1] 3.758
# 
# $Petal.Width
# [1] 1.199333

# See https://stackoverflow.com/a/7141669 for a really concise description of the 
# R *apply family of functions
# See ?apply in an R session for further description
?apply
# apply                   package:base                   R Documentation
# 
# Apply Functions Over Array Margins
# ...truncated...
# 

########################### ANALYSIS OF VARIANCE #########################
# Adapted (liberally!) from https://rpubs.com/CPEL/anova_ttest
# Basic test for significance
# Here, test if species is a significant predictor of Sepal Width
# lm: Create a linear model of Sepal Width as a function of Species Category
#     using the iris dataset
lm_sepal_width = lm(Sepal.Width ~ Species, data = iris)
# Show the summary of the linear model fit
summary(lm_sepal_width)

# Call:
# lm(formula = Sepal.Width ~ Species, data = iris)

# Residuals:
#    Min     1Q Median     3Q    Max
# -1.128 -0.228  0.026  0.226  0.972

# Coefficients:
#                   Estimate Std. Error t value Pr(>|t|)
# (Intercept)        3.42800    0.04804  71.359  < 2e-16 ***
# Speciesversicolor -0.65800    0.06794  -9.685  < 2e-16 ***
# Speciesvirginica  -0.45400    0.06794  -6.683 4.54e-10 ***
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

# Residual standard error: 0.3397 on 147 degrees of freedom
# Multiple R-squared:  0.4008,    Adjusted R-squared:  0.3926
# F-statistic: 49.16 on 2 and 147 DF,  p-value: < 2.2e-16

### Note: R has chosen to use `setosa` as the reference species;
#   hence `versicolor` and `virginica` are listed in contrast to the model

# Check to see if 'Species' is a significant predictor of Sepal Width
# using ANalysis Of VAriance (ANOVA)
anova(lm_sepal_width)
# Analysis of Variance Table

# Response: Sepal.Width
#            Df Sum Sq Mean Sq F value    Pr(>F)
# Species     2 11.345  5.6725   49.16 < 2.2e-16 ***
# Residuals 147 16.962  0.1154
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

# The result says yes - use another built-in test to dertermine which
# species are significant predictors!
# (Part of the strength of R is how many of these tests are built in,
# but a full discussion of that is outside today's scope)
# Using Tukey's "Honest Significant Differences" test
# Re-run the analysis, here using `aov` rather than `anova`
#  See https://stackoverflow.com/a/40823311 for a concise explanation
iris_new_aov<-aov(Sepal.Width~Species,data=iris)
TukeyHSD(iris_new_aov)
#   Tukey multiple comparisons of means
#     95% family-wise confidence level
# 
# Fit: aov(formula = Sepal.Width ~ Species, data = iris)
# 
# $Species
#                        diff         lwr        upr     p adj
# versicolor-setosa    -0.658 -0.81885528 -0.4971447 0.0000000
# virginica-setosa     -0.454 -0.61485528 -0.2931447 0.0000000
# virginica-versicolor  0.204  0.04314472  0.3648553 0.0087802

# So, each combination of species is quite likely to be distinguishable
# from the other species by the Sepal Width alone

# There are many, many more readily-available functions in R for
# quickly running statistics! This is a principle reason for the
# popularity of the language
