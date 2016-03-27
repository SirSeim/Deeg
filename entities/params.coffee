Type = require './type.coffee'
error = require '../error/error.coffee'

class Params

  constructor: (@paramList) ->

  toString: ->
    "params go here" #disclaimer: this is wrong

  optimize: -> this

  

module.exports = Params