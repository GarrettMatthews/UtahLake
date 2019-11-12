library(tidyverse)
library(modelr)
library(GGally)
library(stringr)


df = read.csv("Data/ulake_meanbyyear.csv")
options(max.print = 1420)
glimpse(df)
levels(df$Name)

cat = read.csv("h20qual_cat.csv")
cat$Name = cat$Characteristic


flt = df %>%
  count(Name) %>%
  filter(n > 10)
flt = flt$Name
flt = factor(flt)


df2 = df[df$Name %in% flt,]

df2$Name = factor(df2$Name)

cate = left_join(df2,cat, by = "Name")

write.csv(cate,"./Data/wat_qualdata.csv")

nitrogen = df2 %>%
  filter(str_detect(Name, c("Nitrogen", "nitrogen","Ammonia","ammonia","Nitrate","nitrate",
                            "Nitrite","nitrite")))
phos = df2 %>%
  filter(str_detect(Name,c("Phosphorus","phosphorus")))
k = df2 %>%
  filter(str_detect(Name, c("Potassium","potassium")))




df2[df2$Name == "Count", ]





#sink("./water_quality_greater10.txt")
#levels(df2$Name)
#sink(NULL)
df2$Name = factor(df2$Name)
levels(df2$Name)
## Eliminate variables that aren't monitored for water quality
## Start classifying the data into larger groups, especially nutrients
## Start over, building a model that looks two months before beach closures for algal blooms
## and see what predictors are useful. (Function that does the best model)

ch = df2[df2$Name == "Chlorophyll a, uncorrected for pheophytin", ]
nit = df2[df2$Name == "Inorganic nitrogen (nitrate and nitrite)", ]
nit = nit %>%
  filter(Year > 1989) %>%
  filter(Year < 2008)
am = df2[df2$Name == "Ammonia and ammonium", ]
am = am %>%
  filter(Year > 1989) %>%
  filter(Year < 2008)
amn = df2[df2$Name == "Ammonia-nitrogen", ]
amn = amn %>%
  filter(Year > 1989) %>%
  filter(Year < 2008)
p = df2[df2$Name == "Phosphorus", ]
p =  p %>%
  filter(Year > 1989) %>%
  filter(Year < 2008)

chnit = full_join(ch, nit)
chnit = full_join(chnit,am)
chnit = full_join(chnit,amn)
chnit = full_join(chnit,p)
chnit %>%
  ggplot(aes(x=Year, y = Mean_Value,color = Name)) + geom_point() + 
  geom_smooth(se = FALSE) + facet_wrap(~Name)


cnt = df2 %>%
  count(Name)

