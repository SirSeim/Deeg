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

  constructor: (@truthAction, @condition, @elseAction) ->

  toString: ->
    "(TrailingIf #{@truthAction} if
        #{@condition}#{if @elseAction then ' else ' + @elseAction else ''})"

  analyze: (context) ->
    # analyze the initial expression
    @truthAction.analyze context
    # make sure the condition is valid
    @condition.analyze context
    # if there's an else, analyze the instruction that follows
    if @elseAction
      @elseAction.analyze context

  optimize: -> this

  

module.exports = TrailingIf