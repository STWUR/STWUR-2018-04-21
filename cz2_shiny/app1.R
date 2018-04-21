library(shiny)

server <- function(input, output) {
  output[["plot"]] <- renderPlot({
    plot(1L:input[["obs"]], ylab = "Liczba punktów")
  })
}

ui <- fluidPage(
  titlePanel("Hello, shiny"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("obs", "Liczba punktów:", min = 1, max = 10, value = 5)
    ),
    mainPanel(plotOutput("plot"))
  )
)

shinyApp(ui = ui, server = server)
