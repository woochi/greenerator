{li, label, input} = React.DOM

SkillItem = React.createClass

  componentDidMount: ->
    @props.skill.on "change:level", @onSkillAllocation
    depends = @props.skill.get("depends")
    if depends
      for characteristic in depends
        @props.character.on "change:#{characteristic}", @onSkillAllocation

  componentWillUnmount: ->
    @props.skill.off "change:level", @onSkillAllocation
    depends = @props.skill.get("depends")
    if depends
      for characteristic in depends
        @props.character.off "change:#{characteristic}", @onSkillAllocation

  render: ->
    skill = @props.skill
    level = skill.get("level")
    base = skill.getBase(@props.character)
    className = React.addons.classSet
      "skill": true
      "allocated": level > base
    li key: skill.id, className: className,
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
    @props.skill.allocate event.target.value, @props.character

  onSkillAllocation: ->
    @forceUpdate()

module.exports = SkillItem
