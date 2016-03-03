error = require '../error/error.coffee'

cache = {}

class Type

  constructor: (@name) ->
    cache[@name] = this

  @BOOL = new Type 'bool'
  @INT = new Type 'int'
  @FLOAT = new Type 'float'
  @STRING = new Type 'string'
  @LIST = new Type 'List'
  @DICT = new Type 'Dict'
  @FUNCTION = new Type 'Function'
  @ARBITRARY = new Type '<arbitrary_type>'

  toString: -> @name

  mustBeNumeric: (message, location) ->
    @mustBeCompatibleWith [Type.INT, Type.FLOAT], message, location

  mustBeInteger: (message, location) ->
    @mustBeCompatibleWith Type.INT, message, location

  mustBeBoolean: (message, location) ->
    @mustBeCompatibleWith Type.BOOL, message, location

  mustBeString: (message, location) ->
    @mustBeCompatibleWith Type.STRING, message, location

  mustBeCompatibleWith: (otherType, message, location) ->
    error(message, location) if not @isCompatibleWith(otherType)

  mustBeMutuallyCompatibleWith: (otherType, message, location) ->
    if not (@isCompatibleWith otherType or otherType.isCompatibleWith(this))
      error(message, location)

  isCompatibleWith: (otherType) ->
    # In more sophisticated languages, comapatibility would be more complex
    return this is otherType or this is Type.ARBITRARY or otherType is Type.ARBITRARY

module.exports =
  BOOL: Type.BOOL
  INT: Type.INT
  ARBITRARY: Type.ARBITRARY
  forName: (name) -> cache[name]