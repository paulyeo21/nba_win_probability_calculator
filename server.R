library(shiny)
library(dygraphs)
library(ggplot2)

load("finalReport.RData")
# test = gamesDict[[1]][c(250:389),]
# gamesDict[input$game][[1]]

shinyServer(function(input, output, session) {

#   output$dygraph <- renderDygraph({
#     dygraph(gamesDict[input$game][[1]], main = input$game) %>%
#       dyAxis("y", label="Win Probability", valueRange= c(0,1.0)) %>%
#       dyAxis("x", label="Game Time (seconds)") %>%
#       dyRangeSelector(height = 40, keepMouseZoom = TRUE) %>% 
#       dyOptions(drawGrid = F) %>%
#       dyLegend(show="always") %>%
#       dyEvent(date = "0720-1-1", "1Q", labelLoc="bottom", color='black') %>%
#       dyEvent(date = "1440-1-1", "2Q", labelLoc="bottom", color='black') %>%
#       dyEvent(date = "2160-1-1", "3Q", labelLoc="bottom", color='black')
#   })
  
  output$mainPlot <- renderPlot({
    p <- ggplot(gamesDict[input$game][[1]], aes(x=gt, y=p)) 
    p = p + geom_line(aes(colour=m)) 
    p = p + geom_ribbon(aes(ymin=lwr, ymax=upr), alpha=0.3) 
    p = p + scale_colour_gradient(low="blue",high="red") 
    p = p + labs(title=input$game, x="Game Time (in seconds)", y="Probability of Winning", colour="Point Diff") 
    p = p + scale_y_continuous(limits=c(0,1))
    print(p)
  })

#   output$pointPlot <- renderPlot({
#     p <- ggplot(gamesDict[input$game][[1]], aes(x=gt, y=m)) 
#     p = p + geom_line()
#     p = p + labs(x="Game Time (in seconds)", y="Point Difference")
#     print(p)
#   })

  output$p <- renderText({bayesianFunction(pointDiff = input$pointDiff, gameTime = input$gameTime, vegasLine = input$vegasLine)})
})

# TODO: Figure out how to show a pop up of the point difference when mouse is hovering over a point on plot.
