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
mm.df <- read_csv("data/mms.csv")