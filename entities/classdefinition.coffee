Type = require './type.coffee'
error = require '../error/error.coffee'

class ClassDefinition

  constructor: (@id, @body, @parentId) ->

  toString: ->
    "class goes here" #disclaimer: this is wrong

  optimize: -> this

  

module.exports = ClassDefinition