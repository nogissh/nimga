import algorithm
import ../types, ../objects


proc lambdaScore(x, y: Gene): int =
  result = cmp(x.score, y.score)

proc sortGenesByScore*(pop: Population, order=Descending): Population =
  result = pop
  sort(result, lambdaScore, order)
