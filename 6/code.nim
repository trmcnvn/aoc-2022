import std/[strutils, sets]

let test_input = readFile("test.txt").strip()
let real_input = readFile("input.txt").strip()

proc scanner(input: string, target: int): int = 
  for index in 0..input.len()-target-1:
    let packet = input[index..index + target - 1]
    if packet.len() == packet.toHashSet().len():
      return index + target

proc part_one(input: string): int =
  scanner(input, 4)

echo part_one(test_input)
echo part_one(real_input)

proc part_two(input: string): int =
  scanner(input, 14)

echo part_two(test_input)
echo part_two(real_input)
