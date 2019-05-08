import unittest
import population/init

var
  popRange   = 100
  chromRange = 100

test "Can create population unique":
  var population = initPopsUnique(popRange, chromRange)
  check population.gene.len == popRange
  for i in 0..<population.gene.len:
    check population.gene[i].chrom.len == chromRange
  for i in 1..<population.gene.len:
    check population.gene[0].chrom != population.gene[i].chrom
