{ol} = React.DOM
OccupationItem = require("./occupation_item.coffee")

OccupationList = React.createClass

  componentDidMount: ->
    @props.character.on "change:occupation", @updateCurrentOccupation

  componentWillUnmount: ->
    @props.character.off "change:occupation", @updateCurrentOccupation

  render: ->
    ol className: "occupation-list",
      for occupation in @props.occupations.models
        OccupationItem
          key: occupation.id
          character: @props.character
          occupation: occupation

  updateCurrentOccupation: ->
    @forceUpdate()

module.exports = OccupationList
