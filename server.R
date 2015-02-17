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
    input$search
    users <- isolate({
        if(input$location == "") return()

        url <- paste("https://api.github.com/search/users?q=location:", URLencode(iconv(input$location, localeToCharset(), "UTF-8")), "&per_page=1", sep = "")
        data <- request(url, input$user, input$password)
        withProgress(message = paste("Fetching", data$total_count, "users"), value = 0, {
          pages <- floor(data$total_count / 100) + 1
          logins <- unlist(
            lapply(1:pages,
                   function(aPage)
                     lapply(request(paste(url, "00&page=", aPage, sep = ""), input$user, input$password)$items,
                            function(row) row$login)
                     )
          )
        })
        data.frame(logins)
      })
      output$users <- renderDataTable(users, options = list(pageLength = 100))
  })

})
