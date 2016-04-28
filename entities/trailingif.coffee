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

class TrailingIf

  constructor: (@direction, @condition, @instruction) ->

  toString: ->
    res = "#{@direction} if #{@condition}"
    if @instruction
      res += " else #{@instruction}"
    res

  analyze: (context) ->
    # analyze the initial expression
    @direction.analyze context
    # make sure the condition is valid
    @condition.analyze context
    # if there's an else, analyze the instruction that follows
    if @instruction
      @instruction.analyze context

  optimize: -> this

  

module.exports = TrailingIf