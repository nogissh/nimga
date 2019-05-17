type Gene* = ref object of RootObj
  chrom*: seq[int]
  score*: float

type Population* = ref object of RootObj
  gene*: seq[Gene]
  
type CrossoverSeparator* = object
  a*: int
  b*: int

type CrossoverPopulationsOld* = object
  a*: seq[int]
  b*: seq[int]

type CrossoverPopulationsNew* = object
  a*: seq[int]
  b*: seq[int]
