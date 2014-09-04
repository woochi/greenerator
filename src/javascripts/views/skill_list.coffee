{div, fieldset, legend, h5, ul, dl, dt, dd, li, label, input} = React.DOM

SkillItem = require("./skill_item.coffee")

SkillList = React.createClass

  componentDidMount: ->
    @props.character.on "change:occupation", @onOccupationChange
    @props.skills.on "change:level", @onSkillAllocation

  componentWillUnmount: ->
    @props.character.off "change:occupation", @onOccupationChange
    @props.skills.off "change:level", @onSkillAllocation

  render: ->
    remainingOccupationPoints = @props.character.occupationSkillPoints()
    remainingInterestPoints = @props.character.interestSkillPoints()
    occupationSkills = []
    interestSkills = []
    occupation = @props.occupations.get @props.character.get("occupation")
    @props.skills.each (skill) ->
      if skill.id in occupation.get("skills")
        occupationSkills.push skill
        remainingOccupationPoints -= skill.getCurrentAllocation() 
      else
        interestSkills.push skill
        remainingInterestPoints -= skill.getCurrentAllocation()

    div className: "generator-column",
      fieldset {},
        legend {}, "Investigator skills"
        dl {},
          dt {}, "Occupation skill points"
          dd {}, remainingOccupationPoints
          dt {}, "Interest skill points"
          dd {}, remainingInterestPoints
        h5 {}, "Occupation skills"
        ul {},
          @renderSkills occupationSkills
        h5 {}, "Interest skills"
        ul {},
          @renderSkills interestSkills

  renderSkills: (skills) ->
    skills.map (skill) ->
      SkillItem(key: skill.id, skill: skill)

  onOccupationChange: (character, occupation) ->
    @forceUpdate()

  onSkillAllocation: ->
    @forceUpdate()

module.exports = SkillList
