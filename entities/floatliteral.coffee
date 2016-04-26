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

class FloatLiteral

  constructor: (@value) ->

  toString: -> @value.lexeme

  analyze: (context) ->
    # duh
    @type = Type.FLOAT

  optimize: -> this

  # expression: -> true

module.exports = FloatLiteral