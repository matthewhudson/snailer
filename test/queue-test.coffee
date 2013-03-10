vows = require 'vows'
assert = require 'assert'
queue = require '../src/queue'

vows
  .describe('Queue')
  .addBatch
    'A Queue':
      topic: -> 
        new queue.Queue
      
      'when we do q.length':
        topic: (q) -> 
          q.length()
        
        'returns queue.length === 0': (topic) ->
          assert.equal topic, 0

      'when we enqueue an item':
        topic: (q) -> 
          q.enqueue('apple')
          q.length()

        'we get queue.length === 1': (topic) ->
          assert.equal topic, 1

      'when we enqueue an array of items':
        topic: (q) -> 
          q.enqueue(['banana', 'strawberry'])
          q.length()

        'we get queue.length === 3': (topic) ->
          assert.equal topic, 3

      'when we get the first item':
        topic: (q) -> 
          q.peek()

        'we get "apple"': (topic) ->
          assert.equal topic, 'apple'

      'when we dequeue an item':
        topic: (q) -> 
          q.dequeue()
          q.length()

        'we get queue.length === 2': (topic) ->
          assert.equal topic, 2

      'when we get the first item after removing an item':
        topic: (q) -> 
          q.peek()

        'we get "banana"': (topic) ->
          assert.equal topic, 'banana'

  .export(module)