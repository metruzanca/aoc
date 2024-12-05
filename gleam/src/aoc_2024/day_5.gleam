import gleam/bool
import gleam/dict
import gleam/list
import gleam/order
import gleam/result
import gleam/string
import utils/quick

pub fn parse(input: String) {
  let assert Ok(#(rules, lines)) = string.split_once(input, "\n\n")

  let rules =
    string.split(rules, "\n")
    |> list.fold(dict.new(), fn(rules, line) {
      let assert Ok(#(x, y)) = string.split_once(line, "|")

      let y = quick.int(y)
      let x = quick.int(x)

      case dict.get(rules, x) {
        Error(_) -> dict.insert(rules, x, [y])
        Ok(rest) -> dict.insert(rules, x, [y, ..rest])
      }
    })

  let lines =
    list.map(string.split(lines, "\n"), fn(line) {
      line
      |> string.split(",")
      |> list.map(quick.int)
    })

  #(rules, lines)
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
  let #(rules, lines) = input
  use count, line <- list.fold(lines, 0)

  use <- bool.guard(is_ordered(line, rules), count)
  let line = sort_line(line, rules)

  count + get_middle(line)
}

fn sort_line(line: List(Int), rules: dict.Dict(Int, List(Int))) {
  use a, b <- list.sort(line)
  case dict.get(rules, b) {
    Error(_) -> order.Lt
    Ok(first_rules) -> {
      case list.contains(first_rules, a) {
        False -> order.Lt
        True -> order.Gt
      }
    }
  }
}
