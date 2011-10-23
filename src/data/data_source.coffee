EventEmitter = require "events"
EventEmitter = EventEmitter.EventEmitter

class DataSource extends EventEmitter
	#constructor: (type="unknown", mode="unknown") ->
		 #Front of Buffer is newest
		#@buffer = []
		#@mode = mode
		#@type = type

	@defaultInterval = {
		now: new Date,
		start: [now.getMonth(), now.getDate(), now.getFullYear()-1],
		end: [now.getMonth(), now.getDate(), now.getFullYear()]
	}

	# Handles HTTP request / response for grabbing data.
	# Needs to be able to swith between Node / XMLHttpRequest
	# Assume url has: {host: val, port: val, path: val}
	get: (url, args, callback) ->
		# Check if Node is available.
		# Do the appropriate choice.
		# Upon success, callback(data) 
		
	#http.get url, (res) =>
		#rawData = []
		#if res.statusCode == 200
			#res.on "data", (data) ->
				#rawData.push data.toString()
			#res.on "end", () =>
				#@parseCSV rawData.join()
		#else
			#throw "Yahoo Had an Error: #{res.statusCode}"
		
	#next: () ->
		#return @buffer.pop()
	
	#pause: () ->
		#throw "Pause method not implemented in this Data Source"
	
	#playback: (delay = 5) ->
		#process = require "process"
		#if delay < 5
			#process.nextTick ->
				#@emit("data", @buffer.pop())
		#else
			#setTimeout (-> @emit("data", @buffer.pop())), delay
	
	#stop: () ->
		#throw "Stop method not implmented in this Data Source"
