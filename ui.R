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
      h5("Password"),
      tags$input(id="password", type="password", placeholder="Password", class="form-control shiny-bound-input")
    ),

    mainPanel(
      tableOutput("Rinfo")
    )
  )
))
