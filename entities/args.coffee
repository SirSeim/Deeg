Type = require './type.coffee'
error = require '../error/error.coffee'

class Args

  constructor: (@expList) ->

  toString: ->
    "args go here" #disclaimer: this is wrong

  optimize: -> this

  

module.exports = Args