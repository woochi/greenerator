class Skill extends Backbone.Model
  defaults:
    base: 0
    level: 0

  allocate: (level) ->
    return if level < @get("base") or level > 99
    @set "level", level

  getCurrentAllocation: ->
    Math.max(0, @get("level") - @get("base"))

module.exports = Skill
