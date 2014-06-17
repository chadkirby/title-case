assert = require 'assert'
titleCase = require '../lib/title-case'

titles = [
   str: "don't fence me in"
   title: "Don't Fence Me In"
,
   str: 'walk with me in moonlight'
   title: "Walk With Me in Moonlight"
,
   str: "turn off the lights, I'm home" # fails
   title: "Turn Off the Lights, I'm Home" # phrasal verb, we don't account for
,
   str: "what if I do, WHAT IF SHE WON'T"
   title: "What If I Do, What If She Won't"
,
   str: "the least she could do is cry"
   title: 'The Least She Could Do Is Cry'
,
   str: "sales of iPod soar"
   title: "Sales of iPod Soar"
,
   str: "sales soar of iPods"
   title: "Sales Soar of iPods"
,
   str: "iPod sales soar"
   title: "IPod Sales Soar"
,
   str: "The big spender's budget how-to"
   title: "The Big Spender's Budget How-To"
,
   str: "author of how-to book on bee-keeping prone to illness"
   title: "Author of How-to Book on Bee-Keeping Prone to Illness"
,
   str: "GOVERNOR SLAMS E-BOOK ABOUT HER RE-ELECTION CAMPAIGN"
   title: "Governor Slams E-Book About Her Re-Election Campaign"
,
   str: "profits double on word-of-mouth sales"
   title: "Profits Double on Word-of-Mouth Sales"
,
   str: "audiences love his man-about-town sophistication"
   title: "Audiences Love His Man-About-Town Sophistication"
,
   str: 'open your own eBay-based Boutique'
   title: 'Open Your Own eBay-Based Boutique'
]

alter = (str, fn) -> str.replace /\w+/g, (match) ->
   if /^[a-z][A-Z][a-z]/.test(match)
      match
   else
      match[fn]()

for {str, title} in titles
   # console.log """
   # * titleCase("#{str}") == "#{titleCase(str)}"
   # """
   try
      assert.equal titleCase(str), title
      assert.equal titleCase(alter str, 'toLowerCase'), title
      assert.equal titleCase(alter str, 'toUpperCase'), title
   catch e
      {actual, expected} = e
      ii = -1
      wrongIndices = (ii while expected[++ii]? when actual[ii] isnt expected[ii])
      for ii in wrongIndices by -1
         actual = """
         #{actual[0...ii]}*#{actual[ii]}*#{actual[1+ii..]}
         """
      console.log """
      "#{actual}" should be "#{expected}"
      """

titleCase.pollute()
assert.equal 'open your own eBay-based Boutique'.toTitleCase(), 'Open Your Own eBay-Based Boutique'
