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
error = require "#{__dirname}/../error/error.coffee"

class VariableExpression

  constructor: (@id, @depth) ->

  toString: -> "#{@id.lexeme}#{exp for exp in @depth}"

  analyze: (context) ->
    # analyze all of the things
    for exp in @depth
      exp.analyze context

  optimize: -> this


module.exports = VariableExpression