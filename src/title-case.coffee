lcWords = 
   # short prepositions
   a: yes
   an: yes
   as: yes
   at: yes
   but: yes
   by: yes
   for: yes
   in: yes
   mid: yes
   "o'": yes
   of: yes
   off: yes
   on: yes
   out: yes
   per: yes
   pro: yes
   qua: yes
   to: yes
   up: yes
   via: yes

   # short articles
   the: yes

   # short Conjunctions
   and: yes
   but: yes
   coz: yes
   cum: yes
   cus: yes
   cuz: yes
   dat: yes
   "'n": yes
   "'n'": yes
   "n'": yes
   nay: yes
   nd: yes
   nor: yes
   not: yes
   now: yes
   or: yes
   so: yes
   tho: yes
   thy: yes
   til: yes
   xor: yes
   yet: yes
   zat: yes

   # capitalize how, if, why
   # how: yes
   # if: yes
   # why: yes

titleCase = module.exports = (string, options = {}) ->

   return '' unless string?

   leadingSpace = trailingSpace = ""

   arr = string
      .replace(/^\s+/, (match) -> leadingSpace = match; '')
      .replace(/\s+$/, (match) -> trailingSpace = match; '')
      .split /([-–\/]|[”’'"\)\]\}]*\s+[“‘'"\(\[\{]*)/

   last = arr.length - 1
   words = for word, ii in arr when word.length > 0
      if ii%2 # every other item in arr is white space
         word

      else

         iPhone = /^[a-z][A-Z][a-z]+/.test word
         word_lc = if /^[A-Z]+[a-z]+/.test word
            word # don't lowercase words that begin with a series of UC letters followed by LC
         else
            word.toLowerCase()

         capitalize = switch

            when ii is 0 
               yes # always capitalize first word, even iPhone if it begins a sentence

            when iPhone
               no # leave alone proper nouns that begin with lower-case (iPhone, eBay)

            when ii is last, word.length > 3
               yes # always capitalize last word and long words

            when lcWords[word_lc]
               no # don't capitalize certain short prepositions, articles, and conjunctions

            else 
               yes # capitalize all else

         switch
            when iPhone and capitalize
               # word.replace /\w/, (letter) -> letter.toUpperCase()
               word[0].toUpperCase() + word[1..]

            when capitalize
               word[0].toUpperCase() + word_lc[1..]

            when iPhone
               word
               
            else
               word_lc # short words

   "#{leadingSpace}#{words.join('')}#{trailingSpace}"

titleCase.pollute = ->
   Object.defineProperty String::, 'toTitleCase', value: (options) -> titleCase this, options

if require.main is module
   exec = require('child_process').exec
   exec 'cake build', (error, stdout, stderr) -> 
      console.log {error, stdout, stderr}
      require '../test/test'
   console.log titleCase "signaling ‘soft’ client (monkey)"

