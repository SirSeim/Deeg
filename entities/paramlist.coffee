Type = require "#{__dirname}/./type.coffee"
error = require "#{__dirname}/../error/error.coffee"

class ParamList

  constructor: (@paramList) ->

  toString: ->
    "paramList goes here" #disclaimer: this is wrong

  optimize: -> this

  

module.exports = ParamList