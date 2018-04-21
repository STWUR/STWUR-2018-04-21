library(shiny)
library(DT)

server <- function(input, output) {
  output[["table"]] <- renderDataTable({
    datatable(iris)
    # datatable(iris, filter = "top")
    
    # datatable(iris, extensions = "Buttons", 
    #           options = list(
    #             dom = "Brtip",
    #             buttons = list("copy", "csv", "excel")))
    
  })
}

ui <- fluidPage(
  titlePanel("Datatable"),
  dataTableOutput("table")
)

shinyApp(ui = ui, server = server)
