class Binomial
	constructor: ->
		
	calculate: (type, underlyingPrice, dividend, strike, timeToExpiration, riskFree, volatility, steps=2048) ->
		## From Wikipedia American Put/Call
		tree = []
		tree.length = steps
		
		dt = timeToExpiration / steps
		up = Math.exp(volatility * Math.sqrt(dt))
		
		p0 = (up * Math.exp(-riskFree * dt) - Math.exp(-dividend * dt)) * up / (Math.pow(up, 2) - 1)
		p1 = Math.exp(-riskFree * dt) - p0
		
		for i in [0...steps-1]
			tree[i] = strike - underlyingPrice * Math.pow(up, 2*i - steps)
			if tree[i] < 0 then tree[i] = 0
		
		for j in [steps-1...0]
			for i in [0...j-1]
				tree[i] = p0 * tree[i] + p1 * tree[i+1]
				if type == "call"
					exercise = underlyingPrice - strike * Math.pow(up, (2*i - j))
				else
					exercise = strike - underlyingPrice * Math.pow(up, (2*i - j))
				if tree[i] < exercise then tree[i] = exercise
		return tree[0]
		
b = new Binomial
console.log b.calculate "call", 18.00, 0, 17.00, 0.05, 0.5, 0.21