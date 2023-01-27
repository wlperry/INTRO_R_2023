# libraries
library(tidyverse)
library(readxl)
library(janitor)

bact.df <- read_excel("data/Data_R.xlsx") %>% clean_names()

bact_long.df <- bact.df %>% 
  pivot_longer(
    cols = -date,
    names_to = "strain",
    values_to = "value"
  ) %>% 
  arrange(date, strain, value)

write_csv(bact_long.df, "data/data_r_long.csv")
