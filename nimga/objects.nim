type Individual* = ref object of RootObj
  chrom*: seq[int]
  score*: float

type CrossoverSeparator* = object
  a*: int
  b*: int

type CrossoverTargetChrom* = object
  a*: seq[int]
  b*: seq[int]

type CrossoveredChrom* = object
  a*: seq[int]
  b*: seq[int]
