# Data from:
# https://data.novascotia.ca/Population-and-Demographics/NS-Top-Twenty-Baby-Names-1920-2016/emf8-vmuy


library(shiny)
library(readr)
library(dplyr)


babynames <- read_csv(paste0(getwd(), "/NS_Top_Twenty_Baby_Names_-_1920-2016.csv"), col_types = cols(
  sex = col_factor(levels = c("M", "F")),
  year = col_datetime(format = "%m/%d/%Y %H:%M:%S %p"),
  count = col_integer()))

babynames$year <- format(babynames$year, '%Y')

shinyServer(function(input, output) {
  years <- babynames$year
  firstYear <- as.numeric(years[1])
  lastYear <- as.numeric(years[length(years)])
  
  output$yearSlider <- renderUI({
    sliderInput("year",
      "Year:",
      min = firstYear,
      max = lastYear,
      value = firstYear)
  })
  
  output$distPlot <- reactive({
    output$currentYear <- reactive(input$year)
    
    output$distPlot <- renderPlot({
      plot(babynames$count, years)
    })
  })
})
