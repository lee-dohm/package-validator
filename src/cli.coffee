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
    validatorPath = path.join(__dirname, 'validators')
    @validators = {}

    for filename in fs.readdirSync(validatorPath)
      name = path.basename(filename, '.coffee')
      @validators[name] = require(path.join(validatorPath, filename))

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
