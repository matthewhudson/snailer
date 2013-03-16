{spawn, exec} = require 'child_process'

task 'doc:source', 'rebuild the internal documentation', ->
  exec 'docco src/*.*coffee', (err) ->
    throw err if err
    exec 'git checkout gh-pages', (err) ->
      throw err if err
      exec 'git add docs/*', (err) ->
        throw err if err
        exec 'git commit -m "Updating docs"', (err) ->
          throw err if err