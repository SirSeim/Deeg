Type = require "#{__dirname}/type.coffee"
error = require "#{__dirname}../error/error.coffee"

class TrailingIf

  constructor: (@direction, @condition, @instruction) ->

  toString: ->
    "blank if blank else blank" #disclaimer: this is incorrect

  optimize: -> this

  

module.exports = TrailingIf