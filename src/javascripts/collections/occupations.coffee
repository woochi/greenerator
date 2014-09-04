Occupation = require("../models/occupation.coffee")

class Occupations extends Backbone.Collection
  model: Occupation
  comparator: "name"

module.exports = Occupations
