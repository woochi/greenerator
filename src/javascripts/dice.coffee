Dice =

  roll: (dice) ->
    match = /^(\d+)?d(\d+)([+-]\d+)?$/.exec(dice)
    throw "Invalid dice notation: " + dice unless match

    howMany = (if (typeof match[1] is "undefined") then 1 else parseInt(match[1]))
    dieSize = parseInt(match[2])
    modifier = (if (typeof match[3] is "undefined") then 0 else parseInt(match[3]))

    total = 0 #Total starts as 0
    i = 0 #Loop a number of times equal to the number of dice

    while i < howMany
      total += Math.floor(Math.random() * dieSize) + 1 #Random number between 1 and diesize
      i++
    total += modifier #Add the modifier
    total #Return the final total

module.exports = Dice
