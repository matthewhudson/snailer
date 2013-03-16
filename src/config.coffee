# The `Config` class is responsible for managing the `~/.snailer` JSON 
# configuration file. This configuration maintains all the settings configured 
# via the `snailer` CLI. The Snailer daemon uses `Config` to read settings.

# External dependencies.
fs      = require 'fs'
path    = require 'path'
_       = require 'underscore'
helpers = require './helpers'

class exports.Config

  constructor: ->
    platform = if process.platform is 'win32' then 'USERPROFILE' else 'HOME'
    @file = path.join process.env[platform], '.snailer'
    @open()

  # Return contents of ~/.snail or return an empty object {}
  open: ->
    @config = JSON.parse try fs.readFileSync @file, 'utf-8' catch err then '{}'
    @save()

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

  addHostname: (hostname) ->
    hostname = helpers.getHostname hostname

    if @config.hasOwnProperty hostname
      false
    else
      @config[hostname] = []

    @save()
    @config[hostname]

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

      @save()
      @config[hostname]

  getPlugin: (hostname, plugin_name) ->
    hostname = helpers.getHostname hostname
    plugins = @getHostname hostname

    if not plugins or not plugin_name
      false
    else 
      plugin = _.findWhere plugins, { name : plugin_name }

      if not _.size plugin
        false
      else
        plugin

  updatePlugin: (hostname, plugin_name, opts) ->
    self = @
    hostname = helpers.getHostname hostname
    index = false
    plugins = @getHostname hostname

    if not plugins or not plugin_name
      false
    else 
      if not @getPlugin hostname, plugin_name
        false
      else 
        _.each plugins, (element, idx, list) -> 
          if element.name is plugin_name
            index = idx

        if index is false
          false
        else 
          _.each opts, (val, key) ->
            self.config[hostname][index]['opts'][key] = val

          @save()
          @config[hostname]

  deletePlugin: (hostname, plugin_name) ->
    self = @
    hostname = helpers.getHostname hostname
    index = false
    plugins = @getHostname hostname

    if not plugins or not plugin_name
      false
    else 
      if not @getPlugin hostname, plugin_name
        false
      else 
        _.each plugins, (element, idx, list) -> 
          if element.name is plugin_name
            index = idx

        if index is false
          false
        else 
          @config[hostname].splice index, 1
          @save()
          @config[hostname]

