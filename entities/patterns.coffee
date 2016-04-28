Type = require "#{__dirname}/./type.coffee"

class Patterns

  constructor: (@head, @tails)->

  toString: -> "(Patterns
    #{@head}#{if @tails then' | '+tail for tail in @tails else ''})"


  analyze: (context) ->
  	@head.analyze context
  	for tail in @tails 
  		tail.analyze context
  	
  	
  # optimize: -> this

module.exports = Patterns
