#Entering the data in

read.csv("UL_BiologicalData.csv") -> df

#Seperating out columns I think will be the focus of interpretation
tax_name = df$SubjectTaxonomicName
date = df$ActivityStartDate

#Changing the date column to be a date class
as.Date(date, tryFormats = c("%m-%d-%Y", "%m/%d/%Y"), optional = TRUE) -> date

#Seperating out this column to act as a location identifier.
#Visit https://maps.waterdata.usgs.gov/mapper/index.html for USDS codes
# and https://enviro.deq.utah.gov/ for UTAHDWQ codes
# and https://www.waterqualitydata.us/provider/STORET/UTAHGS/ for UTAHGS codes
df$MonitoringLocationIdentifier -> local_code

