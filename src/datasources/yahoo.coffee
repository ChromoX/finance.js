http = require "http"

class Yahoo extends DataSource
	constructor: (stock, options = {}) ->
		@stock = stock
		@options = options
		super "ohlc+v", "static"
		@load()
		
	load: () ->
		now = new Date
		
		if @options.start?
			start = [@options.start.getMonth(), @options.start.getDate(), @options.start.getFullYear()]
		else
			start = [now.getMonth(), now.getDate(), now.getFullYear()-1]
		
		if @options.end?
			end = [@options.end.getMonth(), @options.end.getDate(), @options.end.getFullYear()]
		else
			end = [now.getMonth(), now.getDate(), now.getFullYear()]
		
		if @options.resolution?
			switch @options.resolution
				when "daily" then resolution = "d"
				when "weekly" then resolution = "w"
				when "monthly" then resolution = "m"
		else
			resolution = "d"

		options = 
			host: "ichart.finance.yahoo.com"
			port: 80
			path: "/table.csv?s=#{@stock}&d=#{end.shift()}&e=#{end.shift()}&f=#{end.shift()}&g=#{resolution}&a=#{start.shift()}&b=#{start.shift()}&c=#{start.shift()}&ignore=.csv"
			
		http.get options, (res) =>
			rawData = []
			if res.statusCode == 200
				res.on "data", (data) ->
					rawData.push data.toString()
				res.on "end", () =>
					@parseCSV rawData.join()
			else
				throw "Yahoo Had an Error: #{res.statusCode}"
	
	parseCSV: (csv) ->
		lines = csv.split("\n")
		lines.shift()
		for line in lines
			if line == "" then continue
			[date, open, high, low, close, volume, adjclose] = line.split(",")
			@buffer.push {date: new Date(date), data: {open: open, high: high, low: low, close: close, volume: volume, adjclose: adjclose}}
		return
	
	printBuffer: () ->
		console.log @buffer
###		
y = new Yahoo "AAPL", {resolution: "weekly"}
setTimeout (->
		console.log "Testing next: "
		console.log y.next()
		y.printBuffer()
	), 500
###