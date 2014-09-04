{div, fieldset, legend, ul, li, label, input, a} = React.DOM

Characteristics = React.createClass

  render: ->
    character = @props.character
    div className: "generator-column",
      fieldset {},
        legend {},
          "Charasteristics & rolls - "
          a className: "button", onClick: @rerollCharasteristics, "Re-roll"
        ul {},
          li {},
            label {}, "Strength"
            input type: "number", value: character.get("strength")
          li {},
            label {}, "Constitution"
            input type: "number", value: character.get("constitution")
          li {},
            label {}, "Size"
            input type: "number", value: character.get("size")
          li {},
            label {}, "Dexterity"
            input type: "number", value: character.get("dexterity")
          li {},
            label {}, "Appearance"
            input type: "number", value: character.get("appearance")
          li {},
            label {}, "Sanity"
            input type: "number", value: character.get("sanity")
          li {},
            label {}, "Intelligence"
            input type: "number", value: character.get("intelligence")
          li {},
            label {}, "Power"
            input type: "number", value: character.get("power")
          li {},
            label {}, "Education"
            input type: "number", value: character.get("education")
          li {},
            label {}, "Idea"
            input type: "number", min: 0, max: 99, value: character.get("idea")
          li {},
            label {}, "Luck"
            input type: "number", min: 0, max: 99, value: character.get("luck")
          li {},
            label {}, "Knowledge"
            input type: "number", min: 0, max: 99, value: character.get("knowledge")
      fieldset {},
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

  rerollCharasteristics: ->
    # TODO

module.exports = Characteristics
