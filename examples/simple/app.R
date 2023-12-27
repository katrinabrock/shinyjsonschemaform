library(shiny)
library(shinyjsonschemaform)

schema <- list(
  title = 'My Form',
  type = 'object',
  properties = list(
    name = list(
      title = 'Name',
      type = 'string',
      default = 'Jo'
    ),
    age = list(
      title = 'Age',
      type = 'integer',
      default = 42
    )
  )
)

ui <- fluidPage(
  titlePanel("Simple Form"),
  jsonSchemaFormInput(
      "simpleForm",
      schema = schema
  ),
  verbatimTextOutput('result')
)

server <- function(input, output, session) {
  output$result <- renderText({
    paste(
      input$simpleForm$name,
      input$simpleForm$age,
      sep = '\n'
    )
  })
}

shinyApp(ui, server)