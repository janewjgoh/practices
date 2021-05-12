#1. import sas stata and spss files with haven

library(haven)

#sas data import
sales <- read_sas("sales.sas7bdat")

#stata data import
dta_url <- "http://assets.datacamp.com/production/course_1478/datasets/trade.dta"
sugar <- read_dta(dta_url)
str(sugar)
sugar$Date <- as.Date(as_factor(sugar$Date))
str(sugar)

#spss data import

healthdata <- read_sav("healthdata.sav")
str(healthdata)
subset(healthdata, CD==1)


#2. import stata & spss data using foreign
# for sas can only import .xport sas library not single files; 
# can use haven/ sas7bdat packages for sas

library(foreign)

#dta data import
florida_dta <- read.dta("florida.dta")
head(florida_dta)
nrow(subset(florida_dta, gore > nader + bush + buchanan))
nrow(subset(florida_dta, bush > gore + nader + buchanan))

#spss data import
demo <- read.spss("international.sav",to.data.frame=TRUE)
boxplot(demo$gdp)
plot(demo$gdp, demo$f_illit)
cor(demo$gdp, demo$f_illit)
