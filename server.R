# Data from:
# https://data.novascotia.ca/Population-and-Demographics/NS-Top-Twenty-Baby-Names-1920-2016/emf8-vmuy

library(shiny)
library(readr)
library(dplyr)
library(ggplot2)
library(stringr)



babynames <- read_csv(paste0(getwd(), "/NS_Top_Twenty_Baby_Names_-_1920-2016.csv"), col_types = cols(
  sex = col_factor(levels = c("M", "F")),
  year = col_datetime(format = "%m/%d/%Y %H:%M:%S %p"),
  count = col_integer()))

babynames$year <- format(babynames$year, '%Y')
babynames$`first name` <- str_to_title(babynames$`first name`)

allNames <- sort(unique(babynames$`first name`))



shinyServer(function(input, output) {
  years <- babynames$year
  firstYear <- as.numeric(years[1])
  lastYear <- as.numeric(years[length(years)])
  
  
  
  output$genderSelect <- renderUI({
    selectInput("gender",
      "Gender:",
      c("F", "M"))
  })
  
  
  
  output$nameSelect <- renderUI({
    selectInput("name",
      "Name:",
      allNames)
  })
  
  
  
  output$yearSlider <- renderUI({
    sliderInput("year",
      "Year:",
      min = firstYear,
      max = lastYear,
      value = firstYear)
  })
  
  
  
  output$nameYearPlot <- renderPlot({
    inputYear <- input$year
    if (is.null(input$year)) {
      inputYear <- "1920"
    }
    
    inputGender <- input$gender
    if (is.null(input$gender)) {
      inputGender <- "F"
    }
    
    outputVals <- subset(babynames, year == inputYear & sex == inputGender)
    outputVals$`first name` <- factor(outputVals$`first name`, levels=unique(as.character(outputVals$`first name`)))
    
    p <- ggplot(aes(x=`first name`, y=count), data=outputVals) + geom_bar(stat="identity") + coord_flip() + 
scale_x_discrete(limits = rev(levels(outputVals$`first name`)))
    print(p)
  })
  
  
  
  output$nameOverTimePlot <- renderPlot({
    inputName <- input$name
    if (is.null(input$name)) {
      inputName <- allNames[1]
    }
    
    outputVals <- subset(babynames, `first name` == inputName)
    
    p <- ggplot(aes(x=year, y=count, group=1), data=outputVals) + geom_line() + geom_point()
    print(p)
  })
  
  
  
})
