var Yahoo, http, y;
var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
  for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
  function ctor() { this.constructor = child; }
  ctor.prototype = parent.prototype;
  child.prototype = new ctor;
  child.__super__ = parent.prototype;
  return child;
}, __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
http = require("http");
Yahoo = (function() {
  __extends(Yahoo, DataSource);
  function Yahoo(stock, options) {
    if (options == null) {
      options = {};
    }
    this.stock = stock;
    this.options = options;
    Yahoo.__super__.constructor.call(this, "ohlc+v", "static");
    this.load();
  }
  Yahoo.prototype.load = function() {
    var end, now, options, resolution, start;
    now = new Date;
    if (this.options.start != null) {
      start = [this.options.start.getMonth(), this.options.start.getDate(), this.options.start.getFullYear()];
    } else {
      start = [now.getMonth(), now.getDate(), now.getFullYear() - 1];
    }
    if (this.options.end != null) {
      end = [this.options.end.getMonth(), this.options.end.getDate(), this.options.end.getFullYear()];
    } else {
      end = [now.getMonth(), now.getDate(), now.getFullYear()];
    }
    if (this.options.resolution != null) {
      switch (this.options.resolution) {
        case "daily":
          resolution = "d";
          break;
        case "weekly":
          resolution = "w";
          break;
        case "monthly":
          resolution = "m";
      }
    } else {
      resolution = "d";
    }
    options = {
      host: "ichart.finance.yahoo.com",
      port: 80,
      path: "/table.csv?s=" + this.stock + "&d=" + (end.shift()) + "&e=" + (end.shift()) + "&f=" + (end.shift()) + "&g=" + resolution + "&a=" + (start.shift()) + "&b=" + (start.shift()) + "&c=" + (start.shift()) + "&ignore=.csv"
    };
    return http.get(options, __bind(function(res) {
      var rawData;
      rawData = [];
      if (res.statusCode === 200) {
        res.on("data", function(data) {
          return rawData.push(data.toString());
        });
        return res.on("end", __bind(function() {
          return this.parseCSV(rawData.join());
        }, this));
      } else {
        throw "Yahoo Had an Error: " + res.statusCode;
      }
    }, this));
  };
  Yahoo.prototype.parseCSV = function(csv) {
    var adjclose, close, date, high, line, lines, low, open, volume, _i, _len, _ref;
    lines = csv.split("\n");
    lines.unshift();
    for (_i = 0, _len = lines.length; _i < _len; _i++) {
      line = lines[_i];
      if (line === "") {
        continue;
      }
      _ref = line.split(","), date = _ref[0], open = _ref[1], high = _ref[2], low = _ref[3], close = _ref[4], volume = _ref[5], adjclose = _ref[6];
      this.buffer.push({
        date: new Date(date),
        data: {
          open: open,
          high: high,
          low: low,
          close: close,
          volume: volume,
          adjclose: adjclose
        }
      });
    }
  };
  Yahoo.prototype.printBuffer = function() {
    return console.log(this.buffer);
  };
  return Yahoo;
})();
y = new Yahoo("AAPL", {
  resolution: "weekly"
});
setTimeout((function() {
  return y.printBuffer();
}), 500);