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

class CountsFor

  constructor: (@id, @tally)->

  toString: -> "(For #{@id} counts #{@tally})"


  analyze: (context) ->
    @id.analyze context
    @tally.analyze context

  optimize: -> this

module.exports = CountsFor