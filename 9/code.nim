import std/[strutils, sets, sequtils]

let test_input = readFile("test.txt").strip().split("\n")
let real_input = readFile("input.txt").strip().split("\n")

type Coord = (int, int)
proc `+`(x, y: Coord): Coord =
  (x[0] + y[0], x[1] + y[1]) 
proc `+=`(x: var Coord, y: Coord) =
  x = (x[0] + y[0], x[1] + y[1])

proc is_adjacent(head: Coord, tail: Coord): bool =
  if abs(head[0] - tail[0]) > 1 or abs(head[1] - tail[1]) > 1:
    return false
  true

proc update_tail(head: Coord, tail: Coord): Coord =
  if is_adjacent(head, tail):
    return tail
  if head[1] == tail[1]:
    if head[0] > tail[0]: return tail + (1, 0)
    else: return tail + (-1, 0)
  elif head[0] == tail[0]:
    if head[1] > tail[1]: return tail + (0, 1)
    else: return tail + (0, -1)
  elif head[0] > tail[0] and head[1] > tail[1]:
    return tail + (1, 1)
  elif head[0] < tail[0] and head[1] < tail[1]:
    return tail + (-1, -1)
  elif head[0] > tail[0] and head[1] < tail[1]:
    return tail + (1, -1)
  elif head[0] < tail[0] and head[1] > tail[1]:
    return tail + (-1, 1)

proc problem(input: seq[string], size: int): int =
  var head_position = (0, 0)
  var tail_positions = toSeq(1..size).mapIt((0, 0))
  var visited = initHashSet[Coord]()
  for row in input:
    let instruction = row.split(" ")
    let moves = instruction[1].parseInt()
    let direction = case instruction[0]:
      of "L":
        (-1, 0)
      of "R":
        (+1, 0)
      of "U":
        (0, -1)
      of "D":
        (0, +1)
      else:
        (0, 0)
    for _ in 0..moves - 1:
      head_position += direction
      for n in 0..tail_positions.len - 1:
        var tail = tail_positions[n]
        if n == 0: tail = update_tail(head_position, tail)
        else: tail = update_tail(tail_positions[n - 1], tail)
        tail_positions[n] = tail
      visited.incl(tail_positions[^1])
  visited.len

proc part_one(input: seq[string]): int = problem(input, 1)

echo part_one(test_input)
echo part_one(real_input)

proc part_two(input: seq[string]): int = problem(input, 9)

echo part_two(test_input)
echo part_two(real_input)
