#R packages for Excel data

#1. readxl- only 2 functions

install.packages("readxl")
library(readxl)

dir() #check files in directory
excel_sheets("file.xlsx") #list excel sheets in workbook
read_excel("file.xlsx") #read excel workbook
                        #specify sheet, col_names, skip
                        #col_types = c("text","blank")
                        #blank will not be imported
wblist <- lapply(excel_sheets("file.xlsx"), #use lapply to import all sheets
                 read_excel,path="file.xlsx")

#2. gdata package- use Perl to convert xls to csv
#more stable package but slower than readxl

install.packages("gdata")
library(gdata)

file <- read.xls("file.xlsx") #will read sheet 1
                              #specify sheet, skip,
                              #header, stringsAsFactors
                              #col.names
na.omit(file) #remove na observations


#3. XLConnect package- supercharged Excel  & R bridge (JAVA based)
install.packages("XLConnect")
library(XLConnect)

file <- loadWorkbook("file.xlsx") #reading workbook
getSheets(file) #list all sheets in file
readWorksheet(file, sheet=2, startRow=3,endRow=4 #reading sheet
              startCol=2, endCol=4, header=FALSE)
createSheet(file, name="newSheet") #rmb to save
writeWorksheet(file, newData, sheet="newSheet") #rmb to save
renameSheet(file,"oldSheetName","newSheetName") #rmb to save
removeSheet(file,sheet="thisSheet") #rmb to save
saveWorkbook(file, file="newFile.xlsx") #save workbook
