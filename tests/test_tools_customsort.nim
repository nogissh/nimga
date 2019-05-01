import unittest
import algorithm
import random
import objects/basic
import tools/customsort


randomize()


proc getSampleGenes(n=10): seq[Gene] =
  result = @[]
  for i in 0..<n:
    result.add(Gene(score: rand(1.0)))


test "Can sort Genes order by `score`":
  var sampleGenes       = getSampleGenes()
  var sampleGenesSorted = sortGenesByScore(sampleGenes)
  for i in 0..<sampleGenesSorted.len - 1:
    check sampleGenesSorted[i].score > sampleGenesSorted[i+1].score
  var sampleGenesSortedAscending = sortGenesByScore(sampleGenes, order=Ascending)
  for i in 0..<sampleGenesSortedAscending.len - 1:
    check sampleGenesSortedAscending[i].score < sampleGenesSortedAscending[i+1].score
