import std/strutils
from std/sequtils import mapIt
from std/math import sum
from std/algorithm import sort

let test_input = readFile("test.txt").strip().split("\n\n")
let real_input = readFile("input.txt").strip().split("\n\n")

proc part_one(input: seq[string]): int =
  var max_calories = 0
  for elf in input:
    let calories = elf.split("\n").mapIt(it.parseInt).sum()
    if calories > max_calories:
      max_calories = calories
  max_calories

echo part_one(test_input)
echo part_one(real_input)

proc part_two(input: seq[string]): int =
  var elfs: seq[int] = @[]
  for elf in input:
    let calories = elf.split("\n").mapIt(it.parseInt).sum()
    elfs.add(calories)
  sort(elfs, system.cmp[int])
  elfs[elfs.len - 3..elfs.len - 1].sum()
  
echo part_two(test_input)
echo part_two(real_input)
