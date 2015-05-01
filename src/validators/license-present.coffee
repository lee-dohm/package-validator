fs = require 'fs'

module.exports = (options) ->
  files = fs.readdirSync('.')

  return for file in files when file.indexOf('LICENSE') is 0

  "LICENSE file not found"
