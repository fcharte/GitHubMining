library(shiny)

shinyUI(fluidPage(
  titlePanel("GitHubMining"),

  sidebarLayout(
    sidebarPanel(
      h3("API rate limits"),
      tableOutput("limits"),
      actionButton("update", "Update"),
      hr(),
      h3("Github user account"),
      textInput("user", label = h5("User name")),
      textInput("password", label = h5("Password"))
    ),

    mainPanel(
      tableOutput("Rinfo")
    )
  )
))
