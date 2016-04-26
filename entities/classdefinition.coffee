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
    res = "Class #{@id}"
    if @parentId
      res += " extends #{@parentId}"
    res + ": #{@body}"

  analyze: (context) ->
    # id analysis
    @id.analyze context
    # body analysis
    @body.analyze context
    # make sure parent class is chill
    if @parentId
      @parentId.analyze context

  optimize: -> this

  

module.exports = ClassDefinition