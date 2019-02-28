library(tidyverse)
library(modelr)
library(GGally)

df = read.csv("Data/ulake_meanbyyear.csv")
options(max.print = 1420)
glimpse(df)
levels(df$Name)

