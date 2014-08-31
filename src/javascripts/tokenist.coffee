React = require("react")
_ = require("underscore")
{div, a, span, i} = React.DOM

Token = React.createClass

  getDefaultProps: ->
    token:
      toString: -> "N/A"

  render: ->
    div key: @props.key, className: "tokenist-token", onClick: @_onClick,
      [@props.token.toString(),
      a(className: "token-remove", onClick: @_onRemove,
        span className: "fa fa-times")]

  _onClick: (e) ->
    @props.onClick @

  _onRemove: (e) ->
    @props.onRemove @props.token

Tokenist = React.createClass

  getDefaultProps: ->
    tokens: []

  getInitialState: ->
    tokens: @props.tokens
    caretPosition: @props.tokens.length

  render: ->
    options =
      className: "tokenist"
      onKeyPress: @_onKeyPress
      onKeyDown: @_onKeyDown
      onFocus: @_onFocus
      onBlur: @_onBlur
      contentEditable: true
    div options,
      for token, i in @props.tokens
        options =
          token: token
          key: token
          ref: i
          onClick: @_moveCaretToToken
          onRemove: @_removeToken
        [new Token(options)
        span className: "tokenist-space", '\u0020']

  _onKeyDown: (e) ->
    isCharacter = switch e.which
      when LEFT_ARROW then @_moveCaret(-1)
      when RIGHT_ARROW then @_moveCaret(1)
      when BACKSPACE then @_removeToken(e) # TODO: get token before caret
      when DELETE then @_removeToken(e)
      when ESC then @_blur(e)
      else true
    e.preventDefault() unless isCharacter
    @props.onKeyPress? e

  _onKeyPress: (e) ->
    console.log "PRESS", e.which, DELETE
    switch e.which
      when SPACEBAR then e.preventDefault()
    @props.onKeyPress? e

  _removeToken: (token) ->
    console.log "REMOVE TOKEN", token
    @props.onTokenRemove token

  _onBlur: (e) ->
    console.log "DEFERRING BLUR"
    _.defer => @props.onBlur? e

  _onFocus: (e) ->
    console.log "ON FOCUS", @refs
    if @props.tokens.length
      @_moveCaretToToken @refs[@state.caretPosition]
    @props.onFocus? e

  _moveCaret: (direction) ->
    requestedPosition = @state.caretPosition + direction
    newPosition = Math.max 0, Math.min(@state.tokens.length - 1, requestedPosition)
    @setState caretPosition: newPosition
    if selection = window.getSelection()
      followingSpace = @refs[newPosition].getDOMNode().nextSibling
      console.log followingSpace
      selection.collapse followingSpace, 1
    else if selection = document.selection
      if sel.type not "Control"
        range = selection.createRange()
        range.move "character", 4 * direction
        range.select()

  _moveCaretToToken: (token) ->
    # TODO: move caret to after token element
    console.log "MOVE CARET TO", token, token.getDOMNode().nextSibling

module.exports = Tokenist

SPACEBAR = 32
ENTER = 13
BACKSPACE = 8
TAB = 9
DELETE = 46
LEFT_ARROW = 37
UP_ARROW = 38
RIGHT_ARROW = 39
DOWN_ARROW = 40
PAGEDOWN = 33
PAGEUP = 34
HOME = 35
END = 36
ESC = 27
COMMA = 188
NBSP = 8194 # en space
