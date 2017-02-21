#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
# https://data.novascotia.ca/Population-and-Demographics/NS-Top-Twenty-Baby-Names-1920-2016/emf8-vmuy


library(shiny)
library(readr)


babynames <- read_csv("~/Sites/nsbabynames/NS_Top_Twenty_Baby_Names_-_1920-2016.csv", col_types = cols(
  sex = col_factor(levels = c("M", "F")),
  year = col_datetime(format = "%m/%d/%Y %H:%M:%S %p"),
  count = col_integer()))

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  # browser(babynames)
  output$distPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    cnt <- gsub(",", "", babynames['count'])
    cnt <- as.numeric(cnt)
    
    
    renderPlot({
      plot(c(1, 2, 4, 5, 6), c(6, 7, 8, 9, 10))
    })
  })
})
