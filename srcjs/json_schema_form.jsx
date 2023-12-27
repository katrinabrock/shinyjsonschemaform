import { createElement } from 'react';
import { reactShinyInput } from 'reactR';
import validator from '@rjsf/validator-ajv8';
import Form from '@rjsf/core';

const log = (type) => console.log.bind(console, type);


function App({ configuration, value, setValue }) {
  const onSubmit = ({ formData }, e) => setValue(formData)
  const onChange = configuration.setValueOnChange ? onSubmit : void(0)
  return (createElement(
    Form, 
    {
      validator: validator,
      formData: value,
      onChange: onChange,
      onSubmit: onSubmit,
      onError: log('errors'),
      ...configuration.props
    }
  ));
}

reactShinyInput('.json_schema_form', 'shinyjsonschemaform.json_schema_form', App);