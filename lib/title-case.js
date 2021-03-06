// Generated by CoffeeScript 1.7.1
var exec, lcWords, titleCase;

lcWords = {
  a: true,
  an: true,
  as: true,
  at: true,
  but: true,
  by: true,
  "for": true,
  "in": true,
  mid: true,
  "o'": true,
  of: true,
  off: true,
  on: true,
  out: true,
  per: true,
  pro: true,
  qua: true,
  to: true,
  up: true,
  via: true,
  the: true,
  and: true,
  but: true,
  coz: true,
  cum: true,
  cus: true,
  cuz: true,
  dat: true,
  "'n": true,
  "'n'": true,
  "n'": true,
  nay: true,
  nd: true,
  nor: true,
  not: true,
  now: true,
  or: true,
  so: true,
  tho: true,
  thy: true,
  til: true,
  xor: true,
  yet: true,
  zat: true
};

titleCase = module.exports = function(string, options) {
  var arr, capitalize, iPhone, ii, last, leadingSpace, trailingSpace, word, word_lc, words;
  if (options == null) {
    options = {};
  }
  if (string == null) {
    return '';
  }
  leadingSpace = trailingSpace = "";
  arr = string.replace(/^\s+/, function(match) {
    leadingSpace = match;
    return '';
  }).replace(/\s+$/, function(match) {
    trailingSpace = match;
    return '';
  }).split(/(\b\w[-–]\w\b|[-–\/]|[”’'"\)\]\}]*\s+[“‘'"\(\[\{]*)/);
  last = arr.length - 1;
  ii = -1;
  words = (function() {
    var _i, _len, _results;
    _results = [];
    for (_i = 0, _len = arr.length; _i < _len; _i++) {
      word = arr[_i];
      if (!(word.length > 0)) {
        continue;
      }
      ii++;
      if (ii % 2) {
        _results.push(word);
      } else {
        iPhone = /^[a-z][A-Z][a-z]+/.test(word);
        word_lc = /^[A-Z]+[a-z]+/.test(word) ? word : word.toLowerCase();
        capitalize = (function() {
          switch (false) {
            case ii !== 0:
              return true;
            case !iPhone:
              return false;
            case ii !== last:
            case !(word.length > 3):
              return true;
            case !lcWords[word_lc]:
              return false;
            default:
              return true;
          }
        })();
        switch (false) {
          case !/\b\w[-–]\w\b/.test(word):
            _results.push(word.toUpperCase());
            break;
          case !(iPhone && capitalize):
            _results.push(word[0].toUpperCase() + word.slice(1));
            break;
          case !capitalize:
            _results.push(word[0].toUpperCase() + word_lc.slice(1));
            break;
          case !iPhone:
            _results.push(word);
            break;
          default:
            _results.push(word_lc);
        }
      }
    }
    return _results;
  })();
  return "" + leadingSpace + (words.join('')) + trailingSpace;
};

titleCase.pollute = function() {
  return Object.defineProperty(String.prototype, 'toTitleCase', {
    value: function(options) {
      return titleCase(this, options);
    }
  });
};

if (require.main === module) {
  exec = require('child_process').exec;
  exec('cake build', function(error, stdout, stderr) {
    console.log({
      error: error,
      stdout: stdout,
      stderr: stderr
    });
    return require('../test/test');
  });
  console.log(titleCase("signaling ‘soft’ client (monkey)"));
  console.log(titleCase("Askee Devices a–c"));
}
