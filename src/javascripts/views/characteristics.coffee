{div, fieldset, legend, ul, dl, dt, dd, li, label, input, a, span, i} = React.DOM
TextHelper = require("../helpers/text.coffee")

Characteristics = React.createClass

  componentWillMount: ->
    @props.character.on "change", @update

  componentWillUnmount: ->
    @props.character.on "change", @update

  render: ->
    character = @props.character
    options = className: "charasteristic"
    baseStats = ["strength", "dexterity", "intelligence", 
      "constitution", "appearance", "power",
      "size", "education"]
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
        fieldset {},
          ul className: "stat-list",
            baseStats.map (stat) ->
              statValue = character.get(stat)
              className = React.addons.classSet
                "stat": true
                "stat-high": statValue > 12
                "stat-low": statValue < 8
              li key: stat, className: className,
                span className: "stat-name", TextHelper.capitalize(stat)
                span className: "stat-value", statValue
        fieldset {},
          legend {},
            i className: "fa fa-fw fa-calculator"
            "Calculated points"
          ul className: "stat-list",
            calculatedStats.map (stat) ->
              li key: stat, className: "stat",
                span className: "stat-name", TextHelper.capitalize(stat)
                span className: "stat-value", character.get(stat)

  rerollCharasteristics: ->
    # TODO

  update: ->
    @forceUpdate()

module.exports = Characteristics
