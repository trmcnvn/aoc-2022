import std/strutils
import std/sequtils
import std/tables
import std/re
import std/strformat

let test_input = readFile("test.txt").split("\n").mapIt(it.strip(false))
let real_input = readFile("input.txt").split("\n").mapIt(it.strip(false))

proc build_crates(input: seq[string]): TableRef[int, seq[char]] =
  var stacks = newTable[int, seq[char]]()
  for row in input:
    if row[1] == '1':
      break;
    for index, char in row:
      if char == '[':
        let stack = max(0, int(index / 4))
        stacks.mgetOrPut(stack, @[]).insert(row[index + 1], 0)
  stacks

proc part_one(input: seq[string]): string = 
  let stacks = build_crates(input)
  for row in input:
    if row.startsWith("move"):
      if row =~ re"move (\d+) from (\d+) to (\d+)":
        for _ in 0..parseInt(matches[0]) - 1:
          let crate = stacks[parseInt(matches[1]) - 1].pop()
          stacks[parseInt(matches[2]) - 1].add(crate)
  var x: string = ""
  for k in 0..stacks.len() - 1:
    x = &"{x}{stacks[k][^1]}"
  x

echo part_one(test_input)
echo part_one(real_input)

proc part_two(input: seq[string]): string =
  let stacks = build_crates(input)
  for row in input:
    if row.startsWith("move"):
      if row =~ re"move (\d+) from (\d+) to (\d+)":
        var crates: seq[char] = @[]
        for _ in 0..parseInt(matches[0]) - 1:
          let crate = stacks[parseInt(matches[1]) - 1].pop()
          crates.add(crate)
        for _ in 0..crates.len() - 1:
          let crate = crates.pop()
          stacks[parseInt(matches[2]) - 1].add(crate)
  var x: string = ""
  for k in 0..stacks.len() - 1:
    x = &"{x}{stacks[k][^1]}"
  x

echo part_two(test_input)
echo part_two(real_input)
