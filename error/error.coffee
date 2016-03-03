# Error module
#
#   error = require './error'
#
#   error 'Something happened', {line: 7, col: 22}
#   error 'Illegal start of expression', token
#   error.quiet = true
#   error 'That\'s strange'
#   error 'Type mismatch', {line: 100}
#   console.log error.count

error = (message, location) ->
  if location and location.line
    message += " at line #{location.line}"
    if location.col
      message += ", column #{location.col}"
  { message: message }

module.exports = error