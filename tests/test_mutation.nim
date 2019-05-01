import unittest
import system
import math
import mutation
import objects/basic
import random


randomize()


proc getSampleGenes(n=10): seq[Gene] =
  result = @[]
  for i in 0..<n:
    result.add(Gene(chrom: @[1,2,3,4,5,6,7,8,9], score: 0.1))


test "Randomize `willMutation`":
  var tmp: seq[int] = @[]
  for i in 0..<1000:
    if willMutate() == true:
      tmp.add(1)
    else:
      tmp.add(0)
  var summed = sum(tmp)
  check summed < 120


test "Can be `runMutation`":
  var n = 10
  var sampleGenes = getSampleGenes(n)
  var sampleGenesInput = getSampleGenes(n)
  var mutated     = runMutation(sampleGenesInput)
  var checked: seq[int] = @[]
  for i in 0..<n:
    if mutated[i].chrom == sampleGenes[i].chrom:
      checked.add(0)
    else:
      checked.add(1)
  check sum(checked) == 1
