vows = require 'vows'
assert = require 'assert'
helpers = require '../src/helpers'

vows
  .describe('Helpers')
  .addBatch
    'getHostname(http://example.com)':
      topic: -> 
        helpers.getHostname 'http://example.com'

      'returns "example.com"': (topic) ->
        assert.equal topic, 'example.com'

    'getHostname(http://www.example.com)':
      topic: -> 
        helpers.getHostname 'http://www.example.com'

      'returns "example.com"': (topic) ->
        assert.equal topic, 'example.com'

    'getHostname(http://blog.example.com)':
      topic: -> 
        helpers.getHostname 'http://blog.example.com'

      'returns "blog.example.com"': (topic) ->
        assert.equal topic, 'blog.example.com'
    

  .export(module)