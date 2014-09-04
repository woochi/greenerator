{div, form, fieldset, legend, label, input, ul, li} = React.DOM

OccupationList = require("./occupation_list.coffee")
Investigator = require("./investigator.coffee")
Characteristics = require("./characteristics.coffee")
Status = require("./status.coffee")
SkillList = require("./skill_list.coffee")

Generator = React.createClass

  render: ->
    form className: "generator",
      OccupationList
        character: @props.character
        occupations: @props.occupations
      Characteristics
        character: @props.character
      SkillList
        character: @props.character
        occupations: @props.occupations
        skills: @props.skills
      Investigator
        character: @props.character

module.exports = Generator
