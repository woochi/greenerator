{fieldset, legend, ul, li, label, input, select, option} = React.DOM

Investigator = React.createClass

  render: ->
    character = @props.character
    fieldset className: "generator-column",
      legend {}, "Investigator"
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
          input name: "age", value: character.get("age")
        li {},
          label {}, "Nationality"
          input name: "nationality", value: character.get("nationality")
        li {},
          label {}, "Birthplace"
          input name: "birthplace", value: character.get("birthplace")
        li {},
          label {}, "Occupation"
          select name: "occupation", defaultValue: character.get("occupation"), onChange: @changeOccupation,
            for occupation in @props.occupations.models
              option value: occupation.id, occupation.get("name")
        li {},
          label {}, "Colleges and degrees"
          input name: "degrees", value: character.get("degrees")
        li {},
          label {}, "Mental disorders"
          input name: "disorders", value: character.get("disorders")

  changeOccupation: (event) ->
    @props.character.set "occupation", parseInt(event.target.value)

module.exports = Investigator
