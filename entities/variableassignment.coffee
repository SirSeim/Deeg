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

class VariableAssignment

  constructor: (@id, @value, @modifier) ->

  toString: ->
    "(VarAssign #{@id}
        #{if @modifier then 'modifier:'+@modifier+' ' else ''}= value:#{@value})"

  analyzer: (context) ->
    # check if there's a modifier or value, then analyze
    if @modifier
      @modifier.analyze context
    if @value
      @value.analyze context

  optimize: -> this

  

module.exports = VariableAssignment