class Calculation
	calculateAsync: (params, callback) ->
		AsyncManager.push params, this, callback

	toJSON: () ->
		json = {}
		for key, val of this
			if key not in ['constructor', 'toJSON']
				json[key] = val + ''
		return json