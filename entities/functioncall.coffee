 #  ___________________        ____....-----....____
 # (________________LL_)   ==============================
 #     ______\   \_______.--'.  `---..._____...---'
 #     `-------..__            ` ,/
 #     ___         `-._ -  -  - |
 #    ( /        /     `-------'
 #     / __ (   /_
 #   _/_(_)/_)_/ /_
 #  //
 # (/

Type = require "#{__dirname}/type.coffee"
error = require "#{__dirname}/../error/error.coffee"

class FunctionCall

  constructor: (@name, @params) ->

  toString: ->
    "(FunctionCall #{@name} params:#{@params})"

  analyze: (context) ->
    location = EntityUtils.findLocation @name
    # analyze id
    @name.analyze context
    # analyze each argument
    for arg in @params
      arg.analyze context

    # variable should refer to a function
    @mustBeFunction location
    # must have the correct number of args provided
    @mustHaveCorrectNumberOfArgs location
    @type = Type.UNKNOWN # shrug

  mustBeFunction: (location) ->
    error = "#{@name.type} is not callable"
    @name.type.mustBeCompatibleWith [Type.FUNCTION],
                                    error,
                                    location

  mustHaveCorrectNumberOfArgs: (location) ->
    args = @name.referent.value.params
    msg = "#{@name.token.lexeme}() takes exactly
             #{args.length} arguments
             (#{@params.length} given)"
    error msg, location unless (@params.length is args.length)

  optimize: -> this

  

module.exports = FunctionCall