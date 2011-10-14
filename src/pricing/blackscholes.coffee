class BlackScholes
	constructor: ->
		
	calculate: (type, underlyingPrice, strike, timeToExpiration, riskFree, volatility)->
		d1 = (Math.log(underlyingPrice / strike) + (riskFree + volatility * volatility / 2.0) * timeToExpiration) / (volatility * Math.sqrt(timeToExpiration))
		d2 = d1 - volatility * Math.sqrt(timeToExpiration)
		if type == "c"
			return underlyingPrice * @CND(d1)-strike * Math.exp(-riskFree * timeToExpiration) * @CND(d2);
		else
			return strike * Math.exp(-riskFree * timeToExpiration) * @CND(-d2) - underlyingPrice * @CND(-d1);
			
	CND: (x) ->
		a1 = 0.31938153
		a2 =-0.356563782
		a3 = 1.781477937
		a4= -1.821255978
		a5= 1.330274429;

		if x < 0.0
			return 1-@CND(-x);
		else
			k = 1.0 / (1.0 + 0.2316419 * x);
			return 1.0 - Math.exp(-x * x / 2.0)/ Math.sqrt(2*Math.PI) * k * (a1 + k * (-0.356563782 + k * (1.781477937 + k * (-1.821255978 + k * 1.330274429))))
