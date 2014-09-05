{div, fieldset, legend, h5, ul, dl, dt, dd, li, label, input, i} = React.DOM

SkillItem = require("./skill_item.coffee")
PointCounter = require("./point_counter.coffee")

SkillList = React.createClass

  componentDidMount: ->
    @props.character.on "change:occupation", @onOccupationChange

  componentWillUnmount: ->
    @props.character.off "change:occupation", @onOccupationChange

  render: ->
    occupationSkills = []
    interestSkills = []
    occupation = @props.occupations.get @props.character.get("occupation")
    @props.skills.each (skill) ->
      if skill.id in occupation.get("skills")
        occupationSkills.push skill
      else
        interestSkills.push skill

    div className: "generator-column",
      div className: "column-header",
        PointCounter
          occupations: @props.occupations
          character: @props.character
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
