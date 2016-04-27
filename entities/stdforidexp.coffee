Type = require "#{__dirname}/./type.coffee"

class StdForIdExp

  constructor: (@idList, @typeList, @rangeList) ->

  toString: ->
    res = ""
    for id in [0...@idList.length]
      res += ", "
      res += "(StdFor #{@idList[id].lexeme}:#{@typeList[id]} in #{@rangeList[id]})"
    res

  analyze: (context) ->
    # analyze each id in list
    for id in [0...@idList.length]
      @idList[id].analyze context
    # analyze each expression
    for range in @rangeList
      @rangeList[range].analyze context

  # optimize: -> this

module.exports = StdForIdExp