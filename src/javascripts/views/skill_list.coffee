{div, fieldset, legend, h5, ul, dl, dt, dd, li, label, input, i} = React.DOM

SkillItem = require("./skill_item.coffee")
PointCounter = require("./point_counter.coffee")

SkillList = React.createClass

  componentDidMount: ->
    @props.character.on "change:occupation", @onOccupationChange

  componentWillUnmount: ->
    @props.character.off "change:occupation", @onOccupationChange

  render: ->
    skillGroups = @props.character.getSkillGroups(@props.occupations, @props.skills)
    occupationSkills = skillGroups[0]
    interestSkills = skillGroups[1]

    div className: "generator-column",
      div className: "column-header",
        PointCounter
          character: @props.character
          occupations: @props.occupations
          skills: @props.skills
      div className: "column-body",
        fieldset {},
          legend {},
            i className: "fa fa-fw fa-briefcase"
            "Occupation skills"
          ul {},
            @renderSkills occupationSkills
        fieldset {},
          legend {},
            i className: "fa fa-fw fa-mortar-board"
            "Interest skills"
          ul {},
            @renderSkills interestSkills

  renderSkills: (skills) ->
    skills.map (skill) ->
      SkillItem(key: skill.id, skill: skill)

  onOccupationChange: (character, occupation) ->
    @forceUpdate()

module.exports = SkillList
