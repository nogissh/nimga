import unittest
import random
import objects/crossover
import crossover/kPoint

randomize()

var
  k: int
  r: CrossoverPopulationsNew

var
  testDataA = @[1, 2, 3, 4, 5, 6, 7, 8, 9]
  testDataB = @[0, 0, 0, 0, 0, 0, 0, 0, 0]

test "Can do one-point crossover":
  k = 1
  r = runKPoint(testDataA, testDataB, k)
  check r.a != testDataA
  check r.b != testDataB

test "Can do two-point crossover":
  k = 2
  r = runKPoint(testDataA, testDataB, k)
  check r.a != testDataA
  check r.b != testDataB

test "Can do k-point crossover":
  k = 5
  r = runKPoint(testDataA, testDataB, k)
  check r.a != testDataA
  check r.b != testDataB
