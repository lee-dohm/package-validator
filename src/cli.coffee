fs = require 'fs'
path = require 'path'

class Cli
  constructor: ->
    @exitCode = 0

  getOptions: (name) ->
    options = {}
    options.name = name
    options

  getValidators: ->
    @validators = {}

    for filename in fs.readdirSync(path.join(__dirname, 'validators'))
      name = path.basename(filename, '.coffee')
      @validators[name] = require(path.join(__dirname, 'validators', filename))

  report: (message) ->
    if message
      @exitCode = 1
      console.log(message)

  run: ->
    @getValidators()

    for name, validate of @validators
      options = @getOptions(name)
      @report(validate(options))

    @exitCode

module.exports = Cli
