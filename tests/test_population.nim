import unittest
import population

var
  popRange   = 100
  chromRange = 100
  rangeMax   = 100

test "Able to create population":
  var population = integerStandard(popRange, chromRange, rangeMax)
  check population.gene.len == popRange
  for i in 0..<population.gene.len:
    check population.gene[i].chrom.len == chromRange
  for j in 0..<chromRange:
    check population.gene[0].chrom[j] <= rangeMax

test "Can create population unique":
  var population = integerUnique(popRange, chromRange)
  check population.gene.len == popRange
  for i in 0..<population.gene.len:
    check population.gene[i].chrom.len == chromRange
  for i in 1..<population.gene.len:
    check population.gene[0].chrom != population.gene[i].chrom
