import algorithm
import ../types, ../objects


proc lambdaScore(x, y: Individual): int =
  result = cmp(x.score, y.score)

proc sortIndividualsByScore*(pop: Population, order=Descending): Population =
  result = pop
  sort(result, lambdaScore, order)
