# Easiest way to get access to PxWeb data is to use pxweb R-package

install.packages('pxweb')

# (C) Måns Magnusson, Markus Kainu, Janne Huovari, and Leo Lahti. Retrieval and analysis of PC Axis data with the pxweb package. 
# R package version 0.9.13. URL: http://ropengov.github.io/pxweb

library(pxweb)

# To browse through diffrent datasets, you can use pxweb_interactive().
# Function gives you the url, query in R list or json format and the data dependening on your choices.
pxweb_interactive()

# To retrieve spesific dataset with query, use pxweb_get
# For example, to get Municipal waste by treatment method for year 2015-2018 

# R list formmatted query
pxweb_query_list <- 
  list("vuosi"=c("2015","2016","2017","2018"),
       "Tiedot"=c("AVS","ENE","MÅT"))

# Download data 
px_data <- 
  pxweb_get(url = "http://pxnet2.stat.fi/PXWeb/api/v1/en/StatFin/ymp/jate/statfin_jate_pxt_001.px",
            query = pxweb_query_list)

# If you would rather use json queries, downloading same data would be
# pxweb_get(url =  "http://pxnet2.stat.fi/PXWeb/api/v1/en/StatFin/ymp/jate/statfin_jate_pxt_001.px" , query = <path-to-json> )


# After you have downloaded the data, you can transform it to a data.frame
px_data <- as.data.frame(px_data, column.name.type = "text", variable.value.type = "text")

# You can also choose the code versions of the variables and/or column names by spesifying  variable.value.type = "code" and/or "column.name.type = "code"

# You can then proceed to do your analysis with this data. :)

# P.S If you face a bug or you have a wish recarding the pxweb package, visit https://github.com/rOpenGov/pxweb/issues