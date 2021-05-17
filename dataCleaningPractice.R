#data cleaning practice: data type, range, duplicates, category
setwd("C:/Users/vpn/Documents/R")
dir()

library(readr) #read files
library(readxl) #read excel
library(dplyr) #data wrangling
library(stringr) #string data
library(assertive) #check data
library(lubridate) #date data
library(chron) #time data
library(ggplot2) #plot data
library(forcats) #factor data
library(visdat) #visualize data



data("lakers")

#1. data type 

lakers <- lakers %>% mutate(date = as.Date(as.character(date),format="%Y%m%d"), #change date format
                            opponent = as.factor(opponent), #change opponent to factor
                            game_type = as.factor(game_type), #change game_type to factor
                            #time = ms(time), #change time to minutes & seconds
                            period = as.factor(period), #change period to factor
                            player = replace(player, player == "", NA), #replace blanks with NA
                            result = replace(result, result == "", NA),
                            type = replace(type, type == "", NA)
                            )
head(lakers)

#2. data range, duplicates
subset(lakers, date > today()) #all data are in past
assert_all_are_in_closed_range(lakers$points, 0, 3) #scored points 0~3


filter(lakers, duplicated(lakers)) #duplicates check method 1

lakers %>% #duplicated check method 2
  group_by(date,  time, period, etype) %>%
  count(date,  time, period, etype) %>%
  filter (n>1)

#3. categorical- create nba team regions column
fct_count(lakers$opponent) #verifying NBA team names convention

lakers <- mutate(lakers, region_collapsed = fct_collapse(lakers$team, 
                                 Atlantic = c("BOS","NYK","PHI","NJN","TOR"),
                                 Central = c("CHI","CLE","DET","IND","MIL"),
                                 Southeast = c("ATL","CHA","MIA","ORL","WAS"),
                                 Northwest = c("DEN","MIN","OKC","POR","UTA"),
                                 Pacific = c("GSW","LAL","LAC","PHX","SAC"),
                                 Southwest = c("DAL","HOU","MEM","SAS","NOH")
                                 )) # add new column and collapse teams into different regions
fct_count(lakers$region_collapsed) #checking the region results


#4. text data
str_to_lower() #make lower case
str_to_upper() #make capitalized
str_trim() #remove white space
str_length() #check string length

str_detect() #detect if "-" is in string (col, "-"), use fixed("?") for special characters such as {} [] () 
str_remove_all() #remove all "a" from col
str_replace_all() #replace a with b from col (col, "a", "b")

glimpse(lakers)
str(lakers)

#5. Uniformity 


#convert to celcius
data("nottem")
str(nottem)
plot(nottem)
celcius <- function(X){(X-32)*(5/9)} #create function
nottem_c <- round(celcius(nottem),2) #convert F to C
nottem_c

#convert price currency
epp <- read_csv("electronics_products_pricing.csv")
fct_count(factor(epp$prices.currency))
epp = epp %>% mutate(price_sgd = ifelse(prices.currency == "USD", round(price*1.33,2), NA)) 
head(epp$price_sgd)
str(epp)

#6. Cross validation
epp %>% filter(price_sgd < price) #SGD should be > USD
epp = epp %>% mutate(datediff = floor(as.numeric(as.Date(prices.dateSeen) %--% today(),"years"))) %>% 
        filter(datediff < 0) #no future dated data


#7. Completeness- NA NAN 0 etc
data(airquality)
sum(is.na(airquality)) #check how many & where missing data
vis_miss(airquality) 

#is missing data related to other data points?
airquality %>% mutate(miss_ozone = is.na(Ozone)) %>%
  group_by(miss_ozone) %>%
  summarize_all(median, na.rm=TRUE) 
  #there doesn't seem to be any relation 
  #between other data points and missing Ozone data 

#double check to confirm.. 
airquality %>%
  arrange(Month) %>%
  vis_miss()
  #Month seems to be the problem 

#confirm if related to month?
airquality %>%
  group_by(Month) %>%
  summarize_all(.funs = funs('NA' = sum(is.na(.)))) 
  #yes, ozone readings were missing for most of June

#solution A- drop missing data
airquality_dropna = airquality %>% filter(!is.na(Ozone), !is.na(Solar.R))
airquality_dropna

#solution B- replace missing data
airquality_rep = airquality %>% 
  mutate(ozone_fill = ifelse(is.na(Ozone), mean(Ozone, na.rm=TRUE), Ozone)) %>%
  mutate(solar_fill = ifelse(is.na(Solar.R), mean(Solar.R, na.rm=TRUE), Solar.R))
airquality_rep


#8. record linkage methods

#string variations (string distance)
library(fuzzyjoin) #string data
stringdist_left_join(data1, data2, by="col", 
                     method="dl", max_dist=2)
                      #"dl" "lcs" "jaccard" etc


#similar records in two dataframes
library(reclin)
pair_blocking(city1, cities2, blocking_var= "state") %>%
  compare_pairs(by = c("name", "zip"), 
                default_comparator = lcs()) %>% #or jaro_winkler() jaccard() 
  score_simsum() %>% #or score_problink() for identifying good matches
  select_n_to_m() %>% #select good matches
  link() #linking 2 df together



