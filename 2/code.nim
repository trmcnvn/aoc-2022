import std/tables
import std/strutils

let test_input = readFile("test.txt").strip().split("\n")
let real_input = readFile("input.txt").strip().split("\n")

let score_table = {
  "X": 1, # rock
  "Y": 2, # paper
  "Z": 3, # scissors
  "W": 6, # win
  "L": 0, # loss
  "D": 3  # draw
}.toTable
let counter_table = {
  "A": "Y", # paper > rock
  "B": "Z", # scissors > paper
  "C": "X", # rock > scissors
}.toTable
let decode_table = {
  "A": "X",
  "B": "Y",
  "C": "Z"
}.toTable

proc part_one(input: seq[string]): int =
  var score = 0
  for round in input:
    let choices = round.split(" ")
    let opponent_choice = choices[0]
    let player_choice = choices[1]
    if player_choice == counter_table[opponent_choice]:
      score = score + score_table[player_choice] + score_table["W"]
    elif decode_table[opponent_choice] == player_choice:
      score = score + score_table[player_choice] + score_table["D"]
    else:
      score = score + score_table[player_choice] + score_table["L"]
  score

echo part_one(test_input)
echo part_one(real_input)

let move_table = {
  "LA": "Z",
  "LB": "X",
  "LC": "Y",
  "DA": "X",
  "DB": "Y",
  "DC": "Z",
}.toTable

proc part_two(input: seq[string]): int =
  var score = 0
  for round in input:
    let choices = round.split(" ")
    let opponent_choice = choices[0]
    let round_result = choices[1]
    score = case round_result:
      of "X": # lose
        let move = move_table["L" & opponent_choice]
        score + score_table[move] + score_table["L"]
      of "Y": # draw
        let move = move_table["D" & opponent_choice]
        score + score_table[move] + score_table["D"]
      of "Z": # win
        let move = counter_table[opponent_choice]
        score + score_table[move] + score_table["W"]
      else:
        score
  score
echo part_two(test_input)
echo part_two(real_input)
