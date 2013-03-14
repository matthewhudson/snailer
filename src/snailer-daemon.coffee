crawler     = require 'crawler'
underscore  = require 'underscore'
helpers     = require './helpers'
Queue       = require('./queue').Queue
Config      = require('./config').Config

class exports.Snailer
  constructor: ->
    @queue = new Queue
    @config = new Config

  run: ->
    self = @

    crawl = new crawler.Crawler
      maxConnections: 10,
      callback: (err, response, $) ->

        # Queue all URLS on this page
        $('a').each (index, a) ->
          console.log a.href
          self.queue.enqueue a.href
          crawl.queue self.queue.peek()

    crawl.queue("http://google.com")     #@config.host

snailer = new exports.Snailer
snailer.run()