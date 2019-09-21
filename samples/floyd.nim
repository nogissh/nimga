import algorithm, random, math, sequtils
import nimga

randomize()

var
  pop, popNext: Population
  crossovered: CrossoveredChrom
  a, b: int

proc evaluation(chrom: seq[int]): float =
  # Function of population evaluation
  result = 0.0
  for i in 0..<chrom.len:
    result += (chrom[i].toFloat() * 2.0 - 1.0) * sqrt(i.toFloat() + 1.0)
  result = abs(result)

proc runFloyd*(N, popLength, generateTime, saveElite: int): seq[int] =
  ###
  ### Floyd
  ###

  # Initial population
  pop = pcBinStd(popLength, N)

  # Initial evaluation
  for i in 0..<popLength:
    pop[i].score = evaluation(pop[i].chrom)

  # Sorting
  pop = sortIndividualsByScore(pop, order=Ascending)

  for i in 0..<generateTime:
    # Ready new generation
    popNext = selectElite(pop, saveElite)

    # Generation
    for j in countup(2, (popLength - saveElite) - 1, 2):
      # Selection
      a = rouletteSelection(map(pop, proc(p: Individual): float = p.score))
      b = rouletteSelection(map(pop, proc(p: Individual): float = p.score))

      # Crossover
      crossovered = kPointCrossover(pop[a].chrom, pop[b].chrom, 1)

      # Add to new generation
      popNext.add(Individual(chrom: crossovered.a, score: 0.0))
      popNext.add(Individual(chrom: crossovered.b, score: 0.0))
    
    # Mutation
    if (willMutate()):
      popNext[saveElite..<popNext.len] = mutate(popNext[saveElite..<popNext.len])
    
    # Push new population when pops less than popLength
    if (popNext.len < popLength):
      popNext.add(pcBinStd(popLength - popNext.len, N))
    
    # Evaluation
    for j in 0..<popLength:
      popNext[j].score = evaluation(popNext[j].chrom)
    
    # Sorting
    popNext = sortIndividualsByScore(popNext, order=Ascending)

    # Copy `NextIndividualrationPopulation` to pop
    pop = popNext

    echo "Score at ", i + 1, "\t: ", pop[0].score
  
  # Set result
  result = pop[0].chrom


if isMainModule:
  echo runFloyd(50, 100, 1000, 1)
