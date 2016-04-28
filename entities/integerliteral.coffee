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

Type = require "#{__dirname}/./type.coffee"

class IntegerLiteral

  constructor: (@value) ->

  toString: -> @value.lexeme

  analyze: (context) ->
    # obviously
    @type = Type.INT

  optimize: -> this

module.exports = IntegerLiteral