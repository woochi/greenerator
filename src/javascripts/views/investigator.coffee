{div, fieldset, legend, ul, ol, li, label, input, select, option, i, a, span} = React.DOM

Investigator = React.createClass

  componentDidMount: ->
    @props.character.on "change", @onChange
    @props.character.on "change:sex", @generateName

  componentWillUnmount: ->
    @props.character.off "change", @onChange
    @props.character.off "change:sex", @generateName

  render: ->
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
              i className: "fa fa-fw fa-2x fa-#{character.get("sex")}"
              select className: "sex-select", name: "sex", defaultValue: character.get("sex"), onChange: @updateValue,
                option value: "male", "Male"
                option value: "female", "Female"
                option value: "other", "Other"
            li className: "detail",
              label {}, "Age"
              input name: "age", value: character.get("age"), readOnly: true
            li className: "detail",
              label {}, "Nationality"
              input name: "nationality", value: character.get("nationality"), readOnly: true
            li className: "detail",
              label {}, "Birthplace"
              input name: "birthplace", value: character.get("birthplace"), readOnly: true
            li className: "detail",
              label {}, "Colleges and degrees"
              input name: "degrees", value: character.get("degrees"), readOnly: true
            li className: "detail",
              label {}, "Mental disorders"
              input name: "disorders", value: character.get("disorders"), readOnly: true
        fieldset {},
          legend {}, "Contacts"
          ol className: "contact-list",
            [1..3].map (i) ->
              li className: "contact",
                input type: "text"

  generateName: ->
    @props.character.generateName()

  updateValue: (event) ->
    @props.character.set event.target.attributes.name.value, event.target.value

  onChange: ->
    @forceUpdate()

module.exports = Investigator
