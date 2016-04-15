BooleanLiteral = require "#{__dirname}/./booleanliteral.coffee"

class ForStatement

  constructor: (@forIterate, @body) ->

  toString: () ->
    "(For #{@forIterate} then #{@body})" # disclaimer: probably not correct

  # analyze: (context) ->


  # optimize: () ->


module.exports = ForStatement