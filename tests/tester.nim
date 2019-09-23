import unittest, typetraits
import ../nimga


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


test "pcIntStd":
  var
    popRange   = 10
    chromRange = 100
    chromMax   = 10

  var result = pcIntStd(popRange, chromRange, chromMax)
  for i in 0..<popRange:
    check result[i].chrom.len == chromRange
    check max(result[i].chrom) <= chromMax


test "pcIntUniq":
  var
    popRange   = 10
    chromRange = 100
    without    = @[2, 10, 50]

  var resultOne = pcIntUniq(popRange, chromRange)
  check resultOne.len == popRange
  for i in 0..<popRange:
    check resultOne[i].chrom.len == chromRange
  for i in 0..<popRange:
    for j in 0..<without.len:
      check resultOne[i].chrom.contains(without[j])
      
  var resultTwo = pcIntUniq(popRange, chromRange, without)
  check resultTwo.len == popRange
  for i in 0..<popRange:
    check resultTwo[i].chrom.len == chromRange - without.len
  for i in 0..<popRange:
    for j in 0..<without.len:
      check not resultTwo[i].chrom.contains(without[j])


test "pcBinStd":
  var
    popRange   = 10
    chromRange = 100

  var result = pcBinStd(popRange, chromRange)
  for i in 0..<popRange:
    check result[i].chrom.len == chromRange
    check max(result[i].chrom) == 1
    check min(result[i].chrom) == 0
