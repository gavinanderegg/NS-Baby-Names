library(shiny)


shinyUI(fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "main.css")
  ),
  titlePanel("Nova Scotia Baby Names by Year"),
  p(htmlOutput("description")),
  sidebarLayout(
    sidebarPanel(
      uiOutput("genderSelect"),
      uiOutput("yearSlider")
    ),
    mainPanel(
       plotOutput("nameYearPlot")
    )
  ),
  sidebarLayout(
    sidebarPanel(
      uiOutput("nameSelect")
    ),
    mainPanel(
      plotOutput("nameOverTimePlot")
    )
  )
))
