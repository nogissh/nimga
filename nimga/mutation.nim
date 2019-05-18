import random
import types


proc willMutate*(mutationProb=0.1): bool =
  ##
  ## Decide do mutation
  ##
  if rand(1.0) <= mutationProb:
    result = true
  else:
    result = false


proc runMutation*(pop: Population): Population =
  ##
  ## Mutate chrome twice of pop
  ##
  deepCopy(result, pop)

  var target, a, b, tmp: int

  target = rand(pop.len - 1)
  a      = rand(pop[0].chrom.len - 1)
  b      = rand(pop[0].chrom.len - 1)

  # Replace chrome
  tmp                     = result[target].chrom[a]
  result[target].chrom[a] = result[target].chrom[b]
  result[target].chrom[b] = tmp
