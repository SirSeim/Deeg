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

class BooleanLiteral

  constructor: (@token) ->

  value: ->
    @token.lexeme is 'true'

  toString: -> @token.lexeme

  analyze: (context) ->
    # must be a boolean
    @token.lexeme = Type.BOOL

  optimize: -> this

module.exports = BooleanLiteral