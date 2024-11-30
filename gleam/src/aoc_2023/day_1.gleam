import gleam/int
// import gleam/io
import gleam/list
import gleam/string

/// Goal: Each line has jumble of letters and numbers.
/// Take the first number and last number.
/// Combine those, parse them as a number.
/// Sum all lines.
/// Edgecase: if theres 1 number, repeat it. Each number must be 2-digits!
pub fn pt_1(input: String) {
  input
  |> string.split("\n")
  |> list.map(fn(x) {
    let nums =
      x
      |> string.to_graphemes
      |> list.filter_map(int.parse)

    let assert Ok(left) = list.first(nums)
    case list.last(nums) {
      Error(_) -> left * 11
      Ok(right) -> left * 10 + right
    }
  })
  |> int.sum
  // |> io.debug
}

pub fn pt_2(_input: String) {
  "part 2 not implemented"
}
