# install packages -----
# install.packages("tidyverse")
# install.packages("readxl")
# install.packages("patchwork")
# install.packages("ggThemeAssist")
# install.packages("skimr")
# install.packages("car")
# install.packages("Hmisc")
# install.packages("emmeans")
# install.packages("multcompView")
# install.packages("multcomp")
# install.packages("FSA")
# install.packages("rcompanion")


# Load libraries -----
# these are the libraries I use almost all the time
library(tidyverse)
library(readxl)
library(janitor)
library(patchwork)
# basic stats
library(skimr)
# to do ANOVAS 
library(car)
# to get estimated marginal means
library(emmeans)
# for non parametric tests below
library(FSA)
library(rcompanion)

# I dont think you need to load these but I did this time
# library(multcomp) # this one messes up the select statement in DPLYR
# library(multcompView)

# read in the two files we will work with
# note we can do this at the start with no issues
data.df <- read_csv("data/data_r_long.csv")

# look at data in stat table - 

data.df %>% group_by(strain) %>% skim()


# if you wanted a quick look at the data
data.df %>% 
  ggplot(aes(strain, value)) + geom_boxplot()

# Create factors ------
# note this is not needed if you have character variable and 
# you dont care about the orders
data.df <- data.df %>% 
  mutate(strain= as.factor(strain))

# reorder factors ----
levels(data.df$strain)
data.df <- data.df %>% 
  mutate(strain = fct_relevel(strain, c("wt",  "las_i", "pos_cont", "ppk1" , "ppx")))

# ONE-WAY ANOVA -----
## Anova using lm (note you can sumstitute AOV for similar results) -----
aov.model <- lm(value ~ strain, data= data.df)
summary(aov.model)
Anova(aov.model, type=3)

# Assumption Tests ----
## Homogeneity of Variance----
leveneTest(value ~ strain, data= data.df)

# Checking normality graphically ----
par(mfrow = c(1,2))  # This code put two plots in the same window
hist(aov.model$residuals)   # Makes histogram of residuals  
plot(aov.model, which = 2)   # Makes Q-Q plot

# Checking normality statistically ----
shapiro.test(aov.model$residuals)

# SO WE SHOULD STOP HERE AS THE ASSUMPTION IS VIOLATED or not
# THE CODE BELOW WOULD SSUME THAT RESIDUALS WERE NORMALLY DISTRIBUTED
# Post Hoc tests ---------
model.emm <- emmeans(aov.model, ~ strain)
model.emm

# save emmeans as a dataframe
emmeans.df <- as.data.frame(model.emm)

# plot of comparisons
# blue are confidence intervals, red arrows overlap mean no significant diff
plot(model.emm , comparisons = TRUE)


## Pairwise comparisons with emmeans -----
emm_pairs = emmeans(model.emm, 
                           pairwise ~ strain,
                           adjust="tukey")
# summary of the emmeans pairwise comparisons
summary(emm_pairs)

# to see how comparisons are made
coef(pairs(emm_pairs))

# compare wt to all others
emmeans(aov.model, specs = trt.vs.ctrl ~ strain)
# if wt were the last row - emmeans(aov.model, specs = trt.vs.ctrl ~ strain)

## Pairwise with letters -----
cld <- multcomp::cld(emm_pairs,
                     alpha=.05,
                     Letters=letters)
cld


## Post hoc test plot of 95% CI
# below re different ways
# https://broom.tidymodels.org/reference/tidy.emmGrid.html
# https://broom.tidymodels.org/reference/tidy.summary_emm.html
ggplot(data=cld, aes(x= strain, y = emmean, color = strain)) +
  geom_point() +
  geom_errorbar(aes(min = emmean-SE, ymax = emmean+SE), width=0.3) +
  geom_text(aes(label = .group), hjust=0,vjust = 0)+
  theme_light()

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# Note you could stop here if for the parameteric and not do this fancy graph
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# A different graph and method ----
# https://schmidtpaul.github.io/DSFAIR/compactletterdisplay.html
## now the new plot version ------
# optional: sort factor levels of groups column according to highest mean

# ...in means table
cld <- cld %>% 
  mutate(.group = fct_reorder(.group, emmean))

# # ...in data table
# s.df <- s.df %>% 
#   mutate(.group = fct_relevel(source, levels(model_means_cld$.group)))

# base plot setup
fancy.plot <- ggplot() +
  # x-axis
  scale_x_discrete(name = "Strain") +
  # black data points
  geom_point(
    data = data.df,
    aes(y = value, x = strain),
    shape = 16,
    alpha = 0.5,
    # position = position_nudge(x = 0)
    position = position_dodge2(width=0.05)
  ) +
  # black boxplot
  geom_boxplot(
    data = data.df,
    aes(y = value, x = strain),
    width = 0.15,
    outlier.shape = NA,
    position = position_nudge(x = -0.2)) +
  # red mean value
  geom_point(
    data = cld,
    aes(y = emmean, x = strain),
    size = 2,
    color = "red",
    position = position_nudge(x = 0.2)
  ) +
  # red mean errorbar
  geom_errorbar(
    data = cld,
    aes(ymin = emmean - SE, ymax = emmean + SE, x = strain),
    width = 0.1,
    color = "red",
    position = position_nudge(x = 0.2)) +
  # red letters
  geom_text(
    data = cld,
    aes(
      y = emmean,
      x = strain,
      label = str_trim(.group)
    ),
    position = position_nudge(x = 0.3),
    hjust = 0,
    color = "red") +
  # labs(y="weight (g)", x="") +
  # caption
  labs(caption = str_wrap("Black dots represent raw data. Red dots and error bars 
                       represent (estimated marginal) means ± 95% 1 S.E.. Means not sharing any letter are 
                       significantly different by the Sidak-test at the 5% 
                       level of significance.", width = 70)) +
  theme_classic() 
fancy.plot

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# NON PARAMETRIC STATS ----
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# Kruskal Wallis test no assumptions of normality
kruskal.test(value ~ strain, data= data.df)

# pairwise comparison of KW test -----
dunntest.model = dunnTest(value ~ strain, data= data.df,
              method="bh")      # Adjusts p-values for multiple comparisons;
dunntest.model

# # Residuals of dunntest------
# dunntest.resid = dunntest.model$res
# dunntest.resid

# Compact Letter display of comparisons -----
cldList(P.adj ~ Comparison, data = dunntest.resid, threshold = 0.05)
