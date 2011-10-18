class Calculation

	constructor: (meta, data, callback) ->
		switch meta.graphType
			when 'OptionSpread' then callback(new OptionSpread(data))
			else callback(new TimeSeries(data))
	
	calculateAsync: (params, callback) ->
		AsyncManager.push params, this, callback
