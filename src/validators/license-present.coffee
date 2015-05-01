fs = require 'fs'

module.exports = (options) ->
  files = fs.readdirSync('.')

  return for file in files when file.match(/^LICENSE/)

  "LICENSE file not found"
