Skills = require("../collections/skills.coffee")

sumSkillPoints = (sum, skill) ->
  sum + skill.getCurrentAllocation(@)

educationAgeBonus = (baseAge, age) ->
  Math.round((age - baseAge) / 10)

strengthAgeHandicap = (age) ->
  Math.max(0, Math.floor((age - 40) / 10))

calculateEducation = (baseEducation, baseAge, age) ->
  baseEducation + educationAgeBonus(baseAge, age)

class Character extends Backbone.Model
  defaults:
    sex: "male"
  computed:
    strength:
      depends: ["baseStrength", "age"]
      get: (fields) -> fields.baseStrength - strengthAgeHandicap(fields.age)
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

  @generateName: ->
    $.ajax
      url: "http://api.randomuser.me/?gender=#{@get("sex")}",
      dataType: 'json'

  initialize: (attributes, options) ->
    @computedFields = new Backbone.ComputedFields(@)

  generateName: ->
    Character.generateName().done =>
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
