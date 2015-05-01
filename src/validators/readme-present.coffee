fs = require 'fs'

module.exports = (options) ->
  files = fs.readdirSync('.')

  return for file in files when file.indexOf('README') is 0

  "README file not found"
