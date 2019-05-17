import random
import types, objects


proc integerStandard*(popRange, chromRange, chromMax: int): Population =
  ##
  ## Create population
  ##
  result = @[]

  var newGene: Gene

  for i in 0..<popRange:
    newGene = Gene(chrom: @[], score: 0.0)
    for j in 0..<chromRange:
      newGene.chrom.add(rand(chromMax))
    result.add(newGene)


proc integerUnique*(popRange, chromRange: int): Population =
  ##
  ## Create population
  ## chrom is unique, non-deplicated.
  ##
  result = @[]

  var 
    tmpArray: seq[int]
    newGene : Gene

  tmpArray = @[]
  for n in 0..<chromRange:
    tmpArray.add(n)

  for i in 0..<popRange:
    shuffle(tmpArray)
    newGene = Gene(chrom: tmpArray, score: 0.0)
    result.add(newGene)


proc binaryStandard*(popRange, chromRange: int): Population =
  ##
  ## Create population
  ## Chrom is binary.
  ##
  result = @[]

  var newGene: Gene

  for i in 0..<popRange:
    newGene = Gene(chrom: @[], score: 0.0)
    for j in 0..<chromRange:
      newGene.chrom.add(rand(1))
    result.add(newGene)
