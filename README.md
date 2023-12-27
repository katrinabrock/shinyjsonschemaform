# Description

Generates shiny input form input based on
a [JSON schema](https://json-schema.org/) structured list. Wraps
[react-jsonschema-form](https://rjsf-team.github.io/react-jsonschema-form/docs/).

# Example

![Screenshot of a form with two fields: name and age](https://github.com/katrinabrock/shinyjsonschemaform/assets/16126168/a0880f28-3258-4ed2-a5c2-ee7e62e8450c)

```{r}
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
```

# Installation

This package is not yet on CRAN. Install from github:

```{r}
devtools::install_github('katrinabrock/shinyjsonschemaform', subdir = 'srcR')
```
