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
    'Add a hostname that already exists':
      topic: -> 
        config = new config.Config
        config.addHostname 'http://example.com'

      'returns false': (config) ->
        assert.equal config, false

  .export(module)