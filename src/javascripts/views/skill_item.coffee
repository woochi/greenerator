{li, label, input} = React.DOM

SkillItem = React.createClass

  render: ->
    skill = @props.skill
    li key: skill.id, className: "skill",
      label {},
        skill.get("name")
      input
        type: "number"
        min: skill.get("base")
        max: 99
        value: Math.max(skill.get("base"), skill.get("level"))
        onChange: @setSkillLevel

  setSkillLevel: (event) ->
    @props.skill.allocate event.target.value
    @forceUpdate()

module.exports = SkillItem
