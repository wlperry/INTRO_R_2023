library(readxl)
library(tidyverse)

ga.df <- read_excel("data/mirendorf growth data.xlsx")

ga_long.df <- ga.df %>% 
  pivot_longer(
    cols = -treatment,
    names_to = "day",
    values_to = "length_mm"
  )

ga_long.df <- ga_long.df %>% mutate(day = gsub(".*\\_", "", day) )

ga_long.df <- ga_long.df %>% mutate(day = as.numeric(day))

ga_long.df <- ga_long.df %>%
  separate(treatment, into=c("strain", "cross", "rep"),
           remove = FALSE,
           sep = "\\.")
ga_long.df <- ga_long.df %>%
  mutate(group = paste(strain, cross, sep = "_"))


ga_long.df <- ga_long.df %>%
  mutate(media = case_when(
    rep=="M1" ~ "minimal",
    rep=="M2" ~ "minimal",
    rep=="M3" ~ "minimal",
    rep=="L1" ~ "leucine",
    rep=="L2" ~ "leucine",
    rep=="L3" ~ "leucine",
    TRUE~"other"
  ))

ga_long.df %>%
   filter(day> 41) %>% 
  ggplot(aes(day , length_mm, color=group,
             linetype=media)) +
  stat_summary(
    fun=mean, na.rm = TRUE, 
    geom = "point", 
    size = 1 ) +
  stat_summary(
    fun=mean, na.rm = TRUE, 
    geom = "line", 
    size = 1 ) +
  stat_summary(
    fun.data = mean_se, na.rm = TRUE, 
    geom = "errorbar", 
    width = 0.3 ) +
  labs(y=expression(bold("Nitrate mg L"~
                         Delta^-1*") text"*alpha)))

ga_long.df %>%
  filter(group=="RTH1917_29" & day == 113) %>% 
  ggplot(aes(media , length_mm, color=group,
             linetype=media)) +
  geom_violin()+
  geom_boxplot()
   geom_point()  
  
  
