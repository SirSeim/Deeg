Type = require './type.coffee'
error = require '../error/error.coffee'

class BindingList

  constructor: (@bindingList) ->

  toString: ->
    "ta da! binding list" # disclaimer: this is wrongo bongo

  optimize: -> this
  

module.exports = BindingList