library(shiny)
library(mlr)

load("model_rf.RData")

server <- function(input, output) {
  prediction <- reactive({
    dat <- read.csv(input[["apartments_file"]][["datapath"]])
    
    dat[["dzielnica"]] <- factor(dat[["dzielnica"]], levels = c("Brak", "Fabryczna", "Krzyki", "Psie Pole", "Stare Miasto", "Śródmieście"))
    predict(model_rf, newdata = dat)
  })
  
  
  output[["pred"]] <- renderPrint({
    req(input[["apartments_file"]])
    
    prediction()
  })
  
}

ui <- fluidPage(
  titlePanel("Predykcja dla wielu mieszkań"),
  sidebarLayout(
    sidebarPanel(
      fileInput('apartments_file', "Wybierz plik z danymi (.csv):")
    ),
    mainPanel(verbatimTextOutput("pred"))
  )
)

shinyApp(ui = ui, server = server)