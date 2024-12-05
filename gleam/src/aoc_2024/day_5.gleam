import gleam/dict
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string

pub fn parse(input: String) {
  let assert Ok(#(first, second)) = string.split_once(input, "\n\n")

  let rules =
    list.fold(string.split(first, "\n"), dict.new(), fn(rules, line) {
      let assert Ok(#(x, y)) = string.split_once(line, "|")

      case dict.get(rules, x) {
        Error(_) -> dict.insert(rules, x, [y])
        Ok(rest) -> dict.insert(rules, x, [y, ..rest])
      }
    })

  let lines =
    second
    |> string.split("\n")
    |> list.map(fn(line) { string.split(line, ",") })

  #(rules, lines)
}

pub type Parsed =
  #(dict.Dict(String, List(String)), List(List(String)))

pub fn pt_1(input: Parsed) {
  let #(rules, lines) = input

  lines
  |> list.map(fn(line) {
    let result =
      line
      |> list.window_by_2
      |> list.all(fn(pair) {
        let #(first, second) = pair
        case dict.get(rules, first) {
          Error(_) -> False
          Ok(first_rules) -> list.contains(first_rules, second)
        }
      })

    case result {
      False -> 0
      True -> get_middle(line)
    }
  })
  |> int.sum
}

fn get_middle(array: List(String)) {
  array
  |> list.drop(list.length(array) / 2)
  |> list.first
  |> result.try(int.parse)
  |> result.unwrap(0)
}

pub fn pt_2(input: Parsed) {
  todo as "part 2 not implemented"
}
