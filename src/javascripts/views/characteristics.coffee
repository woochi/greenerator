{div, fieldset, legend, ul, dl, dt, dd, li, label, input, a} = React.DOM

Characteristics = React.createClass

  render: ->
    character = @props.character
    div className: "generator-column",
      fieldset {},
        legend {},
          "Charasteristics & rolls - "
          a className: "button", onClick: @rerollCharasteristics, "Re-roll"
        dl {},
          dt {}, "Strength"
          dd {}, character.get("strength")
          dt {}, "Constitution"
          dd {}, character.get("constitution")
          dt {}, "Size"
          dd {}, character.get("size")
          dt {}, "Dexterity"
          dd {}, character.get("dexterity")
          dt {}, "Appearance"
          dd {}, character.get("appearance")
          dt {}, "Sanity"
          dd {}, character.get("sanity")
          dt {}, "Intelligence"
          dd {}, character.get("intelligence")
          dt {}, "Power"
          dd {}, character.get("power")
          dt {}, "Education"
          dd {}, character.get("education")
          dt {}, "Idea"
          dd {}, character.get("idea")
          dt {}, "Luck"
          dd {}, character.get("luck")
          dt {}, "Knowledge"
          dd {}, character.get("knowledge")
      fieldset {},
        legend {}, "Points"
        dl {},
          dt {}, "Sanity points"
          dd {}, character.get("sanity")
          dt {}, "Magic points"
          dd {}, character.get("magic")
          dt {}, "Hit points"
          dd {}, character.get("hits")

  rerollCharasteristics: ->
    # TODO

module.exports = Characteristics
