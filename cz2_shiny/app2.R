library(shiny)

server <- function(input, output) {
  output[["plot"]] <- renderPlot({
    plot(1L:input[["obs"]], ylab = "Liczba punktów")
  })
  
  output[["print"]] <- renderPrint({
    input[["obs"]]
  })
  
  output[["text"]] <- renderText({
    input[["obs"]]
  })
}

ui <- fluidPage(
  titlePanel("Shiny: input i output"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("obs", "Liczba punktów:", min = 1, max = 10, value = 5)
      #numericInput("obs", "Liczba punktów:", min = 1, max = 10, step = 1, value = 5)
      #selectInput("obs", "Liczba punktów:", choices = c("One point" = 1, "Five points" = 5, "Ten points" = 10))
    ),
    mainPanel(plotOutput("plot"),
              verbatimTextOutput("print"),
              textOutput("text"))
  )
)

shinyApp(ui = ui, server = server)
