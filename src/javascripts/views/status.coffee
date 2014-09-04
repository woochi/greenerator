{fieldset, legend, ul, li, label, input} = React.DOM

Status = React.createClass

  render: ->
    character = @props.character
    fieldset className: "generator-column",
      legend {}, "Points"
      ul {},
        li {},
          label {}, "Sanity points"
          input
            type: "number"
            min: -1
            max: 99
            value: character.get("sanity")
            readOnly: true
        li {},
          label {}, "Magic points"
          input
            type: "number"
            min: -1
            max: 37
            value: character.get("magic")
            readOnly: true
        li {},
          label {}, "Hit points"
          input
            type: "number"
            min: -3
            max: 37
            value: character.get("hits")
            readOnly: true

module.exports = Status
