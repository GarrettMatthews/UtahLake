#Entering the data in

read.csv("UL_BiologicalData.csv") -> df

#Changing the date columns to be a date class
as.Date(df$ActivityStartDate, tryFormats = c("%m-%d-%Y", "%m/%d/%Y"), optional = TRUE) -> df$ActivityStartDate
as.Date(df$ActivityEndDate, tryFormats = c("%m-%d-%Y", "%m/%d/%Y"), optional = TRUE) -> df$ActivityEndDate
as.Date(df$AnalysisEndDate, tryFormats = c("%m-%d-%Y", "%m/%d/%Y"), optional = TRUE) -> df$AnalysisEndDate
as.Date(df$AnalysisStartDate, tryFormats = c("%m-%d-%Y", "%m/%d/%Y"), optional = TRUE) -> df$AnalysisStartDate
as.Date(df$PreparationEndDate, tryFormats = c("%m-%d-%Y", "%m/%d/%Y"), optional = TRUE) -> df$PreparationEndDate
as.Date(df$PreparationStartDate, tryFormats = c("%m-%d-%Y", "%m/%d/%Y"), optional = TRUE) -> df$PreparationStartDate


# The data contains information from a variety of sites, including, as far as I can tell
# tributaries of Utah Lake. Here I am isolating locations that I know to be Utah Lake
# for individual analysis and emphasis towards Utah Lake.

#df[df$MonitoringLocationIdentifier == "USGS-401613111463301", ] -> ulh1
#df[df$MonitoringLocationIdentifier == "USGS-401432111454301" , ] -> ulh4
#df[df$MonitoringLocationIdentifier == "USGS-401327111462601" , ] -> ulh3
#df[df$MonitoringLocationIdentifier == "USGS-401658111491601" , ] -> ulh2
#df[df$MonitoringLocationIdentifier == "NALMS-7458" , ] -> ulnalm
#df[df$MonitoringLocationIdentifier == "OST_SHPD-1476" , ] -> ulost

# Looking over the data in the above locations indicates that none of them have any
# organismal data. I'm leaving them here incase they are useful later, but for now
# they are not helpful

# Compiling a data frame for what I assume to be the most interesting columns at the moment

#df$ActivityStartDate -> acdate
#df$SubjectTaxonomicName -> tax_name
#df$SampleTissueAnatomyName -> stis
#df$GroupSummaryCountWeight.MeasureValue -> gsc.mv
#df$GroupSummaryCountWeight.MeasureUnitCode -> gsc.mu
#df$TrophicLevelName -> trophic
#df$FunctionalFeedingGroupName -> feed
#df$MonitoringLocationIdentifier -> local

#data.frame("Activity Date" = acdate  ,"Subject Taxonomic Name" =  tax_name,
#           "Sample Tissue Anatomy Name" = stis, "Group Summary Count" = gsc.mv  , "Group Summary Unit" = gsc.mu,
#           "Trophic Level Name" = trophic , "Functional Feeding Group" = feed , "Monitoring Location Identifier" = local) -> df2

# This cleared out the empty rows in the simplified dataframe based on the subject taxonomic 
# name which significantly shortened the amount of data present
#df2[!(is.na(df2$Subject.Taxonomic.Name) | df2$Subject.Taxonomic.Name==""), ] -> df3

#levels(df3$Subject.Taxonomic.Name)
#look at water quality
#ept = c(df3$Subject.Taxonomic.Name == "Ephemeroptera",df3$Subject.Taxonomic.Name == "Plecoptera", df3$Subject.Taxonomic.Name == "Trichoptera")
#df4 = df3[df3$Subject.Taxonomic.Name == "Nematoda",]

library(tidyverse)
library(hexbin)


#Getting a data frame just lookingat the nitrogen concentrations
summary(df$CharacteristicName) -> sum
nh4 = df[df$CharacteristicName == "Ammonia and ammonium", "ResultMeasureValue"]
nh4_1 = df[df$CharacteristicName == "Ammonia and ammonium", "ResultMeasure.MeasureUnitCode"]
date = df[df$CharacteristicName == "Ammonia and ammonium", "ActivityStartDate"]
factor(nh4_1) -> nh4_1
factor(nh4) -> nh4
as.character(nh4) -> nh4
as.numeric(nh4) -> nh4
dn = data.frame(Date = date, NH4 = nh4, Unit = nh4_1)
dn = dn %>%
  filter(NH4 > 0)

ggplot(dn, aes(x=NH4, y=Date, col= Unit)) +
  geom_point() + facet_wrap(~Unit) 

# Exploring pH

ph = df[df$CharacteristicName == "pH", "ResultMeasureValue"]
ph_1 = df[df$CharacteristicName == "pH", "ResultMeasure.MeasureUnitCode"]
ph_date = df[df$CharacteristicName == "pH", "ActivityStartDate"]
as.character(ph) -> ph
factor(ph_1) -> ph_1
as.numeric(ph) -> ph
pH = data.frame(Date = ph_date, pH = ph, Unit = ph_1)

pH = pH %>%
  filter(pH > 0)
pH = pH %>%
  filter(pH <= 14)


ggplot(pH, aes(x=pH, y=Date, col=pH)) +
  geom_point() + coord_flip()

# Exploring mercury levels

hg = df[df$CharacteristicName == "Mercury", "ResultMeasureValue"]
hg_1 = df[df$CharacteristicName == "Mercury", "ResultMeasure.MeasureUnitCode"]
hg_date = df[df$CharacteristicName == "Mercury", "ActivityStartDate"]
factor(hg) -> hg
factor(hg_1) -> hg_1
as.character(hg) -> hg
as.numeric(hg) -> hg
HG = data.frame(Date = hg_date, Hg = hg, Unit = hg_1)

HG = HG %>%
  filter(Hg > 0)

hg_date = HG[HG$Unit == "ug/l","Date"]
hg_1 = hg = HG[HG$Unit == "ug/l","Unit"]
hg = HG[HG$Unit == "ug/l","Hg"]
HG_1 = data.frame(Date = hg_date, Hg = hg, Unit = hg_1)


ggplot(HG_1, aes(x=Hg, y= Date, col=Unit)) +
  geom_point() + coord_flip()

# Looking at E. coli

e_date = df[df$CharacteristicName == "Escherichia coli","ActivityStartDate"]
e_1 = df[df$CharacteristicName == "Escherichia coli","ResultMeasure.MeasureUnitCode"]
e = df[df$CharacteristicName == "Escherichia coli","ResultMeasureValue"]
factor(e) -> e
as.character(e) -> e
as.numeric(e) -> e
factor(e_1) -> e_1

Ec = data.frame(Date = e_date, E.coli = e, Unit = e_1)

Ec = Ec %>%
  filter(E.coli > 0)

ggplot(Ec, aes(x=E.coli,y=Date, col=Unit)) +
  geom_point() + coord_flip()  


# Oil and grease

og_date = df[df$CharacteristicName == "Oil and Grease","ActivityStartDate"]
og_1 = df[df$CharacteristicName == "Oil and Grease","ResultMeasure.MeasureUnitCode"]
og = df[df$CharacteristicName == "Oil and Grease","ResultMeasureValue"]
factor(og) -> og
as.character(og) -> og
as.numeric(og) -> og
factor(og_1) -> og_1

OG = data.frame(Date = og_date, Oil_Grease = og, Unit = og_1)

OG = OG %>%
  filter(Oil_Grease > 0)

OG %>%
  ggplot(aes(x=Oil_Grease,y=Date, col = Unit)) +
  geom_point() + coord_flip()
