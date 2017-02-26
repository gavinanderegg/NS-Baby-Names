library(shiny)


shinyUI(fluidPage(
  titlePanel("Baby Names by Year"),
  sidebarLayout(
    sidebarPanel(
      span("Current selected date"),
      verbatimTextOutput("currentYear"),
      uiOutput("yearSlider")
    ),
    mainPanel(
       plotOutput("distPlot")
    )
  )
))
