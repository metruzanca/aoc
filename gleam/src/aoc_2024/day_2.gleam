import gleam/bool
import gleam/int
import gleam/io
import gleam/list
import gleam/string

/// Split lines, split line by space.
/// Each line needs to be either always increasing or always decreesing by 1, 2, or 3.
///   how: check pairs of numbers, abs(a - b) <= 3 
/// Count all lines that follow this rule
pub fn pt_1(input: String) {
  input
  |> string.split("\n")
  // use filter_map instead
  |> list.map(fn(line) {
    line
    |> string.split(" ")
    |> list.filter_map(int.parse)
    |> all2(fn(a, b) { int.absolute_value(a - b) <= 3 })
    // |> io.debug
  })
  |> list.map(bool.to_int)
  |> int.sum
}

pub fn pt_2(input: String) {
  todo as "part 2 not implemented"
}

// taken from gleam stdlib
fn all2(in list: List(a), satisfying predicate: fn(a, a) -> Bool) -> Bool {
  case list {
    [] -> True
    [first, second, ..rest] ->
      case predicate(first, second) {
        True -> all2(rest, predicate)
        False -> False
      }
    [_] -> False
  }
}
