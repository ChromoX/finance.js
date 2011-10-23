class YahooStock extends DataSource

	# Assuming args will/can contain:
		# args.resolution = d/w/m, default to d
		# args.interval = {start: Date, end: Date}, default to something reasonable
	get: (symbol, args = {resolution: 'd', interval: super.defaultInterval}, callback) ->
		url = constructURL symbol, args
		super url, args, (data) ->
			callback parseCSV(data)
	

	constructURL: (symbol, args) ->
			start = args.interval.start; end = args.interval.end; resolution = args.resolution
			url = {
				host: "ichart.finance.yahoo.com",
				port: 80,
				path: "/table.csv?s=#{symbol}&d=#{end.shift()}&e=#{end.shift()}" +
					"&f=#{end.shift()}&g=#{resolution}&a=#{start.shift()}" +
					"&b=#{start.shift()}&c=#{start.shift()}&ignore=.csv"
			}
			return url

	
	parseCSV: (csv) ->
		buffer = []
		lines = csv.split("\n")
		lines.shift()
		for line in lines
			if line == "" then continue
			[date, open, high, low, close, volume, adjclose] = line.split(",")
			buffer.push {
				date: new Date(date),
				data: {
					open: open,
					high: high,
					low: low,
					close: close,
					volume: volume,
					adjclose: adjclose
				}
			}
		return buffer
	
###		
y = new Yahoo "AAPL", {resolution: "weekly"}
setTimeout (->
		console.log "Testing next: "
		console.log y.next()
		y.printBuffer()
	), 500
###
