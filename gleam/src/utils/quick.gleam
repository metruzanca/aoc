import gleam/int

/// Inspired by @hunkyjimpjorps's utils
pub fn int(parse string: String) {
  let assert Ok(number) = int.parse(string)
  number
}
