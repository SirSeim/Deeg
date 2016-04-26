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

class ClassDefinition

  constructor: (@id, @body, @parentId) ->

  toString: ->
    res = "(Class #{@id.lexeme}"
    if @parentId
      res += " extends #{@parentId.lexeme}"
    res + ": #{@body})"

  analyze: (context) ->
    @id.analyze context
    @body.analyze context
    if @parentId
      @parentId.analyze context

  optimize: -> this

  

module.exports = ClassDefinition