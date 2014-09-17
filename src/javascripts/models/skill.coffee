class Skill extends Backbone.Model
  defaults:
    base: 0
    level: 0

  allocate: (level, character) ->
    return if level < @getBase(character) or level > 99
    @set "level", level

  getCurrentAllocation: (character) ->
    Math.max(0, @get("level") - @getBase(character))

  getBase: (character) ->
    if _.isFunction(@get("base")) then @get("base")(character) else @get("base")

module.exports = Skill
