library(shiny)
library(jsonlite)
library(httr)

shinyServer(function(input, output) {
  request <- function(url, user, password) {
    if(user != "" && password != "")
      GET(url, authenticate(user, password, type = 'basic'))
    else
      GET(url)
  }

  observe({
    if(input$update != 0) isolate({
      user <- input$user
      password <- input$password
      limits <- reactive({
        limits <- request("https://api.github.com/rate_limit", user, password)
        data.frame(unlist(fromJSON(content(limits, "text"))))
      })
      output$limits <- renderTable(limits())
    })
  })

  output$Rinfo <- renderTable({
    data.frame(unlist(version))
  })
})
