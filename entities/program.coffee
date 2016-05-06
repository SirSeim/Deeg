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

initialContext = require("#{__dirname}/../analyzer/analyzer.coffee").initialContext
HashMap = require('hashmap').HashMap

class Program
  constructor: (@block) ->

  toString: ->
    "(Program #{@block})"

  analyze: (errors) ->
    # get the train moving, blocks have child blocks
    @block.analyze initialContext errors

  optimize: ->
    @block = @block.optimize()
    this

  # showSemanticGraph: ->
  #   tag = 0
  #   seenEntities = new HashMap()

  #   dump = (entity, tag) ->
  #     props = {}
  #     for key, tree of entity
  #       value = rep tree
  #       props[key] = value if value isnt undefined
  #     console.log "%d %s %j", tag, entity.constructor.name, props

  #   rep = (e) ->
  #     if /undefined|function/.test(typeof e)
  #       return undefined
  #     else if /number|string|boolean/.test(typeof e)
  #       return e
  #     else if Array.isArray e
  #       return e.map(rep)
  #     else if e.kind
  #       return e.lexeme
  #     else
  #       if not seenEntities.has e
  #         seenEntities.set e, ++tag
  #         dump e, tag
  #       return seenEntities.get e

  #   dump this, 0

module.exports = Program