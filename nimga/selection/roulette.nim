from math import sum
from random import rand


proc getListWeight*(scores: seq[float]): seq[float] =
  ##
  ## List of weight
  ##

  # sums
  var summed: float = sum(scores)

  result = @[]
  for score in scores:
    result.add(score / summed)


proc getListTot*(weight: seq[float]): seq[float] =
  ##
  ## Create roulette as list
  ##
  result = @[]
  for i in 0..<weight.len:
    result.add(sum(weight[0..i]))


proc selection*(tot: seq[float], r: float): int =
  ##
  ## Return selected index
  ##
  for i in 0..<tot.len:
    if r < tot[i]:
      return i


proc rouletteSelection*(scores: seq[float]): int =
  ##
  ## Roulette selection
  ##

  var
    r   : float
    weight, tot : seq[float]
  
  # Get some parameters
  weight = getListWeight(scores)
  tot    = getListTot(weight)
  r      = rand(1.0)

  # Set index
  result = selection(tot, r)
