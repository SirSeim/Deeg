Type = require "#{__dirname}/type.coffee"
error = require "#{__dirname}/../error/error.coffee"

class TrailingIf

  constructor: (@truthAction, @condition, @elseAction) ->

  toString: ->
    "(TrailingIf #{@truthAction} if
        #{@condition}#{if @elseAction then ' else ' + @elseAction else ''})"

  optimize: -> this

  

module.exports = TrailingIf