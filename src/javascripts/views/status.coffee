{fieldset, legend, ul, li, label, input} = React.DOM

Status = React.createClass

  render: ->
    character = @props.character
    fieldset className: "generator-column",
      legend {}, "Points"
      ul {},
        li {},
          label {}, "Sanity points"
          input type: "number", min: -1, max: 99, value: character.get("sanity")
        li {},
          label {}, "Magic points"
          input type: "number", min: -1, max: 37, value: character.get("magic")
        li {},
          label {}, "Hit points"
          input type: "number", min: -3, max: 37, value: character.get("hits")

module.exports = Status
