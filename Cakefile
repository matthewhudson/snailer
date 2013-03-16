{spawn, exec} = require 'child_process'
{series}      = require 'async'

sh = (command) -> (k) ->
  console.log "Executing #{command}"
  exec command, (err, sout, serr) ->
    console.log err if err
    console.log sout if sout
    console.log serr if serr
    do k

task 'docs', 'copy documentation to gh-pages branch', ->
  series [
    (sh "docco src/*.*coffee")
    (sh "docco README.markdown")
    (sh "mv docs/README.html docs/index.html")
    (sh "mv docs docs_tmp")
    (sh "git checkout gh-pages")
    (sh "rm -rf docs")
    (sh "mv docs_tmp docs")
    (sh "git add docs/*")
    (sh "git commit -m 'Updating documentation from master'")
    (sh "git checkout master")
    (sh "git push origin gh-pages")
  ]