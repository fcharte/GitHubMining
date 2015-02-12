library(shiny)
library(jsonlite)
library(httr)

shinyServer(function(input, output) {
  user <- ""
  password <- ""

  request <- function(url) {
    user <- input$user
    password <- input$password
    if(user != "" && password != "")
      GET(url, authenticate(user, password, type = 'basic'))
    else
      GET(url)
  }

  limits <- reactive({
    limits <- request("https://api.github.com/rate_limit")
    data.frame(unlist(fromJSON(content(limits, "text"))))
  })
  output$limits <- renderTable(limits())

  output$Rinfo <- renderTable({
    data.frame(unlist(version))
  })
})
