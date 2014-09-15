{ol, div, a, img} = React.DOM
OccupationItem = require("./occupation_item.coffee")

OccupationList = React.createClass

  componentDidMount: ->
    @props.character.on "change:occupation", @updateCurrentOccupation

  componentWillUnmount: ->
    @props.character.off "change:occupation", @updateCurrentOccupation

  render: ->
    div className: "occupation-column",
      div className: "occupation-column-header",
        img className: "logo", src: "/images/icon.svg"
      div className: "occupation-column-body",
        ol className: "occupation-list",
          for occupation in @props.occupations.models
            OccupationItem
              key: occupation.id
              character: @props.character
              occupation: occupation

  updateCurrentOccupation: ->
    @forceUpdate()

module.exports = OccupationList
