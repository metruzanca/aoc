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
  |> list.filter_map(fn(line) {
    let line =
      line
      |> string.split(" ")
      |> list.filter_map(int.parse)

    case is_increasing(line) || is_decreasing(line) {
      False -> Error("Unsafe")
      True -> Ok(line)
    }
  })
  |> list.map(fn(row) {
    row
    |> list.window_by_2
    |> list.all(fn(pair) {
      case pair.0 == pair.1 {
        True -> False
        False -> int.absolute_value(pair.0 - pair.1) <= 3
      }
    })
  })
  |> list.map(bool.to_int)
  |> int.sum
}

fn is_increasing(nums: List(Int)) {
  nums
  |> list.window_by_2
  |> list.all(fn(pair) { pair.0 > pair.1 })
}

fn is_decreasing(nums: List(Int)) {
  nums
  |> list.window_by_2
  |> list.all(fn(pair) { pair.0 < pair.1 })
}

pub fn pt_2(input: String) {
  todo as "aaaa"
}
