class Character extends Backbone.Model
  defaults:
    sex: "male"

  occupationSkillPoints: ->
    @get("education") * 20

  interestSkillPoints: ->
    @get("intelligence") * 10

module.exports = Character
