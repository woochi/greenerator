{div, fieldset, legend, ul, dl, dt, dd, li, label, input, a, span} = React.DOM
TextHelper = require("../helpers/text.coffee")

Characteristics = React.createClass

  render: ->
    character = @props.character
    options = className: "charasteristic"
    baseStats = ["strength", "constitution", "size", "dexterity",
      "appearance", "intelligence", "power", "education"]
    calculatedStats = ["sanity", "idea", "luck", "knowledge"]
    points = ["sanity", "magic", "hits"]
    div className: "generator-column first",
      div className: "column-header",
        ul className: "point-list",
          points.map (pointType) ->
            li className: "point",
              span className: "point-name", TextHelper.capitalize(pointType)
              span className: "point-value", character.get(pointType)
      div className: "column-body",
        ul className: "stat-list",
          baseStats.map (stat) ->
            li key: stat, className: "stat",
              span className: "stat-name", TextHelper.capitalize(stat)
              span className: "stat-value", character.get(stat)
        ul className: "stat-list",
          calculatedStats.map (stat) ->
            li key: stat, className: "stat",
              span className: "stat-name", TextHelper.capitalize(stat)
              span className: "stat-value", character.get(stat)

  rerollCharasteristics: ->
    # TODO

module.exports = Characteristics
