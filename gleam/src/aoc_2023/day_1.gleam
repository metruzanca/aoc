import gleam/int

// import gleam/io
import gleam/list
import gleam/string

pub fn parse(input: String) -> List(String) {
  input
  |> string.split("\n")
}

/// Goal: Each line has jumble of letters and numbers.
/// Take the first number and last number.
/// Combine those, parse them as a number.
/// Sum all lines.
/// Edgecase: if theres 1 number, repeat it. Each number must be 2-digits!
pub fn pt_1(lines: List(String)) {
  // TODO use map_fold and use `use`.
  lines
  |> list.map(fn(line) {
    line
    |> string.to_graphemes
    |> list.filter_map(int.parse)
    |> take_between
  })
  |> int.sum
  // |> io.debug
}

// Goal: Same as above, but you also need to parse strings of numbers spelt out e.g. "one" -> 1.
// pub fn pt_2(lines: List(String)) {
//   lines
//   |> list.map(fn(line) {
//     todo
//     // line
//     // // |> string.to_graphemes
//     // |> list.map(fn(x) {s

//     // })
//     // // |> list.filter_map(int.parse)
//     // |> take_between
//   })
//   |> int.sum
// }

pub fn take_between(nums: List(Int)) {
  let assert Ok(left) = list.first(nums)
  case list.last(nums) {
    Error(_) -> left * 11
    Ok(right) -> left * 10 + right
  }
}
