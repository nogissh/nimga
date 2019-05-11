import math
import random
import ../objects/crossover


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


proc crossover(oldPop: CrossoverPopulationsOld, separators: seq[CrossoverSeparator]): CrossoverPopulationsNew =
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


proc runKPoint*(a, b: seq[int], k: int): CrossoverPopulationsNew =
  ##
  ## k-point crossover
  ##
  var
    points    : seq[int]
    separators: seq[CrossoverSeparator]
    oldPop    : CrossoverPopulationsOld

  points     = getPoints(k, a.len)
  separators = getSeparators(points)
  oldPop     = CrossoverPopulationsOld(a: a, b: b)

  result = crossover(oldPop, separators)
