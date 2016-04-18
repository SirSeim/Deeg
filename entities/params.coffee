Type = require "#{__dirname}/./type.coffee"
error = require "#{__dirname}/../error/error.coffee"

class Params

  constructor: (@paramList) ->

  toString: ->
    "params go here" #disclaimer: this is wrong

  optimize: -> this

  

module.exports = Params