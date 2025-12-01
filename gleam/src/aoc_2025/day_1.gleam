import gleam/list
import gleam/string
import utils/quick

pub type Direction {
  L
  R
}

fn split_line(value: String) {
  case value {
    "L" <> num -> #(L, quick.int(num))
    "R" <> num -> #(R, quick.int(num))
    _ -> #(R, 0)
  }
}

pub fn parse(input: String) {
  use line <- list.map(string.split(input, "\n"))
  split_line(line)
}

pub fn pt_1(input: List(#(Direction, Int))) {
  process(input, 50, 0)
}

fn process(arr: List(#(Direction, Int)), pos: Int, count: Int) {
  // echo arr
  // echo pos
  // echo count

  case arr {
    [] -> count
    [value, ..rest] -> {
      let new_pos = turn_dial(pos, value.0, value.1)
      process(rest, new_pos, next_count(new_pos, count))
    }
  }
}

fn turn_dial(pos: Int, dir: Direction, amount: Int) {
  case dir {
    R -> { pos - amount } % 100
    L -> { pos + amount } % 100
  }
}

fn next_count(pos, count: Int) {
  case pos {
    0 -> count + 1
    _ -> count
  }
}

pub fn pt_2(input: List(#(Direction, Int))) {
  todo as "part 2 not implemented"
}
