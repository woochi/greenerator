{li, label, input} = React.DOM

SkillItem = React.createClass

  componentDidMount: ->
    @props.skill.on "change:level", @onSkillAllocation

  componentWillUnmount: ->
    @props.skill.off "change:level", @onSkillAllocation

  render: ->
    skill = @props.skill
    base = skill.getBase(@props.character)
    li key: skill.id, className: "skill",
      label className: "skill-label",
        skill.get("name")
      input
        className: "skill-input"
        type: "number"
        min: base
        max: 99
        value: Math.max(base, skill.get("level"))
        onChange: @allocateSkill

  allocateSkill: (event) ->
    @props.skill.allocate event.target.value

  onSkillAllocation: ->
    @forceUpdate()

module.exports = SkillItem
