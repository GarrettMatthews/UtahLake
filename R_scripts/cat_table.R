library(tidyverse)



df = read.csv("./Data/ulake_meanbyyear.csv")
df2 = read.csv("h20qual_cat.csv")

flt = df %>%
  count(Name) %>%
  filter(n > 10)
flt = flt$Name
flt = factor(flt)


df3 = df[df$Name %in% flt,]
# Eliminating non-existant levels from the data frame 
df3$Name = factor(df3$Name)
levels(df3$Name)
df3 = df3 %>%
  mutate(Name = as.factor(Name)) %>%
  filter(TRUE)

df2$Name = df2$Characteristic

df4 = left_join(df3,df2)

df4 %>%
  ggplot(aes(x= Year, y = Mean_Value, color = Description)) + geom_line() + 
  facet_wrap(~Description)

# Wrote as a CSV file because I had an easier time thinking through I would edit
# the data frame using lists in Python that I could think through using R for that purpose
#write.csv(df4, file = "./Data/meanyear_cat.csv")

df5 = read.csv("Data/poisons.csv")

p = df5 %>%
  ggplot(aes(x = Year, y = Mean_Value, color = Characteristic)) + geom_point() 
  

p + theme(legend.position = "none")
