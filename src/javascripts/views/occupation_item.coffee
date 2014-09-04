{li, span} = React.DOM

OccupationItem = React.createClass

  render: ->
    className = React.addons.classSet
      "occupation": true
      "current": @props.character.get("occupation") is @props.occupation.id
    options =
      className: className
      onClick: @setOccupation
    li options, @props.occupation.get("name")

  setOccupation: ->
    @props.character.set "occupation", @props.occupation.id

module.exports = OccupationItem
