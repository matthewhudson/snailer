# should move pre-existing readme on start, and back into place when done

vows    = require 'vows'
assert  = require 'assert'
_       = require 'underscore'
config  = require '../src/config'

vows
  .describe('Config')

  .addBatch
    'Reset Config': 
      topic: -> 
        new config.Config
      
      'when we do c.reset()':
        topic: (config) -> 
          config.reset()
        
        'returns an object': (config) ->
          assert.equal _.isObject(config), true

  .addBatch
    'Create a new Config':
      topic: -> 
        new config.Config

      'and we do c.getHostname(http://example.com)':
        topic: (config) -> 
          config.getHostname 'http://example.com'
        
        'returns false': (config) ->
            assert.equal config, false

        'and we do c.addHostname(http://example.com)':
          topic: (file, config) -> 
            config.addHostname 'http://example.com'
          
          'returns an array': (config) ->
            assert.equal _.isArray(config), true

          'returns an empty list of plugins': (config) ->
            assert.equal _.size(config), 0

          'and then access it using c.getHostname(http://example.com)':
              topic: (host, file, config) -> 
                config.getHostname 'http://example.com'
              
              'returns an array': (config) ->
                assert.equal _.isArray(config), true

              'returns an empty list of plugins': (config) ->
                assert.equal _.size(config), 0

  .addBatch
    'Add a plugin':
      topic: -> 
        new config.Config
      
      'when we do c.addPlugin(spell-check)':
        topic: (config) -> 
          config.addHostname 'http://example.com'
          config.addPlugin 'http://example.com', 'spell-check', {}
        
        'returns an array of plugins': (plugins) ->
          assert.equal _.isArray(plugins), true

        'returns an empty array of plugins': (plugins) ->
          assert.equal _.size(plugins), 1

        'when we do c.getPlugin(spell-check)':
          topic: (plugin, config) -> 
            config.getPlugin 'http://example.com', 'spell-check'

          'plugins contains the "spell-check" plugin': (plugin) ->
            assert.equal plugin.name, 'spell-check'

          'the "spell-check" plugin has options': (plugin) ->
            assert.equal plugin.hasOwnProperty('opts'), true

          'the "spell-check" plugin options is an object': (plugin) ->
            assert.equal _.isObject(plugin.opts), true

.addBatch
    'Save a Config to filesystem':
      topic: -> 
        new config.Config
      
      'when we do c.save()':
        topic: (config) -> 
          config.addHostname 'http://example.com'
          config.save()
        
        'returns an object': (config) ->
          assert.equal _.isObject(config), true

        'returns a single hostname': (config) ->
          assert.equal _.size(config), 1

        'hostname points to an array of plugins': (config) ->
          assert.equal _.isArray(config['example.com']), true

  .addBatch
    'Add a plugin that already exists':
      topic: -> 
        new config.Config
      
      'when we call addPlugin() twice with same args':
        topic: (config) -> 
          config.addPlugin 'http://example.com', 'spell-check'
          config.addPlugin 'http://example.com', 'spell-check'
        
        'returns false': (plugin) ->
          assert.equal plugin, false

  .addBatch
    'Add a hostname that already exists':
      topic: -> 
        new config.Config

      'calling addHostname(http://etc.com)':
        topic: (config) -> 
          config.addHostname 'http://etc.com'

        'returns an empty list of plugins': (plugins) ->
          assert.equal plugins.length, 0

        'calling addHostname(http://etc.com)':
          topic: (plugins, config) -> 
            config.addHostname 'http://etc.com'

          'returns false': (config) ->
            assert.equal config, false

  .addBatch
    'Update a plugin':
      topic: -> 
        new config.Config
      
      'when we call addPlugin() and then updatePlugin()':
        topic: (config) -> 
          config.addHostname 'http://eg.com'
          config.addPlugin 'http://eg.com', 'grammar-check', {}
          config.updatePlugin 'http://eg.com', 'grammar-check', { hello : 'world' }
        
        'returns a list of plugins': (plugins) ->
          assert.equal _.isArray(plugins), true

        'returns a list with a single plugin': (plugins) ->
          assert.equal plugins.length, 1

        'plugin.name is "grammer-check"': (plugins) ->
          assert.equal plugins[0].name, "grammar-check"

        'plugin.opts has key "hello"': (plugins) ->
          assert.equal plugins[0].opts.hasOwnProperty('hello'), true
  .addBatch
    'Delete a plugin':
      topic: -> 
        new config.Config
      
      'when we call addPlugin() and then deletePlugin()':
        topic: (config) -> 
          config.addHostname 'http://ie.com'
          config.addPlugin 'http://ie.com', 'grammar-check', {}
          config.deletePlugin 'http://ie.com', 'grammar-check'
        
        'returns a list of plugins': (plugins) ->
          assert.equal _.isArray(plugins), true

        'returns a list with a no plugins': (plugins) ->
          assert.equal plugins.length, 0

  .export(module)