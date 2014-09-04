{div, fieldset, legend, ul, ol, li, label, input, select, option} = React.DOM

Investigator = React.createClass

  render: ->
    character = @props.character
    div className: "generator-column",
      fieldset {},
        legend {}, "Investigator details"
        ul {},
          li {},
            label {}, "Name"
            input name: "name", value: character.get("name")
          li {},
            label {}, "Sex"
            select name: "sex", defaultValue: character.get("sex"),
              option value: "male", "Male"
              option value: "female", "Female"
              option value: "other", "Other"
          li {},
            label {}, "Age"
            input name: "age", value: character.get("age"), readOnly: true
          li {},
            label {}, "Nationality"
            input name: "nationality", value: character.get("nationality"), readOnly: true
          li {},
            label {}, "Birthplace"
            input name: "birthplace", value: character.get("birthplace"), readOnly: true
          li {},
            label {}, "Colleges and degrees"
            input name: "degrees", value: character.get("degrees"), readOnly: true
          li {},
            label {}, "Mental disorders"
            input name: "disorders", value: character.get("disorders"), readOnly: true
      fieldset {},
        legend {}, "Contacts"
        ol {},
          li {},
            input type: "text"
          li {},
            input type: "text"
          li {},
            input type: "text"

module.exports = Investigator
