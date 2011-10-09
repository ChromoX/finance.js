class TimeSeries
	### Time Series needs to have some of the following methods
		Push to disk(Writeable format JSON that saves calculations)
		Load from disk
		Load from JSON
	###
	constructor: ->
		@datasource = {}
		### Idea for Data Sources
			Data sources take whatever data source they are pulling from and 
			will eventually convert it into the standard from of 
			{point:Date()/Number/Anything Sortable, date: Object}
			
			Side-Note: I used the name point in regards to a time point, which I think
			is a generic enough name so that you get the idea that the time point in the 
			series could be a number or date or really anything that could be turned into
			an ordered set
		
			Data Sources are essentially queues acting as a buffer for incoming or parsed data
			
			Data Sources if they are of type "streaming" then they will raise event called data
			every time they have some data to give to someone else, they can have multiple 
			subscribers
			
			Data Sources if they are of type "static" then you can either ask for either end
			of the queue(and that would pop the element off), or you can ask the queue to
			do a playback of its static data (therefore raising events such that you could
			back test easily).
			
			I imagine Data Sources for Stocks Data(Google, Yahoo, IB, Etc...), 
			Options Data(Google, Yahoo, Etc...), Etc...
		###
		@series = []
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
		@calculations = []
		
	### Object must have a date and data object
	
		Ex:
			{ point: Date()
			  data: {} }
	###
	## Appends to the end of the time series
	append: (object) ->
		