import algorithm
from ../objects/basic import Gene


proc lambdaScore(x, y: Gene): int =
  result = cmp(x.score, y.score)


proc sortGenesByScore*(genes: seq[Gene], order=Descending): seq[Gene] =
  result = genes
  sort(result, lambdaScore, order)
