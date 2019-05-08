import random
import ../objects/basic

proc initPopsUnique*(popRange, chromRange: int): Population =
  ##
  ## Create initial population
  ## chrom is unique, non-deplicated.
  ##
  result = Population()

  var tmpArray: seq[int] = @[]
  for n in 0..<chromRange:
    tmpArray.add(n)

  var newGene: Gene
  for i in 0..<popRange:
    shuffle(tmpArray)
    newGene = Gene(chrom: tmpArray, score: 0.0)
    result.gene.add(newGene)
