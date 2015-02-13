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
      tabsetPanel(id = "pages", type = "pills", selected = "Intro",
                  tabPanel("Intro", fluidPage(
                    h3("Introduction to GitHubMining", style="color: blue"),
                    p("This application allows you to access the GitHub API to get data about users, repositories, contributions, etc."),
                    p("Use the buttons above this text to access the sections of the application."),
                    h4("Rate limits accessing GitHub API", style="color: blue"),
                    p("GitHub limits the number of calls a user can send to its API. Use the ", strong("Update"),
                      " button, at the left, to see your current limits."),
                    p("More restrictive limits are applied to anonymous users than to authenticated users. So, to extend de number of calls you can make please introduce your GitHub user name and password. These credentials will be used only for accessing the GitHub API, they are not sent anywhere.")
                    )),
                  tabPanel("R Info", fluidPage(tableOutput("Rinfo"))),
                  tabPanel("Users", fluidPage(
                    inputPanel(
                      textInput("location", "Location"),
                      actionButton("search", "Search")
                    ), hr(),
                    dataTableOutput("users")
                  ))
      )
    )
  )
))
