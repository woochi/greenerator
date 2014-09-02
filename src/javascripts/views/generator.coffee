{div, form, fieldset, legend, label, input, ul, li} = React.DOM

Investigator = require("./investigator.coffee")
Characteristics = require("./characteristics.coffee")
Status = require("./status.coffee")
SkillList = require("./skill_list.coffee")

Generator = React.createClass

  render: ->
    form className: "generator",
      Investigator
        character: @props.character
        occupations: @props.occupations
      Characteristics
        character: @props.character
      Status
        character: @props.character
      SkillList
        character: @props.character
        occupations: @props.occupations
        skills: @props.skills

module.exports = Generator
