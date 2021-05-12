#set working directory to R folder
getwd()
dir()
setwd("C:/Users/vpn/Documents/R")
getwd()

#importing web data

#1. online csv file using utils or readr

#using utils read.csv()
url <- "https://datahub.io/core/gdp-us/r/quarter.csv"
read.csv(url)

#using readr read_csv()
library(readr)
usGDPQ <- read_csv(url)

#2. online excel file using download.file() and readxl
library(readxl)

url <- "https://api.worldbank.org/v2/en/indicator/
          FP.CPI.TOTL.ZG?downloadformat=excel"
dir()
dest_path <- file.path("usInflationA.xls")
download.file(url, dest_path)

excel_sheets(dest_path)
read_excel(dest_path, sheet=1, skip=11, col_names = c("Year","Inflation Rate"))


#3. online excel file using gdata
library(gdata)
url_xls <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/latitude.xls"

read.xls(url_xls)


#4. online RData file using download.file(), load(url())

url_rdata <- "https://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/wine.RData"

#download to local first then load
download.file(url_rdata, "wine_local.RData")
load("wine_local.RData")
summary(wine)

#load url directly without save as local file
load(url("https://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/wine.RData"))
summary(wine)


#5. html/json using httr

library(httr)

json_url <- "http://www.omdbapi.com/?apikey=72bc447a&t=Annie+Hall&y=&plot=short&r=json"

resp <- GET(json_url)
print(resp)
content(resp) #no need to specify as="text" | "raw", content() will convert to R list


#6. html/json using jsonlite

library(jsonlite)

#fromJSON
fromJSON(json_url)

#toJSON and prettify json
pretty_json <- toJSON(mtcars, pretty = TRUE)
print(pretty_json)

#minify json
mini_json <- minify(pretty_json)
print(mini_json)


