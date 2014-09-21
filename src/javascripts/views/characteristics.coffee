{div, fieldset, legend, ul, dl, dt, dd, li, label, input, a, span, i} = React.DOM
TextHelper = require("../helpers/text.coffee")
Stat = require("./stat.coffee")

dragTargetClass = "drag-over"

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
    calculatedStats = ["sanity", "idea", "luck", "knowledge", "damageBonus"]
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
          legend {},
            i className: "fa fa-fw fa-calculator"
            "Characteristics"
          ul className: "stat-list",
            baseStats.map (stat) =>
              valueOptions =
                className: "stat-value"
                draggable: true
                rel: stat
                onDragStart: @onDragStart
                onDragEnter: @onDragEnter
                onDragLeave: @onDragLeave
                onDragOver: @onDragOver
                onDrop: @onDrop
              statValue = character.get(stat)
              className = React.addons.classSet
                "stat": true
                "stat-high": statValue > 12
                "stat-low": statValue < 8
              li key: stat, className: className,
                span className: "stat-name", TextHelper.capitalize(stat)
                span valueOptions, statValue
        fieldset {},
          ul className: "stat-list-computed",
            calculatedStats.map (stat) ->
              li key: stat, className: "stat",
                span className: "stat-name", TextHelper.capitalize(stat)
                span className: "stat-value-computed", character.get(stat)

  rerollCharasteristics: ->
    # TODO

  update: ->
    @forceUpdate()

  onDragEnter: (event) ->
    $(event.target).addClass(dragTargetClass)
    event.preventDefault()

  onDragLeave: ->
    $(event.target).removeClass(dragTargetClass)

  onDragOver: (event) ->
    event.preventDefault()

  onDrop: (event) ->
    character = @props.character
    stat = event.dataTransfer.getData("stat")
    baseStat = "base#{TextHelper.capitalize(stat)}"
    value = parseInt(event.dataTransfer.getData("value"))
    targetStat = event.target.attributes.rel.value
    targetBaseStat = "base#{TextHelper.capitalize(targetStat)}"
    targetValue = parseInt(event.target.innerHTML)

    if character.has(baseStat)
      stat = baseStat
    if character.has(targetBaseStat)
      targetStat = targetBaseStat

    $(event.target).removeClass(dragTargetClass)

    console.log stat, value, targetStat, targetValue
    character.set stat, targetValue
    character.set targetStat, value
    # TODO: Set character stats, check whether baseStat or normal

  onDragStart: (event) ->
    event.dataTransfer.setData("stat", event.target.attributes.rel.value)
    event.dataTransfer.setData("value", event.target.innerHTML)

module.exports = Characteristics
