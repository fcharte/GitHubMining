library(shiny)

shinyUI(fluidPage(
  titlePanel("GitHubMining"),

  sidebarLayout(
    sidebarPanel(
    ),

    mainPanel(
      tableOutput("Rinfo")
    )
  )
))
