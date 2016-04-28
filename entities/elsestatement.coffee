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

class ElseStatement

  constructor: (@body) ->

  toString: () ->
    "(else #{@body})"

  analyze: (context) ->
    # body analysis
    @body.analyze context

  optimize: () ->
    @body = @body.optimize()

module.exports = ElseStatement