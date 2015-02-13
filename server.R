library(shiny)
library(jsonlite)
library(httr)

request <- function(url, user, password) {
  if(user != "" && password != "")
    content(GET(url, authenticate(user, password, type = 'basic')))
  else
    content(GET(url))
}

shinyServer(function(input, output) {
  observe({
    if(input$update != 0) isolate({
      limits <- reactive({
        limits <- request("https://api.github.com/rate_limit", input$user, input$password)
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
    df <- data.frame(unlist(version))
    names(df) <- c("Value")
    df
  })

  observe({
    if(input$search != 0) isolate({
      users <- reactive({
        if(input$location == "") return()

        url <- paste("https://api.github.com/search/users?q=+location:", input$location, "&per_page=100", sep = "")
        data <- request(url, input$user, input$password)
        df <- as.data.frame(t(sapply(data$items, rbind)))
        names(df) <- names(data$items[[1]])
        df[, c(1, 5, 16)]
      })
      output$users <- renderTable(users())
    })
  })

})
