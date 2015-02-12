library(shiny)

shinyServer(function(input, output) {
  output$Rinfo <- renderTable({
    data.frame(unlist(version))
  })
})
