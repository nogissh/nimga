import math
import random
import ../objects


proc getPoints(k, length: int): seq[int] =
  ##
  ## Get separate point
  ##
  result = @[0]

  for i in 0..<k:
    result.add(rand(result[i]..<length))
  
  result.add(length-1)


proc getSeparators(points: seq[int]): seq[CrossoverSeparator] =
  ##
  ## Return array of CrossoverSeparator
  ##
  result = @[]

  for i in 0..<points.len-1:
    result.add(CrossoverSeparator(a: points[i], b: points[i+1]))


proc crossover(oldPop: CrossoverTargetChrom, separators: seq[CrossoverSeparator]): CrossoveredChrom =
  ##
  ## Crossover
  ##
  var tmpChroms: seq[int]

  result.a = oldPop.a
  result.b = oldPop.b

  for i in 0..<separators.len:
    if (i mod 2) == 1:
      continue # skip job when `i` is odd in k-point crossover, ignores on one-point.
    tmpChroms                                   = result.a[separators[i].a..<separators[i].b]
    result.a[separators[i].a..<separators[i].b] = result.b[separators[i].a..<separators[i].b]
    result.b[separators[i].a..<separators[i].b] = tmpChroms


proc runKPoint*(a, b: seq[int], k: int): CrossoveredChrom =
  ##
  ## k-point crossover
  ##
  var
    points    : seq[int]
    separators: seq[CrossoverSeparator]
    oldPop    : CrossoverTargetChrom

  points     = getPoints(k, a.len)
  separators = getSeparators(points)
  oldPop     = CrossoverTargetChrom(a: a, b: b)

  result = crossover(oldPop, separators)
