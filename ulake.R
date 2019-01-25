#Entering the data in

read.csv("UL_BiologicalData.csv") -> df

#Changing the date column to be a date class
as.Date(df$ActivityStartDate, tryFormats = c("%m-%d-%Y", "%m/%d/%Y"), optional = TRUE) -> df$ActivityStartDate
as.Date(df$ActivityEndDate, tryFormats = c("%m-%d-%Y", "%m/%d/%Y"), optional = TRUE) -> df$ActivityEndDate
as.Date(df$AnalysisEndDate, tryFormats = c("%m-%d-%Y", "%m/%d/%Y"), optional = TRUE) -> df$AnalysisEndDate
as.Date(df$AnalysisStartDate, tryFormats = c("%m-%d-%Y", "%m/%d/%Y"), optional = TRUE) -> df$AnalysisStartDate
as.Date(df$PreparationEndDate, tryFormats = c("%m-%d-%Y", "%m/%d/%Y"), optional = TRUE) -> df$PreparationEndDate
as.Date(df$PreparationStartDate, tryFormats = c("%m-%d-%Y", "%m/%d/%Y"), optional = TRUE) -> df$PreparationStartDate

#Seperating out this column to act as a location identifier.
#Visit https://maps.waterdata.usgs.gov/mapper/index.html for USDS codes
# and https://enviro.deq.utah.gov/ for UTAHDWQ codes
# and https://www.waterqualitydata.us/provider/STORET/UTAHGS/ for UTAHGS codes
df$MonitoringLocationIdentifier -> local_code

