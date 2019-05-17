import types

proc select*(pop: Population, selectRange: int): Population =
  result = @[]
  for i in 0..<selectRange:
    result.add(pop[i])
