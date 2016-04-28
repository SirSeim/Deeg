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

Type = require "#{__dirname}/type.coffee"

class StringLiteral

  constructor: (@value) ->

  toString: -> "(StringLiteral #{@value.lexeme.join(', ')})"

  analyze: (context) ->
    # obviously
    @type = Type.STRING

  length: ->
    @.value.lexeme.length - 2
    
  optimize: ->
    #DEEG

module.exports = StringLiteral