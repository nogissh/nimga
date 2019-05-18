import random
import types, objects


proc integerStandard*(popRange, chromRange, chromMax: int): Population =
  ##
  ## Create population
  ##
  result = @[]

  var newIndividual: Individual

  for i in 0..<popRange:
    newIndividual = Individual(chrom: @[], score: 0.0)
    for j in 0..<chromRange:
      newIndividual.chrom.add(rand(chromMax))
    result.add(newIndividual)


proc integerUnique*(popRange, chromRange: int): Population =
  ##
  ## Create population
  ## chrom is unique, non-deplicated.
  ##
  result = @[]

  var 
    tmpArray: seq[int]
    newIndividual : Individual

  tmpArray = @[]
  for n in 0..<chromRange:
    tmpArray.add(n)

  for i in 0..<popRange:
    shuffle(tmpArray)
    newIndividual = Individual(chrom: tmpArray, score: 0.0)
    result.add(newIndividual)


proc binaryStandard*(popRange, chromRange: int): Population =
  ##
  ## Create population
  ## Chrom is binary.
  ##
  result = @[]

  var newIndividual: Individual

  for i in 0..<popRange:
    newIndividual = Individual(chrom: @[], score: 0.0)
    for j in 0..<chromRange:
      newIndividual.chrom.add(rand(1))
    result.add(newIndividual)
