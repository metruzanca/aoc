import gleam/bool
import gleam/dict
import gleam/list
import gleam/result
import gleam/string
import utils/quick

fn parse_rules(rules: String) {
  use rules, line <- list.fold(string.split(rules, "\n"), dict.new())
  let assert Ok(#(x, y)) = string.split_once(line, "|")

  let y = quick.int(y)
  let x = quick.int(x)

  case dict.get(rules, x) {
    Error(_) -> dict.insert(rules, x, [y])
    Ok(rest) -> dict.insert(rules, x, [y, ..rest])
  }
}

fn parse_lines(lines: String) {
  use line <- list.map(string.split(lines, "\n"))
  line
  |> string.split(",")
  |> list.map(quick.int)
}

pub fn parse(input: String) {
  let assert Ok(#(rules, lines)) = string.split_once(input, "\n\n")

  #(parse_rules(rules), parse_lines(lines))
}

pub type Parsed =
  #(dict.Dict(Int, List(Int)), List(List(Int)))

pub fn pt_1(input: Parsed) {
  let #(rules, lines) = input
  use count, line <- list.fold(lines, 0)

  use <- bool.guard(!is_ordered(line, rules), count)
  count + get_middle(line)
}

fn is_ordered(line: List(Int), rules: dict.Dict(Int, List(Int))) {
  use pair <- list.all(list.window_by_2(line))
  case dict.get(rules, pair.0) {
    Error(_) -> False
    Ok(first_rules) -> list.contains(first_rules, pair.1)
  }
}

fn get_middle(array: List(Int)) {
  array
  |> list.drop(list.length(array) / 2)
  |> list.first
  |> result.unwrap(0)
}

pub fn pt_2(input: Parsed) {
  todo
}
