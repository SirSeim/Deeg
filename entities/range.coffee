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

class Range
  constructor: (@op, @left, @right, @skip) ->

  toString: ->
    "(#{@left} #{@op.lexeme} #{@right} by #{@skip or 1})"

  analyze: (context) ->
    # analyze left and right expressions
    @left.analyze context
    @right.analyze context
    # if increment value is specified, analyze it!
    if @skip
      @skip.analyze context
    # this boils down to a list
    @type = Type.LIST
    # make sure it's the form int thru/till int
    @mustHaveIntegerOperands()

  mustHaveIntegerOperands: ->
    error = 'thru and till range operators must have integer operands'
    @left.type.mustBeInteger(error, @op.lineNumber)
    @right.type.mustBeInteger(error, @op.lineNumber)
    if @skip
      @skip.type.mustBeInteger(error, @op.lineNumber)

  length: ->
    lower_bound = +@left.lexeme.value
    upper_bound = if @op.lexeme is 'thru' then +@right.lexeme.value 
    else +@right.lexeme.value - 1

    skip = if @skip then +@skip else 1
    console.log 'lower_bound is ' + lower_bound + 
    ' upper_bound is ' + upper_bound + ' skip is ' + skip

    console.log Math.floor (upper_bound - lower_bound + 1) / skip

    Math.floor (upper_bound - lower_bound + 1) / skip

  optimize: ->
    @length()


module.exports = Range