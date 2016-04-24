Type = require "#{__dirname}/type.coffee"

class StdForIdExp

  constructor: (@idList, @typeList, @expList) ->

  # value: ->
  #   @name is 'true'

  toString: -> "ids and exps yay" # disclaimer: not correct


  # analyze: (context) ->
  #   @type = Type.BOOL

  # optimize: -> this

module.exports = StdForIdExp