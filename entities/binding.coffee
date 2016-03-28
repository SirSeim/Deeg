Type = require './type.coffee'
error = require '../error/error.coffee'

class Binding

  constructor: (@key, @type, @value) ->

  toString: ->
    "key and type and value" # disclaimer: wrong wrong wrong

  optimize: -> this
  

module.exports = Binding