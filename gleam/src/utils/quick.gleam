import gleam/int

/// General purpose unwrap
/// Inspired by @ethab on Discord
pub fn unwrap(result: Result(a, b)) -> a {
  let assert Ok(x) = result
  x
}

/// In Advent of Code we live dangerously. Give me my number or panic, I don't care.
/// Inspired by @hunkyjimpjorps's utils
pub fn int(parse string: String) {
  string |> int.parse |> unwrap
}
