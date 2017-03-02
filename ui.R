library(shiny)


shinyUI(fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "main.css")
  ),
  titlePanel("Baby Names by Year"),
  sidebarLayout(
    sidebarPanel(
      uiOutput("genderSelect"),
      uiOutput("yearSlider")
    ),
    mainPanel(
       plotOutput("distPlot")
    )
  )
))
