library(tidyverse)
library(modelr)
library(naniar)

df = read.csv("Data/ulake_h20quality.csv")
glimpse(df)

date = df$Date
year = as.numeric(substr(date, start=1,stop = 4))
month = as.numeric(substr(date, start=6,stop = 7))
day = as.numeric(substr(date, start=9,stop = 10))

df$Year = year
df$Month = month
df$Day = day

df$Value = as.numeric(df$Value)

df2 = df %>%
  group_by(Name,Unit,Year) %>%
  summarise(N = n(), Mean_Value = mean(Value))

write.csv(df2,"Data/ulake_meanbyyear.csv",row.names = FALSE)

