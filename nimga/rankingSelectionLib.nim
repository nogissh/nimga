import math, random


proc getListRankingPoint(length: int): seq[float] =
  ##
  ## Create list of Ranking point
  ##
  result = @[]
  for n in countdown(length, 1):
    result.add(n.toFloat())


proc getListWeight(listRankingPoint: seq[float]): seq[float] =
  ##
  ## List of weight
  ##
  var summed: float = sum(listRankingPoint)

  result = @[]
  for point in listRankingPoint:
    result.add(point / summed)


proc getListTot(weight: seq[float]): seq[float] =
  ##
  ## Normalize ranking point
  ##
  result = @[]
  for i in 0..<weight.len:
    result.add(sum(weight[0..i]))


proc selection(tot: seq[float], r: float): int =
  ##
  ## Return selected index
  ##
  for i in 0..<tot.len:
    if r < tot[i]:
      return i


proc runRankingSelection*(popLength: int): int =
  ##
  ## Ranking selection
  ##
  var
    r: float
    listRankingPoint, weight, tot: seq[float]
  
  listRankingPoint = getListRankingPoint(popLength)
  weight           = getListWeight(listRankingPoint)
  tot              = getListTot(weight)
  r                = rand(1.0)

  result = selection(tot, r)
