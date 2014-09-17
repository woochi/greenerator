{div, fieldset, legend, ul, ol, li, label, input, select, option, i, a, span} = React.DOM

Investigator = React.createClass

  componentDidMount: ->
    @props.character.on "change", @onChange
    @props.character.on "change:sex", @generateName

  componentWillUnmount: ->
    @props.character.off "change", @onChange
    @props.character.off "change:sex", @generateName

  render: ->
    Character = require("../models/character.coffee")
    character = @props.character
    div className: "generator-column",
      div className: "column-header",
        fieldset {},
          ul {},
            li {},
              label className: "header-label",
                "Investigator name | "
                a onClick: @generateName,
                  i className: "fa fa-random"
                  " Recommend"
              input
                type: "text"
                className: "header-field longer"
                name: "name"
                placeholder: "E.g. John Greene"
                value: character.get("name")
                onChange: @updateValue
      div className: "column-body",
        fieldset {},
          legend {}, "Investigator details"
          ul {},
            li className: "detail",
              ul className: "auto-fill-list",
                li className: "right",
                  input
                    className: "age-field"
                    type: "number"
                    name: "age"
                    min: character.get("baseAge")
                    defaultValue: character.get("age")
                    onChange: @updateValue
                li {},
                  select className: "sex-select longer", name: "sex", defaultValue: character.get("sex"), onChange: @updateValue,
                    option value: "male", "Male"
                    option value: "female", "Female"
            li className: "detail",
              input className: "longer", type: "text", name: "nationality", placeholder: "Nationality"
            li className: "detail",
              input className: "longer", type: "text", name: "birthplace", placeholder: "Birthplace"
            li className: "detail",
              input className: "longer", type: "text", name: "degrees", placeholder: "Colleges & degrees"
        fieldset {},
          legend {}, "Contacts"
          ol className: "contact-list",
            [1..3].map (i) ->
              li className: "contact",
                input className: "longer", type: "text", name: "contact", placeholder: "#{i}. Contact"

  generateName: ->
    @props.character.generateName()

  updateValue: (event) ->
    @props.character.set event.target.attributes.name.value, event.target.value

  onChange: ->
    @forceUpdate()

module.exports = Investigator
