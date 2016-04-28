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

class ReturnStatement

  constructor: (@value) ->

  toString: ->
    "(deeg #{@value})"

  analyze: (context) ->
    # analyze what is being returned
    @value.analyze context

  optimize: -> this

module.exports = ReturnStatement