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

class EntityUtilities

  @findLocation: (parsedToken) ->
    parsedToken = JSON.parse(JSON.stringify parsedToken)
    for k, v of parsedToken
      if typeof v is 'object'
        return @findLocation v
      else if k is 'line'
        return v

module.exports = EntityUtilities