import objects

proc select*(genes: seq[Gene], selectRange: int): seq[Gene] =
  result = @[]
  for i in 0..<selectRange:
    result.add(genes[i])
