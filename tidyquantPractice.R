
install.packages("tidyquant")
library(tidyquant)
 
aapl <- tq_get("AAPL", get="stock.prices", 
               from="2011-01-01", 
               to="2021-05-04")
str(aapl)
head(aapl)
aapl <- tq_mutate(aapl, select = adjusted, 
                  mutate_fun = dailyReturn)
tail(aapl$daily.returns*100,n=7)
sorted_returns <- sort(aapl$daily.returns)
plot(sorted_returns)

summary(aapl$volume)
brange <- c(aapl$volume[1],
            aapl$volume[2],
            aapl$volume[3],
            aapl$volume[4],
            aapl$volume[5],
            aapl$volume[6])
plot(cut(aapl$volume,breaks=brange))

plot(aapl$date,aapl$adjusted,type="l")

