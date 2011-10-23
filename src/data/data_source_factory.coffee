class DataSourceFactory

	# Stores pointers for singletons already created.
	@sources = []

	constructor: () ->
		# Go ahead and initialize defaults for each of the instruments and add to @sources.
		# If a non-default source is requested, we'll create on-demand.

	makeSource: (source = null) ->
		# Check type of 'this' currently and make the appropriate choice.
		# Optional param to pick a non-default source for the given type.
	
	getAvailableSources: () ->
		# Return possible sources at this point in time.
