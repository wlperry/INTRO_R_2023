library(readxl)
library(janitor)
library(tidyverse)


jm.df <- read_excel("data/mirendorf growth data.xlsx")

jm_long.df <- jm.df  %>% 
  pivot_longer(
    cols = -treatment,
    names_to = "day",
    values_to = "value")

jm_long.df %>% 
  ggplot(aes(day, value, color=treatment)) +
  geom_line()

jm_long.df <- jm_long.df %>% mutate(day = gsub(".*\\_", "", day) )

jm_long.df <- jm_long.df %>% mutate(day = as.numeric(day))


jm_long.df <- jm_long.df %>% 
  separate(treatment, into = c("strain", "number", "letter"), 
           sep="\\.",
           remove = FALSE)

jm_long.df <- jm_long.df %>% 
  separate(letter, into = c("letter", "leucine"), 
           sep="\\_",
           remove = FALSE)


jm_long.df %>% 
  ggplot(aes(day, value, color=strain, linetype = leucine)) +
  stat_summary(
    fun=mean, na.rm = TRUE, 
    geom = "line", 
    size = 1 ) +
  stat_summary(
    fun.data = mean_se, na.rm = TRUE, 
    geom = "errorbar", 
    width = 0.3 ) 


