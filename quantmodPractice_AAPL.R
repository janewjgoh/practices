library(quantmod)
library(dplyr)

#Update AAPL data
getSymbols("AAPL",src="yahoo") 
dates <- index(AAPL)
AAPL <- as.data.frame(AAPL)
AAPL <- cbind(date=dates,AAPL)
names(AAPL) <- c("date","open","high","low","close","volume","adjusted")
str(AAPL)

#Update S&P500 data
getSymbols("%5EGSPC",src="yahoo") 
SP500 <- as.xts(`%5EGSPC`)
dates <- index(SP500)
SP500 <- as.data.frame(SP500)
SP500 <- cbind(date=dates,SP500)
names(SP500) <- c("date","open","high","low","close","volume","adjusted")
str(SP500)

#convert AAPL data time from daily to weekly and monthly
aaplWeek <- to.weekly(AAPL)
aaplMonth <- to.monthly(AAPL)
periodicity(aaplWeek)
periodicity(aaplMonth)
# ndays(AAPL); nweeks(aaplWeek); nmonths(aaplMonth)

# check data
#is.OHLC(AAPL)
#has.Vo(AAPL)
#tail(OpCl(AAPL)*100)
#tail(OpOp(AAPL))

#show the latest 7 day prices & volume
tail(AAPL,n=7)

#check if volume was at min/max  
print(paste("Min Vol:",identical(Sys.Date()-1 , AAPL[which.min(AAPL$volume),]$date)))
print(paste("Max Vol:",identical(Sys.Date()-1 , AAPL[which.max(AAPL$volume),]$date)))


#plot full data in months
chartSeries(aaplMonth,multi.col=TRUE,theme='white')
addMACD()
addBBands()