onmessage = (obj) ->
	obj = obj.data
	calculationObject = JSON.parse obj.calculation, (key, val) ->
		if typeof val == 'string' and val.indexOf 'function' > -1
			return eval("(" + val + ")")
		return val
	obj.args = JSON.parse obj.args
	if obj.data?
		obj.data = JSON.parse obj.data
		answer = calculationObject.calculate obj.data, obj.args...
	else
		answer = calculationObject.calculate obj.args...
	postMessage({id: obj.id, answer: answer})