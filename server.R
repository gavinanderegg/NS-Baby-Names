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
  
  
  
  output$description <- renderText('<p>A tool to explore the <a href="https://data.novascotia.ca/Population-and-Demographics/NS-Top-Twenty-Baby-Names-1920-2016/emf8-vmuy">"NS Top Twenty Baby Names - 1920-2016" dataset</a> — part of <a href="https://data.novascotia.ca/">the Nova Scotia Government\'s Open Data Portal</a>.<br><br>To use the top chart, first select a gender, and then a year to see the top names for that gender in that year. The bottom chart is indendant of first, and shows a graph of when that name appeared in the year data, and how many babies with that name were born in those years.<br><br>Built by <a href="http://anderegg.ca/about/">Gavin Anderegg</a> using <a href="https://www.r-project.org/">R</a> and <a href="https://shiny.rstudio.com/">Shiny</a>. <a href="https://github.com/gavinanderegg/NS-Baby-Names">Source available here</a>.<br><br></p>')
  
  
  
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
    
    p <- ggplot(aes(x=`first name`, y=count, fill=count), data=outputVals) + geom_bar(stat="identity") + coord_flip() + 
scale_x_discrete(limits = rev(levels(outputVals$`first name`)))
    print(p)
  })
  
  
  
  output$nameOverTimePlot <- renderPlot({
    inputName <- input$name
    if (is.null(input$name)) {
      inputName <- allNames[1]
    }
    
    outputVals <- subset(babynames, `first name` == inputName)
    
    p <- ggplot(aes(x=year, y=count, group=1, color=count), data=outputVals) + geom_line() + geom_point()
    print(p)
  })
  
  
  
})
