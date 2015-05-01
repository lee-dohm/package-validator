fs = require 'fs'
path = require 'path'

validatorNames = [
  'readme-present'
  'license-present'
]

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

    for name in validatorNames
      @validators[name] = require(path.join(validatorPath, "#{name}.coffee"))

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
