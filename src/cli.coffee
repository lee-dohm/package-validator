fs = require 'fs'
path = require 'path'

class Cli
  constructor: ->
    @error = null

  buildOptions: (name) ->
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
      @error = 1
      console.log(message)

  run: ->
    @getValidators()

    for name, validate of @validators
      options = @buildOptions(name)
      @report(validate(options))

    @error

module.exports = Cli
