import reactShinyInput from 'reactR';
import validator from '@rjsf/validator-ajv8';
import Form from '@rjsf/core';

const log = (type) => console.log.bind(console, type);


function App({ configuration, value, setValue }) {
  const onSubmit = ({ formData }, e) => setValue(formData)
  return (
    <Form
      schema={configuration.schema}
      uiSchema={configuration.uiSchema}
      validator={validator}
      formData={value}
      onChange={log('changed')}
      onSubmit={onSubmit}
      onError={log('errors')}
    />
  );
}

reactShinyInput('.json_schema_form', 'data.catalog.entry.json_schema_form', App);

export default App;