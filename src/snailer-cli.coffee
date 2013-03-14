helpers = require './helpers'

usage = ->
  console.log """
    Usage: snail COMMAND [command-specific-options]

      snail addplugin NAME ARGS
      snail updateplugin NAME ARGS
      snail help

  """
  process.exit 1


exports.run = ->
  args = process.argv[2..]
  usage() if args.length < 1
  action = args.shift()
  if actions[action]
    actions[action] args
  else
    usage()

actions =

  addplugin: (args) ->
    usage() if args.length isnt 2
    console.log 'addplugin', args

  updateplugin: (args) ->
    usage() if args.length isnt 2
    console.log 'updateplugin', args

  help: (args) ->
    usage() if args.length is 0
    console.log 'help', args
