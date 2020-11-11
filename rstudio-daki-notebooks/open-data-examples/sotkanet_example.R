# Easiest way to access Sotkanet data is to use sotkanet r package
# Don't let the dates disturb, package has been looked after in 2020 also :)
install.packages('sotkanet')

# (C) Leo Lahti, Einari Happonen, Juuso Parkkinen and Joona Lehtomaki 2013-2015. sotkanet: Sotkanet R Tools

library(sotkanet)

# To access _all_ indicators, use. Please, have in mind that there is over 3000 indicators
library(jsonlite)
json_ind <- "http://www.sotkanet.fi/rest/1.1/indicators"
indicators <- fromJSON(json_ind, flatten=TRUE)
head(indicators)

# Another way is to use sotkanet packages function, this however does not return as many variables as getting the raw json.
sotkanet.indicators <- SotkanetIndicators(type = "table")
head(sotkanet.indicators)

# To get data, use GetDataSotkanet. For example, number of babies born alive 2015-2018 can be retrieved with following command
born_alive <- GetDataSotkanet(indicators = 1315, 
                              years = 2015:2018, 
                              genders = c("total"),
                              region.category = 'KUNTA')

#You can the use this data in your analysis.





