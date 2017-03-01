# Data from:
# https://data.novascotia.ca/Population-and-Demographics/NS-Top-Twenty-Baby-Names-1920-2016/emf8-vmuy


library(shiny)
library(readr)
library(dplyr)
library(ggplot2)


babynames <- read_csv(paste0(getwd(), "/NS_Top_Twenty_Baby_Names_-_1920-2016.csv"), col_types = cols(
  sex = col_factor(levels = c("M", "F")),
  year = col_datetime(format = "%m/%d/%Y %H:%M:%S %p"),
  count = col_integer()))

babynames$year <- format(babynames$year, '%Y')

shinyServer(function(input, output) {
  years <- babynames$year
  firstYear <- as.numeric(years[1])
  lastYear <- as.numeric(years[length(years)])
  
  output$genderSelect <- renderUI({
    selectInput("gender",
      "Gender:",
      c("F", "M"))
  })
  
  output$yearSlider <- renderUI({
    sliderInput("year",
      "Year:",
      min = firstYear,
      max = lastYear,
      value = firstYear)
  })
  
  output$distPlot <- renderPlot({
    output$currentYear <- reactive(input$year)
  
    inputYear <- input$year
    if (is.null(input$year)) {
      inputYear <- "1920"
    }
    
    inputGender <- input$gender
    if (is.null(input$gender)) {
      inputGender <- "F"
    }
    
    outputVals <- subset(babynames, year == inputYear & sex == inputGender)
  
    # browser()
    
    p <- ggplot(aes(x=`first name`, y=count), data=outputVals) + geom_bar(stat="identity")
    print(p)
  })
})
