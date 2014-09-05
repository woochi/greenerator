class Character extends Backbone.Model
  defaults:
    sex: "male"

  occupationSkillPoints: ->
    @get("education") * 20

  interestSkillPoints: ->
    @get("intelligence") * 10

  generateName: ->
    $.ajax
      url: "http://api.randomuser.me/?gender=#{@get("sex")}",
      dataType: 'json',
      success: (data) =>
        TextHelper = require("../helpers/text.coffee")
        name = data.results[0].user.name
        @set "name", TextHelper.capitalize([name.first, name.last].join(" "))

module.exports = Character
