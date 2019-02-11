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



levels(df$CharacteristicName)
summary(df$CharacteristicName) -> sum
