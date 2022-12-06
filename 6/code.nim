import std/[strutils, sets]

let test_input = readFile("test.txt").strip()
let real_input = readFile("input.txt").strip()

proc scanner(input: string, start: int, target: int): int = 
  var set = initHashSet[char]()
  for index, ch in input[start..^1]:
    set.incl(ch)
    if (index + 1) == target:
      if set.len() == target:
        return start
      else:
        return scanner(input, start + 1, target)

proc part_one(input: string): int =
  scanner(input, 0, 4) + 4

echo part_one(test_input)
echo part_one(real_input)

proc part_two(input: string): int =
  scanner(input, 0, 14) + 14

echo part_two(test_input)
echo part_two(real_input)
