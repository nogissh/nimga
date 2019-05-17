import random
import ../objects


proc setSplit*(initialSplit, popLength: int): int =
  ##
  ## Set `split`
  ##
  if initialSplit == 0:
    result = popLength
  else:
    result = initialSplit


proc getCrossoverSeparator*(split: int): CrossoverSeparator =
  ##
  ## Return separate point twice
  ##
  result.a = rand(0..<split)
  result.b = rand(result.a..<split)


proc exchangeChrom*(this, another: seq[int], target: int): seq[int] =
  ##
  ## Exchange chrome on crossover
  ##

  result = this

  var anotherIndex, tmpChrom: int

  anotherIndex         = find(this, another[target])
  tmpChrom             = result[anotherIndex]
  result[anotherIndex] = result[target]
  result[target]       = tmpChrom


proc crossover*(oldPop: CrossoverTargetChrom, separator: CrossoverSeparator): CrossoveredChrom =
  ##
  ## Crossover
  ##

  var againstIdx, tmpChrom: int

  result.a = oldPop.a
  result.b = oldPop.b

  for i in separator.a..<separator.b:
    result.a = exchangeChrom(result.a, oldPop.b, i)
    result.b = exchangeChrom(result.b, oldPop.a, i)


proc runPartialMatch*(a, b: seq[int], initialSplit: int): CrossoveredChrom =
  ##
  ## Partial Match
  ##

  var
    split    : int
    separator: CrossoverSeparator
    oldPop   : CrossoverTargetChrom

  split     = setSplit(initialSplit, a.len)
  separator = getCrossoverSeparator(split)
  oldPop    = CrossoverTargetChrom(a: a, b: b)

  result = crossover(oldPop, separator)
