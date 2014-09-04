{dl, dt, dd} = React.DOM

PointCounter = React.createClass

  getInitialState: ->
    occupationPoints: @props.character.occupationSkillPoints()
    interestPoints: @props.character.interestSkillPoints()

  componentDidMount: ->
    @props.skills.on "change:level", @onPointAllocation

  componentWillUnmount: ->
    @props.skills.off "change:level", @onPointAllocation

  render: ->
    dl {},
      dt {}, "Occupation skill points"
      dd {}, @state.occupationPoints
      dt {}, "Interest skill points"
      dd {}, @state.interestPoints

  onPointAllocation: (skill) ->
    previous = Math.max(skill.get("base"), skill.previous("level"))
    current = skill.get("level")
    diff = current - previous
    occupation = @props.character.get("occupation")
    occupationSkills = @props.occupations.get(occupation).get("skills")

    if skill.id in occupationSkills
      currentPoints = @state["occupationPoints"]
      state = occupationPoints: currentPoints - diff
    else
      currentPoints = @state["interestPoints"]
      state = interestPoints: currentPoints - diff

    return unless currentPoints > 0
    @setState state

module.exports = PointCounter
