# Load libraries
library(tidyverse)
library(readxl)


# read in files
mm.df <- read.csv("data/mms.csv")

# how to save a file
write_csv(mm.df, file="output/m_and_m_output.csv")


# how to plot some data
ggplot(aes(x=diameter, y=mass), data=mm.df) +
  geom_point()


# how to save a plot
ggsave(filename = "figures/m_and_m.pdf",
       mm.plot, # How do you get this????
       width = 5,
       height = 5,
       units = "in")
