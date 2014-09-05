{dl, dt, dd, div, ul, li} = React.DOM

PointCounter = React.createClass

  getInitialState: ->
    occupationPoints: @props.character.occupationSkillPoints()
    interestPoints: @props.character.interestSkillPoints()

  componentDidMount: ->
    @props.skills.on "change:level", @onPointAllocation

  componentWillUnmount: ->
    @props.skills.off "change:level", @onPointAllocation

  render: ->
    ul className: "counter-list",
      li className: "counter",
        div className: "counter-name", "Occupation points"
        div className: "counter-value", @state.occupationPoints
      li className: "counter",
        div className: "counter-name", "Interest points"
        div className: "counter-value", @state.interestPoints

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
