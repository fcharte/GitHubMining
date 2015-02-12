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
        limits <- fromJSON(content(request("https://api.github.com/rate_limit", user, password), "text"))
        df <- data.frame(
          Limit     = c(limits$resources$core$limit, limits$resources$search$limit),
          Remaining = c(limits$resources$core$remaining, limits$resources$search$remaining),
          Reset     = c(as.POSIXct(limits$resources$core$reset, origin = "1970-01-01"),
                        as.POSIXct(limits$resources$search$reset, origin = "1970-01-01"))
        )
        df <- data.frame(t(df))
        names(df) <- c("Core", "Search")
        df
      })
      output$limits <- renderTable(limits())
    })
  })

  output$Rinfo <- renderTable({
    data.frame(unlist(version))
  })
})
