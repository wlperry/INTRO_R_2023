# install packages -----
# install.packages("tidyverse")
# install.packages("readxl")


# Load libraries -----
library(tidyverse)
library(readxl)

# how does R work
# <- assignment operator - alligator eats the minus sign
#     saves anything on the right to the thing on the left
#     naming is up to you 
#     I suggest - data are name.df, plots are name.plot and models are name.model

# how you you save the value 9 to a variable called x?


# how you you save the value 2 to a variable called z?



# how would you multiply x * z to see the product?



# how would you save the text "hello" to a variable called y?



# two ways to read in files - the first to see how it works -


# the second and faster - 
# read in csv files -----
mm.df <- read.csv("")


# read in excel files? - How do you do it?
b.df <- VERB("")



# how to save a file - WHY use CSV ------
write_csv(mm.df, file="output/m_and_m_output.csv")


# how to plot some data -----
ggplot(aes(x=diameter, y=mass), data=mm.df) +
  geom_point()


# what else might you want to do to the plot to see the different centers? 
# on the legend so you can see different colors for each center?
ggplot(aes(x=diameter, y=mass,    ), data=mm.df) +
  geom_point()




# how to save a plot -----
ggsave(filename = "figures/m_and_m.pdf",
       mm.plot, # How do you get this????
       width = 5,
       height = 5,
       units = "in")



# what if you wanted to do a categorical plot of MASS according the CENTER?
ggplot(aes(x=XXXXX, y=XXXX), data=mm.df) +
  geom_TYPE??()


bact.df <- read_csv("data/data_r_long.csv")

ggplot(bact.df, aes(strain, value)) +
  stat_summary(
    fun=mean, na.rm = TRUE, 
    geom = "point", 
    size = 3 ) +
  stat_summary(
    fun.data = mean_se, na.rm = TRUE, 
    geom = "errorbar", 
    width = 0.3 ) +
  labs(x = "", y = "") +
  theme_light()

