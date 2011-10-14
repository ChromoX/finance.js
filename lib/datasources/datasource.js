var DataSource;
var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
  for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
  function ctor() { this.constructor = child; }
  ctor.prototype = parent.prototype;
  child.prototype = new ctor;
  child.__super__ = parent.prototype;
  return child;
};
require("process");
DataSource = (function() {
  __extends(DataSource, EventEmitter);
  function DataSource(type, mode) {
    if (type == null) {
      type = "unknown";
    }
    if (mode == null) {
      mode = "unknown";
    }
    this.buffer = [];
    this.mode = mode;
    this.type = type;
  }
  DataSource.prototype.next = function() {
    return this.buffer.pop();
  };
  DataSource.prototype.pause = function() {
    throw "Pause method not implemented in this Data Source";
  };
  DataSource.prototype.playback = function(delay) {
    if (delay == null) {
      delay = 5;
    }
    if (delay < 5) {
      return process.nextTick(function() {
        return this.emit("data", this.buffer.pop());
      });
    } else {
      return setTimeout((function() {
        return this.emit("data", this.buffer.pop());
      }), delay);
    }
  };
  DataSource.prototype.close = function() {
    throw "Close method not implmented in this Data Source";
  };
  return DataSource;
})();