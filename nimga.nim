import random, algorithm
import nimga/[rankingSelectionLib, rouletteSelectionLib]


type
  Individual* = ref object of RootObj
    chrom*: seq[int]
    score*: float

  CrossoverSeparator* = object
    a*: int
    b*: int

  CrossoverTargetChrom* = object
    a*: seq[int]
    b*: seq[int]

  CrossoveredChrom* = object
    a*: seq[int]
    b*: seq[int]

type
  Population* = seq[Individual]
  Chrom*      = seq[int]


################################
################################
##
## Common Functions
##
################################
################################

proc sortIndividualsByScore*(pop: Population, order=Descending): Population =
  ##
  ## Sorting Individual by order argument
  ##
  result = pop
  sort(
    result,
    proc (x, y: Individual): int = cmp(x.score, y.score),
    order
  )


################################
################################
##
## Population Creation
## prefix: pc
##
################################
################################

proc pcIntStd*(popRange, chromRange, chromMax: int): Population =
  ##
  ## Population Creation as Integer Standard
  ## Chrom is random, including deplicating number.
  ##
  ## Example: individual.chrom = @[1, 3, 2, 3, 0]
  ##
  result = @[]

  var newIndividual: Individual

  for i in 0..<popRange:
    newIndividual = Individual(chrom: @[], score: 0.0)
    for j in 0..<chromRange:
      newIndividual.chrom.add(rand(chromMax))
    result.add(newIndividual)


proc pcIntUniq*(popRange, chromRange: int): Population =
  ##
  ## Population Creation as Integer Unique
  ## chrom is unique, non-deplicated.
  ##
  ## Example: individual.chrom = @[1, 3, 2, 4, 0]
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


proc pcBinStd*(popRange, chromRange: int): Population =
  ##
  ## Create population
  ## Chrom is binary.
  ##
  ## Example: individual.chrom = @[1, 1, 0, 1, 0]
  ##
  result = @[]

  var newIndividual: Individual

  for i in 0..<popRange:
    newIndividual = Individual(chrom: @[], score: 0.0)
    for j in 0..<chromRange:
      newIndividual.chrom.add(rand(1))
    result.add(newIndividual)


################################
################################
##
## Mutation
##
################################
################################

proc willMutate*(mutationProb=0.1): bool =
  ##
  ## Decide do mutation
  ##
  if rand(1.0) <= mutationProb:
    result = true
  else:
    result = false


proc mutate*(pop: Population): Population =
  ##
  ## Mutate chrome twice of pop
  ##
  deepCopy(result, pop)

  var target, a, b, tmp: int

  target = rand(pop.len - 1)
  a      = rand(pop[0].chrom.len - 1)
  b      = rand(pop[0].chrom.len - 1)

  tmp                     = result[target].chrom[a]
  result[target].chrom[a] = result[target].chrom[b]
  result[target].chrom[b] = tmp


proc selectElite*(pop: Population, selectRange: int): Population =
  result = @[]
  for i in 0..<selectRange:
    result.add(pop[i])


################################
################################
##
## Selection
##
################################
################################

proc rankingSelection*(popLength: int): int =
  ##
  ## Ranking selection
  ##
  result = runRankingSelection(popLength)


proc rouletteSelection*(scores: seq[float]): int =
  ##
  ## Roulette selection
  ##
  result = runRouletteSelection(scores)


################################
################################
##
## Crossover
##
################################
################################

proc exchangeChrom(this, another: seq[int], target: int): seq[int] =
  ##
  ## Exchange chrome on crossover
  ##
  result = this

  var anotherIndex, tmpChrom: int

  anotherIndex         = find(this, another[target])
  tmpChrom             = result[anotherIndex]
  result[anotherIndex] = result[target]
  result[target]       = tmpChrom


proc crossoverForPartialMatch(oldPop    : CrossoverTargetChrom,
                              separator : CrossoverSeparator
                              ): CrossoveredChrom =
  ##
  ## Crossover for partial match
  ##
  result.a = oldPop.a
  result.b = oldPop.b

  for i in separator.a..<separator.b:
    result.a = exchangeChrom(result.a, oldPop.b, i)
    result.b = exchangeChrom(result.b, oldPop.a, i)


proc partialMatchCrossover*(a, b: seq[int], initSplit: int): CrossoveredChrom =
  ##
  ## Partial Match
  ##
  var
    split, sepA, sepB: int
    separator: CrossoverSeparator
    oldPop   : CrossoverTargetChrom
  
  if initSplit == 0:
    split = a.len
  else:
    split = initSplit
  
  sepA = rand(0..<split)
  sepB = rand(sepA..<split)
  separator = CrossoverSeparator(a: sepA, b: sepB)

  oldPop = CrossoverTargetChrom(a: a, b: b)

  result = crossoverForPartialMatch(oldPop, separator)


proc getPoints(k, length: int): seq[int] =
  ##
  ## Get separate point
  ##
  result = @[0]

  for i in 0..<k:
    result.add(rand(result[i]..<length))
  
  result.add(length-1)


proc crossoverForKPoint(oldPop     : CrossoverTargetChrom,
                        separators : seq[CrossoverSeparator]
                        ): CrossoveredChrom =
  ##
  ## Crossover for k-point
  ##
  var tmpChroms: seq[int]

  result.a = oldPop.a
  result.b = oldPop.b

  for i in 0..<separators.len:
    if (i mod 2) == 1:
      # skip job when `i` is odd in k-point crossover
      # ignores on one-point
      continue
    tmpChroms                                   = result.a[separators[i].a..<separators[i].b]
    result.a[separators[i].a..<separators[i].b] = result.b[separators[i].a..<separators[i].b]
    result.b[separators[i].a..<separators[i].b] = tmpChroms


proc kPointCrossover*(a, b: seq[int], k: int): CrossoveredChrom =
  ##
  ## k-point crossover
  ##
  var
    points    : seq[int]
    separators: seq[CrossoverSeparator]
    oldPop    : CrossoverTargetChrom

  points = getPoints(k, a.len)
  
  separators = @[]
  for i in 0..<points.len-1:
    separators.add(CrossoverSeparator(a: points[i], b: points[i+1]))

  oldPop = CrossoverTargetChrom(a: a, b: b)

  result = crossoverForKPoint(oldPop, separators)
