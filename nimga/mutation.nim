import random
import objects


proc willMutate*(mutationProb=0.1): bool =
  ##
  ## Decide do mutation
  ##
  if rand(1.0) <= mutationProb:
    result = true
  else:
    result = false


proc runMutation*(genes: seq[Gene]): seq[Gene] =
  ##
  ## Mutate chrome twice of genes
  ##
  result = genes # Maybe passed by reference

  var target, a, b, tmp: int

  target = rand(genes.len)
  a      = rand(genes[0].chrom.len)
  b      = rand(genes[0].chrom.len)

  # Replace chrome
  tmp                     = result[target].chrom[a]
  result[target].chrom[a] = result[target].chrom[b]
  result[target].chrom[b] = tmp
