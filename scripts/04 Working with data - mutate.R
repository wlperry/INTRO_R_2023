# install packages -----
# install.packages("tidyverse")
# install.packages("readxl")
# install.packages("patchwork")
# install.packages("ggThemeAssist")
# install.packages("skimr")
# 
# # load this library only one time
#  library(ggThemeAssist)

# Load libraries -----
library(tidyverse)
library(readxl)
library(patchwork)
library(skimr)

# read in the two files we will work with
# note we can do this at the start with no issues
data.df <- read_csv("data/  ")


# SELECTING COLUMNS -----
# the first thing you may want to do is remove a few columns or select only
# a few columns - this uses the verb select(x,y,z) or select(-x, -c, -y)

# data.df <- data.df %>% 
   # select(x, y, z) # or # retains columns
   # select(-x, -y, -z) # removes columns
  # type in the code to select a set of columns or remove columns
  
 
# FILTERING ROWS  ------- 
# now you might want to filter out certain rows or sets of data that are 
# out of range or missing - 
# to filter you will use a set of commands common in all programs called
# boolean operators
     ### == means equal to this value
     ### <  means less than
     ### <= means less than or equal to
     ### >  means greater than
     ### >= means greater than or equal to
     ### !  adds in is not so...
     ### != is not equal to
     ### is.na means all na values in a column
     ### !is.na means all values that are not na values

# So if you want to filter out a set of values in a column you would type
       # data.df <- data.df %>% 
       #   filter(!is.na(X)) %>%  # means filter out na values keeping rest
       #   filter(x == "text") # means retain only the values that are exatcly equal to


# USING MUTATE TO DO MATH ------
# OK time to do some math
# the mutate statement changes a variable - 
# data.df <- data.df %>% 
#   mutate(
#     x1 = x*10,
#     y2 = y/10
#   )




# SUMMARY STATS-----
# if there is time and you wanted to make a summary table by hand
# summary.df <- data.df %>% 
#   summarize(
#     mean_x = mean(x, na.rm=TRUE), # this is mean
#     sd_x = sd(x, na.rm=TRUE), # this is standard deviation
#     se_x = sd(x, na.rm=TRUE)/sqrt(sum(!is.na(.))) # this is SE with accounting for missing values
#   )

