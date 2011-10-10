(function() {
  var BlackScholes, b;
  BlackScholes = (function() {
    function BlackScholes() {}
    BlackScholes.prototype.calculate = function(type, underlyingPrice, strike, timeToExpiration, riskFree, volatility) {
      var d1, d2;
      d1 = (Math.log(underlyingPrice / strike) + (riskFree + volatility * volatility / 2.0) * timeToExpiration) / (volatility * Math.sqrt(timeToExpiration));
      d2 = d1 - volatility * Math.sqrt(timeToExpiration);
      if (type === "c") {
        return underlyingPrice * this.CND(d1) - strike * Math.exp(-riskFree * timeToExpiration) * this.CND(d2);
      } else {
        return strike * Math.exp(-riskFree * timeToExpiration) * this.CND(-d2) - underlyingPrice * this.CND(-d1);
      }
    };
    BlackScholes.prototype.CND = function(x) {
      var a1, a2, a3, a4, a5, k;
      a1 = 0.31938153;
      a2 = -0.356563782;
      a3 = 1.781477937;
      a4 = -1.821255978;
      a5 = 1.330274429;
      if (x < 0.0) {
        return 1 - this.CND(-x);
      } else {
        k = 1.0 / (1.0 + 0.2316419 * x);
        return 1.0 - Math.exp(-x * x / 2.0) / Math.sqrt(2 * Math.PI) * k * (a1 + k * (-0.356563782 + k * (1.781477937 + k * (-1.821255978 + k * 1.330274429))));
      }
    };
    return BlackScholes;
  })();
  b = new BlackScholes;
  console.log(b.calculate("c", 18.00, 17.00, 0.05, 0.5, .21));
}).call(this);
