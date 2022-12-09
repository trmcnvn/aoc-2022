import std/[strformat, strutils, tables, sequtils]

let test_input = readFile("test.txt").strip().split("\n")
let real_input = readFile("input.txt").strip().split("\n")

type Coord = (int, int)
type Grid = Table[Coord, int]

proc `+`(x, y: Coord): Coord =
  let n_x = x[0] + y[0]
  let n_y = x[1] + y[1]
  (n_x, n_y)

proc build_grid(input: seq[string]): Grid =
  var grid = initTable[(int, int), int]()
  for y_index, row in input:
    for x_index, tree in row:
      grid[(x_index, y_index)] = ($tree).parseInt()
  grid

proc get_grid_size(grid: Grid): Coord =
  let seq = toSeq(grid.keys)
  let outer_x_trees = seq.mapIt(it[0]).max()
  let outer_y_trees = seq.mapIt(it[1]).max()
  (outer_x_trees, outer_y_trees)

proc is_visible(grid: Grid, coord: Coord, direction: Coord): bool =
  let height = grid[coord]
  var is_visible = true
  try:
    var new_coord = coord
    while true:
      new_coord = new_coord + direction
      if grid[new_coord] >= height:
        is_visible = false
        break
  except KeyError:
    return is_visible
  is_visible

proc visible_count(grid: Grid, coord: Coord, direction: Coord): int =
  let height = grid[coord]
  var count = 0
  try:
    var new_coord = coord
    while true:
      new_coord = new_coord + direction
      count += 1
      if grid[new_coord] >= height:
        break
  except KeyError:
    count -= 1
    return count
  count

proc part_one(input: seq[string]): int =
  let grid = build_grid(input)
  let (outer_x_trees, outer_y_trees) = get_grid_size(grid)
  let outer_tree_count = (outer_x_trees * 2) + (outer_y_trees * 2)

  var visible_count = 0
  for coord, height in grid:
    let (x, y) = coord
    if x == 0 or x == outer_x_trees:
      continue
    if y == 0 or y == outer_y_trees:
      continue

    if is_visible(grid, coord, (-1, 0)):
      visible_count += 1
    elif is_visible(grid, coord, (+1, 0)):
      visible_count += 1
    elif is_visible(grid, coord, (0, -1)):
      visible_count += 1
    elif is_visible(grid, coord, (0, +1)):
      visible_count += 1
   
  visible_count + outer_tree_count

echo part_one(test_input)
echo part_one(real_input)

proc part_two(input: seq[string]): int =
  let grid = build_grid(input)
  let (outer_x_trees, outer_y_trees) = get_grid_size(grid)

  var counts: seq[int] = @[]
  for coord, height in grid:
    counts.add(
      visible_count(grid, coord, (-1, 0)) *
      visible_count(grid, coord, (+1, 0)) *
      visible_count(grid, coord, (0, -1)) *
      visible_count(grid, coord, (0, +1))
    )
  counts.max

echo part_two(test_input)
echo part_two(real_input)
