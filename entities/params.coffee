Type = require "#{__dirname}/./type.coffee"
error = require "#{__dirname}/../error/error.coffee"

class Params

  constructor: (@paramList) ->

  toString: ->
    "(Params #{@paramList.toString()})"

  optimize: -> this

  

module.exports = Params