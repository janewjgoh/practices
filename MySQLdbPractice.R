#Using R to import data from MySQL database 

install.packages("RMySQL")
library(DBI)

con <- dbConnect(RMySQL::MySQL(),
  dbname = "company",
  host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com",
  port = 3306,
  user = "student",
  password = "datacamp")
str(con)

dbListTables(con) #listing tables in this db
dbReadTable(con, "employees") #reading specific table

tables <- lapply(dbListTables(con),
                 dbReadTable, conn=con) #use lapply to read all tables
tables #show tables

employees <- dbReadTable(con, "employees")
employees

#selective import using subset()- will read entire table then subset
subset(employees,
       subset = started_at > "2012-01-01",
       select = c(id, name))

#selective import using dbGetQuery()- only returns requested info, more efficient
dbGetQuery(con, "SELECT id, name FROM employees
                    WHERE started_at > '2012-01-01'")

dbListTables(con)
dbReadTable(con,"products")
dbGetQuery(con, "SELECT * FROM products WHERE contract >= 1")

#using while loop to load large data records 1 by 1
#dbSendQuery(), dbFetch(), dbHasCompleted(), dbClearResult()
req <- dbSendQuery(con,"SELECT * FROM products")
while(!dbHasCompleted(req)){
  chunk <- dbFetch(req, n=1) #fetch 1 record
  print(chunk)
  }
dbClearResult(req) #clear req

#when done, disconnect
dbDisconnect(con) 
