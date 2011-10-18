class EMA extends Calculation

	constructor: (@period, @data) ->
		super {type: 'EMA', graphType: 'TimeSeries'},
			@data,
			(graph) -> @graph = graph

	calculate: ->
		# EMA calculation goes here
