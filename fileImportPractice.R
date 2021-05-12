#file import methods using utils, readR and data.table

#1. basic utils package (preloaded in R)

dir() #lists all files in directory
path <- file.path("") #specifying file path
read.csv(path, stringsAsFactors = FALSE) #reading comma separated files
read.delim(path, stringsAsFactors = FALSE) #reading \t tab separated files
read.table(path, stringsAsFactors = FALSE) #reading other file types, 
                #specify ColClasses, col.names, header, 
                #separator, stringsAsFactors
read.csv2() #use for ; , separators
read.delim2() #use for ; , separators

#2. readR package- faster and more concise than utils

install.packages("readr")
library(readr)

dir() #lists all files in directory
path <- file.path("") #specifying file path
read_csv(path) #reading comma separated files, 
                  #similar to read.csv(), 
                  #except don't have to specify stringsAsFactors
read_tsv(path) #reading \t tab separated files, 
                  #similar to read.delim()
                  #no sAF
read_delim(path) #reading other file types, 
                  #similar to read.table()
                  #specify delim, col_names, header,
                  #col_types="cdil_" char double integer logical skip 
                  #col_types= list(col_factor(levels=c("",""),ordered=FALSE), col_integer)
                  #stringsAsFactors, skip, n_max


#3. data.table- suitable for reading large files
install.packages("data.table")
library(data.table)

fread(path) #drop, select columns as needed
            #similar to read.table and read_delim
            #able to infer column types and separators
            #default stringsAsFactors = FALSE

