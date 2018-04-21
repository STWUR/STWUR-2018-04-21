library(shiny)

server <- function(input, output) {
  twice_as_much <- reactive({
    input[["obs"]]*2
  })
  
  output[["plot"]] <- renderPlot({
    plot(1L:twice_as_much(), ylab = "Liczba punktow")
  })
  
  output[["print"]] <- renderPrint({
    twice_as_much()
  })
  
  output[["text"]] <- renderText({
    twice_as_much()
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
