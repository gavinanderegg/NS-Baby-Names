library(readr)


babynames <- read_csv("~/Sites/nsbabynames/NS_Top_Twenty_Baby_Names_-_1920-2016.csv", col_types = cols(
  sex = col_factor(levels = c("M", "F")),
  year = col_datetime(format = "%m/%d/%Y %H:%M:%S %p"),
  count = col_integer()))

plot(babynames[['count']], format(babynames[['year']],'%Y'))
