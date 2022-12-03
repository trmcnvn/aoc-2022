import std/strutils
import std/sets
import std/math
import std/sequtils

let test_input = readFile("test.txt").strip().split("\n")
let real_input = readFile("input.txt").strip().split("\n")

var lookup: seq[char] = @[]
for c in 'a'..'z':
  lookup.add(c)
for c in 'A'..'Z':
  lookup.add(c)

proc part_one(input: seq[string]): int =
  var priorities: seq[int] = @[]
  for rucksacks in input:
    let split = int(rucksacks.len / 2)
    let first = toHashSet(rucksacks[0 .. split - 1])
    let second = rucksacks[split .. ^1]
    for item in second:
      if first.contains(item):
        priorities.add(lookup.find(item) + 1)
        break
  priorities.sum

echo part_one(test_input)
echo part_one(real_input)

proc part_two(input: seq[string]): int =
  var priorities: seq[int] = @[]
  let groups = input.distribute(int(input.len / 3), false)
  for group in groups:
    let first = toHashSet(group[0])
    let last = toHashSet(group[2])
    for item in group[1]:
      if first.contains(item) and last.contains(item):
        priorities.add(lookup.find(item) + 1)
        break
  priorities.sum

echo part_two(test_input)
echo part_two(real_input)
