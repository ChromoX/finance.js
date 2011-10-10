fs = require 'fs'
util = require 'util'
require 'colors'

{spawn, exec} = require 'child_process'
{basename, join} = require 'path'

# Compile src/*.coffee to lib/*.js 
task 'build', 'Build the server source files', ->
	coffee = spawn 'coffee', ['-cw', '-o', 'lib', 'src']
	coffee.stdout.on 'data', (data) ->
		process.stderr.write data.toString()

	# Output that we're watching for changes after a 2 second delay.
	setTimeout (-> invoke 'output:watching'), 2000

task 'output:watching', 'Let user know we are watching for changes', ->
	util.log 'Watching source directory for changes...'.bold.white
