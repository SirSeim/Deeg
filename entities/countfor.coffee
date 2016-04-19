 #  ___________________        ____....-----....____
 # (________________LL_)   ==============================
 #     ______\   \_______.--'.  `---..._____...---'
 #     `-------..__            ` ,/
 #     ___         `-._ -  -  - |
 #    ( /        /     `-------'
 #     / __ (   /_
 #   _/_(_)/_)_/ /_
 #  //
 # (/

class CountFor

  constructor: (@tally)->

  toString: -> 
    "(For count #{@tally})"

  analyze: (context) ->
    @tally.analyze context

  optimize: -> this

module.exports = CountFor