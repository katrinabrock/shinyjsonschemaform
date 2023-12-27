library(shiny)
library(jsonlite)
library(shinyjsonschemaform)

reg_form = fromJSON('
{
  "title": "A registration form",
  "description": "A simple form example.",
  "type": "object",
  "required": [
    "firstName",
    "lastName"
  ],
  "properties": {
    "firstName": {
      "type": "string",
      "title": "First name"
    },
    "lastName": {
      "type": "string",
      "title": "Last name"
    },
    "age": {
      "type": "integer",
      "title": "Age"
    },
    "bio": {
      "type": "string",
      "title": "Bio"
    },
    "password": {
      "type": "string",
      "title": "Password",
      "minLength": 3
    },
    "telephone": {
      "type": "string",
      "title": "Telephone",
      "minLength": 10
    }
  }
}
')

default = fromJSON('
{
  "firstName": "June",
  "lastName": "Summer",
  "age": 75,
  "bio": "Comes every year like clockwork."
}
')

  
ui <- fluidPage(
  titlePanel("Form Demo"),
  p(tagList(
    'Example schema from',
    a(
      'react-jsonschema-form playground.',
      href = 'https://rjsf-team.github.io/react-jsonschema-form/'
    )
  )),
  sidebarLayout(
    sidebarPanel(
      h3('Output'),
      verbatimTextOutput("formData")
    ),
    mainPanel(
      tabsetPanel(
        id = 'tabfocus',
        type = 'tabs',
        tabPanel(
          title = 'Simple',
          value = 'simple',
          br(),
          jsonSchemaFormInput(
            "simpleForm",
            schema = reg_form
          )
        ),
        tabPanel(
          title = 'With Default and uiSchema',
          value = "withDefault",
          br(),
          jsonSchemaFormInput(
            "withDefaultForm",
            schema = reg_form,
            default = default,
            uiSchema = list(
              # Uses bootstrap tags
              'ui:classNames' = 'bg-info',
              firstName = list('ui:classNames' = 'text-primary'),
              lastName = list('ui:classNames' = 'text-primary'),
              bio = list('ui:classNames' = 'text-muted')
            )
          )
        ),
        tabPanel(
          title = 'setValueOnChange',
          value = 'setValueOnChange',
          br(),
          jsonSchemaFormInput(
            'setValueOnChangeForm',
            schema = list(
              title = "Story",
              description = "This text updates as you type",
              type = "string"
            ),
            default = "Give it a try!",
            setValueOnChange = TRUE,
            uiSchema = list(
              'ui:submitButtonOptions' = list(norender=TRUE) 
            )
          )
        )
      )
    ),
    position = 'right'
  )
)

server <- function(input, output, session) {
  all_outputs <- reactive({
    list(
        simple = input$simpleForm,
        withDefault = input$withDefaultForm,
        setValueOnChange = input$setValueOnChangeForm
      )
  })
  output$formData <- renderText({
    toJSON(
      all_outputs()[[input$tabfocus]],
      pretty = TRUE,
      auto_unbox = TRUE)
  })
}

shinyApp(ui, server)