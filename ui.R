library(shiny)
library(dygraphs)

shinyUI(fluidPage(
  
  titlePanel("NBA Win Probability Calculator"),
  
  fluidRow(
    column(4,
           wellPanel(
             numericInput("pointDiff", "Point Difference", 0),
             numericInput("gameTime", "Game Time (in seconds)", 0, min=0),
             numericInput("vegasLine", "Vegas Line", 0),
             tags$small(paste0(
               "Note: Point Difference and Vegas Line are in respect to the home team. ",
               "For example, a point difference of 5 would indicate that the home teams is",
               "up 5 points. Similarly, a Vegas line of -6, would mean that ",
               "the Vegas odds before the game favored the home team by a spread of 6 than the away team"
             ))
            ),
           wellPanel(
             selectInput("game", "Select Game", c("LAL vs LAC 11/17/2004", "HOU vs SAS 12/9/2004")),
             tags$small(paste0(
               "Note: The selected games are from the 2004-2005 NBA regular season"
             ))
           )
    ),
    column(7,
           wellPanel(
             strong("Win Probability:",
                  textOutput("p")
             )
           ),
#            dygraphOutput("dygraph"),
#            plotOutput("pointPlot"),
           plotOutput("mainPlot")
    )
  )
))

