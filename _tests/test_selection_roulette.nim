import unittest
import math


proc getArrayForTestFloat(): seq[float] =
  result = @[0.1, 0.2, 0.3, 0.4, 0.5]


from selection/roulette import getListWeight
test "can get list of weight":
  var scores: seq[float] = getArrayForTestFloat()
  var weight: seq[float] = getListWeight(scores)
  check weight.len == scores.len
  for i in 0..<weight.len:
    check weight[i] == scores[i] / sum(scores)


from selection/roulette import getListTot
test "can get list of tot":
  var scores: seq[float] = getArrayForTestFloat()
  var weight: seq[float] = getListWeight(scores)
  var tot: seq[float]    = getListTot(weight)
  check weight.len == tot.len
  for i in 0..<tot.len:
    check tot[i] == sum(weight[0..i])


from selection/roulette import selection
test "can get certain index":
  var tot = getArrayForTestFloat()
  check selection(tot, 0.15) == 1
  check selection(tot, 0.45) == 4
