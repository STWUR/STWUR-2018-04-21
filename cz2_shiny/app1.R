library(shiny)

server <- function(input, output) {
  output[["plot"]] <- renderPlot({
    plot(1L:input[["obs"]], ylab = "Liczba punktow")
  })
}

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      sliderInput("obs", "Number of points:", min = 1, max = 10, value = 5)
    ),
    mainPanel(plotOutput("plot"))
  )
)

shinyApp(ui = ui, server = server)
