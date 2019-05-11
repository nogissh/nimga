#
# Basic object for Population and Gene
#

type Gene* = ref object of RootObj
  chrom*: seq[int]
  score*: float


type Population* = ref object of RootObj
  gene*: seq[Gene]
