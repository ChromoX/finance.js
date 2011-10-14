EventEmitter = require "events"
EventEmitter = EventEmitter.EventEmitter

class DataSource extends EventEmitter
	constructor: (type="unknown", mode="unknown") ->
		# Front of Buffer is newest
		@buffer = []
		@mode = mode
		@type = type
		
	next: () ->
		return @buffer.pop()
	
	pause: () ->
		throw "Pause method not implemented in this Data Source"
	
	# Delay is the delay in miliseconds before raising another event
	playback: (delay = 5) ->
		process = require "process"
		if delay < 5
			process.nextTick ->
				@emit("data", @buffer.pop())
		else
			setTimeout (-> @emit("data", @buffer.pop())), delay
	
	close: () ->
		throw "Close method not implmented in this Data Source"