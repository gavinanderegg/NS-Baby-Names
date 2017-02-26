library(shiny)


shinyUI(fluidPage(
  titlePanel("Baby Names by Year"),
  sidebarLayout(
    sidebarPanel(
      uiOutput("yearSlider")
    ),
    mainPanel(
       plotOutput("distPlot")
    )
  )
))
