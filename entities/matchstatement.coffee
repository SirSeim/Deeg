Type = require "#{__dirname}/./type.coffee"

class MatchStatement

  constructor: (@matchee, @patBlock)->

  toString: -> "(Match #{@matchee} with #{@patBlock})"

  # analyze: (context) ->
  	
  # optimize: -> this

module.exports = MatchStatement