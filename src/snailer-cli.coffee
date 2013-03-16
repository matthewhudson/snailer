helpers = require './helpers'

usage = ->
  console.log """
    Usage: snail COMMAND [command-specific-options]

    -h -help
    -V -version
    -s -service [start|pause|stop|restart]
    -a -add <hostname> <plugin> <options>
    -u -update <hostname> <plugin> <options>
    -d -delete <hostname> <plugin> 
    -c -config Manage the config info? Get summary/printout
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
