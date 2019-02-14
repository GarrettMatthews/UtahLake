ulake = read.csv("../Desktop/UtahLake/UL_BiologicalData.csv")

names(ulake) -> names

names
ulake[ulake$SubjectTaxonomicName == TRUE,"SubjectTaxonomicName" ]
head(ulake[c(ulake ,101)])
library(dplyr)
glimpse(ulake)
plot(x= ulake$SubjectTaxonomicName , y= ulake$ActivityStartDate) -> plot1
library(ggplot2)
qplot(ulake$SubjectTaxonomicName,ulake$ActivityStartDate)
tail(ulake$SubjectTaxonomicName, n=100)
qplot(ulake$SubjectTaxonomicName)
dim(ulake)
glimpse(ulake$SubjectTaxonomicName)
summary(ulake$SubjectTaxonomicName) -> taxonomic_summary
plot(ulake$SubjectTaxonomicName == "Salmo trutta", ulake$ActivityStartDate)
summary(taxonomic_summary)
taxonomic_summary
ulake[ulake$SubjectTaxonomicName == "Isogenoides","SubjectTaxonomicName"] -> isogenoides_rows
