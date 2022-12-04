import std/strutils
import std/sequtils
import std/sets

let test_input = readFile("test.txt").strip().split("\n")
let real_input = readFile("input.txt").strip().split("\n")

proc part_one(input: seq[string]): int =
  var count = 0
  for group in input:
    let ranges = group.split(",")
    var first = ranges[0].split("-").mapIt(it.parseInt)
    first = (first[0] .. first[1]).toSeq
    var last = ranges[1].split("-").mapIt(it.parseInt)
    last = (last[0] .. last[1]).toSeq
    let x = toHashSet(concat(first, last))
    if x.len == max(first.len, last.len):
      count = count + 1
  count

echo part_one(test_input)
echo part_one(real_input)

proc part_two(input: seq[string]): int =
  var count = 0
  for group in input:
    let ranges = group.split(",")
    var first = ranges[0].split("-").mapIt(it.parseInt)
    first = (first[0] .. first[1]).toSeq
    var last = ranges[1].split("-").mapIt(it.parseInt)
    last = (last[0] .. last[1]).toSeq
    let x = toHashSet(first)
    for y in last:
      if x.contains(y):
        count = count + 1
        break
  count

echo part_two(test_input)
echo part_two(real_input)
