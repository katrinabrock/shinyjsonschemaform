VALID_FORM_PROPS <- c(
  'acceptcharset',
  'action',
  'autoComplete',
  'autocomplete',
  'className',
  'children',
  'customValidate',
  'experimental_defaultFormStateBehavior',
  'disabled',
  'readonly',
  'enctype',
  'extraErrors',
  'extraErrorsBlockSubmit',
  'fields',
  'focusOnFirstError',
  'formContext',
  # formData is set by "default" argument
  # 'formData',
  'id',
  'idPrefix',
  'idSeparator',
  'liveOmit',
  'liveValidate',
  'method',
  'name',
  'noHtml5Validate',
  'noValidate',
  'omitExtraData',
  'onBlur',
  # onChange and/or onSubmit set to update input
  # 'onChange',
  'onError',
  'onFocus',
  #'onSubmit',
  'schema',
  'showErrorList',
  'tagName',
  'target',
  'templates',
  'transformErrors',
  'translateString',
  'uiSchema',
  # validator is set in javascript, not passed through from R
  # 'validator',
  'widgets'
)

#' Shiny Input Form from JSON Schema
#'
#' Allows you to use a json schema to create a form-style shiny input.
#'
#' Wraps [react-jsonschema-form](https://rjsf-team.github.io/react-jsonschema-form/docs/).
#'
#' @param schema An R object using JSON schema keywords that configures
#'  the form fields.
#' @param setValueOnChange Whether `input` slot be updated as data is entered
#'  into form making submit button decorative.
#' @inheritParams reactR::createReactShinyInput
#' @param ... Additional arguments passed to react-jsonschema-form `<Form />`.
#' 
#' @export
jsonSchemaFormInput <- function(
  inputId,
  schema,
  default = NA,
  setValueOnChange = FALSE,
  ...
) {
  configuration <- list(
    setValueOnChange = setValueOnChange,
    props = list(
      schema = schema,   
      ...
    )
  )
  
  unk_args <- names(configuration[['props']])[
    !names(configuration[['props']]) %in% c(VALID_FORM_PROPS, 'setValueOnChange')
  ]
  
  if(length(unk_args) > 0) stop(paste(c(
     'Unknown argument(s):', unk_args),
     collapse = ' '
   ))
  
  reactR::createReactShinyInput(
    inputId,
    "json_schema_form",
    htmltools::htmlDependency(
      name = "json_schema_form-input",
      version = "1.0.0",
      src = "",
      package = "shinyjsonschemaform",
      script = "json_schema_form.js"
    ),
    default,
    configuration
  )
}