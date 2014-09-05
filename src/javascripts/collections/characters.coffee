Character = require("../models/character.coffee")
Dice = require("../dice.coffee")

class Characters extends Backbone.Collection
  model: Character

  @generateRandom: ->
    strength = Dice.roll("3d6")
    constitution = Dice.roll("3d6")
    size = Dice.roll("2d6+6")
    appearance = Dice.roll("3d6")
    dexterity = Dice.roll("3d6")
    intelligence = Dice.roll("2d6+6")
    power = Dice.roll("3d6")
    education = Dice.roll("3d6+3")

    new Character
      sex: "male"
      age: education + 6 # min: edu + 6, +1 edu for each +10 years, -1 STR/CON/DEX/APP for +10 years after 40 years
      nationality: "Jamaican"
      birthplace: "Jamaica Town"
      occupation: 0
      degrees: null
      disorders: null
      strength: strength # 3d6
      constitution: constitution # 3d6
      size: size # 2d6 + 6
      dexterity: dexterity # 3d6
      appearance: appearance # 3d6
      sanity: 5 * power # 5x pow
      intelligence: intelligence # 2d6 + 6
      power: power # 3d6
      education: education # 3d6 + 3
      idea: 5 * intelligence # 5x int
      luck: 5 * power # 5x pow
      knowledge: 5 * education #5x edu
      magic: power # pow
      hits: Math.ceil((constitution + size) / 2) # (con + size) / 2, rounded up

    # Occupation skill points: EDU x 20
    # Personal interest points: INT x 10 (can't raise cthulhu mythos)

module.exports = Characters
