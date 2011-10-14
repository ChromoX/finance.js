class TimeSeries
	### Time Series needs to have some of the following methods
		Push to disk(Writeable format JSON that saves calculations)
		Load from disk
		Load from JSON
	###
	constructor: ->
		@series = []
		@datasource = {}
		@calculations = []
		### Idea for calculations...
			Allow calculation objects to be attached to a time series
			such that the current calculation at that current point gets
			looped into the return data
			
			Calculations can have 2 modes
				* Calculations that will be calculated for each point
					* Ex. 20 day moving average, DI+/DI-, ADX, Etc...
				* Calculations that will be calculated for the entire series
					* Ex. stdDev, variance, mean, mode, median, etc...
			
			Once you have initalized a TimeSeries with a Data Input Source the time series
			should on demand calculate the required calculations for a TimeSeries whenever
			prompted to and should also cache the calculations as to not do them over and over
			
			Ex. 
				Our Series:
					[Date(), {close: Number, volume: Number}]
					
				After adding a calculation:
					[Date(), {close: Number, volume: Number, 20daymovingavg: Number}]
		###
	sort: (key) ->
		@series.sort (a, b) ->
				if a["data"][key] < b["data"][key]
					return -1
				else if a["data"][key] > b["data"][key]
					return 1
				else
					return 0
					
	length: () -> return @series.length	
	range: () -> return @series.length
	domain: () -> return @series.length
	
	attach: (obj) ->
		if obj.type == "ohlc+v"
			@datasource = obj
			## Data Source
			obj.on "data", (data) ->
				@process(data)
			if obj.mode == "static"
				obj.playback 0
				
	process: (obj) ->
		if obj.date? and obj.data?
			@series.push obj
	
	get: (obj) ->
		if typeof obj == "number"
			return @series[obj]
		if typeof obj == "array"
			if obj.length == 2
				return @series[obj[0]...obj[1]]
			else
				return (num for num in obj)
		if typeof obj == "object"
			return
			#Two Queries, start and end date
	
	
	
	
	
	
	
	
	
	