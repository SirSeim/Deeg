# not exactly sure what this is used for
# -josh

class EntityUtilities

  @findLocation: (parsedToken) ->
    parsedToken = JSON.parse(JSON.stringify parsedToken)
    for k, v of parsedToken
      if typeof v is 'object'
        return @findLocation v
      else if k is 'line'
        return v

module.exports = EntityUtilities