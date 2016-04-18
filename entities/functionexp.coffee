Type = require "#{__dirname}/./type.coffee"
error = require "#{__dirname}/../error/error.coffee"

class FunctionExp

  constructor: (@params, @type, @body) ->

  toString: ->
    "go function go" # disclaimer: this is wrong

  # analyze: (context) ->
  #   location = EntityUtils.findLocation @func

  #   @func.analyze context
  #   arg.analyze context for arg in @args

  #   @mustBeFunction location
  #   @mustHaveCorrectNumberOfArgs location


  #   @type = Type.ARBITRARY



  # mustBeFunction: (location) ->
  #   error = "#{@func.type} is not callable"
  #   @func.type.mustBeCompatibleWith [Type.FUNC],
  #                                   error,
  #                                   location

  # mustHaveCorrectNumberOfArgs: (location) ->
  #   params = @func.referent.value.params
  #   error = "#{@func.token.lexeme}() takes exactly
  #            #{params.length} arguments
  #            (#{@args.length} given)"
  #   throw new CustomError error, location unless
  #     (@args.length is params.length)

  optimize: -> this

  

module.exports = FunctionExp