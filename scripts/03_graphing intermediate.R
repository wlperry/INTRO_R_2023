# install packages -----
# install.packages("tidyverse")
# install.packages("readxl")
install.packages("patchwork")
install.packages("ggThemeAssist")
install.packages("skimr")

# load this library only one time
library(ggThemeAssist)

# Load libraries -----
library(tidyverse)
library(readxl)
library(patchwork)
library(skimr)


# read in the two files we will work with
# note we can do this at the start with no issues
mm.df <- read_csv("data/mms.csv")
bact.df <- read_csv("data/data_r_long.csv")

# summary stats
skim(mm.df)
# this is a pipe %>% and moves the dataframe intoe the skim command
mm.df %>% skim()


# so we finished here with making a graph
ggplot(aes(x=diameter, y=mass, color=color), data=mm.df) +
  geom_point()

# this us using the pipe
mm.df %>%  ggplot(aes(x=diameter, y=mass, color=color)) +
  geom_point()



# what if we wanted to see a plot of MASS  based on the CENTER of m and m
mm.df %>%  ggplot(aes(x= XXXX, y=XXXX, color=color)) +
  geom_point()

# 
# we can change this type of plot to show a box and whisker plot - geom_boxplot
# we can do a variety of other plots - geom_violin
mm.df %>%  ggplot(aes(x=center, y=mass, color=color)) +
  geom_XXXX() 


# CHALLENGE ----
# what if we wanted to change the colors to match what we really want
# list of colors are here - http://sape.inf.usi.ch/quick-reference/ggplot2/colour
mm.df %>%  ggplot(aes(x=center, y=mass, color=color)) +
  geom_boxplot() +
  scale_color_manual(
    name = "color",
    labels = c("blue", "brown", "green", "orange", "red", "yellow"),
    values = c(XX XX XX XX XX XX XX XX ) )


# # # # # # # # # # # #
# challenge - 
# what would you change to change the fill?
ggplot(aes(x=center, y=mass, color=color), data=mm.df) +
  geom_boxplot() +
  scale_color_manual(
    name = "color",
    labels = c("blue", "brown", "green", "orange", "red", "yellow"),
    values = c("blue", "brown", "green", "orange", "red", "yellow") )




# The end of this is never ending on what you can layer in
ggplot(aes(x=center, y=mass, color=color), data=mm.df) +
  geom_boxplot(position = position_dodge( width = 0.9 )) +
  geom_point(position = position_jitterdodge(jitter.width=0.057, dodge.width = 0.9), alpha = 0.4, size=0.9)+
  scale_color_manual(
    name = "color",
    labels = c("blue", "brown", "green", "orange", "red", "yellow"),
    values = c("blue", "brown", "green", "orange", "red", "yellow") )



# OK SO ENOUGH WITH M & M'S
# LETS TRY RITIKAS DATA
bact.df 

# lets make a box plot - who likes this?
bact.df %>% ggplot(aes(strain, value)) +
  geom_boxplot()
  
  
# Lets make a mean and standard error plot
# we added in a theme - try modifying this? what are the options?
basic.plot <- bact.df %>% ggplot(aes(strain, value)) +  
  stat_summary(
    fun=mean, na.rm = TRUE, 
    geom = "point", 
    size = 3 ) +
  stat_summary(
    fun.data = mean_se, na.rm = TRUE, 
    geom = "errorbar", 
    width = 0.3 ) +
  labs(x = "Strain", y = "Value (something she measured)") +
  theme_light()
basic.plot

# now how can we modify the theme?
personal.plot <- bact.df %>% ggplot(aes(strain, value)) +  
  stat_summary(
    fun=mean, na.rm = TRUE, 
    geom = "point", 
    size = 3 ) +
  stat_summary(
    fun.data = mean_se, na.rm = TRUE, 
    geom = "errorbar", 
    width = 0.3 ) + 
  labs(x = "Strain", y = "Value (something she measured)") 

personal.plot



# Combining plots with patchwork
basic.plot + 
  personal.plot +
  plot_layout(ncol = 1)









 # Setting your own theme
theme_personal <- function(base_size = 14, base_family = "Times")
{theme(
    # #REMOVE PLOT FILL AND GRIDS
    panel.background=element_rect(fill = "transparent", colour = "transparent"), 
    plot.background=element_rect(fill="transparent", colour=NA),
    # # removes the grid lines
    panel.grid.major = element_line(linetype = "blank"),
    panel.grid.minor = element_line(linetype = "blank"),
    
    # ADD AXES LINES AND SIZE
    axis.ticks = element_line(colour = "black"),
    axis.line.x = element_line(color="black", size = 0.5,linetype = "solid" ),
    axis.line.y = element_line(color="black", size = 0.5, linetype = "solid"),
    
    # LABLES APPEARANCE
    axis.text = element_text(colour = "black"),
    axis.title.x=element_text(size=13, face="bold"),
    axis.title.y=element_text(size=13, face="bold"),
    axis.text.x = element_text(size=12, face="bold", angle=0, vjust = .5, hjust=.5),
    axis.text.y = element_text(size=12, face="bold"),

    # LEGEND
    legend.position="bottom",
    # LEGEND TEXT
    legend.text = element_text(colour="black", size = 14, face = "bold"),
    # LEGEND TITLE
    legend.title = element_text(colour="black", size=16, face="bold"),
    legend.key = element_rect(fill = NA),
    legend.background = element_rect(fill = NA))
}
