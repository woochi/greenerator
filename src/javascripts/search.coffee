React = require("react")
Tokenist = require("./tokenist.coffee")
Autocompleter = require("./autocompleter.coffee")

{fieldset, form} = React.DOM

Search = React.createClass

  getInitialState: ->
    tokens: []
    options: [
      {toString: -> "Files"}
      {toString: -> "#help"}
      {toString: -> "@Mikko"}
    ]
    autocompleterVisible: false

  render: ->
    tokenist = Tokenist
      tokens: @state.tokens
      onTokenRemove: @onTokenRemove
      onBlur: @onTokenistBlur
      onFocus: @onTokenistFocus
    autocompleter = Autocompleter
      options: @state.options
      onSelect: @onAutocomplete
      visible: @state.autocompleterVisible
    form id: "search-form",
      fieldset {},
        tokenist
        autocompleter

  onTokenistFocus: ->
    console.log "TOKENIST FOCUS"
    @setState autocompleterVisible: true

  onTokenistBlur: ->
    console.log "TOKENIST BLUR"
    _.delay =>
      @setState autocompleterVisible: false
    , 50

  onTokenRemove: (token) ->
    @setState tokens: _.without @state.tokens, token

  onAutocomplete: (option) ->
    @setState tokens: @state.tokens.concat [option]

module.exports = Search
