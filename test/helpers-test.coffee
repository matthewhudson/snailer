vows = require 'vows'
assert = require 'assert'
helpers = require '../src/helpers'

vows
  .describe('Helpers')
  .addBatch
    'getHostname(http://google.com)':
      topic: -> 
        helpers.getHostname 'http://google.com'

      'returns "google.com"': (topic) ->
        assert.equal topic, 'google.com'

    'getHostname(http://blog.github.com)':
      topic: -> 
        helpers.getHostname 'http://blog.github.com'

      'returns "blog.github.com"': (topic) ->
        assert.equal topic, 'blog.github.com'
    

  .export(module)