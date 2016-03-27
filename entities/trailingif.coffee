Type = require './type.coffee'
error = require '../error/error.coffee'

class TrailingIf

  constructor: (@direction, @condition, @instruction) ->

  toString: ->
    "blank if blank else blank" #disclaimer: this is incorrect

  optimize: -> this

  

module.exports = TrailingIf