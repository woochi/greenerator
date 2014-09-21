Skills = require("../collections/skills.coffee")

sumSkillPoints = (sum, skill) ->
  sum + skill.getCurrentAllocation(@)

educationAgeBonus = (baseAge, age) ->
  Math.round((age - baseAge) / 10)

strengthAgeHandicap = (age) ->
  Math.max(0, Math.floor((age - 40) / 10))

calculateEducation = (baseEducation, baseAge, age) ->
  baseEducation + educationAgeBonus(baseAge, age)

calculateStrength = (baseStrength, age) ->
  baseStrength - strengthAgeHandicap(age)

class Character extends Backbone.Model
  defaults:
    sex: "male"
  computed:
    strength:
      depends: ["baseStrength", "age"]
      get: (fields) -> calculateStrength(fields.baseStrength, fields.age)
    education:
      depends: ["baseEducation", "baseAge", "age"]
      get: (fields) -> calculateEducation(fields.baseEducation, fields.baseAge, fields.age)
    sanity:
      depends: ["power"]
      get: (fields) -> 5 * fields.power # 5x pow
    idea:
      depends: ["intelligence"]
      get: (fields) -> 5 * fields.intelligence # 5x int
    luck:
      depends: ["power"]
      get: (fields) -> 5 * fields.power # 5x pow
    knowledge:
      depends: ["baseEducation"]
      get: (fields) -> 5 * fields.baseEducation #5x edu
    magic:
      depends: ["power"]
      get: (fields) -> fields.power # pow
    hits:
      depends: ["constitution", "size"]
      get: (fields) -> Math.ceil((fields.constitution + fields.size) / 2) # (con + size) / 2, rounded up
    occupationSkillPoints:
      depends: ["baseEducation", "baseAge", "age"]
      get: (fields) -> calculateEducation(fields.baseEducation, fields.baseAge, fields.age) * 20
    interestSkillPoints:
      depends: ["intelligence"]
      get: (fields) -> fields.intelligence * 10
    damageBonus:
      depends: ["baseStrength", "age", "size"]
      get: (fields) ->
        sum = calculateStrength(fields.baseStrength, fields.age) + fields.size
        if (sum < 13)
          bonus = "-1D6"
        else if (sum < 17)
          bonus = "-1D4"
        else if sum < 25
          bonus = 0
        else if sum < 33
          bonus = "1D4"
        else if sum < 41
          bonus = "1D6"
        else if sum < 57
          bonus = "2D6"
        else if sum < 73
          bonus = "3D6"
        else
          bonus = "4D6"
        bonus

  @generateName: (character) ->
    $.ajax
      url: "http://api.randomuser.me/?gender=#{character.get("sex")}",
      dataType: 'json'

  initialize: (attributes, options) ->
    @computedFields = new Backbone.ComputedFields(@)

  generateName: ->
    Character.generateName(@).done (data) =>
      TextHelper = require("../helpers/text.coffee")
      name = data.results[0].user.name
      @set "name", TextHelper.capitalize([name.first, name.last].join(" "))

  getSkillGroups: (occupations, skills) ->
    occupation = occupations.get(@get("occupation"))
    occupationsSkillIds = occupation.get("skills")
    occupationSkills = []
    interestSkills = []
    _.partition skills.models, (skill) -> skill.id in occupationsSkillIds

  getAvailableSkillPoints: (occupations, skills) ->
    [occupationSkills, interestSkills] = @getSkillGroups(occupations, skills)
    occupationSkillPoints = occupationSkills.reduce sumSkillPoints.bind(@), 0
    interestSkillPoints = interestSkills.reduce sumSkillPoints.bind(@), 0
    [@get("occupationSkillPoints") - occupationSkillPoints, @get("interestSkillPoints") - interestSkillPoints]

module.exports = Character
