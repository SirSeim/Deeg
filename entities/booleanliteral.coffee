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

  constructor: (name) ->
    @name = "#{name}"

  value: ->
    @name is 'true'

  toString: -> @name

  analyze: (context) ->
    @type = Type.BOOL

  optimize: -> this

module.exports = BooleanLiteral