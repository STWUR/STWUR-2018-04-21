library(shiny)

server <- function(input, output) {
  output[["plot"]] <- renderPlot({
    plot(1L:input[["obs"]], ylab = "Liczba punktow")
  })
  
  output[["print"]] <- renderPrint({
    input[["obs"]]
  })
  
  output[["text"]] <- renderText({
    input[["obs"]]
  })
}

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      sliderInput("obs", "Number of points:", min = 1, max = 10, value = 5)
      #numericInput("obs", "Number of points:", min = 1, max = 10, step = 1, value = 5)
      #selectInput("obs", "Number of points:", choices = c("One point" = 1, "Five points" = 5, "Ten points" = 10))
    ),
    mainPanel(plotOutput("plot"),
              verbatimTextOutput("print"),
              textOutput("text"))
  )
)

shinyApp(ui = ui, server = server)
