Type = require "#{__dirname}/type.coffee"

class DeegEntities
  @entities =
    print:
      inDeeg: true
      value:
        params: [value: token: 'str']
        type: Type.FUNC
      type: Type.FUNC
      generateCode: (args) ->
        "console.log( #{args} );"

    # times:
    #   inDeeg: true
    #   value:
    #     params: [
    #       { value: token: Type.FUNC }
    #       { value: token: Type.INT }
    #       { value: token: 'str' }
    #     ]
    #     type: Type.FUNC
    #   type: Type.FUNC
    #   generateCode: (args) ->
    #     numberOfCalls = args[2]
    #     result = ''
    #     i = 0
    #     while i < numberOfCalls
    #       result += "#{args[0]} ("
    #       i++
    #     result += "#{args[1]}"
    #     j = 0
    #     while j < numberOfCalls
    #       result += ' )'
    #       j++
    #     result += ';'

    # sqrt:
    #   inDeeg: true
    #   value:
    #     params: [value: token: 'str']
    #     type: Type.FUNC
    #   type: Type.FUNC
    #   generateCode: (args) ->
    #     "Math.sqrt( #{args} );"


module.exports = DeegEntities