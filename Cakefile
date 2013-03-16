{spawn, exec} = require 'child_process'

task 'doc:source', 'rebuild the internal documentation', ->
  exec 'docco src/*.*coffee', (err) ->
    throw err if err