# install packages -----
# install.packages("tidyverse")
# install.packages("readxl")
# install.packages("patchwork")
# install.packages("ggThemeAssist")
# install.packages("skimr")

install.packages("ggpubr")

install.packages("car")
 
# # load this library only one time
#  library(ggThemeAssist)

# Load libraries -----
library(tidyverse)
library(readxl)
library(patchwork)
library(skimr)
library(janitor)
library(ggpubr)
library(car)

# read in the two files we will work with
# note we can do this at the start with no issues
data.df <- read_excel("data/  ") %>% clean_names()

# look at data in the console with head(.df) or tail(.df)

head(data.df)

# lets get rid of date column - just to make life challenging-------
data.df <- data.df %>% 
  # what goes here

# if we try to make a box plot graph of wt and lasi how would we do that? -----
data.df %>% 
  ggplot() +
  geom_boxplot() 

# so its hard to plot in wide format - how do we switch from wide to long to wide again?-----
# To long format -----
data_long.df <- data.df %>% 
  

# now lets go back to wide ------
# will this even work?????-----
data_wide.df <- data_long.df %>% 
  
  
  

# how to add in an ID column -------
# works but not great
data.df  <- tibble::rowid_to_column(data.df, "index")

data.df  <- data.df %>% 
  mutate(index = seq(0, by = 0.002, length.out = nrow(data.df)))

data.df  <- data.df %>% 
  mutate(index = seq(0, by = 1, length.out = n()))


# now we can redo the wide to long and long to wide
data_long.df <- data.df %>% 
  pivot_longer(

# now lets go back to wide ------
data_wide.df <- data_long.df %>% 
  pivot_wider(



# t-test for 2 groups
# https://rcompanion.org/rcompanion/d_02.html
# bartlett.test(Value ~ Group, data=Data)

# t.test(Value ~ Group, data=Data,
#        var.equal=FALSE,
#        conf.level=0.95)

# Correlation test 

# cor.test( ~ Var1 + VAr2,
#           data=Data,
#           method = "pearson", # or "spearman" # non-parametric
#           conf.level = 0.95)

# Regression
# model = lm(Y ~ X,
#            data = Data)
# summary(model)  
# Anova(model, type="III") 
# note several assumptions need to be tested




# now that we have a dataframe lets try different plots again
# https://stackoverflow.com/questions/7549694/add-regression-line-equation-and-r2-on-graph
# Correlation data ----
data_wide.df %>% 
  ggplot(aes(x=pos_cont, y = wt)) +
  geom_point() +
  # geom_smooth(method="lm") +
  stat_cor(method = "pearson", label.x = 3, label.y = 30)  # Add correlation coefficient
  
# Regression data ----
data_wide.df %>% 
  ggplot(aes(x=pos_cont, y = wt)) +
  geom_point() +
  geom_smooth(method="lm") +
  stat_cor(label.x = 3, label.y = 46) +
  stat_regline_equation(label.x = 3, label.y = 42)
