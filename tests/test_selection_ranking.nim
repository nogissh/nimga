import unittest
from math import sum


from selection/ranking import getListRankingPoint
test "can get certain ranking point array":
  var n: int = 100
  var listRankingPoint: seq[float] = getListRankingPoint(n)
  check listRankingPoint.len == n
  check listRankingPoint[0] == n.toFloat()
  check listRankingPoint[n-1] == 1.0


from selection/ranking import getListWeight
test "can get list of weight":
  var listRankingPoint = getListRankingPoint(100)
  var listWeight = getListWeight(listRankingPoint)
  check listWeight[0] > listWeight[1]
  check listWeight[1] > listWeight[2]
  check listWeight[0] > listWeight[99]


from selection/ranking import getListTot
test "can get list of tot":
  var listRankingPoint = getListRankingPoint(100)
  var listWeight       = getListWeight(listRankingPoint)
  var listTot          = getListTot(listweight)
  check listTot[0] < listTot[1]
  check listTot[1] < listTot[2]
  check listTot[2] < listTot[3]
