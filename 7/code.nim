import std/[strutils, tables, sequtils, math, algorithm]

let test_input = readFile("test.txt").strip().split("\n")
let real_input = readFile("input.txt").strip().split("\n")

let max_size = 100000

proc build_tree(input: seq[string]): Table[string, int] =
  var tree = initTable[string, int]()
  var dirs = newSeq[string]()
  for line in input:
    let tokens = line.split(" ")
    if tokens[0] == "$":
      if tokens[1] == "cd":
        if tokens[2] == "..":
          let _ = dirs.pop()
        else:
          dirs.add(tokens[2])
    elif tokens[0] != "dir":
      let size = tokens[0].parseInt()
      if dirs.len() != 1:
        let parent_dirs = dirs[0..dirs.len() - 2]
        for index, _ in parent_dirs:
          let dir = dirs[0..index].join()
          tree.mgetOrPut(dir, 0).inc(size)
      tree.mgetOrPut(dirs.join(), 0).inc(size)
  tree

proc part_one(input: seq[string]): int =
  let tree = build_tree(input)
  toSeq(tree.values).filter(proc (x: int): bool = x <= max_size).sum

echo part_one(test_input)
echo part_one(real_input)

let total_size = 70000000
let target_size = 30000000

proc part_two(input: seq[string]): int =
  let tree = build_tree(input)
  let current_remaining = total_size - tree["/"]
  let need_to_delete = target_size - current_remaining
  var x = toSeq(tree.pairs)
  x.sort(proc (a, b: (string, int)): int =
    if a[1] > b[1]: 1
    else: -1
  )
  for (dir, size) in x:
    if size >= need_to_delete:
      return size

echo part_two(test_input)
echo part_two(real_input)
