import unittest
import typetraits
import random

randomize()


from objects/crossover import CrossoverSeparator
test "Check CrossoverSeparator":
  var obj = CrossoverSeparator()
  check obj.type.name == "CrossoverSeparator"


from objects/crossover import CrossoverPopulationsOld
test "Check `CrossoverPopulationsOld`":
  var obj = CrossoverPopulationsOld()
  check obj.type.name == "CrossoverPopulationsOld"


from objects/crossover import CrossoverPopulationsNew
test "Check `CrossoverPopulationsNew`":
  var obj = CrossoverPopulationsNew()
  check obj.type.name == "CrossoverPopulationsNew"


from crossover/partialMatch import setSplit
test "Set split":
  check setSplit(0, 10) == 10
  check setSplit(5, 10) == 5


from crossover/partialMatch import getCrossoverSeparator
test "Get crossover range":
  for i in 0..<100:
    var sample = getCrossoverSeparator(10)
    check sample.a <= sample.b
    check sample.b != 10


from crossover/partialMatch import exchangeChrom
test "Do exact `exchangeChrom`":
  var
    r1, r2: seq[int]
    pop1  : seq[int] = @[1, 2, 3, 4, 5]
    pop2  : seq[int] = @[3, 2, 4, 1, 5]
  r1 = exchangeChrom(pop1, pop2, 2)
  r2 = exchangeChrom(pop1, pop2, 3)
  check r1 == @[1, 2, 4, 3, 5]
  check r2 == @[4, 2, 3, 1, 5]


from crossover/partialMatch import crossover
test "Do exact `crossover`":
  var
    test1 = @[1, 2, 3, 4, 5]
    test2 = @[3, 2, 4, 1, 5]
  var
    separator = CrossoverSeparator(a: 0, b: 5)
    this      = CrossoverPopulationsOld(a: test1, b: test2)
  var r = crossover(this, separator)
  check r.a == test2
  check r.b == test1


# from crossover/partialMatch import runPartialMatch
# test "Do exact `partialMatch`":
#   var
#     r: CrossoverPopulationsNew
#     test1 = @[1, 2, 3, 4, 5]
#     test2 = @[3, 2, 4, 1, 5]
#   r = runPartialMatch(test1, test2, 0)
#   check r.a != test1
#   check r.b != test2
#   r = runPartialMatch(test1, test2, 1)
#   check r.a == test1
#   check r.b == test2
#   r = runPartialMatch(test1, test2, 4)
#   check r.a != test1
#   check r.b != test2
