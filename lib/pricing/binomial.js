var Binomial;
Binomial = (function() {
  function Binomial() {}
  Binomial.prototype.calculate = function(type, underlyingPrice, dividend, strike, timeToExpiration, riskFree, volatility, steps) {
    var dt, exercise, i, j, p0, p1, tree, up, _ref, _ref2, _ref3;
    if (steps == null) {
      steps = 2048;
    }
    tree = [];
    tree.length = steps;
    dt = timeToExpiration / steps;
    up = Math.exp(volatility * Math.sqrt(dt));
    p0 = (up * Math.exp(-riskFree * dt) - Math.exp(-dividend * dt)) * up / (Math.pow(up, 2) - 1);
    p1 = Math.exp(-riskFree * dt) - p0;
    for (i = 0, _ref = steps - 1; 0 <= _ref ? i < _ref : i > _ref; 0 <= _ref ? i++ : i--) {
      tree[i] = strike - underlyingPrice * Math.pow(up, 2 * i - steps);
      if (tree[i] < 0) {
        tree[i] = 0;
      }
    }
    for (j = _ref2 = steps - 1; _ref2 <= 0 ? j < 0 : j > 0; _ref2 <= 0 ? j++ : j--) {
      for (i = 0, _ref3 = j - 1; 0 <= _ref3 ? i < _ref3 : i > _ref3; 0 <= _ref3 ? i++ : i--) {
        tree[i] = p0 * tree[i] + p1 * tree[i + 1];
        if (type === "call") {
          exercise = underlyingPrice - strike * Math.pow(up, 2 * i - j);
        } else {
          exercise = strike - underlyingPrice * Math.pow(up, 2 * i - j);
        }
        if (tree[i] < exercise) {
          tree[i] = exercise;
        }
      }
    }
    return tree[0];
  };
  return Binomial;
})();