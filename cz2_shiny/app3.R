library(shiny)

server <- function(input, output) {
  random_points <- reactive({
    rnorm(input[["obs"]])
  })
  
  points_mean <- reactive({
    mean(random_points())
  })
  
  output[["plot"]] <- renderPlot({
    #plot(1L:input[["obs"]], random_points(), ylab = "Liczba punktów")
    plot(1L:input[["obs"]], random_points(), ylab = "Liczba punktów")
    abline(h = points_mean(), col = "red")
  })
  
  output[["print"]] <- renderPrint({
    points_mean()
  })
  
  output[["text"]] <- renderText({
    points_mean()
  })
}

ui <- fluidPage(
  titlePanel("Reaktywność"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("obs", "Liczba punktów:", min = 1, max = 10, value = 5)),
    mainPanel(plotOutput("plot"),
              verbatimTextOutput("print"),
              textOutput("text"))
  )
)

shinyApp(ui = ui, server = server)
