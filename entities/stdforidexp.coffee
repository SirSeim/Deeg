Type = require "#{__dirname}/./type.coffee"

class StdForIdExp

  constructor: (@idList, @typeList, @rangeList) ->

  toString: -> 
    res = ""
    for id in @idList
      res += ", "
      res += "(StdFor #{@idList[id]}:#{@typeList[id]} in #{@rangeList[id]})"
    res

  analyze: (context) ->
    # analyze each id in list
    for id in @idList
      @idList[id].analyze context
    # analyze each expression
    for range in @rangeList
      @rangeList[range].analyze context

  # optimize: -> this

module.exports = StdForIdExp