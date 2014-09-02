{fieldset, legend, ul, li, label, input} = React.DOM

Characteristics = React.createClass

  render: ->
    character = @props.character
    fieldset className: "generator-column",
      legend {}, "Charasteristics & rolls"
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

module.exports = Characteristics
