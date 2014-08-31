React = require("react")

{div, ul, li, a, i} = React.DOM

AutocompleteOption = React.createClass

  getDefaultProps: ->
    value: "N/A"

  render: ->
    li {},
      a className: "autocomplete-option", onClick: @_onSelect,
        [@props.option.toString()
        i className: "fa fa-plus autocomplete-plus"]

  _onSelect: (e) ->
    console.log "OPTION: ON SELECT"
    @props.onSelect @props.option

Autocompleter = React.createClass

  getDefaultProps: ->
    options: []
    visible: false

  render: ->
    extraClass = if not @props.visible then " hidden" else ""
    div className: "autocompleter#{extraClass}",
      ul className: "autocomplete-options",
        for option in @props.options
          new AutocompleteOption(option: option, onSelect: @props.onSelect)

module.exports = Autocompleter
