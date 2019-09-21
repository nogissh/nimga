import unittest
import typetraits

import ../nimga/nimga


test "`Individual` is Individual":
  var sample: Individual = Individual()
  sample.chrom = @[]
  sample.score = 0.0
  check sample.type.name == "Individual"
  check sample.chrom.type.name == "seq[int]"
  check sample.score.type.name == "float"

test "`CrossoverSeparator` is CrossoverSeparator":
  var sample: CrossoverSeparator = CrossoverSeparator()
  sample.a = 0
  sample.b = 0
  check sample.type.name == "CrossoverSeparator"
  check sample.a.type.name == "int"
  check sample.b.type.name == "int"

test "`CrossoverTargetChrom` is CrossoverTargetChrom":
  var sample: CrossoverTargetChrom = CrossoverTargetChrom()
  sample.a = @[0]
  sample.b = @[0]
  check sample.type.name == "CrossoverTargetChrom"
  check sample.a.type.name == "seq[int]"
  check sample.b.type.name == "seq[int]"

test "`CrossoveredChrom` is CrossoveredChrom":
  var sample: CrossoveredChrom = CrossoveredChrom()
  sample.a = @[0]
  sample.b = @[0]
  check sample.type.name == "CrossoveredChrom"
  check sample.a.type.name == "seq[int]"
  check sample.b.type.name == "seq[int]"

test "`Population` is `seq[Individual]`":
  var
    sample: Population = @[]
    indSmp: Individual = Individual()
  indSmp.chrom = @[0,1,2]
  indSmp.score = 0.0
  sample.add(indSmp)
  check sample.type.name == "seq[Individual]"

test "`Chrom` is `seq[int]`":
  var sample: Chrom = @[0,1,2]
  check sample.type.name == "seq[int]"
