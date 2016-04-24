Type = require "#{__dirname}/./type.coffee"
error = require "#{__dirname}/../error/error.coffee"

class ParamList

  constructor: (@paramList) ->

  toString: ->
    "(#{paramitem for paramitem in @paramList})"

  optimize: -> this

  

module.exports = ParamList