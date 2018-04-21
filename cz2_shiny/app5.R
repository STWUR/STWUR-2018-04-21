library(shiny)
library(mlr)

load("model_rf.RData")

server <- function(input, output) {
  prediction <- reactive({
    dat <- data.frame(n_pokoj = 2, 
                metraz = input[["metraz"]], 
                cena_m2 = 5270L, 
                rok = 2007L, 
                pietro = 2L, 
                pietro_maks = 2L, 
                dzielnica = factor(input[["dzielnica"]], levels = c("Brak", "Fabryczna", "Krzyki", "Psie Pole", "Stare Miasto", "Śródmieście")))
    
    predict(model_rf, newdata = dat)
  })
  
   
  output[["pred"]] <- renderPrint({
    prediction()
  })
}

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      sliderInput("metraz", "Metraż:", min = 30, max = 100, value = 61),
      selectInput("dzielnica", "Dzielnica:", choices = c("Brak", "Fabryczna", "Krzyki", "Psie Pole", "Stare Miasto", "Śródmieście"))
    ),
    mainPanel(verbatimTextOutput("pred"))
  )
)

shinyApp(ui = ui, server = server)