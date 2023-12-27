#' Shiny Input Form from JSON Schema
#'
#' Allows you to use a json schema to create a form-style shiny input.
#'
#' Wraps [react-jsonschema-form](https://rjsf-team.github.io/react-jsonschema-form/docs/).
#'
#' @export
jsonSchemaFormInput <- function(inputId, default = "", configuration=list()) {
  reactR::createReactShinyInput(
    inputId,
    "json_schema_form",
    htmltools::htmlDependency(
      name = "json_schema_form-input",
      version = "1.0.0",
      src = "",
      package = "data.catalog.entry",
      script = "json_schema_form.js"
    ),
    default,
    configuration
  )
}