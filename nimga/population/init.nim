import random
import ../objects/basic


proc initPopulation*(popRange, chromRange, chromMax: int): Population =
  ##
  ## Create initial population
  ##
  result = Population()

  var newGene: Gene

  for i in 0..<popRange:
    newGene = Gene(chrom: @[], score: 0.0)
    for j in 0..<chromRange:
      newGene.chrom.add(rand(chromMax))
    result.gene.add(newGene)


proc initPopulationUnique*(popRange, chromRange: int): Population =
  ##
  ## Create initial population
  ## chrom is unique, non-deplicated.
  ##
  result = Population()

  var 
    tmpArray: seq[int]
    newGene : Gene

  tmpArray = @[]
  for n in 0..<chromRange:
    tmpArray.add(n)

  for i in 0..<popRange:
    shuffle(tmpArray)
    newGene = Gene(chrom: tmpArray, score: 0.0)
    result.gene.add(newGene)
