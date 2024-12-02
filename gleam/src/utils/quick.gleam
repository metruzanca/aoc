import gleam/int

/// In Advent of Code we live dangerously. Give me my number or panic, I don't care.
/// Inspired by @hunkyjimpjorps's utils
pub fn int(parse string: String) {
  let assert Ok(number) = int.parse(string)
  number
}
