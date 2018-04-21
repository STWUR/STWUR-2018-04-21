library(shiny)
library(DT)

server <- function(input, output) {
  output[["table"]] <- renderDataTable({
    #datatable(iris)
    #datatable(iris, filter = "top")
    datatable(iris, extensions = "Buttons", options = list(
      dom = 'Brtip',
      buttons = 
        list('copy', 'print', list(
          buttons = c('csv', 'excel', 'pdf')
        ))))
  })
}

ui <- fluidPage(
  dataTableOutput("table")
)

shinyApp(ui = ui, server = server)
