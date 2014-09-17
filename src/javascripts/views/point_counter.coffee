{dl, dt, dd, div, ul, li} = React.DOM

PointCounter = React.createClass

  componentDidMount: ->
    @props.character.on "change:occupationSkillPoints", @onPointAllocation
    @props.character.on "change:interestSkillPoints", @onPointAllocation
    @props.skills.on "change:level", @onPointAllocation

  componentWillUnmount: ->
    @props.character.off "change:occupationSkillPoints", @onPointAllocation
    @props.character.off "change:interestSkillPoints", @onPointAllocation
    @props.skills.off "change:level", @onPointAllocation

  render: ->
    skillPoints = @props.character.getAvailableSkillPoints(@props.occupations, @props.skills)
    occupationPoints = skillPoints[0]
    interestPoints = skillPoints[1]

    ul className: "counter-list",
      li className: "counter",
        div className: "counter-name", "Occupation points"
        div className: "counter-value", occupationPoints
      li className: "counter",
        div className: "counter-name", "Interest points"
        div className: "counter-value", interestPoints

  onPointAllocation: ->
    @forceUpdate()

module.exports = PointCounter
