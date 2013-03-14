fs      = require 'fs'
path    = require 'path'
_       = require 'underscore'
helpers = require './helpers'

class exports.Config

  constructor: ->
    platform = if process.platform is 'win32' then 'USERPROFILE' else 'HOME'
    @file = path.join process.env[platform], '.snail'
    @open()
    @config

  # Return contents of ~/.snail or return an empty object {}
  open: ->
    @config = JSON.parse try fs.readFileSync @file, 'utf-8' catch err then '{}'
    @save()
    @config

  # Returns false on fail, or the file contents
  save: ->
    err = fs.writeFileSync @file, JSON.stringify(@config, null, 2)
    if err
      false
    @config

  # Erase & reset the config
  reset: ->
    @config = {}
    @save()
    @config

  addHostname: (hostname) ->
    hostname = helpers.getHostname hostname

    if @config.hasOwnProperty hostname
      false
    else
      @config[hostname] = []

  getHostname: (hostname) ->
    hostname = helpers.getHostname hostname

    if not @config.hasOwnProperty hostname
      false
    else
      @config[hostname]

  deleteHostname: (hostname) ->
    hostname = helpers.getHostname hostname

    delete @config[hostname]

  addPlugin: (hostname, plugin_name, opts) ->
    hostname = helpers.getHostname hostname

    if not _.size opts 
      opts = {}

    if @getPlugin hostname, plugin_name
      false
    else
      @config[hostname].push 
        name: plugin_name
        opts: opts

      @config[hostname]

  getPlugin: (hostname, plugin_name) ->
    hostname = helpers.getHostname hostname
    plugins = @getHostname hostname

    if not plugins or not plugin_name
      false
    else 
      plugin = _.where plugins, { name : plugin_name }

      if not plugin.length
        false
      else
        plugin[0]

  updatePlugin: (hostname, plugin_name, opts) ->
    hostname = helpers.getHostname hostname

    if not @getHostname hostname or not plugin_name
      false
    else 
      if not @getPlugin hostname, plugin_name
        false
      else 
        _.each opts, (val, key) ->
          @config[hostname][plugin]['opts'][key] = val

